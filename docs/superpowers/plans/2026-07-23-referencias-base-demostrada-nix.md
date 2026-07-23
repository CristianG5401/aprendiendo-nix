# Referencias de la base demostrada de Nix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Completar las referencias rápidas con todos los conceptos de Nix que Cristian demostró en la conversación compartida.

**Architecture:** Distribuir el conocimiento por modelo mental: `0002` cubre valores y control de flujo, `0003` cubre composición y consulta, y la nueva `0004` cubre funciones, argumentos, `inherit` e `import`. Todos los documentos son HTML estático, reutilizan `assets/teach.css` y quedan enlazados desde `START-HERE.md`.

**Tech Stack:** HTML5 semántico, CSS compartido existente, Markdown, shell, Nix 2.34 mediante Docker Compose.

## Global Constraints

- Aplicar KISS y DRY; no añadir JavaScript, frameworks ni dependencias.
- Escribir en español y conservar los términos técnicos oficiales de Nix en inglés.
- Usar solamente conocimientos demostrados en la conversación o ya cubiertos por la lección 0003.
- Mantener ejemplos pequeños y orientados a servidores y home labs.
- Usar `../assets/teach.css`; no añadir estilos inline.
- Citar únicamente fuentes oficiales de Nix para las afirmaciones de sintaxis.
- No modificar `MISSION.md`, `NOTES.md`, los learning records ni la progresión de lecciones.
- No crear commits sin autorización explícita del usuario; cada tarea termina en un checkpoint de diff y validación.

## File Map

- Modify: `reference/0002-nix-language-minimum-cheatsheet.html` — valores, expresiones, control de flujo y errores frecuentes.
- Modify: `reference/0003-operadores-composicion-cheatsheet.html` — comparación operativa de `//`, `?`, `or` y `++`.
- Create: `reference/0004-funciones-argumentos-imports-cheatsheet.html` — funciones, patrones de argumentos, `inherit` e `import`.
- Modify: `START-HERE.md` — enlace a la cuarta referencia.
- Reference only: `assets/teach.css` — presentación compartida, sin cambios previstos.

---

### Task 1: Completar la referencia de valores y control de flujo

**Files:**
- Modify: `reference/0002-nix-language-minimum-cheatsheet.html`

**Interfaces:**
- Consumes: clases CSS `.kicker`, `.card` y `.small` de `assets/teach.css`.
- Produces: una referencia autónoma con anchors `#expresiones`, `#let`, `#valores`, `#condicionales` y `#errores`.

- [ ] **Step 1: Ejecutar el chequeo de cobertura previo**

Run:

```bash
rg -n 'id="(expresiones|condicionales|errores)"|if .* then .* else' \
  reference/0002-nix-language-minimum-cheatsheet.html
```

Expected: el comando termina con status `1`, porque la referencia todavía no cubre esos tres recordatorios.

- [ ] **Step 2: Ampliar la página con secciones de consulta rápida**

Conservar el `head` y reemplazar el contenido de `main` por tarjetas que incluyan exactamente estos conceptos y ejemplos:

```html
<p class="kicker">Referencia rápida</p>
<h1>Valores y expresiones esenciales de Nix</h1>
<p class="subtitle">Recordatorios para leer configuraciones sin volver a estudiar la lección completa.</p>

<section class="card" id="expresiones">
  <h2>Un archivo evalúa a un valor</h2>
  <p>Nix es expression-oriented: cada construcción produce un valor. No describe pasos secuenciales como un script de Bash.</p>
  <pre><code>1 + 2
# 3</code></pre>
</section>

<section class="card" id="let">
  <h2><code>let ... in</code> — nombres locales</h2>
  <pre><code>let
  hostname = "homeserver";
  port = 22;
in
  "${hostname}:${toString port}"
# "homeserver:22"</code></pre>
  <p>Los bindings viven en la expresión que sigue a <code>in</code>.</p>
</section>

<section class="card" id="valores">
  <h2>Valores que ya conoces</h2>
  <pre><code>{
  enabled = true;
  tools = [ "curl" "git" "jq" ];
  server = { hostname = "lab"; port = 22; };
  message = "Servidor: ${"lab"}";
}</code></pre>
  <ul class="checklist">
    <li>Attribute set: usa <code>=</code> y termina cada binding con <code>;</code>.</li>
    <li>Lista: separa elementos con whitespace, sin comas.</li>
    <li>Interpolación: coloca una expresión dentro de <code>${...}</code>.</li>
    <li>Selección: <code>config.server.hostname</code> accede a atributos anidados.</li>
  </ul>
</section>

<section class="card" id="condicionales">
  <h2><code>if ... then ... else</code> — elegir un valor</h2>
  <pre><code>let
  production = true;
in
  if production then "homeserver-prod" else "homeserver-dev"
# "homeserver-prod"</code></pre>
  <p>Es una expresión: ambas ramas producen el valor del resultado.</p>
</section>

<section class="card">
  <h2>Puentes con JavaScript/TypeScript</h2>
  <ul class="checklist">
    <li><code>{ host = "lab"; }</code> recuerda a un object literal, pero usa <code>=</code> y <code>;</code>.</li>
    <li><code>[ "git" "jq" ]</code> recuerda a un array, pero no usa comas.</li>
    <li><code>if c then a else b</code> se parece más a <code>c ? a : b</code> que a un bloque <code>if</code>.</li>
    <li><code>let ... in</code> crea una expresión con scope local; la IIFE es solo una analogía de lectura.</li>
  </ul>
</section>

<section class="card" id="errores">
  <h2>Errores frecuentes</h2>
  <ul class="checklist">
    <li>Olvidar <code>in</code> después de los bindings de <code>let</code>.</li>
    <li>Escribir comas entre elementos de una lista.</li>
    <li>Escribir un <code>if</code> sin rama <code>else</code>.</li>
    <li>Confundir <code>.</code> de selección con acceso tolerante a atributos ausentes.</li>
  </ul>
</section>

<section class="card small">
  <h2>Fuente primaria</h2>
  <p><a href="https://nix.dev/tutorials/nix-language">nix.dev — Nix language basics</a></p>
</section>

<nav aria-label="Referencias relacionadas">
  <a href="./0001-shell-nix-cheatsheet.html">← shell.nix básico</a>
  · <a href="./0003-operadores-composicion-cheatsheet.html">Operadores de composición →</a>
</nav>
```

- [ ] **Step 3: Verificar la sintaxis Nix crítica**

Run:

```bash
docker compose -f lab/docker-compose.yml exec -T nix \
  nix-instantiate --eval --strict --expr \
  'let hostname = "homeserver"; port = 22; production = true; in { address = "${hostname}:${toString port}"; environment = if production then "prod" else "dev"; }'
```

Expected:

```text
{ address = "homeserver:22"; environment = "prod"; }
```

- [ ] **Step 4: Confirmar cobertura y revisar el diff**

Run:

```bash
rg -n 'id="(expresiones|let|valores|condicionales|errores)"|nix.dev/tutorials/nix-language' \
  reference/0002-nix-language-minimum-cheatsheet.html
git diff --check -- reference/0002-nix-language-minimum-cheatsheet.html
git diff -- reference/0002-nix-language-minimum-cheatsheet.html
```

Expected: aparecen los cinco anchors y la fuente oficial; `git diff --check` no imprime errores.

---

### Task 2: Afinar la referencia de composición y consulta

**Files:**
- Modify: `reference/0003-operadores-composicion-cheatsheet.html`

**Interfaces:**
- Consumes: terminología de valores de `reference/0002-nix-language-minimum-cheatsheet.html`.
- Produces: una tabla comparativa y errores frecuentes para `//`, `?`, `or` y `++`.

- [ ] **Step 1: Ejecutar el chequeo de cobertura previo**

Run:

```bash
rg -n '<table|Errores frecuentes|Produce un boolean|Produce el valor' \
  reference/0003-operadores-composicion-cheatsheet.html
```

Expected: no aparecen una tabla ni una sección de errores frecuentes.

- [ ] **Step 2: Añadir una comparación de propósito y resultado**

Añadir después del `<h1>`:

```html
<p class="subtitle">Qué operador usar para combinar, comprobar o recuperar valores.</p>
```

Insertar inmediatamente después:

```html
<section class="card">
  <h2>Elegir el operador</h2>
  <table>
    <thead>
      <tr><th>Necesidad</th><th>Forma</th><th>Resultado</th></tr>
    </thead>
    <tbody>
      <tr><td>Aplicar overrides</td><td><code>base // local</code></td><td>Attribute set</td></tr>
      <tr><td>Comprobar existencia</td><td><code>config ? backup</code></td><td>Boolean</td></tr>
      <tr><td>Leer con fallback</td><td><code>config.backup or "/srv"</code></td><td>Valor</td></tr>
      <tr><td>Unir listas</td><td><code>baseTools ++ extraTools</code></td><td>Lista</td></tr>
    </tbody>
  </table>
</section>
```

Actualizar las tarjetas existentes para que cada ejemplo muestre el resultado y añadir al final:

```html
<section class="card">
  <h2>Errores frecuentes</h2>
  <ul class="checklist">
    <li><code>//</code> no hace deep merge: un set anidado del lado derecho reemplaza el anterior.</li>
    <li><code>?</code> solo comprueba existencia; no devuelve el atributo.</li>
    <li><code>or</code> forma parte de attribute selection: escribe <code>set.attr or fallback</code>.</li>
    <li><code>++</code> concatena listas; no actualiza attribute sets.</li>
  </ul>
</section>
```

Cambiar la navegación final por:

```html
<nav aria-label="Referencias relacionadas">
  <a href="./0002-nix-language-minimum-cheatsheet.html">← Valores y expresiones</a>
  · <a href="./0004-funciones-argumentos-imports-cheatsheet.html">Funciones e imports →</a>
</nav>
```

- [ ] **Step 3: Verificar el comportamiento de los cuatro operadores**

Run:

```bash
docker compose -f lab/docker-compose.yml exec -T nix \
  nix-instantiate --eval --strict --expr \
  'let base = { host = "lab"; tools = [ "git" ]; }; effective = base // { host = "prod"; }; in { host = effective.host; hasBackup = effective ? backup; backup = effective.backup or "/srv/backups"; tools = effective.tools ++ [ "jq" ]; }'
```

Expected:

```text
{ backup = "/srv/backups"; hasBackup = false; host = "prod"; tools = [ "git" "jq" ]; }
```

- [ ] **Step 4: Confirmar cobertura y revisar el diff**

Run:

```bash
rg -n '<table|Errores frecuentes|deep merge|Attribute set|Boolean|Lista' \
  reference/0003-operadores-composicion-cheatsheet.html
git diff --check -- reference/0003-operadores-composicion-cheatsheet.html
git diff -- reference/0003-operadores-composicion-cheatsheet.html
```

Expected: la tabla y los cuatro recordatorios aparecen; `git diff --check` no imprime errores.

---

### Task 3: Crear la referencia de funciones, argumentos e imports

**Files:**
- Create: `reference/0004-funciones-argumentos-imports-cheatsheet.html`

**Interfaces:**
- Consumes: valores de `0002` y operadores de `0003`.
- Produces: anchors `#funciones`, `#argumentos`, `#inherit`, `#import` y `#errores`, enlazables desde el índice y otras referencias.

- [ ] **Step 1: Verificar que la referencia todavía no existe**

Run:

```bash
test ! -e reference/0004-funciones-argumentos-imports-cheatsheet.html
```

Expected: status `0`.

- [ ] **Step 2: Crear la estructura HTML compartida**

Crear el archivo con:

```html
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Referencia — Funciones, argumentos e imports en Nix</title>
  <link rel="stylesheet" href="../assets/teach.css">
</head>
<body>
<main>
  <p class="kicker">Referencia rápida</p>
  <h1>Funciones, argumentos e imports</h1>
  <p class="subtitle">Cómo leer funciones Nix y reutilizar valores entre archivos.</p>

  <section class="card" id="funciones">
    <h2>Funciones y aplicación</h2>
    <pre><code>increment = x: x + 1;
increment 2
# 3</code></pre>
    <pre><code>makeAddress = host: port: "${host}:${toString port}";
withHost = makeAddress "homeserver";
withHost 22
# "homeserver:22"</code></pre>
    <ul class="checklist">
      <li><code>x: expresión</code> recibe exactamente un argumento.</li>
      <li><code>x: y: expresión</code> es <code>x: (y: expresión)</code>: una función que devuelve otra.</li>
      <li><code>makeAddress "homeserver"</code> es aplicación parcial y todavía produce una función.</li>
      <li>La aplicación se escribe con whitespace, sin paréntesis ni comas obligatorios.</li>
    </ul>
  </section>

  <section class="card" id="argumentos">
    <h2>Argumentos como attribute set</h2>
    <pre><code>makeServer = { host, port ? 22 }:
  "${host}:${toString port}";

makeServer { host = "homeserver"; }
# "homeserver:22"</code></pre>
    <pre><code>describe = args@{ host, port ? 22, ... }: {
  address = "${host}:${toString port}";
  received = args;
};</code></pre>
    <ul class="checklist">
      <li><code>{ host, port }</code> exige esos atributos.</li>
      <li><code>port ? 22</code> hace opcional el argumento y define su default.</li>
      <li><code>...</code> permite atributos adicionales.</li>
      <li><code>args@{ ... }</code> conserva el attribute set completo bajo el nombre <code>args</code>.</li>
    </ul>
  </section>

  <section class="card" id="inherit">
    <h2><code>inherit</code> — evitar repetir nombres</h2>
    <pre><code>let
  host = "homeserver";
  port = 22;
in
{
  inherit host port;
}
# { host = "homeserver"; port = 22; }</code></pre>
    <pre><code>let server = { host = "lab"; port = 2222; };
in { inherit (server) host port; }
# { host = "lab"; port = 2222; }</code></pre>
    <p><code>inherit host;</code> equivale a <code>host = host;</code>. <code>inherit (server) host;</code> equivale a <code>host = server.host;</code>.</p>
  </section>

  <section class="card" id="import">
    <h2><code>import</code> — evaluar otro archivo</h2>
    <pre><code># value.nix
{ host = "homeserver"; port = 22; }

# caller.nix
import ./value.nix
# devuelve el attribute set</code></pre>
    <pre><code># make-server.nix
{ host, port ? 22 }: "${host}:${toString port}"

# caller.nix
import ./make-server.nix { host = "homeserver"; }
# "homeserver:22"</code></pre>
    <p><code>import ./archivo.nix</code> devuelve el valor evaluado del archivo. Los tokens posteriores aplican ese valor si es una función.</p>
  </section>

  <section class="card">
    <h2>Puentes con JavaScript/TypeScript</h2>
    <ul class="checklist">
      <li><code>x: x + 1</code> recuerda a <code>x =&gt; x + 1</code>.</li>
      <li><code>{ host, port ? 22 }:</code> combina destructuring con un default, pero usa sintaxis Nix.</li>
      <li><code>inherit host;</code> recuerda al object shorthand <code>{ host }</code>.</li>
      <li><code>import</code> evalúa una expresión Nix; no es idéntico al sistema de módulos ES.</li>
    </ul>
  </section>

  <section class="card" id="errores">
    <h2>Errores frecuentes</h2>
    <ul class="checklist">
      <li>Leer <code>f a b</code> como una llamada de dos argumentos: en realidad es <code>(f a) b</code>.</li>
      <li>Pasar atributos adicionales sin declarar <code>...</code>.</li>
      <li>Confundir <code>port ? 22</code> de un patrón de función con <code>config ? port</code>.</li>
      <li>Suponer que <code>import</code> siempre devuelve un attribute set; puede devolver cualquier valor Nix.</li>
      <li>Suponer que importar una función también la ejecuta sin proporcionarle un argumento.</li>
    </ul>
  </section>

  <section class="card small">
    <h2>Fuente primaria</h2>
    <p><a href="https://nix.dev/tutorials/nix-language">nix.dev — Nix language basics</a></p>
  </section>

  <nav aria-label="Referencias relacionadas">
    <a href="./0002-nix-language-minimum-cheatsheet.html">← Valores y expresiones</a>
    · <a href="./0003-operadores-composicion-cheatsheet.html">Operadores de composición</a>
  </nav>
</main>
</body>
</html>
```

- [ ] **Step 3: Verificar funciones, defaults, captura e `inherit`**

Run:

```bash
docker compose -f lab/docker-compose.yml exec -T nix \
  nix-instantiate --eval --strict --expr \
  'let makeAddress = host: port: "${host}:${toString port}"; withHost = makeAddress "homeserver"; describe = args@{ host, port ? 22, ... }: { address = makeAddress host port; received = args; }; server = { host = "lab"; port = 2222; }; in { partial = withHost 22; described = describe { host = "backup"; enabled = true; }; inherit (server) host port; }'
```

Expected:

```text
{ described = { address = "backup:22"; received = { enabled = true; host = "backup"; }; }; host = "lab"; partial = "homeserver:22"; port = 2222; }
```

- [ ] **Step 4: Verificar la semántica de `import` con archivos temporales**

Run:

```bash
docker compose -f lab/docker-compose.yml exec -T nix sh -c \
  'printf "%s\n" "{ host, port ? 22 }: \"\${host}:\${toString port}\"" > /tmp/make-server.nix && nix-instantiate --eval --strict --expr "import /tmp/make-server.nix { host = \"homeserver\"; }"'
```

Expected:

```text
"homeserver:22"
```

- [ ] **Step 5: Confirmar estructura y revisar el archivo**

Run:

```bash
rg -n 'id="(funciones|argumentos|inherit|import|errores)"|assets/teach.css|nix.dev/tutorials/nix-language' \
  reference/0004-funciones-argumentos-imports-cheatsheet.html
git diff --no-index --check /dev/null reference/0004-funciones-argumentos-imports-cheatsheet.html
```

Expected: aparecen los cinco anchors, el CSS y la fuente; el segundo comando solo informa que el archivo fue añadido, sin whitespace errors.

---

### Task 4: Integrar el índice y validar el conjunto

**Files:**
- Modify: `START-HERE.md`
- Test: `reference/*.html`

**Interfaces:**
- Consumes: `reference/0004-funciones-argumentos-imports-cheatsheet.html`.
- Produces: una ruta de consulta enlazada y un conjunto de referencias sin enlaces locales rotos.

- [ ] **Step 1: Ejecutar el chequeo de índice previo**

Run:

```bash
rg -n '0004-funciones-argumentos-imports-cheatsheet.html' START-HERE.md
```

Expected: status `1`; el índice todavía no contiene el enlace.

- [ ] **Step 2: Añadir la cuarta referencia al índice**

En la lista “Usa las referencias rápidas cuando te atasques”, añadir:

```markdown
   - [Referencia — funciones, argumentos e imports](./reference/0004-funciones-argumentos-imports-cheatsheet.html)
```

- [ ] **Step 3: Ejecutar la validación estructural de los HTML y enlaces locales**

Run:

```bash
for file in reference/*.html; do
  rg -q '<!doctype html>' "$file"
  rg -q '<html lang="es">' "$file"
  rg -q '<meta name="viewport"' "$file"
  rg -q 'href="../assets/teach.css"' "$file"
done

for target in $(rg -o 'href="(\./|\.\./)[^"#]+' reference/*.html | sed 's/.*href="//'); do
  test -e "reference/$target"
done
```

Expected: ambos loops terminan con status `0`.

- [ ] **Step 4: Comprobar la matriz completa de conocimientos**

Run:

```bash
rg -q 'let \.\.\. in|<code>let' reference/0002-nix-language-minimum-cheatsheet.html
rg -q 'Attribute set' reference/0002-nix-language-minimum-cheatsheet.html
rg -q 'Lista' reference/0002-nix-language-minimum-cheatsheet.html
rg -q 'Interpolación' reference/0002-nix-language-minimum-cheatsheet.html
rg -q 'if .* then .* else' reference/0002-nix-language-minimum-cheatsheet.html
rg -q '<code>//</code>' reference/0003-operadores-composicion-cheatsheet.html
rg -q '<code>\?</code>' reference/0003-operadores-composicion-cheatsheet.html
rg -q '<code>or</code>' reference/0003-operadores-composicion-cheatsheet.html
rg -q '<code>\+\+</code>' reference/0003-operadores-composicion-cheatsheet.html
rg -q 'currying|función que devuelve otra' reference/0004-funciones-argumentos-imports-cheatsheet.html
rg -q 'aplicación parcial' reference/0004-funciones-argumentos-imports-cheatsheet.html
rg -q 'port \? 22' reference/0004-funciones-argumentos-imports-cheatsheet.html
rg -q 'args@\{' reference/0004-funciones-argumentos-imports-cheatsheet.html
rg -q 'inherit \(server\)' reference/0004-funciones-argumentos-imports-cheatsheet.html
rg -q 'import ./make-server.nix' reference/0004-funciones-argumentos-imports-cheatsheet.html
```

Expected: todos los comandos terminan con status `0`.

- [ ] **Step 5: Ejecutar las verificaciones finales del repositorio**

Run:

```bash
git diff --check
rg -n '<style|FIXME|PLACEHOLDER' reference START-HERE.md \
  docs/superpowers/specs/2026-07-23-referencias-base-demostrada-nix-design.md \
  docs/superpowers/plans/2026-07-23-referencias-base-demostrada-nix.md
docker compose -f lab/docker-compose.yml exec -T nix \
  sh /workspace/lab/smoke-test.sh
git status --short
```

Expected:

- `git diff --check` no imprime errores.
- `rg` no encuentra estilos inline ni marcadores pendientes.
- El smoke test termina con `Smoke test OK`.
- `git status --short` muestra solamente el spec, el plan, las tres referencias afectadas y `START-HERE.md`.

- [ ] **Step 6: Checkpoint de revisión sin commit**

Revisar:

```bash
git diff --stat
git diff -- START-HERE.md \
  reference/0002-nix-language-minimum-cheatsheet.html \
  reference/0003-operadores-composicion-cheatsheet.html
git diff --no-index /dev/null reference/0004-funciones-argumentos-imports-cheatsheet.html
```

Expected: el diff implementa únicamente el spec aprobado y no altera archivos ajenos al alcance.
