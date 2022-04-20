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

# Obtenemos un vector con todos los elementos seguidos
# Lo que yo conozco como flatten
# La funcion unlist se puede usar para desestructurar otros tipos de datos
v <- unlist(l)
```

## Funciones apply

```r
# Devuelve una lista
sumas <- lapply(lista, sum)

# Devuelve una lista
# Se hace print de forma mas compacta
sumas <- sapply(lista, sum)

# Se puede usar tapply para aplicar funciones en una lista y en un factor dado
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

## Operaciones básicas

```r
# Primeros y ultimos 5 elementos del dataframe
head(data, 5)
tail(data, 5)

# Estructura del dataframe
str(data)

# Resumen con algunas estadisticas
summary(data)
```

## Manipulación de dataframes

```r
# Supongamos que queremos tipificar dos variables xi, yi conociendo su media y varianza

# Sintaxis transform:
datos.n.new <- transform(
    datos,
    xi_tip = (xi - x_mean) / sqrt(x_quasivar),
    yi_tip = (yi - y_mean) / sqrt(y_quasivar)
)

# Sintaxis within
datos.n.new <- within(datos, {
    xi_tip <- (xi - x_mean) / sqrt(x_quasivar)
    yi_tip <- (yi - y_mean) / sqrt(y_quasivar)
})

# Por ejemplo, para pasar la columna 'x8' a tipo factor, con ciertos nombres:
data <- within(data, {
    x8 <- factor(x8, labels = c("pequeña", "grande"))
})


# Aplicar una funcion segun un factor
data <- Chick100
peso.dieta <- tapply(data$weight, data$Diet, summary)


# Aplicar una funcion, segun un factor, y guardar los resultados en un dataframe
peso.dieta.2 <- aggregate(data$weight, by = list(data$Diet), summary)

# Ordenamos un dataframe segun el valor de varias columnas
data <- ChickWeight
Chick100Ordered <- data[
  with(Chick100, order(data$Diet, data$weight, decreasing = FALSE)),
]

# Acceder a los elementos del dataframe que no esten duplicados en el valor del factor Diet
# El orden de las filas en el dataframe influyen
NotDuplicated <- data[!duplicated(Chick100Ordered$Diet), ]

# Se puede usar unlist para obtener todos los elementos del dataframe en una vector simple
# Es lo que conozco como un flatten

# Filtrar de un dataframe las filas en las que haya algun missing value
data2 <- data[complete.cases(data), ]
data2 <- na.omit(data)

# Nos quedamos con las filas con un valor de un factor u otro
# data$x8 es un factor con dos niveles: empresas pequeñas y grandes
empresas_grandes <- data[data$x8 == "grande",]
empresas_pequeñas <- data[data$x8 == "pequeña",]
```

## Consultas sobre un dataframe

```r
# Contar los valores perdidos (missing values) por columna
valores_perdidos_por_columna <- lapply(data, is.na)
valores_perdidos_por_columna <- sapply(valores_perdidos_por_columna, sum)

# Contar el numero de filas sin missing values
no_missing_values <- sum(complete.cases(data))

```

## Acceso a columnas del dataframe

```r
xi <- c(1.2, 1.8, 2.2, 2.5, 1.1)
yi <- c(15, 18, 10, 12, 16)
ni <- c(12, 23, 5, 9, 11)
datos <- data.frame(xi = xi, yi = yi, ni = ni)
x <- datos["xi"]
x <- datos$xi

```

## Muestreo en el dataframe

```r
data <- ChickWeight

# Tomamos 100 filas sin muestreo
Chick100 <- data[sample(1:nrow(data), size = 100, replace = FALSE), ]

# Permutamos aleatoriamente las columnas del dataframe
Chick100ColPerm <- data[, sample(1:ncol(data), size = ncol(data), replace = FALSE)]
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

Ejemplo usado para mostrar dos gráficas de funciones superpuestas

```r
# Funcion que vamos a mostrar
f<-function(x) x^2-5

# Hacemos plot de la funcion en un intervalo
curve(f,0,10)

# Añadimos una linea horizontal
abline(h=0,col=2)
```

--------------------------------------------------------------------------------

# Control de errores

Para capturar un error y que no pare la ejecución del programa:

```r
try({
    # Codigo que puede devolver un error
    # ...
})

try(funcion_que_puede_fallar(n))
```

Para levantar un error con un texto:

```r
if(cond){
    stop("Mensaje de error")
}
```

Podemos hacer lo mismo pero sin parar la ejecución, solo con un warning:


```r
if(cond){
    warning("Mensaje de alerta")
}
```

--------------------------------------------------------------------------------

# Acceso a ficheros externos

```r
file <- "../SesionesDiarias/Census.csv"

# Leemos de un csv
# as.is sirve para indicar que columnas de tipo string queremos que se guarden como tipo factor
# Se usa a la inversa, indicamos que columnas no queremos que sean tipo factor
# Si hacemos as.is = NA, indicamos que todas las columnas de tipo string sean factores
data <- read.csv(file, header = TRUE, as.is = rep(FALSE, 10))
data <- read.csv(file, header = TRUE, as.is = NA)

# Lectura de un fichero de forma generica
# Da algo mas de flexibilidad que read.csv, como en el separador
data <- read.table(filename, header = TRUE, sep = "\t", as.is = rep(FALSE, 10))


# Escribimos una tabla de forma generica
# Tenemos muchos mas parametros que podemps establecer, como eol END OF LINE
write.table(data2, filename, sep = "\t", row.names = FALSE, col.names = TRUE)

# Escribimos usando la funcion mas basica
# Por ejemplo, tenemos una matriz y queremos guardarla en un fichero grabando los nombres de las
# columnas, que estan guardadas en nombres
# Cuando usamos esto, notar que tenemos que trasponer la matriz de datos, cosa que no hace falta con
# write.table o write.csv
write(nombres, file = 'matriz.txt', ncol = 5, sep = ',')
write(t(matriz), file = 'matriz.txt', ncol = 5, sep = ',', append = TRUE)
```

--------------------------------------------------------------------------------

# Optimización y búsqueda de ceros

Tenemos que definir la funcion de forma que solo reciba un parámetro, tipo lista, a optimizar. Por ejemplo:

```r
logl <- function(theta) {
    # El parametro de entrada es una lista
    a <- theta[1]
    b <- theta[2]

    # Logaritmo de la verosimilitud de una distribucion aleatoria
    l <- sum(log(dgamma(x=muestra,shape=a,scale=b)))

    # Devolvemos el negativo, porque dos de las tres librerias minimizan, y queremos maximizar esta funcion
    return(-l)
}
```

Para optimizar, podemos usar tres librerías:

```r
# Libreria por defecto de R, que minimiza
a0 <- 1 # Valores iniciales
b0 <- 1 # Valores iniciales
res <- optim(par=c(a0,b0),fn=logl)

# Libreria Rsolnp, que minimiza
library(Rsolnp)
b0 <- 1
a0 <- 1
res<-solnp(pars=c(a0,b0), fun=logl, LB=c(0,0))


# Libreria maxLik, que maximiza. Por tanto, cambiamos el signo de la funcion de nuevo
library(maxLik)
res <- maxLik(function(theta) -logl(theta),start=c(1,1))
res_depurado <- res$estimate)

# Con esta libreria podemos incluir restricciones. Por ejemplo, para indicar que a, b > 0, usamos
# las siguientes matrices para indicar esto:
A <- matrix(c(1,0,0,1),2)
B <- c(0,0)
maxLik(logl2,start=c(1,1),constraints=list(ineqA=A,ineqB=B))
```

--------------------------------------------------------------------------------

# Funciones

## Devolucion de valores

Para un único valor:

```r
f <- function(x){
    return(x^2)
}
```

Para devolver varios valores necesitamos usar una lista

```r
f <- function(x){
    return(list(x_square = x^2, x_cube = x^3))
}

```

## Comprobaciones de seguridad

Podemos usar las funciones `missing` y `is.numeric` para sanear las entradas a una función. Esto se ve mejor con un ejemplo:

```r
medias <- function(x) {

    # Comprobamos que el vector sea numerico
    if(is.numeric(x) == FALSE) {
        # Mostramos un mensaje de error
        # TODO -- aqui la profesora usa stop para interrumpir la ejecucion del programa
        warning("ERROR, se esperaba un vector numerico")

        # No computamos ninguna media
        return(NA)
    }

    # Comprobamos datos perdidos. En caso de encontrarlos, los ignoramos
    if(length(x[is.na(x)]) > 0) {
        # Mostramos un mensaje por pantalla
        warning("CUIDADO! Hay valores perdidos en el vector, que vamos a igrnorar")

        # Limpiamos el vector de valores NA
        no_na_values <- x[!is.na(x)]
        x <- x[no_na_values]
    }

    # Comprobamos si tenemos valores negativos o cero
    # Guardamos la comprobacion en una variable porque la vamos a necesitar mas adelante
    tiene_cero_o_negativos <- length(x[x <= 0]) > 0
    if(tiene_cero_o_negativos){
        warning("CUIDADO! En vector contiene valores cero o negativos")
    }

    # Resto de la funcion ...
}
```

## Aproximaciones numéricas de la derivada

```r
# Libreria que se usa para la derivacion numerica
library(numDeriv)

# Funcion de ejemplo
f <- function(x) exp(x) - x^2

# Funcion que usa para evaluarse en un punto la derivada numerica en ese punto
f.prima <- function(x) genD(func = f, x = x)$D[1]
```
