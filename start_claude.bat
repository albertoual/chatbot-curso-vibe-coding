@echo off
REM ============================================================================
REM Script para iniciar Claude Code con configuracion de Vertex AI
REM ============================================================================

echo Configurando variables de entorno para Claude Code...

REM --- Configuracion de Proxy Corporativo ---
set HTTP_PROXY=http://185.46.212.88:80
set HTTPS_PROXY=http://185.46.212.88:80

REM --- Configuracion General de Vertex AI ---
set CLAUDE_CODE_USE_VERTEX=1
set ANTHROPIC_VERTEX_PROJECT_ID=tecpr04s-globlc-roboauto
REM Establece la region por defecto. Puede ser sobreescrita por modelos especificos.
set CLOUD_ML_REGION=europe-west1

REM ============================================================================
REM --- Seleccion de Modelo Principal ---
REM Descomenta la seccion del modelo que deseas utilizar y comenta la otra.
REM ============================================================================

REM --- Opcion 1: Claude Sonnet 4 (Activado por defecto) ---
set ANTHROPIC_MODEL=claude-sonnet-4@20250514
set VERTEX_REGION_CLAUDE_4_0_SONNET=europe-west1
REM ---------------------------------------------------------

REM --- Opcion 2: Claude Opus 4.1 ---
REM set ANTHROPIC_MODEL=claude-opus-4-1@20250805
REM set VERTEX_REGION_CLAUDE_4_1_OPUS=europe-west1
REM ---------------------------------------------------------

REM ============================================================================
REM --- Configuracion Adicional Opcional ---
REM ============================================================================

REM --- Modelo Secundario (Rapido) ---
REM Utilizado para tareas mas pequenas y rapidas. El predeterminado es Haiku.
set ANTHROPIC_SMALL_FAST_MODEL=claude-3-5-haiku@20241022
set VERTEX_REGION_CLAUDE_3_5_HAIKU=europe-west1

REM --- Cache de Prompts ---
REM Descomenta la siguiente linea para deshabilitar el cache de prompts.
REM Util cuando se necesita una respuesta fresca sin cache.
REM set DISABLE_PROMPT_CACHING=1

echo Variables configuradas. Iniciando Claude Code...
echo.

REM Iniciar Claude Code con las variables cargadas
claude