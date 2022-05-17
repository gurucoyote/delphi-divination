program Karten;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Windows,
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
    for i := 1 to anz do
    begin
      k := stapel.zieheKarte;
      Writeln(IntToStr(i) + ' gezogen:');
      Writeln(Utf8String(k.aufdecken));
      if k.FZahl = 0 then
        break;
    end; // end loop
  finally
    k.free;
  end; // try
end;

// main
begin
  SetConsoleOutputCP(CP_UTF8);
  SetTextCodePage(Output, CP_UTF8);
  try // outer app try block
    // handle command line params
    if FindCmdLineSwitch('l', lInput) then
    begin
      laden(lInput);
      if FindCmdLineSwitch('z', lInput) then
      begin
        try
          ziehen(StrToInt(lInput));
        except
          ziehen(1);
        end;
      end; // end z param
      // if user didn't request interactive mode, exit
      if not FindCmdLineSwitch('i', lInput) then
        exit
      else
        lLastInput := 'z';
    end;

    // handle interactive user input
    lCmdList := TStringList.create;
    try
      repeat
        ReadLn(lInput);
        if lInput.length = 0 then
          lInput := lLastInput;

        lCmdList.clear;
        ExtractStrings([' '], [], PChar(lInput), lCmdList);
        // var c: Integer;
        // for c := 0 to lCmdList.count-1 do
        // begin
        // WriteLn(lCmdList[c]);
        // end;

        case lCmdList[0][1] of
          'l':
            begin
              if lCmdList.count > 1 then
                laden(lCmdList[1])
              else
                laden('test');
            end;
          'z':
            begin
              if lCmdList.count > 1 then
                ziehen(StrToInt(lCmdList[1]))
              else
                ziehen(1);
            end;
          'm':
            laden(stapel.FName);
          'q':
            lInput := '.'; // end this loop
          '.':
            Writeln('Und Tschüß');
        else
          Writeln('unbekannter Befehl ' + lInput);
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
