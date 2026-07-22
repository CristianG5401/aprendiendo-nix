# shell.nix — Declarative development environment for lesson-0001.
#
# Run `nix-shell` in this directory to enter an isolated shell with the
# tools listed below. Nix downloads exact package versions and puts them on
# PATH without polluting the host system.

let
  # Pin nixpkgs to a specific release tarball so builds stay reproducible
  # across machines and over time (same URL → same package set).
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-26.05";

  # Load the nixpkgs package set. `config` and `overlays` are empty here;
  # they would enable options like unfree packages or custom package overrides.
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in

# mkShellNoCC builds a shell environment without a C/C++ compiler toolchain.
# Use mkShell instead if you need gcc/clang for native compilation in this lab.
pkgs.mkShellNoCC {
  # Packages exposed on PATH inside the nix-shell session.
  packages = with pkgs; [
    curl   # HTTP client for APIs and downloads
    git    # Version control
    jq     # JSON processor for scripting and inspection
    htop   # Interactive process monitor
  ];

  # Custom environment variable available as $LAB_NAME in the shell.
  LAB_NAME = "home-lab-reproducible";

  # Commands run automatically each time you enter `nix-shell`.
  shellHook = ''
    echo "Entorno Nix activo: $LAB_NAME"
    echo "Herramientas disponibles: curl git jq htop"
  '';
}
