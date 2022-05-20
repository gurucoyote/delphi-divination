@echo off 
:: IMPORTANT: change to dir this script lives in
cd /D %~dp0
:: need to load the rsvars.bat to setup enviroment
call "C:\Program Files (x86)\Embarcadero\Studio\21.0\bin\rsvars.bat"
:: actual build script
echo building Release
msbuild.exe -v:q -nologo -p:config=release || goto :error
:: only do this if no error occured
echo OK
:: obviously jump over error reporting
goto :EOF
   :error
echo FAILED
