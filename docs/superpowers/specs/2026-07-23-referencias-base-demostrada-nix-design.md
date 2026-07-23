# Diseño: referencias de la base demostrada del lenguaje Nix

## Objetivo

Convertir en referencias rápidas todos los conceptos que Cristian demostró en la conversación compartida, sin confundir temas explicados con temas aprendidos. El resultado debe servir para recuperar sintaxis durante ejercicios reales de servidores y home labs, no para volver a impartir las lecciones completas.

## Evidencia de aprendizaje

La conversación y `learning-records/0005-base-demostrada-del-lenguaje-nix.md` muestran uso o predicción correcta de:

- expresiones, `let ... in`, attribute sets, listas, interpolación y condicionales;
- acceso a atributos y concatenación de listas con `++`;
- funciones currificadas y aplicación parcial;
- argumentos recibidos como attribute sets, valores predeterminados y captura mediante `args@{ ... }`;
- `inherit` e `inherit (set) ...`;
- `import` como evaluación de otro archivo y la aplicación posterior cuando el valor importado es una función.

Las referencias de `//`, `?` y attribute selection con `or` se conservarán porque ya forman parte de la lección 0003 y de la ruta actual del curso.

## Organización elegida

El contenido se distribuirá por modelo mental:

1. valores, expresiones y control de flujo;
2. composición y consulta de colecciones;
3. funciones, argumentos, reutilización e imports.

Esta separación amplía documentos existentes cuando el concepto ya pertenece a ellos y crea una sola referencia nueva para el grupo que aún no tiene cobertura. No se crearán fichas aisladas por cada construcción.

## Cambios por archivo

### `reference/0002-nix-language-minimum-cheatsheet.html`

Ampliar la referencia de sintaxis mínima con:

- la regla mental de que un archivo Nix evalúa a un valor;
- bindings locales con `let ... in`;
- attribute sets, listas, interpolación y acceso con punto;
- `if ... then ... else` como expresión que siempre produce un valor;
- equivalencias Nix ↔ JavaScript/TypeScript, marcadas como analogías y no como identidad semántica;
- resultados esperados junto a los ejemplos;
- errores frecuentes: omitir `in`, usar comas entre elementos de listas y escribir un `if` sin `else`.

### `reference/0003-operadores-composicion-cheatsheet.html`

Conservar la cobertura actual de `//`, `?`, `or` y `++`, y mejorar su recuperación mediante:

- resultado visible para cada ejemplo;
- comparación breve entre propósito, entrada y resultado;
- advertencia explícita de que `//` actualiza de forma superficial;
- distinción entre `set ? atributo`, que produce un boolean, y `set.atributo or fallback`, que produce un valor;
- un error frecuente por operador cuando aporte valor práctico.

### `reference/0004-funciones-argumentos-imports-cheatsheet.html`

Crear una referencia imprimible con:

- función simple `x: expresión`;
- currying `x: y: expresión`;
- aplicación completa y aplicación parcial;
- parámetro como attribute set `{ host, port }`;
- argumento con default `{ port ? 22 }`;
- captura completa `args@{ ... }` y aclaración de que `args` conserva el set recibido;
- `inherit nombre;` e `inherit (set) nombre;`;
- `import ./archivo.nix` como evaluación del archivo;
- `import ./archivo.nix { ... }` como evaluación seguida de aplicación cuando el resultado es una función;
- analogías compactas con funciones, destructuring, defaults y object shorthand de JavaScript/TypeScript;
- errores frecuentes relacionados con la asociación de la aplicación y la diferencia entre importar y aplicar.

La página enlazará las referencias `0002` y `0003`, y usará ejemplos de configuración de un home lab.

### `START-HERE.md`

Añadir la referencia `0004` a la lista de ayudas rápidas. No se cambiará la ruta de lecciones ni el siguiente tema del curso.

## Presentación

Todos los documentos:

- reutilizarán `../assets/teach.css`;
- mantendrán HTML semántico, tarjetas breves y bloques de código pequeños;
- usarán español con los términos técnicos de Nix en inglés;
- serán legibles en pantalla e imprimibles;
- favorecerán la búsqueda rápida sobre la explicación extensa;
- citarán documentación oficial de Nix para la sintaxis cubierta.

No se añadirá JavaScript ni una dependencia visual nueva. Las referencias son material de consulta, por lo que no necesitan quizzes ni estado interactivo.

## Fuentes

Las afirmaciones de sintaxis se verificarán contra documentación oficial vigente:

- Nix language basics y tutorial de nix.dev;
- Nix language operators;
- Nix manual, sección de constructs y built-ins, cuando sea necesario precisar `import`.

Las analogías con JavaScript/TypeScript se usarán solo como puente didáctico y señalarán los límites relevantes.

## Verificación

Se comprobará que:

- cada tema de la evidencia aparece al menos una vez en las referencias;
- cada archivo contiene `doctype`, idioma, `title`, viewport y el CSS compartido;
- todos los enlaces locales resuelven a archivos existentes;
- no hay estilos inline, marcadores de trabajo pendiente ni whitespace errors;
- los snippets Nix críticos evalúan correctamente mediante el laboratorio;
- `START-HERE.md` enlaza la nueva referencia.

## Fuera de alcance

- Marcar como dominados temas que solo fueron mencionados.
- Añadir `map`, `builtins.filter`, `rec`, lazy evaluation, derivations, módulos o flakes.
- Crear una lección nueva o modificar el laboratorio más allá de evaluar snippets necesarios para validar las referencias.
- Reorganizar retrospectivamente todos los archivos del curso.
- Cambiar `MISSION.md`, `NOTES.md` o los learning records: la evidencia ya está registrada.

## Criterios de aceptación

- `0002` permite recuperar todos los valores y controles de flujo demostrados.
- `0003` permite distinguir y aplicar `//`, `?`, `or` y `++` sin ambigüedad.
- `0004` permite recordar funciones, defaults, captura de argumentos, `inherit` e `import`.
- Las analogías con JavaScript/TypeScript ayudan sin ocultar diferencias importantes.
- El índice enlaza las cuatro referencias y no altera la progresión vigente del curso.
- No se incorpora conocimiento sin evidencia de aprendizaje.
