# Diseño: sincronizar el progreso y crear la lección 0003 de operadores Nix

## Objetivo

Actualizar el espacio docente con la evidencia del chat compartido y crear una nueva unidad práctica sobre composición y consulta segura de configuraciones Nix. La actualización debe mantener la misión de construir servidores y home labs reproducibles, a la vez que reconoce que Cristian ya avanzó más allá de la sintaxis cubierta por la lección 0002.

## Evidencia de aprendizaje importada

La conversación demuestra mediante traducciones correctas entre Nix y JavaScript/TypeScript que Cristian puede usar:

- `let ... in`, attribute sets, listas, interpolación y condicionales;
- concatenación de listas con `++`;
- funciones currificadas y aplicación parcial;
- argumentos en attribute sets, valores predeterminados y `args@{ ... }`;
- `inherit` e `inherit (set) ...`;
- `import` como evaluación de un archivo, distinguiéndolo de la aplicación posterior de una función.

Estos conocimientos se registrarán como piso de enseñanza. No se registrarán como aprendidos los temas que el asistente solo enumeró al final del chat, porque no existe todavía evidencia de uso.

## Alcance

### Sincronización del workspace

- Actualizar `MISSION.md` para que el próximo paso sea composición de configuraciones antes de flakes, sin cambiar la misión general.
- Actualizar `START-HERE.md` con la lección y referencia nuevas.
- Actualizar `NOTES.md` con las preferencias y el nivel demostrado: analogías precisas con JavaScript/TypeScript, ejercicios de traducción y ritmo incremental.
- Añadir un learning record breve que consolide el nuevo piso de conocimiento con evidencia del chat.
- Curar en `RESOURCES.md` la referencia oficial usada para operadores, anotando para qué se consulta.

### Lección 0003

Crear `lessons/0003-componer-y-consultar-configuraciones-nix.html`, enlazada al CSS compartido y a la referencia rápida. La lección será corta y tendrá una victoria tangible: construir una configuración efectiva de home lab combinando defaults y overrides.

Contenido nuevo:

- `base // overrides`: unión superficial de attribute sets y precedencia del lado derecho;
- `set ? atributo`: comprobación de existencia;
- `set.atributo or fallback`: fallback al seleccionar un atributo ausente;
- diferencia entre comprobar existencia y elegir un fallback.

Recuperación intercalada:

- `++` para construir la lista final de herramientas, sin volver a enseñarlo desde cero;
- una pregunta breve que obligue a predecir el resultado antes de mostrar feedback.

La lección citará documentación oficial de Nix, enlazará las lecciones anteriores y recordará que se pueden hacer preguntas al agente.

### Referencia rápida

Crear `reference/0003-operadores-composicion-cheatsheet.html` con:

- forma, significado y ejemplo mínimo de `//`, `?`, `or` y `++`;
- precedencia práctica relevante y advertencia de que `//` no hace una unión profunda;
- patrón reusable `defaults // overrides`;
- diseño imprimible mediante `assets/teach.css`.

### Laboratorio ejecutable

Crear `lab/lesson-0003/operators.nix`. El archivo debe:

1. definir una configuración base de home lab;
2. aplicar overrides locales mediante `//`;
3. consultar atributos opcionales con `?` y `or`;
4. concatenar herramientas mediante `++`;
5. devolver un attribute set pequeño cuyo resultado pueda predecirse manualmente.

Extender `lab/smoke-test.sh` para evaluar el archivo con `nix-instantiate --eval --strict`. El test existente de las lecciones anteriores debe conservarse.

## Flujo de aprendizaje

1. Recuperar de memoria qué produce `++`.
2. Comparar `//` con object spread de JavaScript, explicando el límite de la analogía.
3. Predecir la precedencia de un override.
4. Distinguir `?` de `or` mediante ejemplos contrapuestos.
5. Construir y evaluar una configuración real del laboratorio.
6. Recibir feedback inmediato mostrando el resultado y mediante el smoke test.

## Fuentes

Antes de redactar el material se verificará la sintaxis y semántica en documentación oficial vigente de Nix. Se priorizarán el manual del lenguaje y nix.dev; no se usarán publicaciones comunitarias para fundamentar afirmaciones centrales de sintaxis.

## Verificación

- Comprobar que los archivos HTML tienen título, hoja de estilos compartida, navegación, fuente primaria, ejercicio y recordatorio de preguntas.
- Comprobar que todos los enlaces locales nuevos apuntan a archivos existentes.
- Evaluar `lab/lesson-0003/operators.nix` de forma estricta.
- Ejecutar `lab/smoke-test.sh` dentro del servicio Docker si el laboratorio está disponible.
- Revisar el diff para no sobrescribir cambios ajenos y confirmar que la ruta del curso ya no envía directamente a flakes.

## Fuera de alcance

- Enseñar `map`, `filter`, evaluación lazy, `rec`, módulos de NixOS, derivations o flakes en esta lección.
- Convertir retrospectivamente cada tema del chat en una lección independiente.
- Cambiar la misión hacia una migración inmediata a NixOS.
- Añadir frameworks JavaScript o dependencias nuevas para la interactividad.

## Criterios de aceptación

- El estado del curso refleja únicamente conocimientos demostrados, no solo temas expuestos.
- La lección 0003 permite explicar y aplicar correctamente `//`, `?` y `or` en una configuración de home lab.
- `++` se practica como recuperación, sin duplicar la lección anterior.
- El ejemplo Nix evalúa y el smoke test continúa validando las lecciones previas.
- El índice, la misión, las notas, los recursos y los enlaces quedan coherentes con el nuevo siguiente paso.
