# Misión de aprendizaje: Nix para servidores/home labs reproducibles

## Empieza aquí

Si acabas de abrir este archivo, sigue esta ruta:

1. Abre el índice del curso: [START-HERE.md](./START-HERE.md)
2. Haz la primera lección: [0001 — Tu primer entorno reproducible con Nix](./lessons/0001-tu-primer-entorno-reproducible-con-nix.html)
3. Ten a mano la referencia rápida: [shell.nix básico](./reference/0001-shell-nix-cheatsheet.html)
4. Consulta las fuentes oficiales en [RESOURCES.md](./RESOURCES.md)

## Por qué aprender esto

Cristian quiere aprender Nix para crear entornos reproducibles para sus servidores y home labs personales. Ya tiene un servidor con Ubuntu Server, pero quiere evitar empezar de cero si cambia de equipo, formatea o algo se daña.

## Resultado práctico deseado

Ser capaz de describir herramientas, servicios auxiliares y entornos de trabajo en archivos versionables, de modo que pueda reconstruirlos en otra máquina con pasos mínimos y predecibles.

## Enfoque del curso

1. Empezar con entornos de shell reproducibles en Linux usando Nix sin migrar todavía a NixOS.
2. Entender cómo Nix separa instalación imperativa de configuración declarativa.
3. Aprender `shell.nix`, luego `flake.nix`, y más adelante Home Manager / NixOS si aporta valor.
4. Usar ejemplos cercanos a servidores: herramientas CLI, backup, monitoring, Docker/containers, automatización y recuperación.

## Criterio de éxito inicial

Cristian puede crear un directorio versionable que, al ejecutar un comando de Nix, le entregue las mismas herramientas CLI en otra máquina compatible.

## Próximo paso concreto

Cristian ya demostró que puede leer y traducir la base del lenguaje Nix. El siguiente paso es completar:

- [Lección 0003 — Componer y consultar configuraciones Nix](./lessons/0003-componer-y-consultar-configuraciones-nix.html)
- [Referencia — Operadores de composición](./reference/0003-operadores-composicion-cheatsheet.html)

La meta inmediata es construir una configuración efectiva de home lab combinando defaults y overrides, y consultando atributos opcionales sin romper la evaluación.
