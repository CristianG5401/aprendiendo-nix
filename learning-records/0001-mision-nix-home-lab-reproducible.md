# 0001 — Misión: Nix para home lab reproducible

## Contexto

Cristian quiere aprender Nix para evitar reconstruir manualmente sus servidores si cambia de equipo, formatea o algo se daña.

## Aprendizaje clave

La ruta inicial debe enfocarse en usar Nix sobre Ubuntu Server para entornos reproducibles antes de considerar migraciones mayores como NixOS.

## Implicación para próximas lecciones

Priorizar ejemplos prácticos de servidor/home lab:

- herramientas CLI reproducibles;
- scripts y automatización;
- backups y recuperación;
- eventualmente Home Manager, flakes y NixOS.

## Próxima zona de desarrollo

Después de `shell.nix`, enseñar `flake.nix` y `flake.lock` como mecanismo más fuerte de pinning/reproducibilidad.
