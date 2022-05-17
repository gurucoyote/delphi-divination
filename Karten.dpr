program Karten;

{$APPTYPE CONSOLE}

{$R *.res}

uses
	System.SysUtils,
	Classes,
	Spiel in 'Spiel.pas';

var
	lInput, lLastInput: String;
	lCmdList: TStrings;
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
	lCmdList := TStringList.create;
	try
		lLastInput := '.';
		repeat
			ReadLn(lInput);
			if lInput.length = 0 then 
	lInput := lLastInput;

	lCmdList.clear;
ExtractStrings([' '], [], PChar(lInput), lCmdList);
var c: Integer;
for c := 0 to lCmdList.count-1 do
	begin
	WriteLn(lCmdList[c]);
end;

			case lCmdList[0][1] of
			'l': begin
				if lCmdList.count > 1 then
					laden(lCmdList[1] )
				else 
				laden('test');
			end;
			'z': begin
				if lCmdList.count > 1 then
					ziehen(StrToInt(lCmdList[1]))
				else
					ziehen(1);
			end;
			'm': laden(stapel.FName);
			'q': lInput := '.';// end this loop
		else  WriteLn('unbekannter Befehl ' + lInput);
	end;
	lLastInput := lInput;
until lInput = '.';

  finally
	  lCmdList.free;
stapel.free;
end;
  except
	  on E: Exception do
		  Writeln(E.ClassName, ': ', E.Message);
  end;
end.
