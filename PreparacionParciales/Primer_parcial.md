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

# Matrices

## Creación de matrices

```r
# Usando el comando matrix para crear la matriz directamente
A <- matrix(1:9, 3, 3)

# Creamos primero un vector, y luego asignamos las dimensiones
A <- 1:9                # Tenemos un vector
dim(A) <- c(3, 3)       # Asignamos dimensiones

# Crear una matriz de la forma:
# 1 2 ... n
# 1^2 2^2 ... n^2
# 1^3 2^3 ... n^3
# ... ... ... ...
# 1^n 2^n ... n^n
#
# Mi metodo:
A <- rep(1:n, times = 1, each = n) ^ rep(1:n, times = n, each = 1)
dim(A) <- c(n, n)

# Metodo de la profesora:
A <- matrix(
    rep(1:n, times=n, each=n)^rep(1:n, times=n),
    ncol=n,
    nrow=n
)

# Creacion de una matriz como concatenacion de columnas
x <- 1:10
y <- 11:20
z <- 21:30
w <- 31:40

# Concatenando por columnas
A <- cbind(x, y, z, w)

# Concatenando por filas
A <- rbind(x, y, z, w)

# Esto se puede hacer a mano concatenando filas con c(...) y luego asignando las dimensiones
# Pero es mucho mas lento
```

## Operaciones matriciales

```r
# Multiplicacion de dos matrices
A <- matrix(1:9, 3, 3)
B <- matrix(10:18, 3, 3)
C <- A %*% B

# Multiplicacion de vector por matriz
x <- 1:3
C <- A %*% x

# Transposicion de matrices
At <- t(A)
xt <- t(x)solve(2,2)

# Inversa de una matriz
A_inv <- solve(A)

# Determinante de una matriz
A_det <- det(A)

# Kappa y numero de condicion reciproco
A_kappa <- kappa(A)  # Muy grande => malo
A_rcond <- rcond(A)  # Muy cercano a cero => malo
A_kappa <- kappa(A, exact = TRUE) # Usa los eigenvalues para el computo

# Valores y vectores propios
eigen_values <- eigen(A)$values
eigen_vectors <- eigen(A)$vectors
```

## Resolución de sistemas lineales

```r

# Para resolver la ecuacion 2x = 2
x <- solve(2, 2)

# Para resolver el sistema:
#   3x + y = 12
#   4x + 2y = 8
A<-matrix(c(3, 1, 4, 2), 2, 2)
b<-c(12, 8)
sol <- solve(A, b)
```

## Método de mínimos cuadrados

Implementación a mano:

```r

# Datos de entrada
n<-5
x<-rnorm(n)
y<-1+x+rnorm(n,0,0.1)

# Generamos la matriz de datos para resolver el problema
X <- cbind(rep(1, n), x)

# Resolvemos el problema
# La solucion se encuentra en betta_hat
pre_matrix <- solve(t(X)%*%X)
betta_hat <- pre_matrix %*% t(X) %*% y

# En una funcion compacta
lin_reg_mse <- function(x, y){

    # Generamos la matriz de datos para resolver el problema
    X <- cbind(rep(1, n), x)

    # Resolvemos el problema
    # La solucion se encuentra en betta_hat
    pre_matrix <- solve(t(X)%*%X)
    betta_hat <- pre_matrix %*% t(X) %*% y

    return(betta_hat)

}

```

Implementación usando descomposición QR:

```r

lin_reg_mse_qr <- function(x, y){

    # Generamos la matriz para resolver el sistema
    # Haremos la descomposicion QR de esta matriz
    X <- cbind(rep(1, n), x)

    # Empezamos computando la descomposicion QR
    qr_descomp <- qr(X)
    X.Q <- qr.Q(qr_descomp)
    X.R <- qr.R(qr_descomp)

    # Calculamos la matriz intermedia Q'y
    inter_matrix <- t(X.Q) %*% y

    # Solucionamos el problema usando backsolve
    # Backsolve se usa para solucionar matrices triangulares superiores o inferiores
    result <- backsolve(X.R, inter_matrix)

    return(result)
}

n<-5
x<-rnorm(n)
y<-1+x+rnorm(n,0,0.1)
sol <- lin_reg_mse_qr(x, y)
```

## Otras operaciones

```r
# Cambiamos el nombre de las columnas
row.names(A) <- c("primera fila", "segunda fila")
colnames(A) <- c("Autor", "Libro", "Precio")
```

----------------------------------------------------------------------------------------------------

# Listas

## Creación de listas

```r
# Ejemplo basico
x1 = 1:3
x2 = 4:6
l <- list(x1 = x1, x2 = x2)

# Añadir elementos a una lista
# Las dos formas que pongo son equivalentes
x <- runif(200)
l$x <- x
l[["x"]] <- x
```

## Funciones apply

```r
# Devuelve una lista
sumas <- lapply(lista, sum)

# Devuelve una lista
# Se hace print de forma mas compacta
sumas <- sapply(lista, sum)


```

----------------------------------------------------------------------------------------------------

# Dataframes

## Creación de dataframes

```r
# Forma clasica de crear un dataframe
xi <- c(1.2, 1.8, 2.2, 2.5, 1.1)
yi <- c(15, 18, 10, 12, 16)
ni <- c(12, 23, 5, 9, 11)
datos <- data.frame(xi = xi, yi = yi, ni = ni)

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

----------------------------------------------------------------------------------------------------

# Plotting

Ejemplo usado a la hora de hacer plot de regresión lineal

```r
x<-rnorm(n)
y<-1+x+rnorm(n,0,0.1)

sol <- lin_reg_mse(x, y)
f <- function(x) {
    return(sol[1] + sol[2] * x)
}

# Añadimos una curva con la solucion real al problema
curve(1+x, -3, 3)

# Añadimos los puntos al grafico anterior
points(x,y)

# Añadimos una linea roja con la solucion que hemos encontrado
curve(f, add = TRUE, col = 2)
```

--------------------------------------------------------------------------------

# Control de errores

```r
try({
    # Codigo que puede devolver un error
    # ...
})

try(funcion_que_puede_fallar(n))
```
