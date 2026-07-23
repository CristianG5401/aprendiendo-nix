# Recursos para aprender Nix

## Fuentes primarias

1. [nix.dev — Declarative shell environments with `shell.nix`](https://nix.dev/tutorials/first-steps/declarative-shell.html)
   - Uso: primera lección sobre entornos reproducibles.
   - Motivo: documentación oficial orientada a aprendizaje práctico.

2. [nix.dev — Nix language basics](https://nix.dev/tutorials/nix-language.html)
   - Uso: lección 0002 sobre lectura básica del lenguaje Nix.
   - Motivo: introducción oficial enfocada en leer Nix y entender expresiones, nombres, valores, funciones y derivations.

3. [Nix manual — Nix Language](https://nix.dev/manual/nix/stable/language/)
   - Uso: referencia de respaldo para tipos, valores, funciones y propiedades del lenguaje.
   - Motivo: manual oficial; Nix se describe como lenguaje declarativo, puro, funcional, lazy y dinámicamente tipado.

4. [Nix manual — Syntax and semantics](https://nix.dev/manual/nix/stable/language/constructs)
   - Uso: detalles de `let ... in`, attribute sets, listas, comments, functions e `inherit`.
   - Motivo: referencia oficial de sintaxis.

5. [Nix manual — `nix flake`](https://nix.dev/manual/nix/stable/command-ref/new-cli/nix3-flake.html)
   - Uso: cuando pasemos de `shell.nix` a `flake.nix` y `flake.lock`.
   - Motivo: fuente oficial para semántica de flakes.

6. [Nixpkgs manual — `mkShell`](https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-mkShell)
   - Uso: explicar `pkgs.mkShell`, `mkShellNoCC`, `packages`, `shellHook`.
   - Motivo: referencia oficial de Nixpkgs.

7. [Nix manual — Operators](https://nix.dev/manual/nix/stable/language/operators.html)
   - Uso: lección 0003 sobre attribute selection con `or`, comprobación con `?`, concatenación con `++` y actualización con `//`.
   - Motivo: referencia oficial de sintaxis, precedencia y semántica de operadores.

## Comunidades / sabiduría práctica

- [NixOS Discourse](https://discourse.nixos.org/)
- [NixOS Wiki](https://wiki.nixos.org/)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/)

Nota: las lecciones deben citar fuentes oficiales para conceptos básicos, y usar comunidades para patrones reales y casos de troubleshooting.
