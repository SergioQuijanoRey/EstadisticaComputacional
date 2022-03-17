# Autor: Sergio Quijano Rey
# Fecha: 17.03.2022
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion03-17-03-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

# Ejercicio 1
#===================================================================================================

message("EJERCICIO 1")
message("================================================================================")
message("")

# 1. Crea un objeto de tipo lista con estas tres componentes: x1 = (1, 2, 3, 4, 5),
# x2 = (2, 3, 4, 5, 6) y x3 = (3, 4, 5, 6, 7). A partir de ella resuelve las siguientes tareas:

x1 <- 1:5
x2 <- 2:6
x3 <- 3:7
lista <- list(x1 = x1, x2 = x2, x3 = x3)

message("La lista creada es: ")
print(lista)

# a ) Crea un vector x con una muestra de 10 números aleatorios de una distribución
# uniforme en el intervalo (0,1). Añade dicho vector como una nueva componente
# a la lista anterior.

message("a)")
message("")

# Creo el vector con los valores aleatorios
x <- runif(10, min = 0, max = 1)
message("El vector aleatorio creado es")
print(x)
message("")

# Añado el vector como nueva componente de la lista
lista[["aleatorio_uniforme"]] <- x
message("Ahora la lista con ese nuevo elemento es:")
print(lista)
message("")

# b ) Crea un vector y con una muestra de 10 números aleatorios de una distribución
# normal estándar. Añade dicho vector como una nueva componente a la lista
# anterior.

message("b)")
message("")

# Creo el vector con los valores aleatorios (de una normal)
y <- rnorm(n = 10, mean = 0, sd = 1)
message("El vector aleatorio creado es")
print(y)
message("")

# Añado el vector como nueva componente de la lista
lista[["aleatorio_normal"]] <- y
message("Ahora la lista con ese nuevo elemento es:")
print(lista)
message("")

# c ) Utiliza la función lapply para calcular la suma de cada componente de la lista.
# Observa qué tipo de objeto devuelve. Después prueba con la variante sapply,
# qué diferencia observas entre las dos funciones?.

message("c)")
message("")

# Empezamos con lapply
suma_componentes <- lapply(lista, sum)
message("La suma de componentes con lapply es:")
print(suma_componentes)
message("")

# Hacemos lo mismo con sapply
suma_componentes_s <- sapply(lista, sum)
message("La suma de componentes con sapply es:")
print(suma_componentes_s)
message("")

# La diferencia que veo es que lapply devuelve una lista con los mismos nombres de las componentes
# almacenando el resultado de la operacion. Sapply devuelve un vector con el resultado
# La clase de lapply es list y la clase de sapply es numeric
# Por lo tanto, la diferencia entre las dos funciones es el tipo de datos que devuelve

# d ) Escribe el siguiente código:
# reg<-lm(y~x) y utiliza una función adecuada para conrmar que reg es un objeto de tipo
# lista.
message("d)")
message("")

# Aplicamos el codigo
reg <- lm(formula = y ~ x)
message("El resultado de aplicar la instruccion es")
print(reg)
message("")

message("El tipo de dato devuelto es:")
print(class(reg))
message("")

message("Si hacemos is.list() nos da:")
print(is.list(reg))
message("")

message("Si hacemos typeof:")
print(typeof(reg))
message("")

# Por tanto podemos ver que estamos ante una lista, aunque ha sido enrriquecida de alguna forma,
# porque por pantalla se muestra de forma distinta y class no devuelve directamente lista,
# aunque por debajo tengamos una lista

# e ) Utiliza una función adecuada para obtener qué tipo de objetos constituyen las
# componentes de reg.
message("e)")
message("")

# Aplico lapply a las componentes devueltas para saber sus tipos

message("Si hacemos class() nos da:")
print(lapply(reg, class))
message("")

message("Si hacemos is.list() nos da:")
print(lapply(reg, is.list))
message("")

message("Si hacemos typeof:")
print(lapply(reg, typeof))
message("")

# Con esto:
# 1. Tenemos las listas $model $xlevels $qr
# 2. Tenemos los numeric $coefficients $residuals $effects $fitted.values
# 3. Tenemos los integer $rank $assign $df.residual
# 4. Tenemos el call $call
# 5. Tenemos el terms, formula $terms
#6. Tenemos el dataframe $model

# f ) Crea una matriz que contenga por columnas las componentes residuals y
# fitted.values del objeto reg, además de los vectores x e y. Añade nombres
# a las columnas de dicha matriz.

message("f)")
message("")

# Creamos la matriz con cbind
# Ademas, usando los parametros, damos directamenten ombre a los componentes de la matriz
matriz <- cbind(residuos = reg$residuals, fitted.values = reg$fitted.values, x = x, y = y)
message("La matriz renombrada es:")
print(matriz)
message("")


# Ejercicio 2
#===================================================================================================

# 2. A veces los datos que tenemos para un análisis estadístico corresponden a datos
# agregados en forma de tabla de frecuencias. Crea un data frame con nombre datos
# con los datos que aparecen a continuación:

message("EJERCICIO 2")
message("================================================================================")
message("")

# Creo tres vectores con las columnas de los datos
xi <- c(1.2, 1.8, 2.2, 2.5, 1.1)
yi <- c(15, 18, 10, 12, 16)
ni <- c(12, 23, 5, 9, 11)

datos <- data.frame(xi, yi, ni)
message("El dataframe creado es:")
print(datos)
message("")

# a ) Calcula el tamaño de la muestra.

message("a)")
message("")

n <- sum(datos["ni"])
message("El tamaño de la muestra es ", n)
message("")

# b ) Calcula las media aritméticas de las observaciones de las variables x̄ e ȳ , así
# como las cuasivarianzas, sx y sy .

message("b)")
message("")

# Empezamos con las medias
# Lo calculo a mano, porque las funciones que he visto no tienen forma de incorporar la informacion
# de las frecuencias absolutas que tenemos en el dataframe
x_mean <- sum(datos["xi"] * datos["ni"]) / n
y_mean <- sum(datos["yi"] * datos["ni"]) / n

message("x media: ", x_mean)
message("y media: ", y_mean)
message("")

# De nuevo, calculamos a mano la cuasivarianza
x_quasivar <- sum((datos["xi"] - x_mean)^2 * datos["ni"] ) / (n - 1)
y_quasivar <- sum((datos["yi"] - y_mean)^2 * datos["ni"] ) / (n - 1)

message("quasivar x: ", x_quasivar)
message("quasivar y: ", y_quasivar)
message("")

# c ) Crea un segundo data frame con nombre datos.n que recoja las n observaciones
# individuales por las, esto es, repitiendo las las de datos tantas veces como
# indique la columna de la frecuencia absoluta.

message("c)")
message("")

# Creo los vectores x_i, y_i por separado para luego agregarlos en el dataframe
xi_rep <- rep(xi, ni)
yi_rep <- rep(yi, ni)
datos.n <- data.frame(xi = xi_rep, yi = yi_rep)

message("El dataframe con los datos desenrrollados es:")
print(datos.n)
message("")

# d ) A partir del data frame datos.n calcula de nuevo las medias aritméticas y las
# cuasivarianzas (usando mean y var, respectivamente) y comprueba el resultado
# anterior con los datos agregados.

message("d)")
message("")

message("Medias de las variables:")
print(colMeans(datos.n))
message("")

message("Cuasivarianzas de las variables:")
message("quasi x: ", var(datos.n["xi"]))
message("quasi y: ", var(datos.n["yi"]))
message("")

# e ) La tipicación de los datos es una práctica habitual y requerida en algunas
# técnicas estadísticas. Consiste en una transformación del tipo zi = (xi − x̄)/sx ,
# de modo que la media de los zi es 0 y su cuasi-varianza es 1. Añadir dos
# columnas al nal del data frame datos.n con los valores tipicados de las
# variables x e y . Realiza esta tarea de dos formas, primero utilizando la función
# transform y luego utilizando within.

message("e)")
message("")

# Empezamos usando la orden transform
datos.n["x_tipi_trans"] <- transform(datos.n, x_tipi_trans <- (xi - x_mean) / sqrt(x_quasivar))
datos.n["y_tipi_trans"] <- transform(datos.n, y_tipi_trans <- (yi - y_mean) / sqrt(y_quasivar))

message("Tras el trasnform, el dataset queda:")
print(datos.n)
message("")
