# Empieza aquí: Nix para servidores/home labs reproducibles

Este es el índice práctico del curso. Si abres solo un archivo, que sea este.

## Laboratorio Docker + Nix

Ya tienes un entorno aislado para practicar Nix sin instalarlo directamente en el host:

- [Lab README](./lab/README.md)
- [Docker Compose](./lab/docker-compose.yml)
- [Smoke test](./lab/smoke-test.sh)

Arranque rápido:

```bash
cd ~/estudio/linux/nix/lab
docker compose start nix
```

Entrar al contenedor:

```bash
docker compose exec nix sh
```

Verificación rápida:

```bash
docker compose exec nix sh /workspace/lab/smoke-test.sh
```

## Ruta recomendada

1. **Lee la misión**
   - [MISSION.md](./MISSION.md)
   - Sirve para recordar por qué estamos aprendiendo Nix: reconstruir entornos de servidor/home lab sin depender de memoria manual.

2. **Haz la primera lección**
   - [Lección 0001 — Tu primer entorno reproducible con Nix](./lessons/0001-tu-primer-entorno-reproducible-con-nix.html)
   - Objetivo: crear un `shell.nix` que declare herramientas CLI como `curl`, `git`, `jq` y `htop`.

3. **Haz la segunda lección**
   - [Lección 0002 — Leer Nix sin miedo: let, sets y listas](./lessons/0002-lectura-basica-del-lenguaje-nix.html)
   - Objetivo: entender la sintaxis mínima de Nix usando comparaciones con JavaScript/TypeScript.

4. **Haz la tercera lección**
   - [Lección 0003 — Componer y consultar configuraciones Nix](./lessons/0003-componer-y-consultar-configuraciones-nix.html)
   - Objetivo: combinar defaults y overrides con `//`, comprobar atributos con `?` y seleccionar valores opcionales con `or`.

5. **Usa las referencias rápidas cuando te atasques**
   - [Referencia — `shell.nix` básico](./reference/0001-shell-nix-cheatsheet.html)
   - [Referencia — lenguaje Nix mínimo](./reference/0002-nix-language-minimum-cheatsheet.html)
   - [Referencia — operadores de composición](./reference/0003-operadores-composicion-cheatsheet.html)

6. **Consulta fuentes oficiales**
   - [RESOURCES.md](./RESOURCES.md)
   - Ahí están las fuentes primarias: nix.dev, manual de Nix y manual de Nixpkgs.

## Después de completar la lección 0003

- Vuelve al chat y dime: `completé la lección 0003`.
- Incluye tu predicción del resultado de `operators.nix`.
- Si falló algo, pega el error exacto.
- Siguiente tema sugerido: funciones de listas y attribute sets (`map`, `builtins.filter` y consultas dinámicas).

## Comando útil para abrir la lección actual

Si tienes entorno gráfico:

```bash
xdg-open ~/estudio/linux/nix/lessons/0003-componer-y-consultar-configuraciones-nix.html
```

Si estás por SSH o TUI, puedes inspeccionarla con:

```bash
cd ~/estudio/linux/nix
python3 -m http.server 8000
```

Luego abre desde otro equipo de tu red:

```text
http://IP_DEL_SERVIDOR:8000/lessons/0002-lectura-basica-del-lenguaje-nix.html
```

## Regla del curso

No vamos a aprender Nix como teoría abstracta primero. Vamos a usarlo para resolver un problema concreto:

> poder reconstruir herramientas y entornos de administración de servidores con archivos versionables.

Además, desde la lección 0002, toda sintaxis nueva de Nix debe explicarse antes de usarse.
