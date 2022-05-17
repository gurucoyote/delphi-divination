unit Spiel;

interface

uses
  Classes, // Unit containing the tstringlist
  Generics.Collections;

type
  TKarte = class
    FName: String;
    FZahl: Integer;
    FHell: String;
    FDunkel: String;
    constructor create(name: String; zahl: Integer; hell: String;
      dunkel: String);
    function aufdecken: String;
  end;

type
  TStapel = class
    FName: String;
    FKarten: TObjectList<TKarte>;
    constructor create(deckName: String);
    function zieheKarte(): TKarte;
    procedure mischen;
  end;

type
  TSpiel = class

    FName: String;

    TZiehStapel: TStapel;
    FAblageStapel: TStapel;

  end;

implementation

uses
  IniFiles,
  SysUtils,
  System.Generics.Defaults;

constructor TKarte.create(name: String; zahl: Integer; hell: String;
  dunkel: String);
begin
  inherited create;
  FName := name;
  FZahl := zahl;
  FHell := hell;
  FDunkel := dunkel;
end;

function TKarte.aufdecken: String;
var
  s: String;
begin
  randomize;
  s := FName;
  case random(2) of
    0:
      begin
        s := s + sLineBreak + 'Dunkel: ' + FDunkel;
        s := s + sLineBreak + '(Hell: ' + FHell + ')';
      end;
    1:
      begin
        s := s + sLineBreak + 'Hell: ' + FHell;
        s := s + sLineBreak + '(dunkel: ' + FDunkel + ')';
      end;
  else
    Writeln('huh?');
  end;
  Result := s;
end;

function deckDatei(deckName: String): String;
begin
  Result := GetCurrentDir + PathDelim + deckName + '.deck';
end;

constructor TStapel.create(deckName: String);
var
  ini: TmemIniFile;
  filename: String;
  cards: TStringList;
  i: Integer;
  karte: TKarte;
begin
  inherited create;
  // set our name
  FName := deckName;
  // create our card list
  FKarten := TObjectList<TKarte>.create(true);

  filename := deckDatei(deckName);
  // TODO: first check if deck file with given name exists
  ini := TmemIniFile.create(filename, TEncoding.UTF8);
  cards := TStringList.create;

  try
    // ini.WriteString('Meine Straße', 'Haus', 'tröt');
    ini.readSections(cards);
    for i := 0 to cards.count - 1 do
    begin
      karte := TKarte.create(cards[i], i + 1, ini.ReadString(cards[i], 'hell',
        'h'), ini.ReadString(cards[i], 'dunkel', 'd'));
      FKarten.add(karte);
    end;

  finally
    ini.Free;
    cards.Free;
  end;
end;

function TStapel.zieheKarte(): TKarte;
begin
  try
    Result := FKarten.extract(FKarten[0]);
  Except
    Result := TKarte.create('Keine Karten im Stapel', 0, 'bitte neu mischen',
      'bitte neu mischen');
  end;
end;

procedure TStapel.mischen;
begin
  FKarten.Sort(TComparer<TKarte>.Construct(function(const L, R: TKarte): Integer
    begin
      randomize;
      Result := -1 + random(3);
    end));
end;

end.
