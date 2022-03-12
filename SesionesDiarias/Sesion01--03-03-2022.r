# Sesion 3 Marzo 2022
# Sergio Quijano Rey
# sergioquijano@correo.ugr.es
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion01-03-03-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

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

y <- seq(1, by = 2, length.out = n)
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
message("Creamos el vector de valores del eje x")
x <- seq(-2, 2, by = 0.1)
cat("El conjunto de valores de x es ", x, "\n")
message("")

# Evaluo la funcion por trozos usando mascaras logicas para anular ciertos trozos
# Por tanto, expresamos los trozos como sumandos acompañados por la mascara que multiplica
y <-
    (x >= -2 & x < -1)*(1) +
    (x >= -1 & x < 0)*(log(x*x)) +
    (x >= 0 & x < 1)*(log(x*x + 1)) +
    (x >= 1)*(2)
cat("El conjunto de valores de la imagen es ", y, "\n")
message("")

message("Los valores NAN los sustituyo por 0")
y[is.nan(y)] <- 0
cat("Los valores de y ahora son: ", y, "\n")
message("")

# Ejercicio 3
message("")
message("EJERCICIO 3")
message("================================================================================")
message("")

# Crea un vector con nombre x que contenga 50 valores aleatorios de una distribución
# uniforme en el intervalo unidad usando la función runif (previamente ja la semilla
# de generación de números aleatorios escribiendo la sentencia set.seed(1)). A partir
# de dicho vector realiza las siguientes tareas:
message("Creamos el vector con los 50 valores aleatorios en el intervalo unidad")
set.seed(1)
x <- runif(50)
cat("Los 50 valores aleatorios son:\n", x, "\n")
message("")

# a) Calcula cuántos de sus elementos están en el intervalo (0.25, 0.75).
message("a)")

# Tomo el vector de elementos que cumple la condicion
elements_in_interval = x[x>= 0.25 & x <= 0.75]

# Cuento cuantos elementos tiene dicho vector
n_elements_in_interval <- length(elements_in_interval)
message("Hay ", n_elements_in_interval, " en el intervalo 0.25 0.75")
message("")

# b) Calcula cuántos de sus elementos están por debajo de 0.1 o por encima de 0.9.
# Reemplaza dichos elementos por el valor NA. Después calcula su media.
message("b)")

# En el vector y guardo los elementos que cumplen la condicion del enunciado
y <- x[x <= 0.1 | x >= 0.9]

# Calculo el numero de elementos
n_y <- length(y)
message("El numero de elementos cumpliendo las condiciones del enunciado son ", n_y)
message("Dichas condiciones son estar por debajo de 0.1 o por encima de 0.9")
message("")

# Remplazo estos valores por NA
# Para ello, calculo las posiciones de x que lo cumplen y los uso como mascara
positions <- which(x <= 0.1 | x >= 0.9)

# Uso las posiciones para remplazar por NA
x[positions] <- NA

message("Remplazo dichas posiciones por NA")
cat("Despues de reemplazar las posiciones, el vector queda:\n", x, "\n")
message("")

# Ahora calculamos la media ignorando los NA
mx <- mean(x, na.rm = TRUE)
message("La media del vector x ahora es ", mx)
message("")

# c) Partiendo del vector obtenido en el apartado anterior, reemplaza los valores NA
# por ceros. Después calcula su media y compara con la obtenida en el apartado
# anterior
message("c)")

# Calculo las posiciones que son NA (aunque es el vector ya calculado positions)
# y reemplazo dichas posiciones por 0
message("Sustituimos los NA del vector por 0")
positions <- which(is.na(x))
x[positions] <- 0
cat("Ahora el vector de X es ", x, "\n")
message("")

# Calculo la media
message("Calculamos la media del vector remplazado")
mx <- mean(x)
cat("Ahora la media de x es", mx, "\n")
message("Como era de esperar, ahora la media es menor al no estar ignorando los NA y estar usando el valor mas bajo del rango (0)")
message("")

# Ejercicio 4
message("EJERCICIO 4")
message("================================================================================")
message("")

# 4. Crea un vector con los 20 primeros términos de la progresión aritmética an = a1 +
# (n − 1)d con a1 = 1 y d = 1.2. A partir de él:
message("Creamos un vector con los primeros 20 termino de la progresion aritmetica")
message("an = a1 + (n-1)d con a1 = 1 d = 1.2")
message("")

# Parametros de la progresion
n <- 20
a1 <- 1
d <- 1.2

# Creo el vector calculando el vector [n - 1 ; n \in 1..20] y a partir de el computo la progresion
x <- 0:(n-1)
x <- a1 + x * d
cat("El vector con la progresion es: ", x, "\n")
message("")

# a ) Calcula la suma de sus elementos usando la función sum y comprueba que
# coincide con fórmula n(a1 + an )/2, para n = 20.
message("a)")

# Calculo la suma haciendo la suma elemento a elemnto
manually_computed_sum <- sum(x)

# Calculo la suma usando la formula dada
# Para ello creo una funcion que computa dicha formula
sum_function <- function(n){
    sum_value <- n * (a1 + x[n]) / 2.0
    return(sum_value)
}
formula_sum <- sum_function(n)

message("Suma de los valores computados a mano: ", manually_computed_sum)
message("Suma de los valores usando la formula: ", formula_sum)
message("")

# b ) Calcula la (cuasi-)desviación típica usando la función sd y comprueba que
# coincide con $|d| \sqrt{\frac{n(n+1)}{12}}$
message("b)")

# Calculo la cuasidesviacion usando la instruccion de R
quasi_manually_comp <- sd(x)

# Calculo ahora la cuasidesviacion usando la formula dada en el enunciado
qusidesv_func <- function() {
    quasi <- abs(d) * sqrt((n * (n+1)) / 12.0)
    return(quasi)
}
quasi_formula_comp <- qusidesv_func()

message("Cuasidesviacion computada con la instruccion de R: ", quasi_manually_comp)
message("Cuasidesviacion computada usando la formula: ", quasi_formula_comp)
message("")

# c ) Calcula el producto de sus elementos usando la función prod y comprueba que coincide con:
# $\prod (a_1 + kd) = d^n * \frac{\gamma(\frac{a_1}{d + n})}{\gamma(\frac{a1}{d})}
# donde Γ denota la función gamma  (en R tienes esta función con el mismo nombre).
message("c)")

# Calculamos el producto a mano
manually_computed_prod <- prod(x)

# Calculamos el producto usando la primera formula dada en el enunciado
first_prod_func <- function () {
    # Computo un vector con los elementos del producto
    k <- 0:(n-1)
    product_elements <- a1 + k * d

    # Devuelvo el producto de los elementos
    return(prod(product_elements))
}

first_formula_comp_prod <- first_prod_func()

# Calculamos el producto usando la segunda formula dada en el enunciado
second_prod_func <- function() {
    prod <- (d^n) * gamma((a1 / d) + n) / gamma(a1 / d)
    return(prod)
}
second_formula_comp_prod <- second_prod_func()

message("Producto de los elementos computada a mano: ", manually_computed_prod)
message("Producto de los elementos computados usando la primera formula: ", first_formula_comp_prod)
message("Producto de los elementos computados usando la segunda formula: ", second_formula_comp_prod)
message("")
