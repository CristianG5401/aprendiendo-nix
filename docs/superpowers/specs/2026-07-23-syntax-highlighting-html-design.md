# Diseño: syntax highlighting en las páginas HTML

## Objetivo

Añadir syntax highlighting a los snippets de código de todas las lecciones y referencias HTML sin cambiar su contenido didáctico, su estructura visual ni el comportamiento de los elementos interactivos existentes.

## Alcance

El cambio cubrirá los siete documentos de `lessons/` y `reference/`. Los bloques `pre > code` declararán su lenguaje de forma explícita. Los elementos `code` inline conservarán su marcado y estilo actuales.

Los lenguajes necesarios son:

- `nix` para expresiones y archivos Nix;
- `bash` para comandos de shell;
- `javascript` para las analogías con JavaScript y TypeScript que no usan sintaxis exclusiva de TypeScript;
- `plaintext` para resultados evaluados y salidas de consola que no deban interpretarse como código.

## Solución elegida

Se usará Prism.js 1.30.0 mediante jsDelivr, con el tema oficial Okaidia y el plugin Autoloader. Cada HTML incluirá:

1. la hoja de estilos del tema de Prism en `head`;
2. el núcleo de Prism al final de `body`;
3. el Autoloader después del núcleo.

El tema se cargará antes de `../assets/teach.css` para conservar los estilos propios del curso. El Autoloader leerá las clases `language-*` y descargará únicamente las gramáticas necesarias. Se usarán estas URLs, todas con la versión fijada para evitar cambios inesperados del CDN:

- `https://cdn.jsdelivr.net/npm/prismjs@1.30.0/themes/prism-okaidia.min.css`;
- `https://cdn.jsdelivr.net/npm/prismjs@1.30.0/prism.min.js`;
- `https://cdn.jsdelivr.net/npm/prismjs@1.30.0/plugins/autoloader/prism-autoloader.min.js`.

No se añadirá un build step, un package manager, archivos vendorizados ni JavaScript propio.

## Marcado

Cada bloque seguirá esta forma:

```html
<pre><code class="language-nix">let
  answer = 42;
in
answer</code></pre>
```

Los bloques de shell, JavaScript y texto plano cambiarán únicamente el valor de la clase. No se insertarán elementos `span` manualmente: Prism generará los tokens al cargar la página.

## Carga y degradación

El HTML y el contenido de los bloques seguirán siendo legibles si el CDN o JavaScript no están disponibles. En ese caso, `assets/teach.css` mantendrá el fondo, el contraste, la tipografía monoespaciada y el scroll horizontal actuales; solo faltarán los colores por token.

No se mostrará un error al usuario por una descarga fallida, porque el contenido no depende funcionalmente de Prism y la degradación es segura.

## Verificación

Se comprobará que:

- los siete HTML enlazan la misma versión de Prism, el tema y el Autoloader;
- todos los bloques `pre > code` tienen una sola clase `language-*` admitida;
- los elementos `code` inline no se modifican;
- los ejemplos Nix, shell, JavaScript y plaintext se clasifican de acuerdo con su contenido;
- no quedan marcadores `TODO` o URLs de versión flotante;
- `git diff --check` no encuentra errores de whitespace;
- el smoke test existente del laboratorio continúa pasando.

La validación estructural será local. El resaltado visual requiere acceso al CDN al abrir las páginas en un navegador.

## Fuera de alcance

- Resaltar elementos `code` inline.
- Añadir números de línea, botón de copiado, etiquetas de lenguaje o edición interactiva.
- Descargar Prism al repositorio para uso offline.
- Reescribir los snippets o modificar el contenido pedagógico.
- Cambiar de rama o crear un worktree; la implementación se hará en la rama actual.

## Criterios de aceptación

- Cada bloque de código declara explícitamente su lenguaje.
- Los snippets muestran colores por token cuando el CDN está disponible.
- Las páginas conservan su apariencia general y siguen siendo legibles sin red.
- No se introducen dependencias de instalación ni pasos de compilación.
