@echo off
setlocal EnableDelayedExpansion
title DFUp
rem ============================================================
rem dfup.cmd - DF-Programme von https://d-ai.at/dfup/ holen
rem            (Ausweichquelle: GitHub-Releases dai-info)
rem
rem Braucht nur curl.exe (in Windows 10 ab 1803 enthalten), kein PowerShell.
rem
rem Erstinstallation: diese Datei in den df-Ordner legen (z.B. C:\df)
rem                   und doppelklicken. Update: wieder doppelklicken.
rem
rem Ablage:  df\cps\   cps.exe, cpss.exe, libcurl.dll
rem          df\f2p\   F2P.exe, f2x.exe, TE.exe, DFPanel.exe, help\*.md,
rem                    DFCon.exe, OpenConsoleProxy.dll
rem
rem Ohne Rueckfragen:  dfup.cmd 7          (Auswahl als Parameter, Ziel = eigener Ordner)
rem                    set DFDIR=T:\df     (Zielordner vorgeben)
rem ============================================================
set "URL=https://d-ai.at/dfup"
set "GH=https://github.com/dai-info"
set /a FEHLER=0

where curl.exe >nul 2>&1
if errorlevel 1 (
  echo curl.exe fehlt. Windows 10 ab Version 1803 noetig, sonst dfup.ps1 verwenden.
  pause
  exit /b 1
)

rem --- Zielordner: DFDIR, sonst Ordner dieser Datei --------------------------
set "DF=%DFDIR%"
if defined DF goto :df_ok
set "VOR=%~dp0"
set "VOR=!VOR:~0,-1!"
if not "%~1"=="" set "DF=!VOR!"
if defined DF goto :df_ok
set /p "DF=Zielordner [!VOR!]: "
if not defined DF set "DF=!VOR!"
:df_ok
if "!DF:~-1!"=="\" set "DF=!DF:~0,-1!"
if not exist "!DF!" mkdir "!DF!"
echo df-Ordner: !DF!

rem --- Auswahl ----------------------------------------------------------------
set "SEL=%~1"
if not defined SEL set "SEL=%DFSEL%"
if defined SEL goto :sel_ok
echo.
echo   0  nichts ^(Abbruch^)
echo   1  TE     -^> !DF!\f2p
echo   2  F2P    -^> !DF!\f2p
echo   3  CPS    -^> !DF!\cps
echo   4  DFCon  -^> !DF!\f2p
echo   7  alle
echo.
set /p "SEL=Auswahl (mehrere moeglich, z.B. 13) [7]: "
if not defined SEL set "SEL=7"
:sel_ok
if "!SEL!"=="0" echo Nichts gemacht.& exit /b 0
set "W_TE=" & set "W_F2P=" & set "W_CPS=" & set "W_DFCON=" & set "SYS32="
if not "!SEL:7=!"=="!SEL!" set "W_TE=1" & set "W_F2P=1" & set "W_CPS=1" & set "W_DFCON=1"
if not "!SEL:1=!"=="!SEL!" set "W_TE=1"
if not "!SEL:2=!"=="!SEL!" set "W_F2P=1"
if not "!SEL:3=!"=="!SEL!" set "W_CPS=1"
if not "!SEL:4=!"=="!SEL!" set "W_DFCON=1"
if not "!SEL:9=!"=="!SEL!" set "W_TE=1" & set "SYS32=1"
if not defined W_TE if not defined W_F2P if not defined W_CPS if not defined W_DFCON (
  echo Ungueltige Auswahl: !SEL!
  exit /b 1
)

rem --- Download ---------------------------------------------------------------
del /s /q "!DF!\*.old" >nul 2>&1
if defined W_TE (
  echo.
  echo TE -^> !DF!\f2p
  call :hole f2p TE.exe te
  call :hole f2p DFPanel.exe te
  call :hole f2p\help cps.md te help/
  call :hole f2p\help f2p.md te help/
  call :hole f2p\help form.md te help/
)
if defined W_F2P (
  echo.
  echo F2P -^> !DF!\f2p
  call :hole f2p F2P.exe f2p
  call :hole f2p f2x.exe f2p
)
if defined W_CPS (
  echo.
  echo CPS -^> !DF!\cps
  call :hole cps cps.exe cps
  call :hole cps cpss.exe cps
  call :hole cps libcurl.dll cps
)
if defined W_DFCON (
  echo.
  echo DFCon -^> !DF!\f2p
  call :hole f2p DFCon.exe dfcon
  call :hole f2p OpenConsoleProxy.dll dfcon
)

rem --- 9: TE.exe + DFPanel.exe + help nach System32 (nur als Administrator) ----
if defined SYS32 if exist "!DF!\f2p\TE.exe" (
  echo.
  echo TE.exe, DFPanel.exe, help\ -^> %windir%\System32
  net session >nul 2>&1
  if errorlevel 1 (
    echo   FEHLER: keine Adminrechte. dfup.cmd per Rechtsklick "Als Administrator ausfuehren" starten.
    set /a FEHLER+=1
  ) else (
    call :sys32 TE.exe
    call :sys32 DFPanel.exe
    if not exist "%windir%\System32\help" mkdir "%windir%\System32\help"
    copy /y "!DF!\f2p\help\*.md" "%windir%\System32\help\" >nul
    echo   kopiert, 'te' startet jetzt aus jedem Fenster
  )
)

echo.
if !FEHLER! gtr 0 (
  echo Fertig mit !FEHLER! Fehler^(n^).
) else (
  echo Fertig. Naechstes Update: Doppelklick auf !DF!\dfup.cmd
)
if "%~1"=="" pause
exit /b !FEHLER!

rem ============================================================
rem :hole  Unterordner  Datei  Repo  [Unterpfad auf d-ai.at, z.B. help/]
rem ============================================================
:hole
set "Z=!DF!\%~1\%~2"
if not exist "!DF!\%~1" mkdir "!DF!\%~1"
curl -s -S -f -L --connect-timeout 20 -o "!Z!.neu" "%URL%/%~4%~2" 2>nul
if errorlevel 1 curl -s -S -f -L --connect-timeout 20 -o "!Z!.neu" "%GH%/%~3/releases/latest/download/%~2" 2>nul
if errorlevel 1 (
  del /q "!Z!.neu" >nul 2>&1
  echo   %~2  FEHLER: Download fehlgeschlagen
  set /a FEHLER+=1
  exit /b
)
rem laufende EXE laesst sich nicht ueberschreiben, aber umbenennen
if exist "!Z!" move /y "!Z!" "!Z!.old" >nul
move /y "!Z!.neu" "!Z!" >nul
del /q "!Z!.old" >nul 2>&1
for %%s in ("!Z!") do set /a KB=%%~zs/1024
set "N=%~2                      "
echo   !N:~0,22! !KB! KB  ok
rem alte flache Ablage (vor Oktober 2026 lag alles direkt im df-Ordner) aufraeumen
if exist "!DF!\%~2" (
  del /q "!DF!\%~2" >nul 2>&1
  if exist "!DF!\%~2" move /y "!DF!\%~2" "!DF!\%~2.old" >nul
  echo   %~2  aus !DF! entfernt ^(liegt jetzt in %~1^)
)
exit /b

:sys32
set "Q=!DF!\f2p\%~1"
set "S=%windir%\System32\%~1"
if exist "!S!" move /y "!S!" "!S!.old" >nul
copy /y "!Q!" "!S!" >nul
del /q "!S!.old" >nul 2>&1
exit /b
