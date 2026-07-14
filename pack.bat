@echo off
setlocal

rem ==============================================================
rem  retoc-Packer: 2pack (.uasset/.uexp) -^> output (.utoc/.ucas)
rem  Spiel: Laundering Simulator (Unreal Engine 5.3)
rem ==============================================================

rem Engine-Version des Spiels (Laundering Simulator = UE5_3)
set "VERSION=UE5_3"

rem In den Ordner dieser Batch-Datei wechseln
cd /d "%~dp0"

if not exist "retoc.exe" (
    echo [FEHLER] retoc.exe nicht gefunden - pack.bat muss neben retoc.exe liegen.
    pause
    exit /b 1
)

if not exist "2pack\*.uasset" (
    echo [FEHLER] Keine .uasset-Dateien im Ordner "2pack" gefunden.
    pause
    exit /b 1
)

rem Mod-Name automatisch vom ersten .uasset im Ordner "2pack" uebernehmen
set "MODNAME="
for %%F in ("2pack\*.uasset") do if not defined MODNAME set "MODNAME=%%~nF"
echo Mod-Name (aus 2pack uebernommen): %MODNAME%

if not exist "output" mkdir "output"

echo Konvertiere Assets aus "2pack" nach "output\%MODNAME%.utoc/.ucas" ...
echo.

retoc.exe to-zen "2pack" "output\%MODNAME%.utoc" --version %VERSION%

if errorlevel 1 (
    echo.
    echo [FEHLER] retoc ist fehlgeschlagen - Meldung oben pruefen.
    pause
    exit /b 1
)

echo.
echo [OK] Fertig! Erzeugte Dateien im Ordner "output":
dir /b "output\%MODNAME%.*"
echo.
echo Hinweis: Alle drei Dateien (.pak + .ucas + .utoc) zusammen kopieren nach:
echo   C:\Steam\steamapps\common\Laundering Simulator\LaunderingSimulator\Content\Paks\Mods
echo.
pause
