# A small divination tool for the CLI, written in Delphi

This little project was created to get my fingers wet in writing Delphi (10.3) code in a terminal, not using the IDE.

## Purpose:

- on startup, load a simple INI file with a set of ''cards' that define a name, a light and a dark side.
- let the user draw one or more cards, randomly picking them from the deck, and randomly showing the light or dark side
- show each card only onece, let the user re-shuffle the deck to start over

## building the project with msbuild.exe 

(describe here)

## using the tool, define your own deck etc.

(describe here)

## requirements for building

- Delphi 10.3 or higher, the free community edition should do
- some knowledge of how to build via the command line (will give examples soon)

### building a delpi  project in cmd

```
echo Load resvars.bat
call "C:\Program Files (x86)\Embarcadero\Studio\21.0\bin\rsvars.bat"
echo run msbuild
msbuild.exe -v:q -nologo
```
