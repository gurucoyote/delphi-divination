@echo off
echo change to dir this script lives in
@echo on
cd /D %~dp0
@echo off
echo Load resvars.bat
call "C:\Program Files (x86)\Embarcadero\Studio\21.0\bin\rsvars.bat"
echo run msbuild
msbuild.exe -v:q -nologo
dir /b win32
