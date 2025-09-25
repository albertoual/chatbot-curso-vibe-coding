# find_gcloud_error.ps1
#
# Proposito: Analiza la transcripcion de Claude en busca de un error de 
#            autenticacion de gcloud especifico y reciente.
#
# Salida:
#   - Codigo de salida 0: Si se encuentra el error que cumple todas las condiciones.
#   - Codigo de salida 1: Si no se encuentra el error o si ocurre cualquier fallo.

try {
    # 1. Leer el evento de entrada y obtener la ruta de la transcripcion
    $evento = $Input | Out-String | ConvertFrom-Json
    $transcriptPath = $evento.transcript_path

    if (-not (Test-Path $transcriptPath)) {
        # El archivo no existe, no se puede continuar.
        exit 1
    }

    # 2. Definir el umbral de tiempo (hace 10 segundos desde ahora en UTC)
    $umbralTiempo = [DateTime]::UtcNow.AddSeconds(-2)

    # 3. Procesar la transcripcion para encontrar el mensaje relevante
    $mensajeError = Get-Content $transcriptPath -Encoding UTF8 | ForEach-Object {
        $_ | ConvertFrom-Json -ErrorAction SilentlyContinue
    } | Where-Object {
        $timestampValido = $false
        try {
            $timestamp = [datetime]::Parse($_.timestamp, $null, [System.Globalization.DateTimeStyles]::RoundtripKind)
            if ($timestamp -gt $umbralTiempo) {
                $timestampValido = $true
            }
        } catch {}

        # Comprobar todas las condiciones
        $_.type -eq 'assistant' -and
        $_.message.stop_reason -eq 'stop_sequence' -and
        $timestampValido -and
        $_.message.content[0].text -like '*API Error*' -and
        $_.message.content[0].text -like '*invalid_grant*'
    } | Select-Object -Last 1

    # 4. Devolver el codigo de salida apropiado
    if ($null -ne $mensajeError) {
        # ¡Éxito! Se encontró el error.
        exit 0
    } else {
        # No se encontró el error.
        exit 1
    }
}
catch {
    # Cualquier otro error durante la ejecucion del script.
    exit 1
}