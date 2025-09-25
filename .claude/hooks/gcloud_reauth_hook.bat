@echo off
setlocal enabledelayedexpansion

REM ============================================================================
REM Hook Principal (BAT): Llama al detector de PowerShell y actua si es necesario.
REM Version Final
REM ============================================================================

REM --- Configuracion ---
set "CHROME_PROFILE_DIR_NAME=Default"
set "CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe"
set "DETECTOR_SCRIPT=%~dp0find_gcloud_error.ps1"

REM 1. Leer todo el stdin (el JSON del evento) a una variable.
set "JSON_INPUT="
for /f "delims=" %%L in ('more') do set "JSON_INPUT=!JSON_INPUT!%%L"

REM 2. Ejecutar el script detector de PowerShell, pasandole el JSON como entrada.
echo %JSON_INPUT% | powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%DETECTOR_SCRIPT%"

REM 3. Comprobar el codigo de salida (ERRORLEVEL) del script de PowerShell.
if %ERRORLEVEL% EQU 0 (
    if exist "%CHROME_PATH%" (
        start "" "%CHROME_PATH%" --profile-directory="%CHROME_PROFILE_DIR_NAME%"
        gcloud auth application-default login
    )
)

endlocal