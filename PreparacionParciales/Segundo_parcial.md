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

```r
# Histograma basico de los datos
hist(salary, prob = TRUE)

# Funcion de densidad de los datos en azul
lines(density(salary),col='blue')

# Distribucion normal con media y desviacion la de los datos, en rojo sobre el grafico anterior
curve(dnorm(x,mean=mean(salary),sd=sd(salary)),add=TRUE,col='red',lty=2)

# Leyenda explicativa
legend('topright',c('Función de densidad suavizada','Función de densidad Normal'),lty
```

- Obtener los metadatos de un histograma:

```r
metadatos <- hist(employees$salary, plot = FALSE)
metadatos
```

# Estudios estadísticos

## Estudio de la normalidad

- Gráfico probabilístico normal
    - Buscamos con este gráfico que los puntos salgan alineados en una recta
    - En cuyo caso, podemos pensar que los datos siguen una distribución normal

```r
qqnorm(salary)
```
