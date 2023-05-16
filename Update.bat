@ECHO OFF
SET ZIP_PATH=C:\Program Files\7-Zip\
SET PATH=%PATH%;%ZIP_PATH%

SET "CLIENT="
FOR /F %%A IN (.\.eclipseproduct) DO (
	ECHO %%A | FINDSTR /r version > NUL
	IF NOT ERRORLEVEL 1 SET "CLIENT=%%A"
)

MKDIR .update

ECHO Current client is:
ECHO %CLIENT%
ECHO.

ECHO Downloading DBeaver Windows 64 bit (zip)...

POWERSHELL -ExecutionPolicy Unrestricted -File Update.ps1
SET /P NEW_CLIENT=<new_version.txt
ECHO.

IF "%NEW_CLIENT%" == "%CLIENT%" GOTO skip

RMDIR /s /q configuration features jre licenses Meta-inf p2 plugins

7z x .update\dbeaver-ce-latest-win32.win32.x86_64.zip -o.update | FIND "Extracting archive:"

ROBOCOPY .update\dbeaver . /NFL /NDL /NJH /NJS /NS /NC /E /R:0 /DCOPY:T

SET "CLIENT="
FOR /F %%A IN (.\.eclipseproduct) DO (
	ECHO %%A | FINDSTR /r version > NUL
	IF NOT ERRORLEVEL 1 SET "CLIENT=%%A"
)

ECHO New client is:
ECHO %CLIENT%
GOTO end

:skip
ECHO Current client is up to date

:end
RMDIR /s /q .update
ECHO.

TIMEOUT /T 25
