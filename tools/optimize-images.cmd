@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM Optimize images for the Jamison Stamps & Books static site.
REM
REM Requirements:
REM - ImageMagick installed and available as `magick` on PATH
REM   https://imagemagick.org/
REM
REM Safety:
REM - Default mode is DRY RUN (writes *.opt.* next to originals)
REM - Use /inplace to overwrite originals
REM - Use /backup with /inplace to create .bak copies first
REM
REM Examples:
REM   tools\optimize-images.cmd
REM   tools\optimize-images.cmd /inplace /backup

set "ROOT=%~dp0.."
set "TARGET=%ROOT%\picts"

set "INPLACE=0"
set "BACKUP=0"

:parse
if "%~1"=="" goto run
if /I "%~1"=="/inplace" set "INPLACE=1"
if /I "%~1"=="/backup" set "BACKUP=1"
shift
goto parse

:run
where magick >nul 2>&1
if errorlevel 1 (
  echo ERROR: ImageMagick not found. Install it so `magick` is on PATH: https://imagemagick.org/
  exit /b 1
)

if not exist "%TARGET%" (
  echo ERROR: Expected image folder not found: "%TARGET%"
  exit /b 1
)

if "%INPLACE%"=="1" (
  echo In-place optimization ENABLED
  if "%BACKUP%"=="1" (
    echo Backups ENABLED ^(creates .bak next to each file^)
  ) else (
    echo Backups DISABLED
  )
) else (
  echo DRY RUN ^(no files overwritten^). Use /inplace to overwrite images.
)

for /r "%TARGET%" %%F in (*.jpg) do call :process "%%F"
for /r "%TARGET%" %%F in (*.jpeg) do call :process "%%F"
for /r "%TARGET%" %%F in (*.png) do call :process "%%F"

echo Done.
exit /b 0

:process
set "FILE=%~1"
set "EXT=%~x1"

if "%INPLACE%"=="1" (
  set "OUT=%FILE%"
  if "%BACKUP%"=="1" (
    if not exist "%FILE%.bak" copy /y "%FILE%" "%FILE%.bak" >nul
  )
  echo Optimizing: %FILE%
) else (
  set "OUT=%~dp1%~n1.opt%~x1"
  echo Would optimize: %FILE% ^-^> %OUT%
  goto :eof
)

if /I "%EXT%"==".png" (
  magick "%FILE%" -strip -define png:compression-level=9 "%OUT%" >nul
) else (
  magick "%FILE%" -strip -interlace Plane -quality 82 "%OUT%" >nul
)

goto :eof
