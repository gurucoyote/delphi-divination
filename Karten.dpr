program Karten;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Windows,
  Classes,
  Spiel in 'Spiel.pas';

var
  lSpiel: TSpiel;

  // main
begin

  try // outer app try block
    lSpiel := TSpiel.create;
    lSpiel.verarbeiteEingabe(lSpiel.verarbeiteCmdZeile);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
