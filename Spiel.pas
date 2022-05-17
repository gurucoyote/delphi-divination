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
			 constructor create(name: String; zahl: Integer; hell: String; dunkel: String);
			 function aufdecken: String; 
		 end;

		 type
			 TStapel = class
				 FName: String;
	FKarten: TObjectList<TKarte>;
constructor create(deckName: String);
	function zieheKarte(): TKarte;
	procedure  mischen;
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

			 constructor TKarte.create(name: String; zahl: Integer; hell: String; dunkel: String);
begin
	inherited Create;
	FName := name;
				 FZahl := zahl;
				 FHell := hell;
				 FDunkel := dunkel;
			 end;

function TKarte.aufdecken: String; 
var s: String;
begin
	randomize;
	s := FName;
case random(2)  of
0: s := s + sLineBreak + 'Dunkel: ' + FDunkel;
1: s:= s + sLineBreak + 'Hell: ' + FHell;
		else Writeln('huh?');
end;
	Result := s;
end;

function deckDatei(deckName: String): String;
begin
	  Result :=  GetCurrentDir + PathDelim + deckName + '.deck';
end;

constructor TStapel.create(deckName: String);
var 
  ini: TIniFile;
  filename: String;
  cards: TStringList;
  i: Integer;
  karte: TKarte;
begin
	inherited Create;
	// set our name
	FName := deckName;
	// create our card list
	FKarten := TObjectList<TKarte>.create(true);

	filename := deckDatei(deckName);
  // TODO: first check if deck file with given name exists
    ini := TIniFile.Create(filename);
	cards := TStringList.create;

    try
	    // Writeln('read all cards for ' + deckName + ' from ' +fileName); exit;
	     ini.readSections(cards);
	     // Writeln('output each card : ' + IntToStr(cards.count));
	     for i := 0 to cards.count -1 do
		     begin
		     karte := TKarte.create(
		     cards[i],
		     i+1,
		     ini.ReadString(cards[i], 'hell', 'h'),
		     ini.ReadString(cards[i], 'dunkel', 'd'));
	FKarten.add(karte);
		     end;

		        finally
				    ini.Free;
				    cards.free;
				      end;
			      end;

	function TStapel.zieheKarte(): TKarte;
begin
	try
		Result  := FKarten.extract( FKarten[0]);
	Except
		Result := TKarte.create('Keine Karten im Stapel', 0, 'bitte neu mischen', 'bitte neu mischen');
	end;
end;

procedure  TStapel.mischen;
begin
	FKarten.Sort(TComparer<TKarte>.Construct(
		function (const L, R: TKarte): integer
begin
	randomize;
	Result:=-1 + Random(3);
end
));
	end;

end.
