Comando para hacer merge de worktrees, resolver conflictos y verificar la integridad con tests

## Qué hace este comando

1.  **Identifica los worktrees**: Busca todas las ramas asociadas a los worktrees ubicados en la carpeta `.trees`.
2.  **Hace merge de cada worktree**: Itera sobre cada rama de worktree y le hace `git merge` en tu rama actual, forzando la creación de un commit de merge (`--no-ff`) para mantener un historial claro.
3.  **Genera un mensaje de merge convencional**: Para cada commit de merge, crea automáticamente un mensaje que sigue un formato estandarizado para mejorar la legibilidad del historial.
4.  **Resuelve conflictos automáticamente**: Durante el merge, si aparecen conflictos, los resuelve de forma automática y autónoma. 
5.  **Ejecuta los tests**: Una vez que a todas las ramas de los worktrees se les ha hecho merge, ejecuta la suite completa de tests del proyecto.
6.  **Analiza y repara si los tests fallan**:
    * Si los tests no pasan, el comando analiza los logs de error para identificar las pruebas fallidas.
    * Intenta aplicar correcciones automáticas al código, **dando siempre prioridad a que la nueva funcionalidad** opere correctamente sin romper la que ya existía.
	* Una vez aplicadas las correcciones, estas se añaden directamente al commit de merge anterior mediante un amend, asegurando que el historial se mantenga limpio y que cada commit sea funcional.
    * Vuelve a ejecutar los tests después de cada intento de corrección para verificar la solución.
7.  **Limpia los worktrees**: Una vez que todos los tests han pasado y el merge se ha completado con éxito, elimina los worktrees usando el procedimiento que funciona en Windows:
    * `rm -rf .git/worktrees/nombre-rama1 .git/worktrees/nombre-rama2 ...` (elimina referencias)
    * `git branch -D nombre-rama1 nombre-rama2 ...` (elimina las ramas)
    * `rm -rf .trees` (limpia directorio si existe)
8.  **Sube los cambios (Push)**: Si todos los pasos anteriores se han completado con éxito, sube la rama actualizada al repositorio remoto (git push), finalizando el ciclo de integración.

---

## Formato del Mensaje de Merge ✍️

Para mantener un historial del repositorio limpio y consistente, los mensajes de los commits de merge se generan siguiendo un formato estandarizado.

El formato para un mensaje de merge será:

**`🔀 chore: fusionar rama 'nombre-del-worktree'`**

Este formato se desglosa así:

* **Emoji y Tipo**: `🔀 chore`. Se utiliza el tipo `chore` (tarea) porque un merge es una acción de mantenimiento del repositorio. El emoji `🔀` se asocia visualmente con esta acción.
* **Descripción**: Un mensaje conciso en modo imperativo que explica qué rama se está integrando.

Si el comando hace merge de múltiples worktrees en una sola operación, podría generar un mensaje más detallado en el cuerpo del commit, listando todas las ramas integradas para un mejor contexto.

---

## Estrategia de reparación de tests

Cuando un test falla después del merge, el comando sigue estos pasos para intentar arreglarlo:

1.  **Análisis del error**: Revisa el resultado de los tests para identificar las aserciones fallidas y las funciones o módulos implicados.
2.  **Contextualización del cambio**: Compara el código que falla con los cambios introducidos desde el worktree para entender la causa raíz del problema.
3.  **Priorización de la nueva funcionalidad**: Al corregir, el objetivo principal es asegurar que la lógica introducida por el worktree funcione como se espera. Si un test antiguo falla porque la lógica de negocio ha cambiado intencionadamente, el comando sugerirá actualizar el test en lugar de revertir la nueva funcionalidad.
4.  **Corrección inteligente**: Intenta aplicar soluciones comunes, como ajustar mocks, actualizar aserciones de tests que esperaban un comportamiento antiguo o corregir integraciones entre el código nuevo y el existente.
5.  **Bucle de verificación**: Después de cada corrección, los tests se ejecutan de nuevo. El proceso se repite hasta que todos los tests pasen o hasta que no se puedan encontrar más soluciones automáticas, en cuyo caso se notificará al usuario para una revisión manual.

---

## Procedimiento específico para Windows

Para evitar errores de permisos y referencias bloqueadas, usar EXACTAMENTE este procedimiento que funciona:

```bash
# 1. Listar worktrees para identificar las ramas
git worktree list

# 2. Eliminar referencias de worktree (esto es CRÍTICO en Windows)
rm -rf .git/worktrees/rama1 .git/worktrees/rama2 .git/worktrees/rama3

# 3. Eliminar las ramas (ahora funcionará sin errores)
git branch -D rama1 rama2 rama3

# 4. Verificar que solo queda main
git branch -a
```

**IMPORTANTE**: No usar `git worktree remove` ni `git worktree prune` - causan errores de permisos en Windows. El procedimiento anterior es el único que funciona de forma consistente.

## Notas importantes

-   **Creación de commit de merge**: Se usa la estrategia `--no-ff` para asegurar que siempre se cree un commit de merge, manteniendo un registro explícito de la integración de cada worktree.
-   **Seguridad**: Antes de iniciar el proceso, el comando crea un punto de restauración para que puedas volver fácilmente al estado anterior si el resultado no es el esperado.
-   **Limpieza final**: La eliminación de los worktrees solo se produce si todo el proceso, incluyendo la ejecución de los tests, ha sido exitoso.
-   **Windows**: Usar SIEMPRE el procedimiento específico documentado arriba - es el único que funciona sin errores.
