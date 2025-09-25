# notificacion_hook_final.ps1
# Versión 2.3: Versión final sin logging, con correcciones para manejo de objetos y arrays.

try {
    # --- Lógica de extracción de datos ---
    $evento = $Input | Out-String | ConvertFrom-Json
    $transcriptPath = $evento.transcript_path
    if (-not (Test-Path $transcriptPath)) { throw "El archivo transcript no se encontró." }

    # 1. Busca el último mensaje de usuario.
    $ultimoMensajeUsuario = Get-Content $transcriptPath -Encoding UTF8 | ForEach-Object {
        $_ | ConvertFrom-Json -ErrorAction SilentlyContinue
    } | Where-Object {
        $_.type -eq 'user' -and $_.message.role -eq 'user'
    } | Select-Object -Last 1

    if (-not $ultimoMensajeUsuario) { throw "No se encontró ningún mensaje de usuario en la transcripción." }

    # 2. Extrae el contenido de forma segura, convirtiéndolo a un único string.
    $contenidoFinal = ($ultimoMensajeUsuario.message.content | Out-String -Stream) -join [Environment]::NewLine
    if ([string]::IsNullOrWhiteSpace($contenidoFinal)) { throw "El contenido del último mensaje está vacío." }

    # --- Lógica de notificación mejorada ---
    # 3. Determina el tipo de contenido para una notificación más informativa.
    $tipoContenido = "Mensaje" # Valor por defecto
    if ($ultimoMensajeUsuario.message.content -is [array]) {
        $tipoContenido = $ultimoMensajeUsuario.message.content[0].type
    } elseif ($null -ne $ultimoMensajeUsuario.message.content.type) {
        $tipoContenido = $ultimoMensajeUsuario.message.content.type
    }
    
    $tipoContenidoFormateado = (Get-Culture).TextInfo.ToTitleCase($tipoContenido.Replace("_", " "))
    $titulo = "Claude: $tipoContenidoFormateado Finalizado"

    # 4. Trunca el contenido si es demasiado largo.
    if ($contenidoFinal.Length -gt 200) {
        $contenidoFinal = $contenidoFinal.Substring(0, 197) + "..."
    }

    # 5. Muestra la notificación.
    Add-Type -AssemblyName System.Windows.Forms
    $toast = New-Object System.Windows.Forms.NotifyIcon
    $toast.Icon = [System.Drawing.SystemIcons]::Information
    $toast.BalloonTipTitle = $titulo
    $toast.BalloonTipText = $contenidoFinal
    $toast.Visible = $true
    $toast.ShowBalloonTip(10000)
}
catch {
    # Si algo falla, muestra el error en una notificación de globo.
    $errorMessage = "Error en el hook: " + $_.Exception.Message.Split([Environment]::NewLine)[0]
    Add-Type -AssemblyName System.Windows.Forms
    $toast = New-Object System.Windows.Forms.NotifyIcon
    $toast.Icon = [System.Drawing.SystemIcons]::Error
    $toast.BalloonTipTitle = "Error en Hook de Claude"
    $toast.BalloonTipText = $errorMessage
    $toast.Visible = $true
    $toast.ShowBalloonTip(15000)
}
finally {
    # Limpieza del objeto NotifyIcon para evitar que el icono persista.
    if ($toast) {
        $toast.Dispose()
    }
}