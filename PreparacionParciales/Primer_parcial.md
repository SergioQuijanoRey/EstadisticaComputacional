---
title: Primer parcial
author: Sergio Quijano Rey
date: 18/04/2022
---

# Generalidades

Apuntes / resumen que escribo como preparación para el primer parcial de la asignatura *"Estadística Computacional"*

----------------------------------------------------------------------------------------------------

# Vectores

## Creación

```r
x <- 1:10
x <- seq(from = 1, to = 20, by = 0.2)
x <- seq(from = 1, by = 2, length.out = 20) # Genera los primeros 20 impares


# Dado un vector de valores de entrada, construir un vector con la salida de una funcion dada a
# trozos
x <- seq(from = -2, to = 2, by = 0.1)
y <-
    1 * (x < -1) +
    log(x * x) * (x >= -1) * (x < 0) +
    log(x*x + 1) * (x >= 0) * (x < 1) +
    2 * (x >= 1)

y[is.nan(y)] <- 0  # Limpiamos algunos NaN generados por el log

# Tambien se puede hacer con & para declarar mas de una condicion
y <-
    1 * (x < -1) +
    log(x * x) * (x >= -1 & x < 0) +
    log(x*x + 1) * (x >= 0 & x < 1) +
    2 * (x >= 1)


```

## Indexación de vectores

```r
x <- 1:100

# Acceder a una unica posicion
x[1]

# Acceder a mas de una posicion
x[c(1, 2, 3)]

# Usar otro vector para realizar la indexacion
# Por ejemplo, acceder a las primeras cuatro posiciones impares del vector
y <- seq(from = 1, by = 2, length.out = 4)
x[y]
```

## Filtrado de vectores

```r
x <- 1:100
x_par <- x[x %% 2 == 0] # Nos quedamos con los elementos pares

# Para mas de una condicion logica, usamos la version de un solo caracter de los operadores logicos
# Importante usar | & y no || &&, que no funcionan bien
x_intervalo <- x[x <= 0.1 | x >= 0.9]
x_otro_intervalo <- x[x >= 0.1 & x <= 0.9]
```

## Cálculo de posiciones

```r
x <- 1:20
mx <- mean(x)

# Buscamos la posicion del primer elemento mas grande que la media
# Which nos devuelve un vector con las posiciones del vector que cumplen cierta condicion logica
# Como el vector es monotono creciente (x[i] < x[i+1]) podemos usar min fuera
pos <- min(which(x > mx))

# Si no fuese un vector monotono, podemos hacer:
pos <- which(x == min([x > mx]))

```

## Operaciones comunes y estadísticas sobre vectores

```r
x <- codigo_que_genera_vector

# Calculo de la media. Podemos ignorar los valores NA
x_mean <- mean(x, rm.na = TRUE)

# Calculo la desviacion tipica
# Por defecto, usa como denominador n-1, como indica su documentacion
x_sd <- sd(x)

# Calculo la varianza
# Por defecto, usa como denominador n-1, como indica su documentacion
x_var <- var(x)

# Es muy facil realizar operaciones entre dos vectores, elemento a elemento
# Producto por escalar
x <- 1:20
escalar <- 3.0
prod_elemento_a_elemento <- escalar * x

# Producto y suma de dos vectores, elemento a elemento
x <- 1:10
y <- 11:20
xy <- x*y
xmasy <- x + y

# Diferencias entre elementos sucesivos de un vector
x_diffs <- diff(x, lag = 1)                    # Para computarlo usando una funcion de R
x_diffs <- x[2:length(x)] - x[1:length(x) - 1] # Para computarlo a mano
x_diffs <- x[-1] - x[-length(x)]               # Para computarlo a mano (alternativa menos legible)

```

## Otras operaciones

```r

# Asignar nombres a los elementos de un vector
# Usamos la sentencia paste, paste0 para juntar dos vectores en un unico vector
x <- 1:20
names(x) <- paste0("x_", 1:20, sep = "")

# Paste nos devuelve un vector, pero queremos obtener un unico elemento con los valores concatenados
# en un unico string. Por ejemplo, para formar "palabras" con letras aleatorias
#
# Vector con dos palabras generadas aleatoriamente
# Si no hacemos collapse, obtenemos un unico vector con 10 letras contiguas (vector de 10 elementos)
dos_palabras <- c(
    paste0(sample(LETTERS, 5), sep = "", collapse = ""),
    paste0(sample(LETTERS, 5), sep = "", collapse = "")
)

# Asignar cierto valor a las posiciones del vector que sean NA
x[is.na(x)] <- 0
```

----------------------------------------------------------------------------------------------------

# Números aleatorios

```r
# Establecemos la semilla aleatoria
set.seed(1)

# Tomamos n elementos de una muestra uniforme
x <- runif(n = 100, min = 0, max = 5)

# Muestra aleatoria de un vector sin re-emplazamiento
sample(x, size = 10, replace = FALSE)
```
