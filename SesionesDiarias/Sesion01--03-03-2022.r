# Sesion 3 Marzo 2022
# Sergio Quijano Rey
# sergioquijano@correo.ugr.es

# Ejercicio 1
message("EJERCICIO 1")
message("================================================================================")
message("")

# Crea un vector con nombre x que contenga una secuencia de números reales entre 1
# y 10 con incrementos de 0.2. Con dicho vector realiza las siguientes tareas:
message("Creamos el vector pedido en el enunciado")
x <- seq(1, 10, by = 0.2)
message("El vector creado es: ", x)
message("")

# a) Calcula su longitud y almacénala en un objeto con nombre n
message("a)")
n <- length(x)
message("El tamaño del vector x es: ", n)
message("")

# b) Da nombres a cada uno de los elementos del vector del tipo x_1,...,x_n

# Uso paste para concatenar al caracter "x" todas las posiciones hasta la n, que he calculado
# en el apartado anterior
message("b)")
nombres <- paste("x", 1:n, sep = "_")
names(x) <- nombres
message("Los nombres dados al vector son: ")
cat(nombres, "\n")
message("")

# c) Calcula la media de x y almacénala en un objeto con nombre mx.
# Uso la sentencia simple porque no tenemos valores especiales NA NAN en el vector
message("c)")
mx <- mean(x)
message("La media del vector es: ", mx)
message("")

# d) Calcula cuántos elementos de x están por encima de mx.
message("d)")
# Uso una mascara logica para calcular el vector de los elementos por encima de mx, y luego
# calculo la media de ese vector filtrado
filtered_x <- x[x > mx]
elements_greater_than_mean <- length(filtered_x)
message("El numero de elementos por encima de la media (", mx, ") son: ", elements_greater_than_mean)
message("")

# e) Calcula la posición que ocupa el elemento de x más próximo por encima de mx.

message("e)")
# Calculo las posiciones de elementos por encima de la media
posiciones <- which(x > mx)
cat("Las posiciones de elementos que estan por encima de la media son: ", posiciones, "\n")

# Tomo el minimo de esa lista de posiciones, que es la asociada al primer elemento que supera
# la media
first_greater_than_mx <- min(posiciones)
message("La posicion del elemento mas proximo a la media, pero por encima de ella, es: ", first_greater_than_mx)
message("")
message("Nos hemos aprovechado de que los elementos estan ordenados de menor a mayor en el vector")
message("Asi que lo unico que habia que hacer era tomar el minimo del vector de posiciones de elementos por encima de la media")
message("")

# f ) Crea otro vector y con los primeros n números impares.
message("f)")

y <- seq(1, 2*n, 2)
cat("Los primero n impares son ", y, "\n")
message("Tenemos ", length(y), " elementos en el vector de impares")
message("")

# g) Imprime los elementos x que ocupen las posiciones indicadas por los primeros 5 elementos de y
message("g)")

first_elements <- x[y[1:5]]
message("Los elementos de x que ocupan las posiciones indicadas por los primeros 5 elementos de 5 son:")
cat(first_elements, "\n")
message("")


# Ejercicio 2
message("")
message("EJERCICIO 2")
message("================================================================================")
message("")

# Evaluar la siguiente función en una rejilla de valores equiespaciados en el intervalo
# [−2, 2] con incremento 0.1:

# Creo el conjunto de valores de la x sobre la que evaluamos la funcion
message("Creamos el vector pedido en el enunciado")
x <- seq(-2, 2, by = 0.1)
message("El conjunto de valores de x es ", x)
message("")

# Evaluo la funcion por trozos usando mascaras logicas para anular ciertos trozos
# Por tanto, expresamos los trozos como sumandos acompañados por la mascara que multiplica
y <-
    (x >= -2 & x < -1)*(1) +
    (x >= -1 & x < 0)*(log(x*x)) +
    (x >= 0 & x < 1)*(log(x*x + 1)) +
    (x >= 2)*(2)
cat("El conjunto de valores de la imagen es ", y, "\n")

# Ejercicio 3
message("")
message("EJERCICIO 3")
message("================================================================================")
message("")

# Crea un vector con nombre x que contenga 50 valores aleatorios de una distribución
# uniforme en el intervalo unidad usando la función runif (previamente ja la semilla
# de generación de números aleatorios escribiendo la sentencia set.seed(1)). A partir
# de dicho vector realiza las siguientes tareas:
set.seed(1)
x <- runif(50)
cat("Los 50 valores aleatorios son:\n", x, "\n")

# a) Calcula cuántos de sus elementos están en el intervalo (0.25, 0.75).
message("a)")

# Tomo el vector de elementos que cumple la condicion
elements_in_interval = x[x>= 0.25 & x <= 0.75]

# Cuento cuantos elementos tiene dicho vector
n_elements_in_interval <- length(elements_in_interval)
cat("Hay ", n_elements_in_interval, " en el intervalo 0.25 0.75\n")

# b) Calcula cuántos de sus elementos están por debajo de 0.1 o por encima de 0.9.
# Reemplaza dichos elementos por el valor NA. Después calcula su media.

# En el vector y guardo los elementos que cumplen la condicion del enunciado
y <- x[x <= 0.1 | x >= 0.9]

# Calculo el numero de elementos
n_y <- length(y)
cat("El numero de elementos cumpliendo las condiciones del enunciado son ", n_y, "\n")

# Remplazo estos valores por NA
# Para ello, calculo las posiciones de x que lo cumplen y los uso como mascara
positions <- which(x <= 0.1 | x >= 0.9)

# Uso las posiciones para remplazar por NA
x[positions] <- NA

cat("Despues de reemplazar las posiciones, el vector queda:\n", x, "\n")

# Ahora calculamos la media ignorando los NA
mx <- mean(x, na.rm = TRUE)
cat("La media del vector x ahora es ", mx, "\n")

# c) Partiendo del vector obtenido en el apartado anterior, reemplaza los valores NA
# por ceros. Después calcula su media y compara con la obtenida en el apartado
# anterior

# Calculo las posiciones que son NA (aunque es el vector ya calculado positions)
# y reemplazo dichas posiciones por 0
positions <- which(is.na(x))
x[positions] <- 0
cat("Ahora el vector de X es ", x, "\n")

# Calculo la media
mx <- mean(x)
cat("Ahora la media de x es", mx, "\n")
cat("Como era de esperar, ahora la media es menor al no estar ignorando los NA y estar usando el valor mas bajo del rango (0)\n")
