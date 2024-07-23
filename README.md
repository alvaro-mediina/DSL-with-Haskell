---
title: Laboratorio de Funcional
author: Medina Alvaro - Soria Pedro - Teruel Belén
---
La consigna del laboratorio está en https://tinyurl.com/funcional-2024-famaf

# 1. Tareas
Pueden usar esta checklist para indicar el avance.

## Verificación de que pueden hacer las cosas.
- [ ] Haskell instalado y testeos provistos funcionando. (En Install.md están las instrucciones para instalar.)

## 1.1. Lenguaje
- [ ] Módulo `Dibujo.hs` con el tipo `Dibujo` y combinadores. Puntos 1 a 3 de la consigna.
- [ ] Definición de funciones (esquemas) para la manipulación de dibujos.
- [ ] Módulo `Pred.hs`. Punto extra si definen predicados para transformaciones innecesarias (por ejemplo, espejar dos veces es la identidad).

## 1.2. Interpretación geométrica
- [ ] Módulo `Interp.hs`.

## 1.3. Expresión artística (Utilizar el lenguaje)
- [ ] El dibujo de `Dibujos/Feo.hs` se ve lindo.
- [ ] Módulo `Dibujos/Grilla.hs`.
- [ ] Módulo `Dibujos/Escher.hs`.
- [ ] Listado de dibujos en `Main.hs`.

## 1.4 Tests
- [ ] Tests para `Dibujo.hs`.
- [ ] Tests para `Pred.hs`.


# 2. Experiencia
A la hora de hacer el laboratorio en un principio, nos topamos con volver a entender como funciona Haskell, una vez que nos volvimos a familiarizar empezamos a desarrolar la sintaxis del lenguaje, para ver si las funciones andaban le pediamos a chatgpt que nos realize ejemplos y los probabamos. Para hacer la parte de pred utilizamos la misma metodologia. Luego para la interpretacion geometrica de las funciones en el modulo `Interp.hs` nos basamos en la semantica otorgada en la consigna.  Por ultimo para la programacion del modulo Escher, el aticulo de Peter Henderson recomendado y el archivo `Feo.hs` fueron de gran ayuda. Nos trabamos un poco en esta ultima parte, ya que los dibujos no nos quedaban bien pero lo solucionamos copiando literalmente las funciones del articulo.
En cuanto al trabajo en grupo, pudimos organizarnos desde un principio. Para evitar inconvenientes, charlamos sobre el tiempo que cada uno le iba a dedicar al proyecto para así repartir las tareas de la forma más equitativamente posible.


# 3. Preguntas
Al responder tranformar cada pregunta en una subsección para que sea más fácil de leer.

1. ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.
2. ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez de eso, es un parámetro del tipo?
3. ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?
4. ¿Cuál es la diferencia entre los predicados definidos en Pred.hs y los tests?


# Respuestas

## Respuesta 1
Las funcionalidades se encuentran separadas en disitintos modulos con el fin de diferenciar, la sintaxis de la semantica o su interpretacion, como tambien de la utlizacion de las mismas.
En `Dibujos.hs` se define la sintaxis del lenguaje o DSL (Domain Specific Language) que hemos implementado, es decir en este modulo queda especificado què es lo que se puede escribir legalmente en este lenguaje y cuales son las funciones que podra utilizar el usuario.
En `Interp.hs` se define la semantica o interpretacion del lenguaje, lo que hicimos fue utilizar la libreria gloss para la generacion de graficos, a su vez utilizamos el mòdulo Data.Point.Arithmetic que nos permite realizar operaciones aritmèticas entre vectores para poder implementar la semantica como esta definida en el enunciado del laboratorio. 
Dentro de la carpeta Dibujos, se encuentran diferentes modulos en los que utilizamos el lenguaje para poder realizar los distintos dibujos solicitados. Cada modulo se encuentra representado por su configuracion, dada por su nombre, interpretacion y su tipo basico.
Por ultimo el modulo `Main.hs` se encarga de la creación de la pantalla donde se proyecta el dibujo y de qué dibujo se va a proyectar, eligiendo las configuraciones deseadas(accesibles llamando a Main con el parámetro `lista`).

## Respuesta 2
Hacemos esto para tener una abstraccion y que el lenguaje sea mas flexible y reutilizable. De esta forma `Dibujo a` puede ser utilizado con cualquier tipo de figuras basicas (por ej, Pentagono, Hexagono, etc). 
Esta tecnica es conocida como "programacion parametrica" y permite que el codigo sea agnostico al tipo de datos especifico con el que esta trabajando.

## Respuesta 3
Cuando utilizamos pattern-matching directo, debemos escribir un patrón para cada posible caso en cambio `fold` proporciona una forma más general y flexible de procesar la estructura de datos.
Por otro lado, en `fold` utilizamos una función que se aplica a cada elemento de la estructura de datos de manera sistemática. Esta función puede realizar cualquier tipo de operación en cada elemento.
En resumen, utilizar una función de `fold` en lugar de hacer pattern-matching directo te brinda más flexibilidad, modularidad y control sobre cómo procesar una estructura de datos.

## Respuesta 4
Tenemos que tener en cuenta que en el archivo `Pred.hs` definimos el tipo `Pred` y funciones operacionales para predicados, como `cambiar`,`anyDib`,`allDib`, entre otros.

* Sobre el tipo `Pred`: Es nuestro tipo para la definición de predicados.
* Sobre las funciones operacionales: A través de predicados existentes podremos operar sobre ellos. Pej: Rotar todos los triangulos.

Por otro lado en `TestPred.hs`, archivo de testeo, se utilizan las funciones de Pred.hs para corroborar que funcionan correctamente. En efecto, `TestPred.hs` depende de `Pred.hs` pero cumplen roles distintos.

# 4. Ejecución

## Main
- Ejecución Inicial: `cabal run dibujos <dibujo>` (Optativo)
- Ejecución con elección de dibujo: `cabal run dibujos lista`

## Test
- Test para `Dibujo.hs`: `cabal test dibujo`
- Test para `Pred.hs`:   `cabal test predicados`


