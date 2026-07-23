# Sincronizar progreso y lección 0003 de operadores Nix — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Sincronizar el progreso demostrado en el chat compartido y añadir una lección ejecutable sobre `//`, `?` y `or`, recuperando `++`.

**Architecture:** El curso conserva su estructura estática: estado pedagógico en Markdown, contenido navegable en HTML, estilos compartidos en `assets/teach.css` y ejercicios verificables en `lab/`. La lección 0003 y su referencia consumen el mismo ejemplo `operators.nix`, de modo que explicación, consulta y prueba rápida permanezcan coherentes.

**Tech Stack:** Markdown, HTML5, CSS existente, lenguaje Nix, POSIX `sh`, Docker Compose.

## Global Constraints

- Seguir KISS y DRY; no añadir dependencias ni JavaScript reutilizable nuevo.
- Escribir en español y conservar los términos técnicos reales en inglés.
- Mantener un tono de instructor técnico claro; el matiz Tech-Priest nunca puede ocultar la explicación.
- Registrar únicamente conocimientos demostrados por el usuario, no temas que el asistente solo expuso.
- Mantener la misión de servidores y home labs reproducibles; no adelantar flakes ni módulos NixOS.
- Usar `assets/teach.css` sin duplicar estilos inline.
- Fundamentar la sintaxis en [Nix language basics](https://nix.dev/tutorials/nix-language) y [Nix manual — Operators](https://nix.dev/manual/nix/stable/language/operators.html).
- El manual oficial establece que `or` forma parte de attribute selection, `?` comprueba un attribute path, `++` concatena listas y `//` actualiza un attribute set dando precedencia al lado derecho.
- No crear commits: `git rev-parse --show-toplevel` falla porque este workspace no pertenece a un repositorio Git.

---

## File Map

- Modify: `MISSION.md` — mantener la misión y corregir el próximo paso.
- Modify: `START-HERE.md` — incluir lección 0003, referencia y comando de evaluación.
- Modify: `NOTES.md` — registrar nivel demostrado y preferencias didácticas.
- Modify: `RESOURCES.md` — añadir la fuente oficial específica para operadores.
- Create: `learning-records/0005-base-demostrada-del-lenguaje-nix.md` — fijar el nuevo piso de enseñanza.
- Create: `lab/lesson-0003/operators.nix` — ejemplo ejecutable y resultado canónico.
- Modify: `lab/smoke-test.sh` — validar el ejemplo nuevo sin romper pruebas anteriores.
- Create: `lessons/0003-componer-y-consultar-configuraciones-nix.html` — unidad docente principal.
- Create: `reference/0003-operadores-composicion-cheatsheet.html` — consulta imprimible.

### Task 1: Sincronizar el estado pedagógico

**Files:**
- Modify: `MISSION.md`
- Modify: `NOTES.md`
- Modify: `RESOURCES.md`
- Create: `learning-records/0005-base-demostrada-del-lenguaje-nix.md`

**Interfaces:**
- Consumes: evidencia del chat compartido y formatos de la skill `teach`.
- Produces: misión vigente, nivel de entrada para futuras lecciones y fuente oficial curada.

- [ ] **Step 1: Crear una comprobación que inicialmente falle**

Run:

```bash
test -f learning-records/0005-base-demostrada-del-lenguaje-nix.md
```

Expected: exit status `1`, porque el registro todavía no existe.

- [ ] **Step 2: Actualizar el siguiente paso de `MISSION.md`**

Reemplazar la sección `## Próximo paso concreto` completa por:

```markdown
## Próximo paso concreto

Cristian ya demostró que puede leer y traducir la base del lenguaje Nix. El siguiente paso es completar:

- [Lección 0003 — Componer y consultar configuraciones Nix](./lessons/0003-componer-y-consultar-configuraciones-nix.html)
- [Referencia — Operadores de composición](./reference/0003-operadores-composicion-cheatsheet.html)

La meta inmediata es construir una configuración efectiva de home lab combinando defaults y overrides, y consultando atributos opcionales sin romper la evaluación.
```

- [ ] **Step 3: Reemplazar `NOTES.md` por el estado didáctico vigente**

Escribir exactamente:

```markdown
# Notas de enseñanza

- Cristian completó la lección 0001.
- Tiene experiencia intermedia-avanzada con JavaScript/TypeScript.
- El chat compartido demuestra uso correcto de `let ... in`, attribute sets, listas, interpolación, condicionales, `++`, currying, aplicación parcial, defaults, `args@{ ... }`, `inherit` e `import`.
- Usar analogías con JavaScript/TypeScript, pero señalar dónde dejan de ser exactas.
- Favorecer ejercicios de traducción Nix ↔ JavaScript/TypeScript y predicción del resultado antes de evaluar.
- Mantener el ritmo incremental: una habilidad central nueva por lección.
- No registrar como aprendido un tema que solo fue explicado; exigir una solución, predicción o ejercicio correcto.
- Próxima zona de desarrollo: composición y consulta segura con `//`, `?` y `or`; recuperar `++` de memoria.
```

- [ ] **Step 4: Añadir la fuente oficial específica a `RESOURCES.md`**

Insertar al final de `## Fuentes primarias`:

```markdown
7. [Nix manual — Operators](https://nix.dev/manual/nix/stable/language/operators.html)
   - Uso: lección 0003 sobre attribute selection con `or`, comprobación con `?`, concatenación con `++` y actualización con `//`.
   - Motivo: referencia oficial de sintaxis, precedencia y semántica de operadores.
```

- [ ] **Step 5: Crear el learning record 0005**

Crear `learning-records/0005-base-demostrada-del-lenguaje-nix.md`:

```markdown
# Base funcional del lenguaje Nix demostrada

Cristian tradujo correctamente entre Nix y JavaScript/TypeScript ejercicios con `let ... in`, condicionales, `++`, currying, aplicación parcial, argumentos con defaults, `args@{ ... }`, `inherit` e `import`. Esto establece que las próximas lecciones no deben repetir esa sintaxis desde cero: deben recuperarla mediante práctica y avanzar hacia composición de configuraciones.

## Evidencia

En el chat compartido predijo estructuras resultantes y explicó mediante código que `import ./archivo.nix` obtiene el valor evaluado del archivo, mientras que el argumento posterior aplica ese valor si es una función.

## Implicaciones

La siguiente zona de desarrollo es distinguir y aplicar `//`, `?` y attribute selection con `or`, intercalando `++` como recuperación.
```

- [ ] **Step 6: Verificar el estado pedagógico**

Run:

```bash
test -f learning-records/0005-base-demostrada-del-lenguaje-nix.md
rg -n 'composición y consulta segura|Nix manual — Operators|Base funcional del lenguaje Nix demostrada' MISSION.md NOTES.md RESOURCES.md learning-records/0005-base-demostrada-del-lenguaje-nix.md
```

Expected: exit status `0` y al menos una coincidencia en cada archivo modificado.

### Task 2: Crear el laboratorio mediante un ciclo de prueba

**Files:**
- Create: `lab/lesson-0003/operators.nix`
- Modify: `lab/smoke-test.sh`

**Interfaces:**
- Produces: un attribute set con `hostname`, `tools`, `hasMonitoring`, `hasBackupTarget`, `monitoringEndpoint` y `backupTarget`.
- Consumes: `nix-instantiate --eval --strict` dentro del contenedor definido en `lab/docker-compose.yml`.

- [ ] **Step 1: Añadir primero la comprobación de la lección 0003 al smoke test**

Insertar antes del bloque `== Enter shell.nix`:

```sh
echo

echo "== Eval operators.nix from lesson 0003 =="
nix-instantiate --eval --strict /workspace/lab/lesson-0003/operators.nix
```

Actualizar el mensaje final a:

```sh
echo "Smoke test OK: Nix evaluó las lecciones 0002 y 0003, y entró al shell.nix."
```

- [ ] **Step 2: Ejecutar el smoke test y comprobar que falla por el archivo ausente**

Run desde `lab/`:

```bash
docker compose up -d
docker compose exec -T nix sh /workspace/lab/smoke-test.sh
```

Expected: la sección de la lección 0002 pasa y la ejecución falla con un mensaje equivalente a `path '/workspace/lab/lesson-0003/operators.nix' does not exist`.

- [ ] **Step 3: Crear el ejemplo mínimo `operators.nix`**

Crear `lab/lesson-0003/operators.nix`:

```nix
let
  baseConfig = {
    hostname = "homeserver";
    tools = [ "git" "curl" ];
    monitoring = {
      endpoint = "/metrics";
    };
  };

  localOverrides = {
    hostname = "homeserver-prod";
    tools = [ "jq" ];
  };

  effectiveConfig = baseConfig // localOverrides;
  extraTools = [ "htop" ];
in
{
  hostname = effectiveConfig.hostname;
  tools = effectiveConfig.tools ++ extraTools;
  hasMonitoring = effectiveConfig ? monitoring;
  hasBackupTarget = effectiveConfig ? backupTarget;
  monitoringEndpoint = effectiveConfig.monitoring.endpoint or "/health";
  backupTarget = effectiveConfig.backupTarget or "/srv/backups";
}
```

- [ ] **Step 4: Evaluar únicamente el ejemplo nuevo**

Run desde `lab/`:

```bash
docker compose exec -T nix nix-instantiate --eval --strict /workspace/lab/lesson-0003/operators.nix
```

Expected:

```text
{ backupTarget = "/srv/backups"; hasBackupTarget = false; hasMonitoring = true; hostname = "homeserver-prod"; monitoringEndpoint = "/metrics"; tools = [ "jq" "htop" ]; }
```

- [ ] **Step 5: Ejecutar el smoke test completo**

Run desde `lab/`:

```bash
docker compose exec -T nix sh /workspace/lab/smoke-test.sh
```

Expected: exit status `0` y última línea:

```text
Smoke test OK: Nix evaluó las lecciones 0002 y 0003, y entró al shell.nix.
```

### Task 3: Crear la lección y la referencia reutilizando el diseño existente

**Files:**
- Create: `lessons/0003-componer-y-consultar-configuraciones-nix.html`
- Create: `reference/0003-operadores-composicion-cheatsheet.html`
- Reuse: `assets/teach.css`

**Interfaces:**
- Consumes: resultado canónico de `lab/lesson-0003/operators.nix`.
- Produces: una lección navegable y una hoja de consulta imprimible enlazadas entre sí.

- [ ] **Step 1: Comprobar que los materiales aún no existen**

Run:

```bash
test -f lessons/0003-componer-y-consultar-configuraciones-nix.html
test -f reference/0003-operadores-composicion-cheatsheet.html
```

Expected: ambos comandos devuelven exit status `1`.

- [ ] **Step 2: Crear la referencia rápida**

Crear `reference/0003-operadores-composicion-cheatsheet.html` con estas secciones y ejemplos exactos:

```html
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Referencia — Operadores de composición Nix</title>
  <link rel="stylesheet" href="../assets/teach.css">
</head>
<body>
<main>
  <p class="kicker">Referencia rápida</p>
  <h1>Componer y consultar configuraciones Nix</h1>

  <section class="card">
    <h2><code>//</code> — actualizar un attribute set</h2>
    <pre><code>{ editor = "vim"; shell = "bash"; }
// { editor = "nvim"; }</code></pre>
    <p>El lado derecho gana cuando ambos sets contienen el mismo atributo.</p>
    <p><strong>Importante:</strong> la actualización es superficial; un set anidado repetido se reemplaza completo.</p>
  </section>

  <section class="card">
    <h2><code>?</code> — comprobar existencia</h2>
    <pre><code>{ sshPort = 22; } ? sshPort
# true</code></pre>
    <p>Devuelve un boolean. No obtiene el valor.</p>
  </section>

  <section class="card">
    <h2><code>or</code> — seleccionar con fallback</h2>
    <pre><code>{ sshPort = 22; }.backupTarget or "/srv/backups"
# "/srv/backups"</code></pre>
    <p><code>or</code> pertenece a attribute selection: intenta seleccionar y usa el fallback si el atributo no existe.</p>
  </section>

  <section class="card">
    <h2><code>++</code> — concatenar listas</h2>
    <pre><code>[ "git" "curl" ] ++ [ "jq" ]
# [ "git" "curl" "jq" ]</code></pre>
  </section>

  <section class="card">
    <h2>Patrón reusable</h2>
    <pre><code>let
  effectiveConfig = defaults // overrides;
in
{
  tools = effectiveConfig.tools ++ extraTools;
  hasBackup = effectiveConfig ? backupTarget;
  backupTarget = effectiveConfig.backupTarget or "/srv/backups";
}</code></pre>
  </section>

  <section class="card small">
    <h2>Fuente primaria</h2>
    <p><a href="https://nix.dev/manual/nix/stable/language/operators.html">Nix manual — Operators</a></p>
  </section>

  <p><a href="../lessons/0003-componer-y-consultar-configuraciones-nix.html">Volver a la lección 0003</a></p>
</main>
</body>
</html>
```

- [ ] **Step 3: Crear la lección 0003**

Crear `lessons/0003-componer-y-consultar-configuraciones-nix.html`:

```html
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>0003 — Componer y consultar configuraciones Nix</title>
  <link rel="stylesheet" href="../assets/teach.css">
</head>
<body>
<main>
  <p class="kicker">Lección 0003 · Composición de configuraciones</p>
  <h1>Componer y consultar configuraciones Nix</h1>
  <p class="subtitle">Objetivo: combinar defaults y overrides de un home lab, y consultar atributos opcionales sin romper la evaluación.</p>

  <section class="card">
    <h2>Tu misión en esta lección</h2>
    <p>Partirás de una configuración base y aplicarás cambios locales. Al terminar podrás explicar por qué gana cada valor y cómo ofrecer defaults seguros.</p>
    <p><a href="../reference/0003-operadores-composicion-cheatsheet.html">Abre la referencia rápida de operadores</a>.</p>
  </section>

  <section class="recall">
    <h2>Recuperación: <code>++</code></h2>
    <p>Sin ejecutar Nix, predice el resultado de <code>[ "git" "curl" ] ++ [ "jq" ]</code>.</p>
    <button onclick="document.querySelector('#a0').style.display='block'">Mostrar respuesta</button>
    <p id="a0" class="answer"><code>[ "git" "curl" "jq" ]</code>. <code>++</code> concatena listas y conserva su orden.</p>
  </section>

  <section class="card">
    <h2>1. <code>//</code>: defaults más overrides</h2>
    <pre><code>let
  baseConfig = {
    hostname = "homeserver";
    tools = [ "git" "curl" ];
  };

  localOverrides = {
    hostname = "homeserver-prod";
    tools = [ "jq" ];
  };
in
  baseConfig // localOverrides</code></pre>
    <p>El resultado contiene los atributos de ambos sets. Si un nombre aparece en los dos, gana el valor del lado derecho.</p>
    <p>Analogía JavaScript/TypeScript:</p>
    <pre><code>const effectiveConfig = {
  ...baseConfig,
  ...localOverrides,
};</code></pre>
    <p><strong>Límite importante:</strong> <code>//</code> es superficial. Si ambos lados tienen un atributo <code>monitoring</code> que contiene otro objeto, el valor derecho reemplaza todo <code>monitoring</code>; no mezcla recursivamente sus atributos internos.</p>
  </section>

  <section class="card">
    <h2>2. <code>?</code>: preguntar si existe</h2>
    <pre><code>effectiveConfig ? monitoring
effectiveConfig ? backupTarget</code></pre>
    <p><code>?</code> devuelve un boolean: <code>true</code> si el attribute path existe y <code>false</code> si no existe. No devuelve el valor del atributo.</p>
  </section>

  <section class="card">
    <h2>3. <code>or</code>: seleccionar con fallback</h2>
    <pre><code>effectiveConfig.backupTarget or "/srv/backups"</code></pre>
    <p>Esta expresión intenta seleccionar <code>backupTarget</code>. Si no existe, produce <code>"/srv/backups"</code> en lugar de abortar la evaluación.</p>
    <p><code>or</code> no es el operador booleano OR; forma parte de attribute selection. El OR booleano de Nix se escribe <code>||</code>.</p>
  </section>

  <section class="exercise">
    <h2>Ejercicio: configura tu home lab</h2>
    <p>Abre <code>lab/lesson-0003/operators.nix</code> y predice sus seis atributos antes de evaluar:</p>
    <pre><code>let
  baseConfig = {
    hostname = "homeserver";
    tools = [ "git" "curl" ];
    monitoring = {
      endpoint = "/metrics";
    };
  };

  localOverrides = {
    hostname = "homeserver-prod";
    tools = [ "jq" ];
  };

  effectiveConfig = baseConfig // localOverrides;
  extraTools = [ "htop" ];
in
{
  hostname = effectiveConfig.hostname;
  tools = effectiveConfig.tools ++ extraTools;
  hasMonitoring = effectiveConfig ? monitoring;
  hasBackupTarget = effectiveConfig ? backupTarget;
  monitoringEndpoint = effectiveConfig.monitoring.endpoint or "/health";
  backupTarget = effectiveConfig.backupTarget or "/srv/backups";
}</code></pre>
    <p>Dentro del contenedor del laboratorio, evalúa:</p>
    <pre><code>cd /workspace/lab/lesson-0003
nix-instantiate --eval --strict operators.nix</code></pre>
    <p>Resultado esperado:</p>
    <pre><code>{ backupTarget = "/srv/backups"; hasBackupTarget = false; hasMonitoring = true; hostname = "homeserver-prod"; monitoringEndpoint = "/metrics"; tools = [ "jq" "htop" ]; }</code></pre>
  </section>

  <section class="recall">
    <h2>Comprueba tu modelo mental</h2>
    <p>¿Por qué <code>tools</code> no conserva <code>git</code> y <code>curl</code>?</p>
    <button onclick="document.querySelector('#a1').style.display='block'">Mostrar respuesta</button>
    <p id="a1" class="answer">Porque <code>//</code> reemplaza superficialmente el atributo <code>tools</code>; después <code>++</code> añade <code>htop</code> a la lista reemplazante <code>[ "jq" ]</code>.</p>
  </section>

  <section class="card">
    <h2>Siguiente paso</h2>
    <p>Cuando completes el ejercicio, vuelve al chat y escribe <code>completé la lección 0003</code>. Incluye tu predicción y el resultado real.</p>
    <p>Si algo no está claro, pregunta al agente antes de continuar; incluye tu predicción y el resultado real.</p>
  </section>

  <section class="card small">
    <h2>Fuentes y navegación</h2>
    <ul>
      <li><a href="https://nix.dev/manual/nix/stable/language/operators.html">Nix manual — Operators</a></li>
      <li><a href="https://nix.dev/tutorials/nix-language">nix.dev — Nix language basics</a></li>
      <li><a href="../reference/0003-operadores-composicion-cheatsheet.html">Referencia 0003 — Operadores de composición</a></li>
      <li><a href="0002-lectura-basica-del-lenguaje-nix.html">Volver a la lección 0002</a></li>
    </ul>
  </section>
</main>
</body>
</html>
```

- [ ] **Step 4: Verificar estructura, vínculos pedagógicos y ausencia de estilos duplicados**

Run:

```bash
rg -n '<title>|../assets/teach.css|Práctica de recuperación|Mostrar respuesta|Nix manual — Operators|pregunta al agente|0003-operadores-composicion-cheatsheet' lessons/0003-componer-y-consultar-configuraciones-nix.html
rg -n '<title>|../assets/teach.css|actualización es superficial|Volver a la lección 0003|Nix manual — Operators' reference/0003-operadores-composicion-cheatsheet.html
if rg -n '<style' lessons/0003-componer-y-consultar-configuraciones-nix.html reference/0003-operadores-composicion-cheatsheet.html; then exit 1; fi
```

Expected: los dos primeros comandos encuentran todos los marcadores; el tercero termina con exit status `0` porque no existe `<style`.

### Task 4: Integrar navegación y ejecutar la verificación final

**Files:**
- Modify: `START-HERE.md`
- Verify: todos los archivos creados y modificados.

**Interfaces:**
- Consumes: lección, referencia y laboratorio de las tareas anteriores.
- Produces: una ruta de estudio coherente desde `START-HERE.md`.

- [ ] **Step 1: Añadir la lección 0003 a la ruta recomendada**

Insertar después del punto de la lección 0002:

```markdown
4. **Haz la tercera lección**
   - [Lección 0003 — Componer y consultar configuraciones Nix](./lessons/0003-componer-y-consultar-configuraciones-nix.html)
   - Objetivo: combinar defaults y overrides con `//`, comprobar atributos con `?` y seleccionar valores opcionales con `or`.
```

Renumerar los puntos posteriores. En la lista de referencias añadir:

```markdown
- [Referencia — operadores de composición](./reference/0003-operadores-composicion-cheatsheet.html)
```

Reemplazar la sección posterior a la lección 0002 por:

```markdown
## Después de completar la lección 0003

- Vuelve al chat y dime: `completé la lección 0003`.
- Incluye tu predicción del resultado de `operators.nix`.
- Si falló algo, pega el error exacto.
- Siguiente tema sugerido: funciones de listas y attribute sets (`map`, `builtins.filter` y consultas dinámicas).
```

Actualizar el comando gráfico para abrir:

```bash
xdg-open ~/estudio/linux/nix/lessons/0003-componer-y-consultar-configuraciones-nix.html
```

- [ ] **Step 2: Comprobar todos los enlaces locales Markdown y HTML**

Run:

```bash
node -e 'const fs=require("fs"),path=require("path");const files=["MISSION.md","START-HERE.md","lessons/0003-componer-y-consultar-configuraciones-nix.html","reference/0003-operadores-composicion-cheatsheet.html"];let failed=false;for(const file of files){const text=fs.readFileSync(file,"utf8");const links=[...text.matchAll(/(?:href="|\]\()([^"#)]+)(?:#[^")]+)?[")]/g)].map(match=>match[1]).filter(link=>!link.includes("://")&&!link.startsWith("mailto:"));for(const link of links){const target=path.resolve(path.dirname(file),link);if(!fs.existsSync(target)){console.error(`${file}: enlace roto ${link}`);failed=true;}}}if(failed)process.exit(1);console.log("Enlaces locales OK");'
```

Expected:

```text
Enlaces locales OK
```

- [ ] **Step 3: Ejecutar la validación completa del laboratorio**

Run desde `lab/`:

```bash
docker compose exec -T nix sh /workspace/lab/smoke-test.sh
```

Expected: exit status `0`; deben aparecer las secciones de Nix version, lección 0002, lección 0003 y `shell.nix`.

- [ ] **Step 4: Revisar coherencia y archivos finales**

Run desde la raíz:

```bash
rg -n 'flake.nix|lección 0003|Lección 0003|0003-' MISSION.md START-HERE.md NOTES.md RESOURCES.md learning-records lessons reference lab
find lessons reference learning-records lab/lesson-0003 -maxdepth 2 -type f | sort
```

Expected:

- `MISSION.md` y `START-HERE.md` presentan la lección 0003 como siguiente paso.
- Flakes solo queda mencionado como contenido futuro, no como la lección inmediata.
- Existen tres lecciones, tres referencias, cinco learning records y `lab/lesson-0003/operators.nix`.

- [ ] **Step 5: Inspeccionar cambios sin intentar commit**

Run:

```bash
git rev-parse --show-toplevel
```

Expected: `fatal: not a git repository`; informar que no se creó commit y entregar enlaces locales a la lección, referencia y plan.
