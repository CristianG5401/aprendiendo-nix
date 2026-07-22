# Lab Docker Compose para practicar Nix

Este directorio contiene un entorno aislado para practicar Nix sin depender de que Nix esté instalado directamente en el host.

## Arrancar el laboratorio

Desde esta carpeta:

```bash
cd ~/estudio/linux/nix/lab
docker compose up -d
```

## Entrar al contenedor

```bash
docker compose exec nix sh
```

Dentro del contenedor, el curso queda montado en:

```text
/workspace
```

Por ejemplo:

```bash
cd /workspace/lab/lesson-0002
nix-instantiate --eval --strict basics.nix
```

## Ejecutar verificación rápida

Desde el host:

```bash
cd ~/estudio/linux/nix/lab
docker compose exec nix sh /workspace/lab/smoke-test.sh
```

Ese script verifica:

1. que Nix responde con `nix --version`;
2. que puede evaluar `lesson-0002/basics.nix`;
3. que puede entrar al `shell.nix` de la lección 0001;
4. que `jq`, `curl` y `git` aparecen dentro de la shell reproducible.

## Apagar el laboratorio

```bash
cd ~/estudio/linux/nix/lab
docker compose down
```

## Borrar también el Nix store persistente

Esto libera espacio, pero perderás paquetes descargados por Nix dentro del lab:

```bash
cd ~/estudio/linux/nix/lab
docker compose down -v
```

## Notas

- El volumen `nix-store` persiste `/nix` para no descargar todo de nuevo cada vez.
- El archivo `nix.conf` activa `nix-command` y `flakes`, que usaremos en próximas lecciones.
- Este entorno es para aprender y experimentar; no reemplaza todavía una instalación real de Nix en tu servidor.
