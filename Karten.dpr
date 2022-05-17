program Karten;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  TSpiel in 'Spiel.pas';

  var
	  s: String;
	  i: Integer;
	  stapel: TStapel;
begin
  try
	  // create a TStapel
	  // and load a test deck
	  stapel := TStapel.create('test');
	  stapel.mischen;
	  Writeln(IntToStr(stapel.FKarten.count) + 'Karten geladen');
	  for i := 1 to stapel.FKarten.count  do
	  begin
		  Writeln(IntToStr(i) + '. gezogen:'+  SLineBreak + stapel.zieheKarte.asString);
	  end;

	  //  process user input
		repeat
			Readln(s);
			Writeln('Eingabe: ' + s);  
		until s = '.';

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
