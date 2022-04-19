message("EJERCICIO 1")
message("================================================================================")
message("")

# Genero el vector de numeros aleatorios
set.seed(1)
x <- runif(n = 100, min = 0, max = 1)
message("Los 100 valores aleatorios son:")
print(x)
message("")

# Calculo la media del vector x
mx <- mean(x)
message("La media de x es: ", mx)
message("")

# Computo un vector de distancias de los elementos de x a la media del vector
distances <- abs(x - mx)
message("Las distancias a la media son: ")
print(distances)
message("")

# Calculamos la posicion mas cercana
closest <- which(distances == min(distances))
message("La posicion del elemento mas cercano a la media es ", closest)
message("El valor de esa posicion es ", x[closest])
message("")

# Calculo el numero de elementos por debajo de la media
under_mx <- x[x < mx]
number_under_mx <- length(under_mx)
message("El numero de elementos por debajo de la media es ", number_under_mx)
message("")

# Elimino los elementos del apartado anterior realizando un filtrado
x_filtered <- x[x >= mx]
message("El vector x tras el filtrado es: ")
print(x_filtered)
message("")

# Creamos la matriz pedida en el enunciado
# Necesitamos volver a computar las distancias a la media original
distancies <- abs(x_filtered - mx)
A <- c(x, distances)
dim(A) <- c(length(x), 2)
message("La matriz A obtenida es:")
print(A)
message("")

message("EJERCICIO 2")
message("================================================================================")
message("")

hatco <- read.table("hatco.txt", header = TRUE, dec = ".")
message("El dataframe leido es:")
print(hatco)
message("")

hatco <- within(hatco, {
    x8 <- factor(x8, labels = c("pequeña", "grande"))
})
message("Tras añadir factores, el dataframe es:")
print(hatco)
message("")


hatco <- within(hatco, {
    cliente <- as.character(cliente)
})
message("Tras pasar la primera columna a tipo caracter, el dataframe es:")
print(hatco)
message("")

message("La estructura del dataframe ahora es:")
print(str(hatco))
message("")
