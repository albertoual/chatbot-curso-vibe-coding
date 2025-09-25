Formateo y corrección de código con Black y Flake8

**AMBITO_APLICACION**: `$ARGUMENTS`

---

### 0. Objetivo

Tu objetivo es formatear y corregir el código de forma iterativa hasta que `black` y `flake8` no reporten ningún problema. Eres completamente autónomo para añadir, modificar o eliminar código con el fin de alcanzar este objetivo, así que no pidas permiso para realizar estas acciones.

El ámbito de aplicación viene definido por la variable "AMBITO_APLICACION" más arriba. Si está vacía, la ruta objetivo será `.`, es decir, todo el proyecto; de lo contrario, se usará la ruta especificada.

---

### 1. Preparación del Entorno

Antes de comenzar, realiza las siguientes comprobaciones y ajústalas si es necesario:

* **Asegura las dependencias:**
    * Comprueba si los comandos `black` y `flake8` están disponibles en el entorno, mediante el uso de 'uv run python -m'.
    * Si uno o ambos no existen, ejecuta `uv pip install black flake8` para instalarlos.

* **Asegura la configuración de Flake8:**
    * Busca un archivo `.flake8` en la raíz del proyecto.
    * Si no existe, créalo con este contenido exacto (sin incluir las etiquetas `<contenido>`):
<contenido>
[flake8]
max-line-length = 88
ignore = E203, E266, E501, W503, F403, F401, E402
exclude = .venv
</contenido>
    * NOTA: E402 se incluye porque es común en archivos de test que manipulan sys.path antes de imports.

---

### 2. Ciclo de Corrección Iterativa

Entra en un bucle que se repetirá un **máximo de 5 veces**. El ciclo termina antes si el código queda limpio.

**En cada iteración:**

1.  **Ejecuta `black`:** Aplica el formateador `black` sobre la ruta objetivo para solucionar todos los problemas de estilo.
2.  **Ejecuta `flake8`:** Inmediatamente después, ejecuta `flake8` sobre la misma ruta para obtener la lista de errores restantes.
3.  **Evalúa el resultado:**
    * **Si `flake8` no devuelve ningún error:** El código está limpio. Pasa directamente al paso 3 (Informe Final).
    * **Si `flake8` reporta errores:** Analiza cada error y modifica el código fuente para corregirlos. Errores comunes incluyen:
        - **E226**: `missing whitespace around arithmetic operator` → Cambiar `i+1` por `i + 1`
        - **E712**: `comparison to True should be 'if cond is True:'` → Cambiar `== True` por `is True`
        - **E402**: `module level import not at top of file` → Reordenar imports (común en tests que manipulan sys.path)
        - **F821**: `undefined name` → Añadir imports faltantes o corregir nombres de variables

4.  **Estrategias de corrección eficiente:**
    * **Para múltiples instancias del mismo error:** Usa `replace_all=true` en Edit tool
    * **Para errores E402 en tests:** Considera añadir E402 a .flake8 si es apropiado para el proyecto
    * **Para errores de espaciado:** Black debería resolverlos automáticamente en la mayoría de casos

---

### 3. Ejecuta los tests unitarios

Ejecuta los tests unitarios mediante el comando 'uv run python -m pytest' para garantizar que no se ha roto nada de la funcionalidad. En caso de que falle alguno, corrige el código, y vuelve al punto 2 para verificar que pasen las correcciones iterativas.

### 4. Informe Final

Tu respuesta final debe ser **únicamente uno** de los siguientes mensajes, sin añadir nada más:

* **Si los ciclos terminaron con éxito y pasaron todos los tests:**
    ```
    ✅ /limpiar_codigo: Código limpio. Black y Flake8 no reportan más problemas, y pasaron correctamente todos los tests unitarios.
    ```

* **Si se alcanzó el límite de 5 iteraciones sin éxito:**
    ```
    ⚠️ /limpiar_codigo: No se pudo completar la limpieza del código tras 5 iteraciones. Errores pendientes:
    ```
    Y a continuación, muestra la última salida de `flake8` con los errores que no se pudieron resolver.