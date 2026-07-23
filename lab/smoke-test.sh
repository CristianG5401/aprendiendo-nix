#!/usr/bin/env sh
set -eu

echo "== Nix version =="
nix --version

echo

echo "== Eval basics.nix from lesson 0002 =="
nix-instantiate --eval --strict /workspace/lab/lesson-0002/basics.nix

echo

echo "== Eval operators.nix from lesson 0003 =="
nix-instantiate --eval --strict /workspace/lab/lesson-0003/operators.nix

echo

echo "== Enter shell.nix from lesson 0001 and test tools =="
cd /workspace/lab/lesson-0001
nix-shell --run 'echo "LAB_NAME=$LAB_NAME"; command -v jq; jq --version; command -v curl; command -v git'

echo

echo "Smoke test OK: Nix evaluó las lecciones 0002 y 0003, y entró al shell.nix."
