# Diseño: guía de contribución del repositorio

## Objetivo

Crear `AGENTS.md` como una guía breve y específica para quienes contribuyan a este repositorio educativo de Nix. El documento usará el título obligatorio `Repository Guidelines`; el contenido estará en español y tendrá entre 200 y 400 palabras.

## Contenido

La guía describirá las carpetas reales del proyecto: lecciones HTML en `lessons/`, ejercicios Nix y laboratorio Docker en `lab/`, referencias en `reference/`, recursos visuales en `assets/` y registros de aprendizaje en `learning-records/`.

Documentará únicamente comandos comprobables presentes en el repositorio: iniciar o detener el laboratorio con Docker Compose, entrar al contenedor y ejecutar `lab/smoke-test.sh`. También explicará cómo evaluar directamente `lab/lesson-0002/basics.nix` dentro del contenedor.

Las convenciones reflejarán los archivos existentes: indentación de dos espacios para Nix y YAML, scripts POSIX `sh` con `set -eu`, nombres de lecciones con prefijos numéricos de cuatro dígitos y documentación pedagógica en español. Se indicará que no hay formatter, linter, framework de pruebas ni objetivo de cobertura configurados.

## Contribuciones y validación

Como el repositorio todavía no tiene commits, la guía no atribuirá una convención histórica. Recomendará Conventional Commits con ejemplos y pedirá que los pull requests expliquen el propósito, indiquen las comprobaciones ejecutadas y adjunten capturas cuando cambien lecciones HTML.

La verificación final comprobará el rango de palabras, los encabezados requeridos, la existencia de los comandos citados y que `AGENTS.md` no incluya herramientas o políticas inexistentes.
