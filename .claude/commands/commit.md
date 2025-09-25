Comando para crear commits bien formateados con mensajes convencionales y emojis.

## Qué hace este comando

1. Verifica qué archivos están preparados con `git status`
2. Si no hay archivos preparados, añade automáticamente todos los archivos modificados y nuevos con `git add`
3. Ejecuta un `git diff` para entender qué cambios se están incluyendo en el commit
4. Analiza el diff para determinar si hay múltiples cambios lógicos distintos
5. Si se detectan varios cambios distintos, sugiere dividir el commit en varios más pequeños
6. Para cada commit (o el único si no se divide), crea un mensaje siguiendo el formato convencional con emojis

## Buenas prácticas para commits

- **Commits atómicos**: Cada commit debe contener cambios relacionados que cumplan un único propósito
- **Divide los cambios grandes**: Si los cambios afectan a múltiples aspectos, divídelos en commits separados
- **Formato convencional de commit**: Usa el formato `<type>: <description>` donde el tipo puede ser:
  - `feat`: Una nueva funcionalidad
  - `fix`: Corrección de errores
  - `docs`: Cambios en la documentación
  - `style`: Cambios de estilo en el código (formato, etc.)
  - `refactor`: Cambios en el código que no corrigen errores ni añaden funcionalidades
  - `perf`: Mejoras de rendimiento
  - `test`: Añadir o corregir pruebas
  - `chore`: Cambios en el proceso de construcción, herramientas, etc.
- **Tiempo presente, modo imperativo**: Escribe los mensajes como comandos (ej. "agregar funcionalidad" en lugar de "agregada funcionalidad")
- **Mensajes sin acentos, sólo alfanumericos básicos**: Escribe sin signos de puntuación y sustituye la letra "ñ" por "ni" en los mensajes (ej. "incluir anio de defuncion" en lugar de "incluir año de defunción")
- **Primera línea concisa**: Mantén la primera línea por debajo de los 72 caracteres
- **Emoji**: Cada tipo de commit se asocia con un emoji apropiado:
  - ✨ `feat`: Nueva funcionalidad  
  - 🐛 `fix`: Corrección de errores  
  - 📝 `docs`: Documentación  
  - 💄 `style`: Formato/estilo  
  - ♻️ `refactor`: Refactorización de código  
  - ⚡️ `perf`: Mejoras de rendimiento  
  - ✅ `test`: Pruebas  
  - 🔧 `chore`: Herramientas, configuración  
  - 🚀 `ci`: Mejoras en CI/CD  
  - 🗑️ `revert`: Revertir cambios  
  - 🧪 `test`: Añadir prueba que falla  
  - 🚨 `fix`: Corregir advertencias de compilador/linter  
  - 🔒️ `fix`: Corregir problemas de seguridad  
  - 👥 `chore`: Añadir o actualizar colaboradores  
  - 🚚 `refactor`: Mover o renombrar recursos  
  - 🏗️ `refactor`: Cambios arquitectónicos  
  - 🔀 `chore`: Fusionar ramas  
  - 📦️ `chore`: Añadir o actualizar archivos compilados o paquetes  
  - ➕ `chore`: Añadir una dependencia  
  - ➖ `chore`: Eliminar una dependencia  
  - 🌱 `chore`: Añadir o actualizar archivos de semillas  
  - 🧑‍💻 `chore`: Mejorar experiencia del desarrollador  
  - 🧵 `feat`: Añadir o actualizar código relacionado con multihilo o concurrencia  
  - 🔍️ `feat`: Mejorar SEO  
  - 🏷️ `feat`: Añadir o actualizar tipos  
  - 💬 `feat`: Añadir o actualizar textos y literales  
  - 🌐 `feat`: Internacionalización y localización  
  - 👔 `feat`: Añadir o actualizar lógica de negocio  
  - 📱 `feat`: Trabajar en diseño responsivo  
  - 🚸 `feat`: Mejorar experiencia de usuario / usabilidad  
  - 🩹 `fix`: Corrección simple para un problema no crítico  
  - 🥅 `fix`: Capturar errores  
  - 👽️ `fix`: Actualizar código por cambios en APIs externas  
  - 🔥 `fix`: Eliminar código o archivos  
  - 🎨 `style`: Mejorar estructura/formato del código  
  - 🚑️ `fix`: Hotfix crítico  
  - 🎉 `chore`: Comenzar un proyecto  
  - 🔖 `chore`: Etiquetas de versión/lanzamiento  
  - 🚧 `wip`: Trabajo en progreso  
  - 💚 `fix`: Corregir compilación en CI  
  - 📌 `chore`: Fijar versiones de dependencias  
  - 👷 `ci`: Añadir o actualizar sistema de compilación CI  
  - 📈 `feat`: Añadir o actualizar código de analítica o seguimiento  
  - ✏️ `fix`: Corregir errores tipográficos  
  - ⏪️ `revert`: Revertir cambios  
  - 📄 `chore`: Añadir o actualizar licencia  
  - 💥 `feat`: Introducir cambios incompatibles  
  - 🍱 `assets`: Añadir o actualizar recursos  
  - ♿️ `feat`: Mejorar accesibilidad  
  - 💡 `docs`: Añadir o actualizar comentarios en el código fuente  
  - 🗃️ `db`: Realizar cambios relacionados con base de datos  
  - 🔊 `feat`: Añadir o actualizar logs  
  - 🔇 `fix`: Eliminar logs  
  - 🤡 `test`: Mockear elementos  
  - 🥚 `feat`: Añadir o actualizar un easter egg  
  - 🙈 `chore`: Añadir o actualizar archivo .gitignore  
  - 📸 `test`: Añadir o actualizar snapshots  
  - ⚗️ `experiment`: Realizar experimentos  
  - 🚩 `feat`: Añadir, actualizar o eliminar flags de funcionalidades  
  - 💫 `ui`: Añadir o actualizar animaciones y transiciones  
  - ⚰️ `refactor`: Eliminar código muerto  
  - 🦺 `feat`: Añadir o actualizar código relacionado con validaciones  
  - ✈️ `feat`: Mejorar soporte offline

## Guías para dividir commits

Al analizar el diff, considera dividir los commits según estos criterios:

1. **Diferentes aspectos**: Cambios en partes no relacionadas del código
2. **Tipos distintos de cambios**: Mezcla de funcionalidades, correcciones, refactorizaciones, etc.
3. **Patrones de archivo**: Cambios en distintos tipos de archivos (ej. código fuente vs documentación)
4. **Agrupación lógica**: Cambios que serían más fáciles de entender o revisar por separado
5. **Tamaño**: Cambios muy grandes que serían más claros si se dividen

## Ejemplos

Buenos mensajes de commit:
- ✨ feat: aniadir sistema de autenticacion de usuario
- 🐛 fix: resolver fuga de memoria en el proceso de renderizado
- 📝 docs: actualizar la documentacion de la API con nuevos endpoints
- ♻️ refactor: simplificar la logica de manejo de errores en el parser
- 🚨 fix: resolver advertencias del linter en los archivos de componentes
- 🧑‍💻 chore: mejorar el proceso de configuracion de herramientas para desarrolladores
- 👔 feat: implementar logica de negocio para la validacion de transacciones
- 🩹 fix: corregir inconsistencia menor de estilos en el encabezado
- 🚑️ fix: parchear vulnerabilidad critica de seguridad en el flujo de autenticacion
- 🎨 style: reorganizar la estructura de componentes para mejorar la legibilidad
- 🔥 fix: eliminar codigo legado obsoleto
- 🦺 feat: agregar validacion de entrada en el formulario de registro de usuario
- 💚 fix: resolver fallos en las pruebas de la canalizacion CI
- 📈 feat: implementar seguimiento analitico del compromiso del usuario
- 🔒️ fix: reforzar los requisitos de contrasenia en la autenticacion
- ♿️ feat: mejorar la accesibilidad del formulario para lectores de pantalla

Ejemplo de división de commits:
- Primer commit: ✨ feat: agregar definiciones de tipo para nueva version de solc  
- Segundo commit: 📝 docs: actualizar documentacion para nuevas versiones de solc  
- Tercer commit: 🔧 chore: actualizar dependencias en package.json  
- Cuarto commit: 🏷️ feat: agregar definiciones de tipo para nuevos endpoints de API  
- Quinto commit: 🧵 feat: mejorar el manejo de concurrencia en hilos de trabajo  
- Sexto commit: 🚨 fix: resolver problemas de linting en el nuevo codigo  
- Séptimo commit: ✅ test: agregar pruebas unitarias para funcionalidades de nueva version de solc  
- Octavo commit: 🔒️ fix: actualizar dependencias con vulnerabilidades de seguridad


## Notas importantes

- Si hay archivos específicos ya preparados, el comando solo hará commit de esos archivos
- Si no hay archivos preparados, se prepararán automáticamente todos los modificados y nuevos
- El mensaje del commit se construirá en base a los cambios detectados
- Antes de hacer el commit, el comando revisará el diff para identificar si sería mejor hacer múltiples commits
- Si se sugieren múltiples commits, te ayudará a preparar y hacer commit de los cambios por separado
- Siempre revisa el diff del commit para asegurarte de que el mensaje coincide con los cambios

## Notas adicionales

$ARGUMENTS