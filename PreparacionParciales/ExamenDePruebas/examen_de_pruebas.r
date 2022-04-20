set.seed(1)
x <- runif(100, 0, 1)
message("Vector de elementos:")
print(x)
message("")

mx <- mean(x)
message("Meida de x: ", mx)
message("")

# Distancias a la media
distances <- abs(x - mx)
message("Distancias a la media:")
print(distances)
message("")

# Elemento mas cercano a la media
closest_pos <- which(distances == min(distances))
closest_dist <- distances[closest_pos]
closest_el <- x[closest_pos]
message("Elemento mas cercano a la media: ", closest_el)
message("Distancia de dicho elemento a la media: ", closest_dist)
message("")

under_mx <- x[x < mx]
num_under_mx <- length(under_mx)
message("Numero de elementos por debajo de la media: ", num_under_mx)
message("")

A <- cbind(x, distances)
message("Matriz creada:")
print(A)
message("")

filename <- "hatco.txt"
data <- read.table(filename, header = TRUE, sep = "\t", dec = ".")
message("Los datos leidos son:")
print(data)
message("")

data <- within(data, {
    x8 <- factor(x8, labels = c("pequeña", "grande"))
})

message("Despues del cambio a factor, el dataframe queda:")
print(data)
message("")

message("Estructura del dataframe:")
print(str(data))
message("")

data <- within(data, {
    cliente <- as.character(cliente)
})
print(str(data))
print(data$cliente)
message("")

empresas_grandes <- data[data$x8 == "grande",]
empresas_pequeñas <- data[data$x8 == "pequeña",]
message("Empresas grandes:", nrow(empresas_grandes))
message("Empresas pequeñas: ", nrow(empresas_pequeñas))
message("")

una_empresa_grande <- empresas_grandes[sample(1:nrow(empresas_grandes), size = 1), ]
message("Datos de una empresa grande aleatoria:")
print(una_empresa_grande)
message("")

una_empresa_pequeña <- empresas_pequeñas[sample(1:nrow(empresas_pequeñas), size = 1), ]
message("Datos de una empresa pequeña aleatoria:")
print(una_empresa_pequeña)
message("")

fid_media <- mean(data$y)
fid_media_grande <- mean(empresas_grandes$y)
fid_media_pequeña <- mean(empresas_pequeñas$y)
message("Fidelidad media: ", fid_media)
message("Fidelidad media grande: ", fid_media_grande)
message("Fidelidad media pequeña: ", fid_media_pequeña)
message("")

usuarios_muy_fieles_grande <- nrow(empresas_grandes[empresas_grandes$y > fid_media_grande, ])
usuarios_muy_fieles_pequeña <- nrow(empresas_pequeñas[empresas_pequeñas$y > fid_media_pequeña, ])
message("Usuarios mas fieles en la grande: ", usuarios_muy_fieles_grande)
message("Usuarios mas fieles en la pequeña: ", usuarios_muy_fieles_pequeña)

data2 <- within(data, {
    x1 <- (x1 - mean(x1) ) / sd(x1)
    x2 <- (x2 - mean(x2) ) / sd(x2)
    x3 <- (x3 - mean(x3) ) / sd(x3)
    x4 <- (x4 - mean(x4) ) / sd(x4)
    x5 <- (x5 - mean(x5) ) / sd(x5)
    x6 <- (x6 - mean(x6) ) / sd(x6)
    x7 <- (x7 - mean(x7) ) / sd(x7)
    y <- (y - mean(y) ) / sd(y)
})
message("El dataframe tras tipificar es:")
print(data2)
message("")

sucesion <- function(n, a1, d, explicit = FALSE) {
    # Esto se computa de la misma forma en las dos variaciones
    v <- a1 + d * 0:(n-1)

    # Dos variaciones
    if(explicit == FALSE){

        suma <- sum(v)
        prod <- prod(v)

        return(list(v = v, suma = suma, prod = prod))
    }else{

        suma <- n * (a1 + v[n]) / 2.0
        prod <- d^n * gamma(a1 / d + n) / gamma(a1 / d)

        return(list(v = v, suma = suma, prod = prod))
    }
}

print(sucesion(10, 1.3, 3.0, explicit = TRUE))
message("")

print(sucesion(10, 1.3, 3.0, explicit = FALSE))
message("")
