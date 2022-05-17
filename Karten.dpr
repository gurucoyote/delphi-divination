program Karten;

{$APPTYPE CONSOLE}

{$R *.res}

uses
	System.SysUtils,
	Spiel in 'Spiel.pas';

var
	s: String;
	stapel: TStapel;

	procedure laden(deckName: String);
begin
	stapel := TStapel.create(deckName);
	stapel.mischen;
	Writeln(IntToStr(stapel.FKarten.count) + 'Karten geladen');
end;

procedure ziehen(anz: Integer);
var 
k: TKarte;
i: Integer;
begin
	k := TKarte.create('', -1, '', '');
	try
		for i := 1 to anz  do
		begin
			k := stapel.zieheKarte;
			Writeln(IntToStr(i) + '. gezogen:'+  SLineBreak + k.aufdecken);
			if k.FZahl = 0 then
				break;
			end; // end loop
		finally
			k.free;
		end; // try
	end;

	// main
begin
	try

		//  process user input
		repeat
			Readln(s);
			case s[1] of
			'l': laden('test');
			'z': ziehen(1);
		else s := '.'; // end this loop
	end;
	// Writeln('Eingabe: ' + s);  
until s = '.';

  except
	  on E: Exception do
		  Writeln(E.ClassName, ': ', E.Message);
  end;
end.
