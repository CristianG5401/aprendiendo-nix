# HTML Syntax Highlighting Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Añadir syntax highlighting mediante CDN a todos los bloques de código de las lecciones y referencias HTML.

**Architecture:** Cada página estática cargará Prism.js 1.30.0, el tema Okaidia y Autoloader desde jsDelivr. Los bloques `pre > code` declararán su gramática con una clase `language-*`; el CSS compartido seguirá proporcionando la presentación base y la degradación sin red.

**Tech Stack:** HTML5, CSS, Prism.js 1.30.0, jsDelivr, POSIX shell para validación.

## Global Constraints

- Modificar los siete HTML existentes de `lessons/` y `reference/`; no crear una nueva capa de templates o build.
- Usar únicamente `language-nix`, `language-bash`, `language-javascript` y `language-plaintext`.
- No cambiar los 140 elementos `code` inline ni el contenido de los 48 bloques.
- Cargar `prism-okaidia.min.css` antes de `../assets/teach.css`.
- Cargar `prism.min.js` y luego `prism-autoloader.min.js` al final de `body`.
- Fijar todas las URLs en Prism.js `1.30.0`.
- Conservar una degradación legible cuando el CDN o JavaScript no estén disponibles.
- No añadir package manager, build step, JavaScript propio, plugins adicionales ni archivos vendorizados.
- Trabajar en la rama actual y crear commits como checkpoints cuando resulte útil.

---

### Task 1: Integrar Prism en las siete páginas

**Files:**

- Modify: `lessons/0001-tu-primer-entorno-reproducible-con-nix.html:7,118`
- Modify: `lessons/0002-lectura-basica-del-lenguaje-nix.html:7,191`
- Modify: `lessons/0003-componer-y-consultar-configuraciones-nix.html:7,123`
- Modify: `reference/0001-shell-nix-cheatsheet.html:7,47`
- Modify: `reference/0002-nix-language-minimum-cheatsheet.html:7,89`
- Modify: `reference/0003-operadores-composicion-cheatsheet.html:7,91`
- Modify: `reference/0004-funciones-argumentos-imports-cheatsheet.html:7,126`

**Interfaces:**

- Consumes: páginas HTML estáticas que ya enlazan `../assets/teach.css`.
- Produces: las siete páginas con el mismo tema, núcleo y Autoloader de Prism, disponibles para las clases añadidas en Task 2.

- [ ] **Step 1: Ejecutar la comprobación estructural antes del cambio**

```bash
for page in lessons/*.html reference/*.html; do
  rg -q 'prismjs@1\.30\.0/themes/prism-okaidia\.min\.css' "$page" &&
    rg -q 'prismjs@1\.30\.0/prism\.min\.js' "$page" &&
    rg -q 'prismjs@1\.30\.0/plugins/autoloader/prism-autoloader\.min\.js' "$page" ||
    exit 1
done
```

Expected: exit code `1`, porque la primera página todavía no enlaza Prism.

- [ ] **Step 2: Añadir la hoja de estilos antes del CSS local**

En cada uno de los siete `head`, reemplazar el enlace único existente por:

```html
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/prismjs@1.30.0/themes/prism-okaidia.min.css">
  <link rel="stylesheet" href="../assets/teach.css">
```

- [ ] **Step 3: Añadir los scripts al final de cada body**

En cada uno de los siete HTML, insertar justo después de `</main>` y antes de `</body>`:

```html
<script src="https://cdn.jsdelivr.net/npm/prismjs@1.30.0/prism.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/prismjs@1.30.0/plugins/autoloader/prism-autoloader.min.js"></script>
```

- [ ] **Step 4: Repetir la comprobación estructural**

```bash
for page in lessons/*.html reference/*.html; do
  rg -q 'prismjs@1\.30\.0/themes/prism-okaidia\.min\.css' "$page" &&
    rg -q 'prismjs@1\.30\.0/prism\.min\.js' "$page" &&
    rg -q 'prismjs@1\.30\.0/plugins/autoloader/prism-autoloader\.min\.js' "$page" ||
    exit 1
done
```

Expected: exit code `0`; cada una de las tres referencias aparece exactamente una vez en cada HTML.

### Task 2: Declarar el lenguaje de los 48 bloques

**Files:**

- Modify: `lessons/0001-tu-primer-entorno-reproducible-con-nix.html:41-72`
- Modify: `lessons/0002-lectura-basica-del-lenguaje-nix.html:28-160`
- Modify: `lessons/0003-componer-y-consultar-configuraciones-nix.html:30-97`
- Modify: `reference/0001-shell-nix-cheatsheet.html:15-32`
- Modify: `reference/0002-nix-language-minimum-cheatsheet.html:18-55`
- Modify: `reference/0003-operadores-composicion-cheatsheet.html:32-68`
- Modify: `reference/0004-funciones-argumentos-imports-cheatsheet.html:17-91`

**Interfaces:**

- Consumes: Prism y Autoloader cargados por Task 1.
- Produces: 48 bloques con una gramática explícita y cero bloques sin clasificar.

- [ ] **Step 1: Ejecutar el conteo antes del cambio**

```bash
total_blocks=$(rg -o '<pre><code(?: |>)' lessons reference | wc -l)
classified_blocks=$(rg -o '<pre><code class="language-(nix|bash|javascript|plaintext)">' lessons reference | wc -l)
test "$total_blocks" -eq 48
test "$classified_blocks" -eq 48
```

Expected: la primera aserción pasa con `48`; la segunda falla porque el conteo inicial es `0`.

- [ ] **Step 2: Clasificar los bloques de las lecciones**

Cambiar solamente cada apertura `<pre><code>` según este mapa:

```text
lessons/0001...html
  41 bash; 45 nix; 67 bash; 70 bash

lessons/0002...html
  28 javascript; 32 nix; 38 plaintext; 45 nix; 51 javascript
  57 nix; 63 javascript; 73 nix; 79 javascript; 90 nix
  92 plaintext; 98 nix; 100 javascript; 102 nix; 114 nix
  142 bash; 146 nix; 158 bash; 160 plaintext

lessons/0003...html
  30 nix; 44 javascript; 53 nix; 60 nix; 68 nix
  94 bash; 97 plaintext
```

Por ejemplo:

```html
<pre><code class="language-bash">nix-shell</code></pre>
<pre><code class="language-nix">let
  x = 1;
in
x</code></pre>
<pre><code class="language-plaintext">3</code></pre>
```

- [ ] **Step 3: Clasificar los bloques de las referencias**

Cambiar solamente cada apertura `<pre><code>` según este mapa:

```text
reference/0001...html
  15 nix

reference/0002...html
  18 nix; 24 nix; 35 nix; 51 nix

reference/0003...html
  32 nix; 41 nix; 48 nix; 55 nix; 61 nix

reference/0004...html
  17 nix; 22 nix; 38 nix; 44 nix
  64 nix; 72 nix; 80 nix; 86 nix
```

La forma final de cada apertura será:

```html
<pre><code class="language-nix">
```

sin cambiar el texto que sigue al `>`.

- [ ] **Step 4: Ejecutar el conteo y validar las clases**

```bash
total_blocks=$(rg -o '<pre><code(?: |>)' lessons reference | wc -l)
classified_blocks=$(rg -o '<pre><code class="language-(nix|bash|javascript|plaintext)">' lessons reference | wc -l)
inline_blocks=$(( $(rg -o '<code(?: |>)' lessons reference | wc -l) - total_blocks ))

test "$total_blocks" -eq 48
test "$classified_blocks" -eq 48
test "$inline_blocks" -eq 140

if rg -n '<pre><code>' lessons reference; then
  exit 1
fi
```

Expected: exit code `0`, con `48` bloques clasificados y `140` elementos inline intactos.

### Task 3: Verificación integral

**Files:**

- Verify: `lessons/*.html`
- Verify: `reference/*.html`
- Verify: `assets/teach.css`
- Verify: `lab/smoke-test.sh`

**Interfaces:**

- Consumes: las páginas integradas y clasificadas por Tasks 1 y 2.
- Produces: evidencia de estructura consistente, diff limpio y laboratorio sin regresiones.

- [ ] **Step 1: Verificar orden y cardinalidad de recursos**

```bash
for page in lessons/*.html reference/*.html; do
  test "$(rg -c 'prism-okaidia\\.min\\.css' "$page")" -eq 1
  test "$(rg -c 'prism\\.min\\.js' "$page")" -eq 1
  test "$(rg -c 'prism-autoloader\\.min\\.js' "$page")" -eq 1

  prism_css_line=$(rg -n 'prism-okaidia\\.min\\.css' "$page" | cut -d: -f1)
  local_css_line=$(rg -n 'assets/teach\\.css' "$page" | cut -d: -f1)
  core_line=$(rg -n 'prism\\.min\\.js' "$page" | cut -d: -f1)
  autoloader_line=$(rg -n 'prism-autoloader\\.min\\.js' "$page" | cut -d: -f1)

  test "$prism_css_line" -lt "$local_css_line"
  test "$core_line" -lt "$autoloader_line"
done
```

Expected: exit code `0`.

- [ ] **Step 2: Inspeccionar el diff y el whitespace**

```bash
git diff --check
git diff --stat
git diff -- lessons reference assets/teach.css
```

Expected: `git diff --check` no imprime errores; `assets/teach.css` no tiene cambios; el diff HTML contiene solamente los recursos CDN y las clases de lenguaje.

- [ ] **Step 3: Ejecutar el smoke test del laboratorio**

```bash
cd lab
docker compose up -d
docker compose exec nix sh /workspace/lab/smoke-test.sh
docker compose down
```

Expected: termina con `Smoke test OK: Nix evaluó las lecciones 0002 y 0003, y entró al shell.nix.`

- [ ] **Step 4: Confirmar el estado final**

```bash
git status --short
```

Expected: no hay archivos generados ni staged changes; el estado refleja únicamente cualquier cambio deliberadamente dejado para un commit posterior.
