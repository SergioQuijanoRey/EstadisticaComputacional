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
datos.n.transform <- datos.n
datos.n.transform <- transform(datos.n.transform, x_tipi_trans = (xi - x_mean) / sqrt(x_quasivar))
datos.n.transform <- transform(datos.n.transform, y_tipi_trans = (yi - y_mean) / sqrt(y_quasivar))

message("Tras el trasnform, el dataset queda:")
print(datos.n.transform)
message("")

# Realizamos la misma transformacion pero con within
datos.n.within <- datos.n

datos.n.within <- within(datos.n.within, {
    x_tipi_trans <- (xi - x_mean) / sqrt(x_quasivar)
    y_tipi_trans = (yi - y_mean) / sqrt(y_quasivar)
})

message("Tras el within, el dataset queda:")
print(datos.n.within)
message("")

# Ejercicio 3
#===================================================================================================

message("EJERCICIO 3")
message("================================================================================")
message("")

# a ) Imprime en la venta de la consola las primeras 5 las del data frame ChickWeight
# y las 3 últimas, utilizando para ello las funciones head y tail, respectivamente.
message("a)")
message("")

# Tomo el dataset en una variable, para trabajar mas comodamente
data <- ChickWeight

# Mostramos las primeras 5 filas
message("Las primeras cinco filas del dataset son:")
print(head(data, 5))
message("")

# Mostramos las tres ultimas filas
message("Las tres ultimas filas del dataset son:")
print(tail(data, 3))
message("")

# b ) Imprime la estructura del objeto ChickWeight.
message("b)")
message("")

message("La estructura del objeto es:")
print(str(data))
message("")

# c ) Realiza un resumen descriptivo numérico elemental de todas las variables del
# data frame con summary.

message("c)")
message("")

message("El summary de los datos es:")
print(summary(data))
message("")

# d ) Realiza el mismo tipo de resumen pero ahora solo de la variable weight pa-
# ra los distintos niveles del factor dieta, usando la función tapply. Almacena
# el resultado en un objeto con nombre peso.dieta. ¾Qué tipo de objeto es
# peso.dieta

message("d)")
message("")

# Tomamos los datos pedidos y los mostramos por pantalla
peso.dieta <- tapply(data$weight, data$Diet, summary)
message("El resumen de la variable peso organizada segun la dieta seguida es:")
print(peso.dieta)
message("")

# Ahora mostramos el tipo de dato:
message("Mostrando el tipo de dato de peso.dieta:")
message("")

message("Si hacemos class() nos da:")
print(class(peso.dieta))
message("")

message("Si hacemos is.list() nos da:")
print(is.list(reg))
message("")

message("Si hacemos typeof:")
print(typeof(peso.dieta))
message("")

# Por tanto, parece que estamos obteniendo como resultado una lista
# Esto ya lo sospechabamos al ver como hace print del resultado
# Segun la documentacion:
#
# If ‘FUN’ does not return a single atomic value, ‘tapply’ returns
# an array of mode ‘list’ whose components are the values of the
# individual calls to ‘FUN’, i.e., the result is a list with a ‘dim’
# attribute.

# e) Crea un data frame (peso.dieta.2) colocando por columnas el resumen ob-
# tenido del peso para cada tipo de dieta. Cada columna tendrá como nombre el
# de la correspondiente medida descriptiva (Min., 1st Qu., etc.).


message("e)")
message("")

# TODO -- para este ejercicio debe haber una forma mas sencilla de programarlo
# Estoy usando funciones de filtrado que devuelven otras funciones, y esto me parece demasiado complejo

# Funcion que devuelve una funcion filtro para determinada posicion
# Necesitamos hacer esto, porque sapply espera una funcion de un unico parametro: la entrada de la
# lista que esta procesando en ese momento
# Por eso paso de unas funcion de dos parametros a una funcion de un unico parametro con este estilo
# currificacion
filter_func <- function(pos) {

    # Funcion que devolvemos y que, dada una entrada de una listas, se queda con una posicion
    # en concreto de dicha lista
    inner_func <- function(list_entry) {
        return(list_entry[pos])
    }

    return(inner_func)
}

# Filtramos las listas usando sapply y nuestra funcion de filtrado
min <- sapply(peso.dieta, filter_func(1))
q1  <- sapply(peso.dieta, filter_func(2))
q2  <- sapply(peso.dieta, filter_func(3))
q3  <- sapply(peso.dieta, filter_func(4))
max <- sapply(peso.dieta, filter_func(5))

# Creamos el dataframe con los valores filtrados
peso.dieta.2 <- data.frame(
    min = min,
    q1 = q1,
    q2 = q2,
    q3 = q3,
    max = max,
    row.names = 1:4
)

# Mostramos el resultado obtenid# Mostramos el resultado obtenidoo
message("El dataframe con el resumen de las estadisticas del peso organizadas por el tipo de dietas es:")
print(peso.dieta.2)
message("")


# f ) La función aggregate permite resumir columnas de un data frame para cada
# uno de los niveles de un factor . Utiliza esta función para realizar el mismo
# resumen que realizaste antes en el objeto peso.dieta. ¾Qué tipo de objeto
# devuelve esta función? Vuelve a crear el data frame peso.dieta.2 con la es-
# tructura especicada antes a partir del objeto que devuelve aggregate.

message("f)")
message("")

peso.dieta <- aggregate(data$weight, by = list(data$Diet), summary)

message("El dataframe con los datos del resumen del peso en base a la dieta, usando aggregate, es:")
print(peso.dieta)
message("")

# Ahora mostramos el tipo de dato:
message("Mostrando el tipo de dato de peso.dieta:")
message("")

message("Si hacemos class() nos da:")
print(class(peso.dieta))
message("")

message("Si hacemos is.list() nos da:")
print(is.list(reg))
message("")

message("Si hacemos typeof:")
print(typeof(peso.dieta))
message("")

# Por tanto, ahora en vez de obtener una lista con el resumen, obtenemos un dataframe como el que
# hemos creado en peso.dieta.2. Por tanto, este proceso de creacion de peso.dieta.2 ya esta
# programado en R

# Por tanto, ahora es trivial crear el objeto peso.dieta.2
peso.dieta.2 <- peso.dieta

message("peso.dieta.2 ahora es:")
print(peso.dieta.2)
message("")

# g) Crea un data frame (Chick100) con una submuestra de los datos contenidos
# en ChickWeight seleccionando aleatoriamente (sin reemplazo) 100

message("g)")
message("")


Chick100 <- data[sample(nrow(data), size = 100, replace = FALSE), ]

message("Las 100 muestras seleccionadas aleatoriamente sin reemplazo son:")
print(Chick100)
message("")

# h ) Muestra el data frame Chick100 con sus columnas permutadas aleatoriamente .
message("h)")
message("")

# Para permutar, vuelvo a usar sample para realizar la permutacion
# Solo que ahora lo hago por columnas y usando todas las columnas

col_perm_chick100 <- Chick100[, sample(ncol(Chick100), size = ncol(Chick100), replace = FALSE)]
message("El dataset Chick100 con las columnas permutadas es:")
print(head(col_perm_chick100))
message("")

# i ) Muestra el data frame Chick100 con sus columnas por orden alfabético.
message("i)")
message("")

# Obtengo la lista con los nombres ordenados
sorted_col_names <- sort(colnames(Chick100))

# Aplico dicha lista indexada para indexar las columnas del dataframe
col_sorted_chick100 <- Chick100[, sorted_col_names]

message("El dataframe Chick100 con las columnas por orden alfabetico es:")
print(head(col_sorted_chick100))
message("")

# j ) Muestra los datos del data frame Chick100 ordenados según la variable Diet
# (orden ascendente). Observa que cómo trata R los empates en dicha ordenación.
# Repite la operación rompiendo los empates de acuerdo al valor en la variable
# Weight.
message("j)")
message("")

# TODO -- no se que criterio se usa para realizar el desempate
chick100_sorted_diet <- Chick100[
    with(Chick100, order(Chick100$Diet, decreasing = FALSE)),
]
message("El dataframe Chick100 ordenado ascendentemente por la variable dieta es:")
print(chick100_sorted_diet)
message("")

# Ahora ordenamos usando dos columnas
# Para esto, ya necesito la orden `order` con `with`
chick100_sorted_diet_weight <- Chick100[
    # Primero ordeno por dieta, luego ordeno por peso
    with(Chick100, order(Chick100$Diet, Chick100$weight, decreasing = FALSE)),
]
message("El dataframe Chick100 ordenado ascendentemente por la variable dieta y desempatado por peso es:")
print(chick100_sorted_diet_weight)
message("")

# k ) Extrae del data frame Chick100 una submuestra conteniendo solo una obser-
# vación para cada tipo de dieta (variable Diet), en concreto la que corresponda
# al mayor valor de la variable weight. [Sugerencia: ordena las las del data
# frame según weight en orden descendente, después puedes usar la función
# duplicated6 aplicada a columna Diet para quedarse solo con la primera ob-
# servación correspondiente a cada tipo de dieta.
message("k)")
message("")

# Ordenamos por peso, siendo los primeros individuos los mas pesados
chick100_sorted_weight <- Chick100[
    # Primero ordeno por dieta, luego ordeno por peso
    with(Chick100, order(Chick100$weight, decreasing = TRUE)),
]

# Nos quedamos con los elementos del dataframe que no tienen repetida la columna dieta
# Es decir, con los elementos que primero aparecen con determinada dieta
# Por el orden, el elemento de cierta dieta con mayor peso
diet_not_duplicated <- !duplicated(chick100_sorted_weight$Diet)
max_weight_per_diet <- chick100_sorted_weight[diet_not_duplicated, ]

message("La observacion con mayor peso por dieta es:")
print(max_weight_per_diet)
message("")
