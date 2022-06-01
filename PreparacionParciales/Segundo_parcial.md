---
title: Preparación del Segundo Parcial
author: Sergio Quijano Rey
date: 01.06.2022
geometry: margin = 3.0cm
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
