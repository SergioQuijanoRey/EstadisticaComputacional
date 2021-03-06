# Autor: Sergio Quijano Rey, sergioquijano@correo.ugr.es
# NOTA: estoy ejecutando el programa en linux desde la terminal, usando:
# R --no-echo -f ./primer_parcial.r, por eso muestro mensajes por pantalla usando print y message
# De todas formas, se sigue pudiendo ejecutar el script por bloques sin ningun inconveniente

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

# Con esto es directo calcular el numero de estos elementos
no_elemnentos_buscados <- length(elementos_buscados)
message("nº elementos uqe distan de mx mas de sx son: ", no_elemnentos_buscados)
message("")

# Sustituyo por valores perdidos, usando la misma condicion que antes para indexar
x[distancia_mx > sx] <- NA
message("Tras poner NA, x queda:")
print(x)
message("")

# Cuento los multiplos de 3

# Para eso, me quito primero los NA
x_no_na <- x[is.na(x) == FALSE]

# Ahora es facil aplicar la condicion y contar
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

# Convertimos Month a factor usando within
aire <- within(aire, {
    # Uso month.name para obtener los meses del año
    # Solo hay meses del 5 al 9, asi que solo me quedo con esos nombres
    Month <- factor(Month, labels = month.name[5:9])
})
message("Despues de aplicar un factor a meses, ahora la estructura es:")
print(str(aire))
message("")
message("Las cinco primeras filas del dataframe son:")
print(head(aire))
message("")
message("Las cinco ultimas filas del dataframe son:")
print(tail(aire))
message("")

# Calculo las medianas, por el factor de los messes, usando aggregate
# Me devuelve un dataframe con dos columnas, mes y valor de la mediana
# Dos dataframes, uno por variable en la que estoy interesado
med_ozone <- aggregate(aire$Ozone, by = list(aire$Month), median)
med_wind <- aggregate(aire$Wind, by = list(aire$Month), median)

message("Mediana del ozono agrupada por meses:")
print(med_ozone)
message("")
message("Mediana del aire agrupada por meses:")
print(med_wind)
message("")

# Creo el dataframe con los valores de aire que ocurren en mayo
# Uso == month.name[5] y no == "May" o == "Mayo" para evitar problemas con el lenguaje del sistema
aire.mayo <- aire[aire$Month == month.name[5], ]
message("El dataframe aire con solo datos de mayo es:")
print(aire.mayo)
message("")


message("Ejercicio 3")
message("================================================================================")

# Calcula la progresion geometrica an = a1 * r^(n-1) y devuelve la suma y producto de sus elementos
# Calcula dos sumas y dos productos, una vez con sum(), prod() y otra vez con formulas explicitas
progresion_geometrica <- function(n, a1, r) {

    # Comprobaciones de seguridad
    if(missing(n) || missing(a1) || missing(r)) {
        stop("No has proporcionado todos los parametros de la funcion!!")
    }

    if(is.numeric(n) == FALSE || is.numeric(a1) == FALSE || is.numeric(r) == FALSE){
        stop("Todos los parametros de la funcion deben ser numericos!!")
    }

    # Calculo la secuencia de la sucesion, que es la pieza central de esta funcion
    # Como estamos computando la formula an = a1 * r^(n-1), podemos calcular todos los elementos
    # directamente y no necesitamos un bucle for, que es mas ineficiente en R
    # Notar tambien que deberiamos hacer r^((1:n) - 1), pero esto es lo mismo que r^(0:(n-1))
    v <- a1 * r ^ (0:(n-1))

    # Calculamos la suma y producto de forma directa
    suma1 <- sum(v)
    producto1 <- prod(v)

    # Calculamos la suma y producto usando las formulas dadas en el examen
    # La formula de la suma para r == 1 falla
    if(r == 1){
        # Uso warning porque no quiero detener la ejecucion del programa
        warning("Suma 2 no se puede calcular para r == 1")
        suma2 <- NA
    }else{
        suma2 <- a1 * (1 - r^n) / (1 - r)
    }

    # La formula del producto solo es valida cuando a1, r > 0
    if(a1 <= 0 || r <= 0){
        # Uso warning porque no quiero detener la ejecucion del programa
        warning("Producto 2 solo se puede calcular cuando a1, r > 0")
        producto2 <- NA
    }else{
        producto2 <- sqrt(a1^2 * r^(n-1))^n
    }

    # Devolvemos todos los elementos en una lista
    return(list(v = v, suma1 = suma1, suma2 = suma2, producto1 = producto1, producto2 = producto2))
}

# Comprobamos los dos casos del examen
res <- progresion_geometrica(n = 20, a1 = 2, r = -0.5)
message("En el primer caso, el resultado es:")
print(res)
message("")

res <- progresion_geometrica(n = 20, a1 = 2, r = 0.5)
message("En el segundo caso, el resultado es:")
print(res)
message("")

# Voy a realizar algunas comprobaciones de seguridad, a modo de "test unitarios" muy simples
# No he encontrado ninguna libreria por defecto que traiga estas funcionalidades, asi que uso
# estas funciones para realizar las aserciones

# Comprobamos que dos numeros flotantes sean el mismo, con cierta tolerancia
# En caso de que no sean iguales, mostramos un mensaje de error e interrumpimos la ejecucion del
# programa
assert_double_eq <- function(msg, first_val, second_val, eps = 0.001) {
    cond <- abs(first_val - second_val) < eps
    if(cond == FALSE) {
        warning(first_val, " != ", second_val)
        stop(msg)
    }
}

# Asercion para una condicion booleana ada
# En caso de que no sean cierta, mostramos un mensaje de error e interrumpimos la ejecucion del
# programa
assert <- function(msg, cond){
    if(cond == FALSE) {
        warning(first_val, " != ", second_val)
        stop(msg)
    }
}

# Comprobamos que un valor dado es NA. En caso de que no lo sea, mostramos un mensaje de error
# e interrumpimos la ejecucion del programa
assert_is_na <- function(msg, value) {
    if(is.na(value) == FALSE) {
        warning("El valor ", value, " no es NA")
        stop(msg)
    }
}

res <- progresion_geometrica(n = 5, a1 = 2, r = 1.1)
assert_double_eq("Las dos sumas deben coincidir", res$suma1, res$suma2, eps = 1e-10)
assert_double_eq("Los dos productos deben coincidir", res$producto1, res$producto2, eps = 1e-10)
assert("La longitud de la secuencia debe ser n", length(res$v) == 5)

res <- progresion_geometrica(n = 10, a1 = 1.4, r = 0.9)
assert_double_eq("Las dos sumas deben coincidir", res$suma1, res$suma2, eps = 1e-10)
assert_double_eq("Los dos productos deben coincidir", res$producto1, res$producto2, eps = 1e-10)
assert("La longitud de la secuencia debe ser n", length(res$v) == 10)

# Veo que obtengo NA cuando algunas condiciones de las entradas fallan
res <- progresion_geometrica(n = 10, a1 = 1.4, r = -0.9)
assert_double_eq("Las dos sumas deben coincidir", res$suma1, res$suma2, eps = 1e-10)
assert_is_na("El producto 2 en este caso debe ser NA", res$producto2)
assert("La longitud de la secuencia debe ser n", length(res$v) == 10)

res <- progresion_geometrica(n = 10, a1 = 1.4, r = 1)
assert_is_na("La suma 2 en este caso debe ser NA", res$suma2)
assert_double_eq("Los dos productos deben coincidir", res$producto1, res$producto2, eps = 1e-10)
assert("La longitud de la secuencia debe ser n", length(res$v) == 10)

# Veo que la funcion falla cuando pasamos mal algunos parametros
# Para esto uso try() para que el fallo de la funcion no detenga la ejecucion de todo el script
# Recordar que lanzo el script entero, y no ejecuto en bloques usando una REPL
try({
    res <- progresion_geometrica(n = 10, a1 = 4)

    # Este mensaje no se puede mostrar
    message("ESTO NUNCA PUEDE OCURRIR")
})
message("")

try({
    res <- progresion_geometrica(n = 10, a1 = 4, r = function(x) x + 2)

    # Este mensaje no se puede mostrar
    message("ESTO NUNCA PUEDE OCURRIR")
})
message("")

message("")
message("==> Todos los 'test unitarios' han pasado")
message("")
