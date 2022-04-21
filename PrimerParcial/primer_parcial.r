# Autor: Sergio Quijano Rey, sergioquijano@correo.ugr.es

message("Ejercicio 1")
message("================================================================================")

# Vector con los 50 primeros impares
x <- seq(from = 1, by = 2, length.out = 50)
message("Vector con los primeros 50 impares:")
print(x)
message("")

# Calculo media y quasidesviacion
mx <- mean(x)
sx <- sd(x)
message("Media: ", mx)
message("Quasidesviacion: ", sx)
message("")

# Elementos de x que disten de mx mas de sx
distancia_mx <- abs(x - mx)
elementos_buscados <- x[distancia_mx > sx]
message("Los elementos que distan de mx mas de sx son:")
print(elementos_buscados)
message("")

# Sustituyo por valores perdidos, usando la misma condicion que antes para indexar
x[distancia_mx > sx] <- NA
message("Tras poner NA, x queda:")
print(x)
message("")

# Cuento los multiplos de 3
# Para eso, me quito primero los NA
x_no_na <- x[is.na(x) == FALSE]
x_mult3 <- x_no_na[x_no_na %% 3 == 0]
no_x_mult3 <- length(x_mult3)
message("Hay ", no_x_mult3, " multiplos de 3 en el vector x")
message("")


message("Ejercicio 2")
message("================================================================================")

aire <- airquality
message("La estructura del dataset es:")
print(str(aire))
message("")

# Uso lapply para contar valores perdidos, dos veces. La segunda vez uso sapply en vez de lapply
# para que la impresion de los resultados sea mas compacta
valores_perdidos_por_columna <- lapply(aire, is.na) # Miro con lapply si es valor perdido
cuenta_valores_perdidos_por_columna <- sapply(valores_perdidos_por_columna, sum)   # Miro con sapply la suma de los valores perdidos
message("Los valores perdidos por cada columna son:")
print(cuenta_valores_perdidos_por_columna)
message("")

# Borro filas que contengan valores perdidos
# Cuento cuantas filas tengo antes y despues del borrado para saber cuantas filas elimino
# Uso na.omit y no complete.cases por compacidad del codigo
prev_rows <- nrow(aire)
aire <- na.omit(aire)
curr_rows <- nrow(aire)
filtered_rows <- prev_rows - curr_rows
message("He filtrado ", filtered_rows, " filas al borrar missing values" )
message("")
