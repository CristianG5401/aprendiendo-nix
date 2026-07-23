# Base funcional del lenguaje Nix demostrada

Cristian tradujo correctamente entre Nix y JavaScript/TypeScript ejercicios con `let ... in`, condicionales, `++`, currying, aplicación parcial, argumentos con defaults, `args@{ ... }`, `inherit` e `import`. Esto establece que las próximas lecciones no deben repetir esa sintaxis desde cero: deben recuperarla mediante práctica y avanzar hacia composición de configuraciones.

## Evidencia

En el chat compartido predijo estructuras resultantes y explicó mediante código que `import ./archivo.nix` obtiene el valor evaluado del archivo, mientras que el argumento posterior aplica ese valor si es una función.

## Implicaciones

La siguiente zona de desarrollo es distinguir y aplicar `//`, `?` y attribute selection con `or`, intercalando `++` como recuperación.
