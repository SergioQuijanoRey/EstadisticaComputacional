# Sesion 31 Marzo 2022
# Sergio Quijano Rey
# sergioquijano@correo.ugr.es
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion05-31-03-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

# Notas de clase
#
# Para poder optimizar las funciones:
# - El primer parametro de la funcion es el parametro que queremos optimizar. Si es n-dimensional
# debe ser una lista, y no n parametros separados

# Carga de los datos
#=================================================================================

message("Carga de los datos")
message("#=================================================================================")
message("")

# No uso scan copiandolo del PDF porque copia toda una fila de forma contigua, sin considerar
# los espacios. Creo que es por la codificacion en Linux. Asi que los copio a mano
# Ejemplo de copia de la primera fila:
# 25.0318.5947.2080.20187.67
muestra <- c(
    25.03, 18.59, 47.20, 80.20, 187.67,
    95.94, 35.07, 145.38, 9.52, 128.14,
    136.69, 180.82, 49.67, 33.41, 4.16,
    94.87, 102.25, 11.04, 35.14, 151.15,
    17.14, 81.94, 20.01, 125.26, 7.11,
    61.36, 55.59, 10.80, 31.88, 16.39,
    45.95, 4.98, 23.20, 8.78, 30.68,
    22.65, 13.19, 40.62, 2.78, 35.41,
    8.63, 17.04, 8.02, 126.54, 2.11,
    136.93, 17.39, 37.73, 84.53, 14.22
)

message("La muestra de datos es:")
print(muestra)
message("")

# Metodo 1
#=================================================================================
message("Metodo 1")
message("#=================================================================================")
message("")


message("Definimos la funcion a optimizar")

logl <- function(theta) {
    a <- theta[1]
    b <- theta[2]
    l <- sum(log(dgamma(x=muestra,shape=a,scale=b)))
    return(-l)
}

cat("logl(1, 1) = ", logl(c(1, 1)), "\n")
message("")

message("Ejecutamos la optimizacion con optim")
b0 <- a0 <- 1
res <- optim(par = c(a0,b0), fn = logl)
cat("El resultado obtenido es: ", res$par, "\n")
message("")

# Inspecciona qué otros resultados contiene la lista (res) que devuelve la función. Luego
# prueba a cambiar los valores iniciales y observa los cambios en el resultado.

message("El contenido completo del resultado es:")
print(res)
message("")

# Leyendo la ayuda de la funcion sabemos que
# - par es el valor de entrada optimo
# - value es el valor de la funcion en los valores de entrada optimos
# - counts indica el numero de veces que se llama a la funcion en el proceso
# - convergence es un codigo numerico para saber si se ha llegado a converger o no
# - message es un string con informacion adicional sobre el proceso, en caso de ser necesaria

message("Probamos con otros valores iniciales")
message("")

# Vemos que converge a la misma solucion, aproximadamente, sin problemas
b0 <- a0 <- 5
res <- optim(par = c(a0,b0), fn = logl)
cat("El resultado obtenido para valores iniciales (5, 5): ")
print(res)
message("")

# Convergerge a los mismos mismos valores aproximadamente
# Pero en el proceso se nos informa de que se generan algunos NaNs
b0 <- a0 <- 10
res <- optim(par = c(a0,b0), fn = logl)
cat("El resultado obtenido para valores iniciales (10, 10):")
print(res)
message("")

message("Ejecutamos la optimizacion con Rsolnp")
message("")

library(Rsolnp)
b0 <- a0 <- 1
res <- solnp(pars = c(a0, b0), fun = logl, LB = c(0, 0))
cat("El resultado con Rsolnp es: ", res$par, "\n")
message("")

# Un método alternativo a la estimación máximo-verosímil es el método de los momentos.
# a. Repite
# Para la distribución Gamma este método ofrece estimadores b
# a = s2 /x y bb = x/b
# la optimización que has hecho antes con la función solnp pero ahora usando estos valores
# iniciales. Observa la diferencia con respecto a los valores iniciales arbitrario que usábamos
# antes.

# Definimos los dos nuevos valores iniciales
a_hat <- var(muestra) / mean(muestra)
b_hat <- mean(muestra) / a_hat

message("a_hat = ", a_hat)
message("b_hat = ", b_hat)
message("")

# Optimizamos de nuevo con los nuevos valores iniciales
# Vemos que obtenemos el mismo resultado pero sin los warnings de antes
res <- solnp(pars = c(a_hat, b_hat), fun = logl, LB = c(0, 0))
cat("El resultado con Rsolnp y buenos valores iniciales es: ", res$par)
message("")

message("Ejecutamos la optimizacion con maxLik")
message("")

# Importamos la libreria
message("Importando la libreria")
library(maxLik)
message("")

# Ejecutamos la optimizacion
logl2 <- function(theta) -logl(theta)
res <- maxLik(logl2,start = c(1, 1))
message("El resultado con max lik es: ")
print(res$estimate)
message("")

# Pasamos de tener 16 warnings a tener solamente 3
message("El resultado con max lik y buenos valores iniciales es:")
res <- maxLik(logl2,start = c(a_hat, b_hat))
print(res$estimate)
message("")

# Ahora no vemos ningun warning
message("El resultado de max lik con restricciones a, b > 0 es:")
A <- matrix(c(1, 0, 0, 1), 2)
B <- c(0, 0)
res <- maxLik(logl2,start=c(1, 1), constraints = list(ineqA = A, ineqB = B))
print(res$estimate)
message("")


# Metodo 2
#=================================================================================
message("Metodo 2")
message("#=================================================================================")
message("")

f<-function(a) log(a)-digamma(a)- log(mean(muestra))+mean(log(muestra))
res<-uniroot(f,c(0.1,100))
message("El resultado de resolver con uniroot las ecuaciones normales es:")
print(res)
message("")

# Con la solución anterior para a puedes ahora obtener el de b como b = x/a. Compara
# con las soluciones que nos dieron los métodos anteriores.

a_uniroot <- res$root
b_uniroot <- mean(muestra) / a_uniroot

message("Los resultados con uniroot son (a,b): (", a_uniroot, ", ", b_uniroot, ")" )
message("")

message("Los resultados con maxlik son:")
A <- matrix(c(1, 0, 0, 1), 2)
B <- c(0, 0)
res <- maxLik(logl2,start=c(1, 1), constraints = list(ineqA = A, ineqB = B))
print(res$estimate)
message("")

message("Los resultados con Rsolnp son:")
res <- solnp(pars = c(a_hat, b_hat), fun = logl, LB = c(0, 0))
print(res$par)
message("")

message("Los resultados obtenidos con optim son")
res <- optim(par = c(a_hat, b_hat), fn = logl)
print(res$par)
message("")

# Por tanto, en todos los casos obtenemos resultados muy parecidos que difieren a partir de 3 posiciones
# decimales

# Primera funcion elemental
#=================================================================================

message("Primera funcion elemental")
message("#=================================================================================")
message("")

# Funcion que dado un vector de datos devuelve distintas medias
medias <- function(x) {

    # Comprobamos que el vector sea numerico
    if(is.numeric(x) == FALSE) {
        # Mostramos un mensaje de error
        warning("ERROR, se esperaba un vector numerico")

        # No computamos ninguna media
        return(NA)
    }

    # Comprobamos datos perdidos. En caso de encontrarlos, los ignoramos
    if(length(x[is.na(x)]) > 0) {
        # Mostramos un mensaje por pantalla
        warning("CUIDADO! Hay valores perdidos en el vector, que vamos a igrnorar")

        # Limpiamos el vector de valores NA
        no_na_values <- x[!is.na(x)]
        x <- x[no_na_values]
    }

    # Comprobamos si tenemos valores negativos o cero
    # Guardamos la comprobacion en una variable porque la vamos a necesitar mas adelante
    tiene_cero_o_negativos <- length(x[x <= 0]) > 0
    if(tiene_cero_o_negativos){
        warning("CUIDADO! En vector contiene valores cero o negativos")
    }

    # Computamos la media aritmetica
    media.aritm <- sum(x) / length(x)

    # Computamos la media geometrica y armonica teniendo en cuenta si hay negativos o cero en
    # el vector dado como entrada
    if(tiene_cero_o_negativos == FALSE) {

        # Computamos la media geometrica y armonica
        media.geom <- prod(x) ^ (1 / length(x))
        media.arm <- length(x) / sum(1 / x)
    } else {

        # La media geometrica y armonica son NA
        media.geom <- NA
        media.arm <- NA
    }

    return(list(media.aritm = media.aritm, media.geom = media.geom, media.arm = media.arm))
}

# Funciones que vamos a usar para las comprobaciones
# No he encontrado ninguna libreria por defecto que traiga estas funcionalidades
# Ademas, las comprobaciones son con los ejemplos que da la profesora de practicas en el guion

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

# Comprobamos que un valor dado es NA. En caso de que no lo sea, mostramos un mensaje de error
# e interrumpimos la ejecucion del programa
assert_is_na <- function(msg, value) {
    if(is.na(value) == FALSE) {
        warning("El valor ", value, " no es NA")
        stop(msg)
    }
}


# Primera comprobacion
res <- medias(1:10)
message("Resultado de la primera comprobacion:")
print(res)
message("")

assert_double_eq("Resultado de la primera comprobacion", res$media.aritm, 5.5)
assert_double_eq("Resultado de la primera comprobacion", res$media.geom, 4.528729)
assert_double_eq("Resultado de la primera comprobacion", res$media.arm, 3.414172)

# Segunda comprobacion
res <- medias(c(1:10, NA))
message("Resultado de la segunda comprobacion:")
print(res)
message("")

assert_double_eq("Resultado de la segunda comprobacion", res$media.aritm, 5.5)
assert_double_eq("Resultado de la segunda comprobacion", res$media.geom, 4.528729)
assert_double_eq("Resultado de la segunda comprobacion", res$media.arm, 3.414172)

# Tercera comprobacion
res <- medias(0:10)
message("Resultado de la tercera comprobacion:")
print(res)
message("")

assert_double_eq("Resultado de la tercera comprobacion", res$media.aritm, 5)
assert_is_na("Resultado de la tercera comprobacion", res$media.geom)
assert_is_na("Resultado de la tercera comprobacion", res$media.arm)

# Cuarta comprobacion
res <- medias(-1:10)
message("Resultado de la cuarta comprobacion:")
print(res)
message("")

assert_double_eq("Resultado de la cuarta comprobacion", res$media.aritm, 4.5)
assert_is_na("Resultado de la cuarta comprobacion", res$media.geom)
assert_is_na("Resultado de la cuarta comprobacion", res$media.arm)


# Segunda funcion elemental
#=================================================================================

message("Segunda funcion elemental")
message("#=================================================================================")
message("")

# 2. La mediana es una medida de posición central. Para un vector de datos numéricos x
# la mediana es el valor que divide los datos ordenados en dos grupos iguales. Observa
# que cuando el número de datos es par no hay ningún valor que cumpla este papel,
# en ese caso se dene la mediana como la media de los dos valores centrales.
# Con esta denición construye una función que calcule la mediana de un vector de
# datos. La función tendrá por nombre mediana y tan sólo un argumento x (el vector
# de datos). El valor que debe devolver es la mediana calculada. Una vez que tengas la
# función, crea una versión que incluya comprobaciones básicas como que el argumento
# proporcionado es numérico, y si tiene datos perdidos, en cuyo caso deberá ignorarlos
# para el cálculo.
# Finalmente comprueba el resultado de tu función con los siguientes resultados:

# Calcula la mediana de un vector de datos numericos
# En caso de que el numero de elementos sea par, la mediana es la media de los dos elementos
# centrales
# En caso de que haya NA en el vector, se muestra un warning y estos valores se ignoran
# El vector de entrada no tiene por que estar ordenado, de esto se encarga la funcion
mediana <- function(x) {
    # Comprobamos que el vector sea numerico
    if(is.numeric(x) == FALSE) {
        # Mostramos un mensaje de error
        warning("ERROR, se esperaba un vector numerico")

        # No computamos ninguna media
        return(NA)
    }

    # Comprobamos datos perdidos. En caso de encontrarlos, los ignoramos
    if(length(x[is.na(x)]) > 0) {
        # Mostramos un mensaje por pantalla
        warning("CUIDADO! Hay valores perdidos en el vector, que vamos a igrnorar")

        # Limpiamos el vector de valores NA
        no_na_values <- x[!is.na(x)]
        x <- x[no_na_values]
    }

    # Odenamos los valores del vector
    sorted <- sort(x)

    # Computamos la mediana, dependiendo de si tenemos un numero par o impar de valores
    if(length(sorted) %% 2 == 0) {
        return(mediana_par(sorted))
    }
    return(mediana_impar(sorted))
}

# Mediana cuando el vector de entrada esta limpiado y es de longitud impar
mediana_impar <- function(x) {
    mediana_val <- x[length(x) %/% 2 + 1]
    return(mediana_val)
}

# Mediana cuando el vector de entrada esta limpiado y es de longitud par
mediana_par <- function(x) {
    first <- x[length(x) %/% 2]
    second <- x[length(x) %/% 2 + 1]
    return((first + second) / 2.0)
}


# Realizamos algunas comprobaciones a partir de los ejemplos del guion de practicas de la asignatura

# Primera comprobacion
res <- mediana(1:5)
assert_double_eq("Resultado de la primera comprobacion", res, 3, 0.0000001)
message("Resultado de la primera comprobacion:")
print(res)
message("")

res <-  mediana(1:6)
assert_double_eq("Resultado de la segunda comprobacion", res, 3.5, 0.0000001)
message("Resultado de la segunda comprobacion:")
print(res)
message("")

res <- mediana(c(1:6,NA))
assert_double_eq("Resultado de la tercera comprobacion", res, 3.5, 0.0000001)
message("Resultado de la tercera comprobacion:")
print(res)
message("")

set.seed(1)
res <- mediana(runif(20))
assert_double_eq("Resultado de la cuarta comprobacion", res, 0.6009837, 0.00001)
message("Resultado de la cuarta comprobacion:")
print(res)
message("")

res <- mediana("hola")
assert_is_na("Resultado de la quinta comprobacion", res)
message("Resultado de la quinta comprobacion:")
print(res)
message("")

# Tercera funcion elemental
#=================================================================================

message("Tercera funcion elemental")
message("#=================================================================================")
message("")

# 3. Los cuantiles (cuartiles, deciles, percentiles, etc.) constituyen medidas de posición
# en general. Para un vector de datos numéricos x los cuartiles son tres valores (Q1 ,
# Q2 y Q3 ) que dividen los datos en 4 grupos iguales, siendo por tanto Q2 igual a la
# mediana.

# a ) Construye una función con nombre cuartiles y tan sólo un argumento x
# (el vector de datos), que calcule los cuartiles. El valor que debe devolver la
# función es una lista con los tres cuartiles calculados. La función debe incluir
# comprobaciones básicas como que el argumento proporcionado es numérico, y
# si tiene datos perdidos, en cuyo caso deberá ignorarlos para el cálculo.

# Calcula Q1, Q2, Q3 de un vector de datos numerico
# Debe ser un vector numerico, en otro caso devolvemos NA
# Si contiene valores NA, se muestra un mensaje de advertencia, y se computa ignorando estos valores
# El vector de entrada no tiene por que estar ordenado. De esto se encarga la funcion
cuartiles <- function(x) {
    # Comprobamos que el vector sea numerico
    if(is.numeric(x) == FALSE) {
        # Mostramos un mensaje de error
        warning("ERROR, se esperaba un vector numerico")

        # No computamos ninguna media
        return(NA)
    }

    # Comprobamos datos perdidos. En caso de encontrarlos, los ignoramos
    if(length(x[is.na(x)]) > 0) {
        # Mostramos un mensaje por pantalla
        warning("CUIDADO! Hay valores perdidos en el vector, que vamos a igrnorar")

        # Limpiamos el vector de valores NA
        no_na_values <- x[!is.na(x)]
        x <- x[no_na_values]
    }

    # Tenemos que trabajar con el vector ordenador
    sorted <- sort(x)

    # Calculamos Q1
    q1_pos <- length(sorted) * 0.25
    q1 <- NA
    if(custom.is.integer(q1_pos)) {
        q1 <- sorted[q1_pos]
    } else {
        q1 <- (sorted[q1_pos] + sorted[q1_pos + 1]) / 2.0
    }

    # Calculamos Q2
    # Es la mediana, que ya tenemos programada
    q2 <- mediana(x)

    # Calculamos Q3
    q3_pos <- (length(sorted) %/% 4) * 0.75
    q3 <- NA
    if(custom.is.integer(q1_pos)) {
        q3 <- sorted[q3_pos]
    } else {
        q3 <- (sorted[q3_pos] + sorted[q3_pos + 1]) / 2.0
    }

    # Devolvemos la lista con los resultados
    return(list(q1 = q1, q2 = q2, q3 = q3))
}

custom.is.integer <- function(value) {
    if(as.integer(value) == value) {
        return(TRUE)
    }

    return(FALSE)
}


# b ) En el paquete stats tenemos la función quantile que permite calcular el cuantil
# de orden 0 < α < 1, denido como el valor que deja por debajo el α ∗ 100 %
# de los datos. Inspecciona la ayuda de la función y compara para unos datos
# el resultado que te da la función que has calculado con el que te daría esta
# función.

# Usando la funcion quantile, vamos a escribir los tests unitarios con las funciones para realizar
# comprobaciones que hemos desarrollado
# De hecho, escribo una funcion para realizar las tres comprobaciones (una por cuartil)
comprobacion_cuartiles <- function(x, name) {
    res <- cuartiles(x)
    assert_double_eq(name, res$q1, quantile(x, 0.25))
    assert_double_eq(name, res$q2, quantile(x, 0.5))
    assert_double_eq(name, res$q3, quantile(x, 0.75))

}

x <- c(1:10)
res <- cuartiles(x)
comprobacion_cuartiles(x, "Primera comprobacion")
message("Resultados de la primera comprobacion")
print(res)
message("")

x <- c(1:9)
res <- cuartiles(x)
comprobacion_cuartiles(x, "Segunda comprobacion")
message("Resultados de la segunda comprobacion")
print(res)
message("")
