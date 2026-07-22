# 0004 — Lab Docker Compose con Nix creado y verificado

## Contexto

Cristian pidió crear un entorno de pruebas con Nix usando Docker Compose dentro de la carpeta `lab`, para poder probar lo aprendido sin depender de tener Nix instalado en el host.

## Material creado

- `lab/docker-compose.yml`
- `lab/nix.conf`
- `lab/smoke-test.sh`
- `lab/README.md`

## Diseño

El servicio `nix` usa la imagen `nixos/nix:latest`, monta todo el curso en `/workspace`, y persiste `/nix` mediante un volumen Docker llamado `nix-store`.

Se activan experimental features útiles para próximas lecciones:

- `nix-command`
- `flakes`

## Verificación real ejecutada

Se ejecutó:

```bash
cd ~/estudio/linux/nix/lab
docker compose pull nix
docker compose create --force-recreate nix
docker compose start nix
docker compose exec -T nix sh /workspace/lab/smoke-test.sh
```

Resultado relevante:

- `nix (Nix) 2.34.7`
- `lesson-0002/basics.nix` evaluó correctamente.
- `lesson-0001/shell.nix` entró correctamente con `nix-shell`.
- `jq`, `curl` y `git` aparecieron dentro de la shell reproducible.

## Próxima zona de desarrollo

Usar este lab para la lección de `flake.nix` + `flake.lock`, ejecutando comandos reales dentro del contenedor.
