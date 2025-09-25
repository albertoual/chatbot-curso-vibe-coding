@echo off
REM ============================================================================
REM Hook para verificar sesion de gcloud y abrir Chrome si es necesario
REM ============================================================================

REM --- Configuracion de Chrome ---
set CHROME_PROFILE_DIR_NAME=Default
set CHROME_PATH="C:\Program Files\Google\Chrome\Application\chrome.exe"

REM Valida el token de acceso existente de forma explicita.
echo Verificando el estado de la autenticacion de gcloud...

set "ACCESS_TOKEN="
for /f "tokens=*" %%a in ('gcloud auth application-default print-access-token --quiet 2^>NUL') do set "ACCESS_TOKEN=%%a"

if not defined ACCESS_TOKEN (
    REM No hay credenciales locales, se necesita autenticacion.
    set "AUTH_STATUS=INVALID"
) else (
    REM Se encontro un token, se procede a validarlo con la API de tokeninfo.
    curl -s -f -H "Authorization: Bearer %ACCESS_TOKEN%" "https://www.googleapis.com/oauth2/v1/tokeninfo" > NUL 2>&1
    if %ERRORLEVEL% EQU 0 (
        set "AUTH_STATUS=VALID"
    ) else (
        set "AUTH_STATUS=INVALID"
    )
)

IF "%AUTH_STATUS%"=="VALID" (
    echo Las credenciales de gcloud existentes parecen ser validas.
) ELSE (
    echo Credenciales no validas o caducadas. Se iniciara el proceso de re-autenticacion.
    echo Iniciando sesion en gcloud...
    REM Abrir Chrome con el perfil correcto y luego iniciar sesion.
    echo Abriendo Chrome con el perfil '%CHROME_PROFILE_DIR_NAME%'...
    start "" %CHROME_PATH% --profile-directory="%CHROME_PROFILE_DIR_NAME%"
    echo Iniciando la autenticacion de gcloud...
    gcloud auth application-default login
)