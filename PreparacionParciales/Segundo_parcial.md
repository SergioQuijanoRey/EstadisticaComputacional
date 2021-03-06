---
title: Preparación del Segundo Parcial
author: Sergio Quijano Rey
date: 01.06.2022
geometry: margin = 3.0cm
url: https://github.com/SergioQuijanoRey/EstadisticaComputacional
---

# Generalidades

- *Cheatsheet* donde voy a colocar todo el código para la preparación del segundo parcial

# Trabajo con `Dataframes`

- Esto debería consultarlo en el otro archivo, donde tengo toda la información del examen pasado
- Hacer `attach` para que sea más cómodo trabajar con un *dataframe*:

```r
# Cargo un dataset
employees <- read.table("Employee.txt", header = TRUE, sep = " ", as.is = NA)

# Hago attach
# Con esto, en vez de hacer `employees$salary` puedo hacer simplemente `salary`
attach(employees)
```

# Gráficos

## Histogramas

- Histograma básico:

```r
hist(employees$salary)
```

- Histograma con 100 barras:

```r
hist(salary, breaks = 100)
```

- Histograma con barras de distinta longitud
    - Al tener distinta longitud, se representa la densidad de frecuencia


```r
# Defino una secuencia de puntos de corte, de distinta anchura
x1 <-seq(15000,40000,by=5000)
x2 <-seq(50000,80000,by=10000)
x3 <-seq(100000,140000,by=20000)

# Breaks se puede especificar en distintos formatos
# En este caso, lo que buscamos es que breaks indique todos los puntos de corte
# del histograma
hist(salary, breaks = c(x1, x2, x3))
```

- **Histograma con función de densidad**:

```r
# Es muy importante que usemos densidad de frecuencia y no frecuencia absoluta
hist(salary, breaks=c(x1,x2,x3))
lines(density(salary), col='blue')

# En otro caso, tenemos que especificar que usemos densidad de frecuencia:
hist(salary, prob = TRUE)
lines(density(salary), col='blue')
```

- **Histograma con función de densidad y distribución normal de media y desviación la de los datos**:
    - Superponer la normal (pongo esto para poder buscar rápido en el examen)

```r
# Histograma basico de los datos
hist(salary, prob = TRUE)

# Funcion de densidad de los datos en azul
lines(density(salary),col='blue')

# Distribucion normal con media y desviacion la de los datos, en rojo sobre el grafico anterior
curve(dnorm(x,mean=mean(salary),sd=sd(salary)),add=TRUE,col='red',lty=2)

# Leyenda explicativa
legend('topright',c('Función de densidad suavizada','Función de densidad Normal'),lty = 2)
```

- **Histograma de una variable, considerando intervalos de longitud `long`**
    - Para ello, tengo que calcular el rango de dicha variable (max - min) y dividir en 10, para lograr los intervalos
    - Hay que tener cuidado con los valores faltantes

```r
# Lo hago para el ejemplo concreto de `airquality$Ozone`, con `long = 10`

# Maximo y minimo para calcular el numero de breaks que tenemos que hacer
min.ozone <- min(dataset$Ozone, na.rm = TRUE)
max.ozone <- max(dataset$Ozone, na.rm = TRUE)

# Histograma
hist(
    dataset$Ozone[is.na(dataset$Ozone) == FALSE],
    breaks = (max.ozone - min.ozone) / 10.0,
    main = "Histograma del ozono",
    xlab = "Valor del ozono"
)
```

- Obtener los metadatos de un histograma:

```r
metadatos <- hist(employees$salary, plot = FALSE)
metadatos
```

## Gráfico de cajas

- Gráfico básico:

```r
hist(employees$salary)
```

- Para ver los límites de las cajas (cuartiles, mediana y media) podemos usar `summary(employees$salary)`
- Gráfico en el que se muestra una **variable en función de la división por otra variable**

```r
# Se muestra el salario en funcion del genero
boxplot(salary~gender)

# Ahora doble clasificacion, salario en funcion de genero y posicion
boxplot(salary~gender*jobcat)
```

## Diagrama de dispersión

- Diagrama básico:

```r
# Mostramos en el eje x el salario y en el eje y la edad
plot(salary, age)
```

- Matriz de gráficos de dispersión, mostrando todos los posibles pares de dispersión de un *dataset*
    - Sirve para detectar posibles linealidades entre dos variables
    - Sirve para detectar si hay respuesta lineal de la variable de salida con alguna de las variables de entrada

```r
# Uso el dataset `hatco` como ejemplo
# Uso c(6:13) porque en ese dataset, estas son las variables numericas para las
# que tiene sentido hacer graficos de dispersion
plot(hatco[,c(6:13)])
```

## Gráfico de un modelo ajustado a unos datos, sobre el gráfico de dispersión:

- Lo ejemplificamos para las variables `age` y `salary`:

```r
# Generamos el modelo
mod<-lm(salary~age)

# Pintamos la linea del modelo sobre el scatter plot
plot(age, salary)
abline(mod, col="blue")
```

## Tablas de frecuencias de variables categóricas

- **Frecuencias absolutas**

```r
tab <- table(jobcat)
tab
```

- **Frecuencias relativas**
    - Notar que necesitamos haber calculado las frecuencias absolutas

```r
# Dependemos de `tab`, que son las frecuencias absolutas
tab.fi <- prop.table(tab)
tab.fi
```

- Con esto, podemos construir una **tabla clásica de frecuencias**

```r
data.frame(tab, Freq.rel = as.numeric(tab.fi))
```

## Tabla de frecuencias conjuntas de dos variables

- También conocida como **tabla de contingencia**
- Se empieza construyendo un `table` con las dos variables con las que queremos trabajar

```r
tab2 <- table(employee$jobcat, employee$gender)
```

- Añadimos la suma por filas y columnas:

```r
# Notar que no hacemos `tab2 <- addmargins(tab2)`, porque la funcion ya modifica la tabla para
# evitar que tengamos que hacer esto
addmargins(tab2)
```

### Diagrama de barras

- Dependemos de las tablas de frecuencias que hemos explicado en el apartado anterior

```r
barplot(tab)
```

### Diagrama de sectores

- Dependemos de las tablas de frecuencias que hemos explicado en el apartado anterior

```r
pie(tab)
```

### Diagrama de barras apiladas

- Dependemos de una tabla de _contingencia_ construida en un apartado anterior, con la suma de los márgenes realizada
- Las dos variables con las que trabajamos deben ser _factores_ para que se visualice correctamente
- Con esto ya podemos hacer:

```r
# `tab2` debe ser una tabla de contingencia a la que se le han sumado en los
# margenes con `addmargins`
barplot(tab2)
```

- Hacemos lo mismo, pero con una **primera mejora gráfica**:

```r
barplot(
    tab2,
    legend.text=TRUE,
    args.legend = list(x = 'topleft', bty = 'n'),
    ylim = c(0, 300),
    density = 30,
    col = c('green', 'blue', 'red'),
    main = 'Number of employees by gender and job category'
)
```

- Una **segunda mejora gráfica** (es alternativa, no es una mejora que se añada a la primera!):

```r
barplot(
    tab2,
    legend.text = TRUE,
    args.legend = list(x = 'top', bty = 'n'),
    density = 30,
    col = c('green', 'blue', 'red'),
    main = 'Number of employees by gender and job category',
    beside = TRUE
)
```

--------------------------------------------------------------------------------

# Estudios estadísticos

## Estudio de la normalidad

- **Gráfico probabilístico normal**
    - Buscamos con este gráfico que los puntos salgan alineados en una recta
    - En cuyo caso, podemos pensar que los datos siguen una distribución normal

```r
qqnorm(salary)
```

- **Test de hipótesis**:
    - $H_0$: la variable sigue una distribución normal
    - $H_1$: la variable no sigue una distribución normal
    - Buscamos, por tanto, no rechazar la hipótesis nula, luego el $p-value$ debe ser alto
    - Cuando el $p-value$ es bajo, se rechaza la hipótesis nula, es decir, la variable no sigue una distribución normal
- **Test Kolgomorov-Smirnov**:
    - Sirve para otras distribuciones además de la normal, por eso hay que especificar más parámetros que en el test de Shapiro
    - Siempre hay que usar `p<distribucion>` o la función de densidad de probabilidad $f(x)$ que hayamos programado
        - Recordar que esta es la función de distribución $F(x)$, por si la tenemos que definir a mano

```r
# Usando el ejemplo del salario
ks.test(salary, pnorm, mean = mean(salary), sd = sd(salary))
```

- **Test Saphiro-Wilks**:
    - Solo sirve para tests de normalidad

```r
# Usando el ejemplo del salario
shapiro.test(salary)
```

- Se pueden usar *boxplots* también para el estudio de la normalidad

--------------------------------------------------------------------------------

# Ajuste de un modelo

- Para realizar un ajuste lineal:

```r
# Fidelidad en funcion de otras variables de entrada, de forma lineal
# Usando para el ajuste los datos del dataset `hatco`
#
# No hace falta usar `attach`, ya la función sabe que las variables son las que
# estan en el dataset que pasamos para ajustar los datos
mod<-lm(
    fidelidad~velocidad+precio+flexprec+imgfabri+servconj+imgfvent+calidadp,
    hatco
)

# Haciendo print del ajuste podemos ver los coeficientes
mod
```

## Estudio de la bondad del ajuste realizado

### Estudio con `summary`

- Lo más básico es saber el valor de $R^2$
    - También nos marca con asteriscos los niveles de significación
        - $H_0$ significa que $\beta_i = 0$, es decir, que la variable $x_i$ no es relevante en el ajuste
        - Buscamos que los $p-valores$ que vienen dados por $P(> |t|)$ sean bajos para que así las variables sean relevantes
    - El valor $F$ indica que todas las variables son inútiles. Buscamos un valor alto de $F$ (ie. 45) para indicar que el ajuste realizado tiene sentido
    - Un valor de $R^2 = 0.75$ se puede interpretar como que el $75\%$ de la variabilidad total queda explicada por el modelo que hemos ajustado
    - $R^2$ ajustado intenta corregir que $R^2$ normal se eleva demasiado conforme incluimos variables, aunque estas variables no aporten demasiado

```r
summary(mod)
```

### Estudio con la tabla ANOVA

- Se realiza con:

```r
anova(mod)
```

- Para **interpretarlo**:
    - La columna `Sum Sq` en la fila `Residuals` nos da la variabilidad no explicada por el modelo
    - En las filas anteriores, `Sum Sq` nos da la variabilidad explicada por cada variable explicativa

### Estudio de la significación individual

- Para una variable $x_i$ planteamos $H_0: \beta_i = 0$ la variable no es útil $H_1: \beta_i \neq 0$
    - Por tanto, buscamos rechazar la hipótesis nula
    - Por tanto, buscamos $p-valores$ bajos
- Esto se ve en la tabla `summary`, el $p-value$ viene dado por $P(> |t|)$
- Además, vienen marcadas con astericos las variables que sí son útiles
- Realmente no es el p-value. El p-value es $1 - valor$, y queremos que sea un valor alto
- Para el término constante, nos fijamos en `Intercept`

## Diagnóstico del modelo

- Consiste en comprobar que las hipótesis asumidas para construir el modelo se verifican
- Análisis de los residuos:
    - Normalidad
    - Linealidad
    - Homocedasticidad
    - Incorrelación de los errores

### Homocedasticidad

- Tenemos que comprobar que los errores del modelo tengan varianza constante
- Estudiamos esto sobre los errores estandarizados (estandarizar $e_i = Y_i - \hat{Y}_i$)
- Los **errores estandarizados** se calculan con `rstandard`
- Calculamos los residuos, representamos el gráfico de dispersión de los residuos. Para cada variable, el gráfico de dispersión
- Buscamos que dichos gráficos sean aleatorios, sin patrones claros

```r
# Calculamos los errores estandares
ei.std<-rstandard(mod1)

# Para mostrar mas de un grafico en una imagen
par(mfrow=c(2,4))

# Mostramos los valores ajustados en funcion de los errores
plot(mod1$fitted.values, ei.std, main = "" , xlab = "valores ajustados", ylab = "residuos estandarizados")
abline(h=0,col=2)

# Mostramos los graficos de dispersion para cada una de las percepciones
for (j in 6:12) {
    plot(hatco[, j], ei.std, main = "", xlab = paste0("x_", j), ylab = "residuos estandarizados")
    abline(h = 0, col = 2)
}
```

### Incorrelación

- Para encontrar esto, mostramos el gráfico de los residuos frente al orden de cada una de las entradas de nuestro *dataset*

```r
plot(hatco$empresa, ei.std, main = "", xlab = "Número observación", ylab = "residuos estandarizados")
abline(h = 0, col = 2)
```

- También podemos usar el test **Durbin-Watson**
    - Buscamos que el p-value sea alto, para no rechazar la $H_0$ que es que los errores están incorrelados

```r
library(lmtest)
dwtest(mod)
```

### Normalidad

- Se asume que los errores del modelo siguen una distribución normal
- Es de las hipótesis más importantes
- Si tenemos $n > 100$, podemos usar *Kolgomorov-Smirnov*:

```r
ks.test(ei.std, pnorm)
```

- Podemos acompañarlo de un gráfico probabilístico normal:

```r
qqnorm(ei.std)
```

### Linealidad

- Estudiamos la posible falta de linealidad entre la variable de salida y las variables explicativas
- Se puede observar con la gráfica de dispersión múltiple que ya hemos realizado
- Pero es más adecuado los **gráficos de componente más residuo**
    - Tenemos que buscar falta de linealidad en estos patrones
    - Nos ayudamos de la recta azul que se da en este gráfico
    - La línea rosa tiene que aproximarse bastante a la línea rosa

```r
library(car)
crPlots(mod)
```

### Identificación de datos anómalos e influyentes

- Localizar filas con *+error estandarizado por encima de 2.5**:

```r
which(abs(ei.std) > 2.5)
```

- **Distancia de Cook**

```r
plot(hatco$empresa, cooks.distance(mod))
```

- **Aislamiento o _leverage_**

```r
plot(hatco$empresa, hatvalues(mod))
```

- Podemos hacer todas estas tareas con una librería:

```r
library(car)
influenceIndexPlot(mod)
```

- Con esto podemos eliminar las entradas que sean anómalas o demasiado influyentes, por ejemplo:

```r
# Tomamos las entradas anomalas
empresas_anomalas <- hatco[abs(residuos) > 2.5, ]$empresa

# Filtramos el dataset
hatcoclean <- hatco[hatco$empresa != empresas_anomalas, ]

# Miramos que solo tengamos 98 filas en el dataset limpiado
nrow(hatcoclean)
```

### Estudio de la multicolinealidad

1. Matriz de correlaciones
    - Los valores deben ser bajos

```r
R<-cor(hatco[,6:12])
R
```

2. Indice de condicionamiento de la matriz de correlaciones
    - Debe estar por debajo de 30

```r
# Autovalores de R
ai<-eigen(R)$values

# El índice IC
IC <- sqrt(max(ai)/min(ai))
```

3. Para cada una de las percepciones, se calcula el **valor inflado de la varianza** VIF
    - Todos deben estar por debajo de 10, preferentemente por debajo de 5

```r
library(car)
vif(mod)
```

### Selección de variables explicativas

- Usando un algoritmo *Stepwise*:
    - Basado en el criterio de Akaike (**AIC**)

```r
step(mod)
```

- Podemos fijar la dirección:

```r
step(mod2, direction = 'both')
```

--------------------------------------------------------------------------------

# Aproximación de una probabilidad

## Aproximar una probabilidad a partir de la uniforme

- Por ejemplo, partimos de una uniforme $X,Y \sim \mathcal{U}^2[0, 1]$
- Con este ejemplo, podemos calcular $P(X + Y \leq 0)$, con un **gráfico de convergencia**

```r
# Parametros de la simulacion
nsim<-1000
set.seed(1)

# Aplicamos la simulacion, que es muy sencilla porque las variables salen de una
# distribucion uniforme
x <- runif(nsim, -1, 1)
y <- runif(nsim, -1, 1)
suceso <- (x + y <= 0)

# Aproximación
approx <- mean(suceso)

# Error de estimacion
estimacion_error <- sd(suceso) / sqrt(nsim)

# Gráfico de convergencia
# =======================

# Aproximaciones para $n=1,...,nsim$
estim<-cumsum(suceso)/(1:nsim)

# Errores de estimación correspondientes
estim.err<-sqrt(cumsum((suceso-estim)^2))/(1:nsim)

# Con esto ya podemos realizar el grafico
plot(
    1:nsim,
    estim,
    type='l',
    ylab='Aproximación y límites de error',
    xlab='Número de simulaciones',main=expression(P(X+Y<=0)),
    ylim=c(0,1)
)
z<-qnorm(0.025,lower.tail = FALSE)
lines(estim - z*estim.err,col='blue',lwd=2,lty=3)
lines(estim + z*estim.err,col='blue',lwd=2,lty=3)
```

# Aproximación de una integral

## Montecarlo simple

- Integral en un intervalo $(0, 1)$
- Lo codifico en la siguiente función, para ser reutilizada:

```r
# Funcion para realizar la aproximacion de una integral en el intervalo 0, 1
#
# PARAMETERS
# ==========
# `nsim` numero de simulaciones que queremos lanzar
# `f` funcion que estamos integrando en (0, 1)
# `seed` semilla aleatoria que queremos usar
# `show_plot` TRUE si queremos que se muestre el grafico de aproximacion
#
# RETURNS
# =======
# `approx_int` valor de la aproximacion
# `error` estimacion del error cometido
# `approx_seq` secuencia de valores de aproximaciones a la integral
montecarlo_simple <- function(nsim = 1000, f, seed = 1, show_plot = FALSE) {
    # Fijamos la semilla aleatoria
    set.seed(1)

    # Muestreamos de una uniforme 0, 1 y aplicamos la funcion sobre esa muestra
    x <- runif(n = nsim, min = 0, max = 1)
    fx <- f(x)

    # Realizamos la aproximacion usando los valores previamente calculados
    # En vez de guardar el valor final de la aproximacion, guardamos la secuencia de aproximaciones
    # para poder mostrar graficos de convergencai
    approx_int_seq <- cumsum(fx) / (1:nsim)

    # Calculamos los errores en la aproximacion
    error <- sqrt(cumsum((fx - approx_int_seq)^2)) / (1:nsim)

    # Mostramos graficamente los errores si asi se ha dado por parametro
    if(show_plot == TRUE) {
        plot(
            1:nsim,
            approx_int_seq,
            type = "l",
            ylab = "Aproximación y límites de error",
            xlab = "Número de simulaciones"
        )
        z <- qnorm(0.025, lower.tail = FALSE)
        lines(approx_int_seq - z * error, col = "blue", lwd = 2, lty = 3)
        lines(approx_int_seq + z * error, col ="blue", lwd = 2, lty = 3)
        abline(h = approx_int_seq[nsim], col = 2)
    }

    # Devolvemos los datos, esto es, la aproximacion final, el error de la
    # aproximacion y toda la secuencia
    return(list(approx_int = approx_int_seq[nsim], error = error[nsim], approx_seq = approx_int_seq))
}
```

## Montecarlo en un intervalo $(a, b)$

- Lo coloco en una función para que sea fácil de aplicar
- Mostramos también el gráfico de convergencia

```r
# Condiciones de la simulacion
nsim <- 1000
set.seed(1)

# Integral de montecarlo para una funcion `f` en un intervalo (`lower`, `upper`)
# Se usan `nsim` simulaciones para aproximar la integral
# Se muestra el grafico de convergencia cuando `should_plot == TRUE`
montecarlo_acotado <- function(f, nsim = 1000, lower = 0, upper = 1, should_plot = FALSE){

    # Realizamos el muestreo de valores y mapeo por la funcion
    x_values <- runif(nsim, lower, upper)
    fx <- sapply(x_values, f)

    # Aproximaciones para $n=1,...,nsim$
    estim <- ((upper - lower) / (1:nsim)) * cumsum(fx)

    # errores de estimación correspondientes
    estim.err <- sqrt(cumsum((fx-estim)^2))/(1:nsim)
    if(should_plot == TRUE) {
        plot(1:nsim,estim,type='l',ylab='Aproximación y límites de error',xlab='Número de simulaciones')
        z<-qnorm(0.025,lower.tail = FALSE)
        lines(estim - z*estim.err,col='blue',lwd=2,lty=3)
        lines(estim + z*estim.err,col='blue',lwd=2,lty=3)
        abline(h = approx_int,col=2)
    }

    # Aproximación final y su error
    estim[nsim]
    estim.err[nsim]

    # Devolvemos los datos
    return(list(aproximacion = estim[nsim], error = estim.err[nsim], secuencia = estim))
}
```

## Montecarlo en un intervalo infinito

- Tenemos que descomponer $f(x) = c(x) \cdot g(x)$ donde $g(x)$ sea una función de densidad de una probabilidad
- Con esto, muestreamos de esa distribución de probabilidad, multiplicamos por c(x) y aproximamos
- Hacemos esto usando la siguiente función:

```r
# Condiciones de la simulacion
nsim <- 1000
set.seed(1)

# Descomposicion de las funciones
# La funcion f no la ponemos, porque es de la que vamos a muestrear
c <- function(x) sin(x) * exp(-x)

# Funcion para muestrear de la distribucion
# A dicha funcion se le pasa el numero de simulaciones que queremos tomar
# Nos apoyamos en la funcion `rbeta` de distribucion para generar la funcion
g <- function(n) rbeta(nsim, 2.5, 5)

# Integración de montecarlo en limites infinitos
# Se debe haber descompuesto la funcion a integrar convenientemente
# `g` debe ser una funcion `g(numero_simulaciones)` que de la distribucion de probabilidad
# `c` debe ser la funcion de ponderado
# Se muestra el grafico de convergencia cuando `should_plot == TRUE`
montecarlo_infinito <- function(g, c, should_plot = FALSE) {

    # Realizamos el muestreo de valores y mapeo por la funcion
    x_values <- g(nsim)
    fx <- sapply(x_values, c)

    # Aproximaciones para $n=1,...,nsim$
    estim <-  cumsum(fx) / (1:nsim)

    # errores de estimación correspondientes
    estim.err <- sqrt(cumsum((fx-estim)^2))/(1:nsim)

    # Mostramos la funcion cuando asi se indique
    if(should_plot == TRUE) {
        plot(1:nsim,estim,type='l',ylab='Aproximación y límites de error',xlab='Número de simulaciones')
        z<-qnorm(0.025,lower.tail = FALSE)
        lines(estim - z*estim.err,col='blue',lwd=2,lty=3)
        lines(estim + z*estim.err,col='blue',lwd=2,lty=3)
        abline(h = second_approx_int,col=2)
    }

    # Devolvemos los datos
    return(list(aproximacion = estim[nsim], error = estim.err[nsim], secuencia = estim))
}
```

--------------------------------------------------------------------------------

# Simulación de probabilidades

## Simulación de una probabilidad compuesta

- Cuando estamos componiendo probabilidades (ie. sumatoria con sumandos probabilidades y longitud una probabilidad) es bastante directo hacer esto
- Por ejemplo, para la distribución de *Poisson* compuesta:

```r
# Numero de simulaciones
nsim<-5000

# simulamos ahora nsim valores de S_N:
S <- double(nsim) # para almacenar los valores simulados
set.seed(1)

for (i in 1:nsim) {
    n <- rpois(1,lam)
    if (n>0) S[i] <- sum(rlnorm(n,mu,sig))
}

# el vector S contiene los valores simulados de S_N
# un histograma de S nos da una aproximación de la distribución
hist(S,xlim=c(0,7000),breaks=20,prob=TRUE, ylim=c(0,1.2e-3))

# podemos superponer la densidad suavizada que calcula density()
lines(density(S), col = "red")
```

## Método inverso

- Tenemos que conocer $F^{-1}(u)$ la función inversa a la función de distribución
- Con ello, podemos usar la siguiente función:

```r
# Funcion que devuelve un numero de valores simulados de una distribucion de probabilidad
# `n` numero de valores que queremos generar de la distribucion
# `F_inv` inversa de la función de distribución
metodo_inversion <- function(n, F_inv) {

    # Generamos n valores de una uniforme 0, 1
    U <- runif(n = n, min = 0, max = 1)

    # Usamos la función inversa para generar el muestreo simulado
    X <- F_inv(U)

    # Devolvemos dichos valores
    return(X)
}
```

- Podemos mostrar el histograma de los datos obtenidos, junto con la linea de densidad de los datos y la función de densidad real:
    - Para ello necesitamos conocer $f(x)$ la función de densidad real

```r
# Empezamos con el histograma
hist(x, prob = TRUE)

# Añadimos las lineas suavizadas que vienen del histograma
lines(density(x), col = "blue")

# Ahora añadimos la linea de densidad real de la distribucion
f <- function(x) (a*b^a) / (x^(a+1)) # Esta es la función de densidad real
curve(f(x), add = TRUE, col = "red")
```

- Se puede comprobar que la simulacion es buena con el *test de Kolgomorov-Smirnov*:
    - De nuevo, recordar que hay que usar `p<distribucion>` o la función de densidad de probabilidad $f(x)$ que hayamos programado
        - Recordar que esta es la función de distribución $F(x)$, por si la tenemos que definir a mano
    - Buscamos, para aceptar que la simulación es buena, un valor alto del p-valor
- En este ejemplo, uso una $F(x)$ propia y no una `p<distribucion> para ilustrarlo`

```r
# Defino la funcion de distribucion, que debe aceptar los parametros a, b ademas de x
F <- function(x, a, b) (1 - (b / x)^a) * (x > b)

# Aplicamos el test
# Notar que los parametros a, b los paso despues, porque estan fijados
a <- 5
b <- 4
ks.test(x, F, a = a, b = b)
```
