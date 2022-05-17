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
			 function asString: String; 
		 end;

		 type
			 TStapel = class
				 FName: String;
	FKarten: TObjectList<TKarte>;
constructor create(deckName: String);
	function zieheKarte(): TKarte;
	procedure  neuMischen;
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
SysUtils;

			 constructor TKarte.create(name: String; zahl: Integer; hell: String; dunkel: String);
			 begin
				 FName := name;
				 FZahl := zahl;
				 FHell := hell;
				 FDunkel := dunkel;
			 end;
function TKarte.asString: String; 
begin
	Result := FName + SLineBreak + FHell + SLineBreak + FDunkel;
end;

function deckDatei(deckName: String): String;
begin
	// return relative path
	  // Result :=   deckName + '.deck';
	  Result :=  ExtractFilePath(ParamStr(0)) + deckName + '.deck';
end;

// TODO: turn into a constructor
constructor TStapel.create(deckName: String);
var 
  ini: TIniFile;
  filename: String;
  cards: TStringList;
  i: Integer;
  karte: TKarte;
begin
	// set our name
	FName := deckName;
	// create our card list
	FKarten := TObjectList<TKarte>.create(true);

	filename := deckDatei(deckName);
  // TODO: first check if deck file with given name exists
    ini := TIniFile.Create(filename);
	cards := TStringList.create;

    try
	    // Writeln('read all cards for ' + deckName + ' from ' +fileName);
	     ini.readSections(cards);
	     // Writeln('output each card : ' + IntToStr(cards.count));
	     for i := 0 to cards.count -1 do
		     begin
		     karte := TKarte.create(
		     cards[i],
		     i,
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
	Result  := FKarten.extract( FKarten[0]);
end;

	procedure  TStapel.neuMischen;
	begin
	end;

end.
