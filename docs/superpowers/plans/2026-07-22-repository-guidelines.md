# Repository Guidelines Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Crear una guía de contribución específica, concisa y verificable para este repositorio educativo de Nix.

**Architecture:** Un único archivo raíz, `AGENTS.md`, resumirá la organización, el flujo del laboratorio, las convenciones y los criterios de contribución. No añadirá dependencias, automatización ni políticas que el repositorio no tenga.

**Tech Stack:** Markdown, Nix, POSIX shell, Docker Compose y Git.

## Global Constraints

- Usar el título exacto `Repository Guidelines` y redactar el resto en español.
- Mantener el documento entre 200 y 400 palabras.
- Documentar solo estructura, comandos y herramientas comprobables en el repositorio.
- No crear commits durante la implementación.

---

### Task 1: Crear la guía de contribución

**Files:**
- Create: `AGENTS.md`
- Reference: `START-HERE.md`
- Reference: `lab/README.md`
- Reference: `lab/smoke-test.sh`

**Interfaces:**
- Consumes: la estructura y los comandos existentes del repositorio.
- Produces: instrucciones Markdown para futuros colaboradores y agentes.

- [ ] **Step 1: Crear `AGENTS.md`**

````markdown
# Repository Guidelines

## Estructura del proyecto

Este repositorio es un curso práctico de Nix orientado a servidores y home labs reproducibles. `START-HERE.md` es el índice principal. Las lecciones navegables viven en `lessons/`; las hojas de consulta, en `reference/`; y los estilos compartidos, en `assets/teach.css`. `lab/` contiene el entorno Docker, ejercicios Nix y la prueba rápida. Registra avances en `learning-records/` con archivos numerados; conserva decisiones de diseño en `docs/superpowers/specs/`.

## Comandos de desarrollo y validación

Ejecuta los comandos del laboratorio desde `lab/`:

```bash
docker compose up -d
docker compose exec nix sh
docker compose exec nix sh /workspace/lab/smoke-test.sh
docker compose down
```

El primer comando inicia el contenedor, el segundo abre una shell, el tercero valida Nix y las lecciones existentes, y el último detiene el laboratorio. Para evaluar solo el ejercicio de sintaxis:

```bash
docker compose exec nix nix-instantiate --eval --strict \
  /workspace/lab/lesson-0002/basics.nix
```

## Estilo y convenciones de nombres

Usa dos espacios en Nix y YAML, y conserva scripts compatibles con POSIX `sh`, incluyendo `set -eu`. Sigue los patrones `0003-tema-descriptivo.html`, `lesson-0003/` y `0003-descripcion.md`. Escribe documentación pedagógica en español y explica sintaxis nueva antes de usarla. No hay formatter ni linter configurados; imita el estilo cercano y evita cambios de formato ajenos.

## Pruebas

No existe un framework de pruebas ni un mínimo de cobertura. Antes de enviar cambios en `lab/`, ejecuta el smoke test completo. Para ejercicios Nix, añade una evaluación reproducible al script cuando corresponda y confirma que falle inmediatamente mediante `set -eu`.

## Commits y pull requests

El repositorio aún no tiene historial del cual inferir convenciones. Usa Conventional Commits, por ejemplo `docs: add lesson 0003` o `test(lab): extend smoke test`. Mantén cada commit enfocado. En el pull request explica propósito y alcance, enumera los comandos ejecutados y enlaza incidencias relacionadas. Adjunta capturas si modificas HTML o CSS visible y evita incluir `node_modules/`, `result*` o estado local de `direnv`.
````

- [ ] **Step 2: Verificar contenido y formato**

Run:

```bash
wc -w AGENTS.md
rg -n '^# Repository Guidelines$|^## ' AGENTS.md
git diff --check -- AGENTS.md
```

Expected: entre 200 y 400 palabras, un título exacto, cinco encabezados de segundo nivel y ninguna advertencia de espacios.

- [ ] **Step 3: Revisar el diff final**

Run:

```bash
git diff --no-index /dev/null AGENTS.md
```

Expected: únicamente la guía aprobada, sin archivos generados ni cambios colaterales.
