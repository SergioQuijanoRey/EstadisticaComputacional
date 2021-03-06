# Sesion 07/04/2022
# Sergio Quijano Rey
# sergioquijano@correo.ugr.es
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion05-31-03-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

# EJERCICIO 1.2
#================================================================================

message("EJERCICIO 1.2")
message("#================================================================================")
message("")

# Repite el proceso anterior ahora para encontrar una raíz de f (x) = x3 − 2x − 5 en
# el intervalo (−5, 5). Comienza representando la función en dicho intervalo y observa la
# dicultad que puede tener el problema. Después implementa una a una las iteraciones
# eligiendo primero como valor inicial un valor cercano a la verdadera raíz y luego otro
# más alejado. ¾Qué observas?


# Definimos la funcion y la representamos graficamente
# El problema es que la función tiene máximos y mínimos relativos a la izquierda de la raiz, y por
# tanto la derivada se puede anular, ocasionando problemas en el algoritmo
f <- function(x) x^3 - 2*x -5
curve(f, -5, 5)
abline(h = 0, col = 2)

# Definimos la derivada de la funcion
f.prima<-function(x) 3*x^2 - 2

# Valor inicial
# Lo elegimos lo suficientemente cercana a la raiz
x0 <- 2
message("Valor inicial: ", x0)
message("")

# Iteramos el proceso mostrando como avanza el algoritmo

x1 <- x0-f(x0)/f.prima(x0)
message("Valor tras la primera iteracion: ", x1)
message("")

x2<-x1-f(x1)/f.prima(x1)
message("Valor tras la segunda iteracion: ", x2)
message("")

x3<-x2-f(x2)/f.prima(x2)
message("Valor tras la tercera iteracion: ", x3)
message("")

x4<-x3-f(x3)/f.prima(x3)
message("Valor tras la cuarta iteracion: ", x4)
message("")


# Repetimos el proceso usando un valor inicial más alejado
# Lo elegimos lo suficientemente cercana a la raiz
x0 <- -3
message("Repetimos el proceso escogiendo un valor inicial mas alejado")
message("Valor inicial: ", x0)
message("")

# Iteramos el proceso mostrando como avanza el algoritmo

x1 <- x0-f(x0)/f.prima(x0)
message("Valor tras la primera iteracion: ", x1)
message("")

x2<-x1-f(x1)/f.prima(x1)
message("Valor tras la segunda iteracion: ", x2)
message("")

x3<-x2-f(x2)/f.prima(x2)
message("Valor tras la tercera iteracion: ", x3)
message("")

x4<-x3-f(x3)/f.prima(x3)
message("Valor tras la cuarta iteracion: ", x4)
message("")

x5<-x4-f(x4)/f.prima(x4)
message("Valor tras la quinta iteracion: ", x5)
message("")

# Vemos que converge y que, al estar mas lejos, necesita mas iteraciones

# Repetimos el proceso usando un valor inicial más alejado
# Lo elegimos lo suficientemente cercana a la raiz
x0 <- -4
message("Repetimos el proceso escogiendo un valor inicial mas alejado")
message("Valor inicial: ", x0)
message("")

# Iteramos el proceso mostrando como avanza el algoritmo

x1 <- x0-f(x0)/f.prima(x0)
message("Valor tras la primera iteracion: ", x1)
message("")

x2<-x1-f(x1)/f.prima(x1)
message("Valor tras la segunda iteracion: ", x2)
message("")

x3<-x2-f(x2)/f.prima(x2)
message("Valor tras la tercera iteracion: ", x3)
message("")

x4<-x3-f(x3)/f.prima(x3)
message("Valor tras la cuarta iteracion: ", x4)
message("")

x5<-x4-f(x4)/f.prima(x4)
message("Valor tras la quinta iteracion: ", x5)
message("")

x6<-x5-f(x5)/f.prima(x5)
message("Valor tras la sexta iteracion: ", x6)
message("")

x7<-x6-f(x6)/f.prima(x6)
message("Valor tras la septima iteracion: ", x7)
message("")

xn <- x7
xn <-xn-f(xn)/f.prima(xn)
message("Valor tras la octava iteracion: ", xn)
message("")

xn <-xn-f(xn)/f.prima(xn)
message("Valor tras la novena iteracion: ", xn)
message("")

xn <-xn-f(xn)/f.prima(xn)
message("Valor tras la decima iteracion: ", xn)
message("")

xn <-xn-f(xn)/f.prima(xn)
message("Valor tras la undecima iteracion: ", xn)
message("")

# En este caso no converge. Estamos demasiado alejados de la solucion

# Funcion que implementa el metodo NR
algoritmo.NR <- function(f, f.prima, x0, tol, nmax) {

    # Partimos del valor inicial
    xn <- x0

    for(it in 1:nmax) {

        # Computamos el nuevo valor y la tolerancia alcanzada
        new_value <- xn - (f(xn) / f.prima(xn))
        curr_tol <- abs(new_value - xn)

        # Ahora que ya hemos computado la tolerancia, podemos asignar a la variable raiz su nuevo
        # valor
        xn <- new_value

        # Si la tolerancia esta por debajo de cierto umbral, devolvemos
        if(curr_tol < tol) {
            return(list(raiz = xn, tol = curr_tol, iteraciones = it))
        }
    }

    # Se han agotado todas las iteraciones sin estar por debajo de la tolerancia
    # Mostramos un mensaje de advertencia y devolvemos los valores
    warning("Se agotaron todas las iteraciones sin bajar de la tolerancia dada")
    return(list(raiz = xn, tol = curr_tol, iteraciones = nmax))
}

# Comprobamos el funcionamiento de la funcion

resultado <- algoritmo.NR(
    function(x) x^2 - 5,
    function(x) 2 * x,
    2,
    0.000001,
    10000
)

message("El resultado obtenido para la primera funcion es:")
print(resultado)
message("")

resultado <- algoritmo.NR(
    function(x) x^3 - 2*x -5,
    function(x) 3*x^2 - 2,
    2,
    0.00001,
    1000
)

message("El resultado obtenido para la segunda funcion es:")
print(resultado)
message("")

# Redefinimos la funcion para añadir las comprobaciones

# Funcion que implementa el metodo NR
algoritmo.NR <- function(f, f.prima, x0, tol, nmax) {

    # Comprobaciones de seguridad
    if(missing(f) || missing(f.prima) || missing(x0) || missing(tol) || missing(nmax)){
        warning("No has pasado todos los argumentos necesarios de la funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.function(f) == FALSE){
        warning("El argumento f debe ser una funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.function(f.prima) == FALSE){
        warning("El argumento f.prima debe ser una funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.numeric(x0) == FALSE || is.numeric(tol) == FALSE || is.numeric(nmax) == FALSE){
        warning("Los parametros x0, tol y nmax deben ser numericos")
        warning("Se devuelve NA")
        return(NA)
    }

    # Partimos del valor inicial
    xn <- x0

    for(it in 1:nmax) {

        # Computamos el nuevo valor y la tolerancia alcanzada
        new_value <- xn - (f(xn) / f.prima(xn))
        curr_tol <- abs(new_value - xn)

        # Ahora que ya hemos computado la tolerancia, podemos asignar a la variable raiz su nuevo
        # valor
        xn <- new_value

        # Si la tolerancia esta por debajo de cierto umbral, devolvemos
        if(curr_tol < tol) {
            return(list(raiz = xn, tol = curr_tol, iteraciones = it))
        }
    }

    # Se han agotado todas las iteraciones sin estar por debajo de la tolerancia
    # Mostramos un mensaje de advertencia y devolvemos los valores
    warning("Se agotaron todas las iteraciones sin bajar de la tolerancia dada")
    return(list(raiz = xn, tol = curr_tol, iteraciones = nmax))
}

# Comprobamos su funcionamiento

message("Comprobamos la funcion con filtros")
message("")

message("Lanzando la funcion sin parametros")
res <- algoritmo.NR()
message("Resultado obtenido:")
print(res)
message("")

message("Lanzando la funcion con parametros con tipos incorrectos")
res <- algoritmo.NR(2, 3, 4, 5, 6)
message("Resultado obtenido:")
print(res)
message("")


# Redefinimos la funcion para añadir la muestra de los graficos

# Funcion que implementa el metodo NR
algoritmo.NR <- function(f, f.prima, x0, tol, nmax, dibuja = TRUE) {

    # Comprobaciones de seguridad
    if(missing(f) || missing(f.prima) || missing(x0) || missing(tol) || missing(nmax)){
        warning("No has pasado todos los argumentos necesarios de la funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.function(f) == FALSE){
        warning("El argumento f debe ser una funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.function(f.prima) == FALSE){
        warning("El argumento f.prima debe ser una funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.numeric(x0) == FALSE || is.numeric(tol) == FALSE || is.numeric(nmax) == FALSE){
        warning("Los parametros x0, tol y nmax deben ser numericos")
        warning("Se devuelve NA")
        return(NA)
    }

    # Empezamos realizando el dibujado
    if(dibuja == TRUE){
        # Tomamos un intervalo de longitud 6 con centro el valor inicial
        curve(f, x0 - 3, x0 + 3)
        abline(h = 0, col = 2)
    }

    # Partimos del valor inicial
    xn <- x0

    for(it in 1:nmax) {

        # Computamos el nuevo valor y la tolerancia alcanzada
        new_value <- xn - (f(xn) / f.prima(xn))
        curr_tol <- abs(new_value - xn)

        # Ahora que ya hemos computado la tolerancia, podemos asignar a la variable raiz su nuevo
        # valor
        xn <- new_value

        # Si la tolerancia esta por debajo de cierto umbral, devolvemos
        if(curr_tol < tol) {
            return(list(raiz = xn, tol = curr_tol, iteraciones = it))
        }
    }

    # Se han agotado todas las iteraciones sin estar por debajo de la tolerancia
    # Mostramos un mensaje de advertencia y devolvemos los valores
    warning("Se agotaron todas las iteraciones sin bajar de la tolerancia dada")
    return(list(raiz = xn, tol = curr_tol, iteraciones = nmax))
}

# Comprobamos la funcion

message("Lanzando la funcion con el dibujado")
resultado <- algoritmo.NR(
    function(x) x^2 - 5,
    function(x) 2 * x,
    2,
    0.000001,
    10000
)
message("Resultado obtenido:")
print(resultado)
message("")


message("Lanzando la funcion sin el dibujado")
resultado <- algoritmo.NR(
    function(x) x^2 - 5,
    function(x) 2 * x,
    2,
    0.000001,
    10000,
    FALSE
)
message("Resultado obtenido:")
print(resultado)
message("")

# EJERCICIO 1.3
#================================================================================

message("EJERCICIO 1.3")
message("#================================================================================")
message("")

# Funcion que implementa el metodo NR
library(numDeriv)
algoritmo.NR <- function(f, f.prima, x0, tol, nmax, dibuja = TRUE) {

    # Comprobaciones de seguridad
    if(missing(f) || missing(x0) || missing(tol) || missing(nmax)){
        warning("No has pasado todos los argumentos necesarios de la funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    # Si no se pasa f.prima, se usa la derivacion numerica
    if(missing(f.prima)) {
        message("Estamos usando derivacion numerica")
        f.prima <- function(x) genD(func = f, x = x)$D[1]
    }

    if(is.function(f) == FALSE){
        warning("El argumento f debe ser una funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.function(f.prima) == FALSE){
        warning("El argumento f.prima debe ser una funcion")
        warning("Se devuelve NA")
        return(NA)
    }

    if(is.numeric(x0) == FALSE || is.numeric(tol) == FALSE || is.numeric(nmax) == FALSE){
        warning("Los parametros x0, tol y nmax deben ser numericos")
        warning("Se devuelve NA")
        return(NA)
    }

    # Empezamos realizando el dibujado
    if(dibuja == TRUE){
        # Tomamos un intervalo de longitud 6 con centro el valor inicial
        curve(f, x0 - 3, x0 + 3)
        abline(h = 0, col = 2)
    }

    # Partimos del valor inicial
    xn <- x0

    for(it in 1:nmax) {

        # Computamos el nuevo valor y la tolerancia alcanzada
        new_value <- xn - (f(xn) / f.prima(xn))
        curr_tol <- abs(new_value - xn)

        # Ahora que ya hemos computado la tolerancia, podemos asignar a la variable raiz su nuevo
        # valor
        xn <- new_value

        # Si la tolerancia esta por debajo de cierto umbral, devolvemos
        if(curr_tol < tol) {
            return(list(raiz = xn, tol = curr_tol, iteraciones = it))
        }
    }

    # Se han agotado todas las iteraciones sin estar por debajo de la tolerancia
    # Mostramos un mensaje de advertencia y devolvemos los valores
    warning("Se agotaron todas las iteraciones sin bajar de la tolerancia dada")
    return(list(raiz = xn, tol = curr_tol, iteraciones = nmax))
}

# Comprobamos la funcion anterior con distintas funciones matematicas

message("Probando la primera funcion con derivacion numerica")
resultado <- algoritmo.NR(
    f = function(x) x^2 - 5,
    x0 = 2,
    tol = 0.000001,
    nmax = 10000,
    dibuja = FALSE
)
message("Resultado obtenido:")
print(resultado)
message("")

message("Probando la segunda funcion con derivacion numerica")
resultado <- algoritmo.NR(
    f = function(x) x^3 - 2*x -5,
    x0 = 2,
    tol = 0.000001,
    nmax = 10000,
    dibuja = FALSE
)
message("Resultado obtenido:")
print(resultado)
message("")

message("Probando la tercera funcion con derivacion numerica")
resultado <- algoritmo.NR(
    f = function(x) exp(2*x) - x - 6,
    x0 = 3,
    tol = 0.000001,
    nmax = 10000,
    dibuja = FALSE,
)
message("Resultado obtenido:")
print(resultado)
message("")

# REALIZAMOS LAS COMPARACIONES CON UNIROOT
# Voy a usar la siguiente funcion para comprobar que los valores obtenidos con ambas funciones
# coinciden aproximadamente:

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

# Comprobamos que dos elementos comparables con el operador == son eferectivamente iguales
assert_eq <- function(msg, first_val, second_val) {
    cond <- first_val == second_val
    if(cond == FALSE) {
        warning(first_val, " != ", second_val)
        stop(msg)
    }
}


message("Comparando uniroot vs nuestra implementacion en la primera funcion con derivacion numerica")


# --> Primer Caso
curr_f <- function(x) x^2 - 5
xo <- 2

resultado <- algoritmo.NR(
    f = curr_f,
    x0 = x0,
    tol = 0.000001,
    nmax = 10000,
    dibuja = FALSE
)
resultado_uniroot <- uniroot(curr_f, c(x0 - 3, x0 + 3))

# Realizamos la comprobacion usando la funcionalidad de asercion antes de mostrar los mensajes
assert_double_eq("Comprobando dos funcionalidades en el primer caso", resultado$raiz, resultado_uniroot$root, 1e-5)

message("Primer caso: resultado obtenido con nuestra funcion:")
print(resultado$raiz)
message("")
message("Primer caso: obtenido con uniroot funcion:")
print(resultado_uniroot$root)
message("")
message("")

# --> Segundo Caso
xo <- 2
curr_f <- function(x) x^3 - 2*x -5

resultado <- algoritmo.NR(
    f = curr_f,
    x0 = x0,
    tol = 0.000001,
    nmax = 10000,
    dibuja = FALSE
)
resultado_uniroot <- uniroot(curr_f, c(x0 - 10, x0 + 10))

# Realizamos la comprobacion usando la funcionalidad de asercion antes de mostrar los mensajes
assert_double_eq("Comprobando dos funcionalidades en el tercer caso", resultado$raiz, resultado_uniroot$root, 1e-5)

message("Segundo caso: resultado obtenido con nuestra funcion:")
print(resultado$raiz)
message("")
message("Segundo caso: obtenido con uniroot funcion:")
print(resultado_uniroot$root)
message("")
message("")

# --> Tercer Caso
curr_f <- function(x) exp(2*x) - x - 6
x0 = 3

resultado <- algoritmo.NR(
    f = curr_f,
    x0 = x0,
    tol = 0.000001,
    nmax = 10000,
    dibuja = FALSE
)
resultado_uniroot <- uniroot(curr_f, c(x0 - 3, x0 + 3))

# Realizamos la comprobacion usando la funcionalidad de asercion antes de mostrar los mensajes
assert_double_eq("Comprobando dos funcionalidades en el tercer caso", resultado$raiz, resultado_uniroot$root, 1e-4)

message("Tercer caso: resultado obtenido con nuestra funcion:")
print(resultado$raiz)
message("")
message("Tercer caso: obtenido con uniroot funcion:")
print(resultado_uniroot$root)
message("")
message("")


# EJERCICIO Propuesto
#================================================================================

message("EJERCICIO Propuesto")
message("#================================================================================")
message("")

# Calcula los [n] primeros elementos de la sucesion:
#   x_1 = [x1]
#   x_{n+1} = r * x_n (1 - x_n)
diff.eq <- function(x1, r, n) {

    # Lista con los elementos que guardamos
    sucesion <- list()

    # Elemento inicial
    xn <- x1
    sucesion <- c(sucesion, xn)

    # Aplicamos la sucesion
    for(i in 2:n) {
        xn <- r * xn * (1 - xn)
        sucesion <- c(sucesion, xn)
    }

    return(list(xn = xn, sucesion = sucesion))
}

# a ) Ejecuta la función para r = 2 y 0 < x1 < 1. Deberías obtener que xn tiende a
# 0.5 cuando n tiende a innito.
message("a)")
message("")

# Probamos con un ejemplo
x1 <- 0.77
r <- 2.0
n <- 100
res <- diff.eq(x1, r, n)
xn <- res$xn
suc <- res$sucesion
assert_double_eq("Comprobamos la sucesion programada", xn, 0.5, 1e-6)
assert_eq("Comprobamos la longitud de la sucesion programada", length(suc), n)
message("Para x1 = ", x1, ", r = ", r, " n = ", n, " se obtiene x_n = ", xn)
message("")


# Probamos con otro ejemplo
x1 <- 0.25
r <- 2.0
n <- 20
res <- diff.eq(x1, r, n)
xn <- res$xn
suc <- res$sucesion
assert_double_eq("Comprobamos la sucesion programada", xn, 0.5, 1e-6)
assert_eq("Comprobamos la longitud de la sucesion programada", length(suc), n)
message("Para x1 = ", x1, ", r = ", r, " n = ", n, " se obtiene x_n = ", xn)
message("")

# Probamos con otro ejemplo
x1 <- 0.15
r <- 2.0
n <- 10
res <- diff.eq(x1, r, n)
xn <- res$xn
suc <- res$sucesion
assert_double_eq("Comprobamos la sucesion programada", xn, 0.5, 1e-6)
assert_eq("Comprobamos la longitud de la sucesion programada", length(suc), n)
message("Para x1 = ", x1, ", r = ", r, " n = ", n, " se obtiene x_n = ", xn)
message("")

# b ) Representa grácamente los primeros n = 500 de la sucesión para x1 = 0.95 y
# r = 2.99. La gráca la puedes obtener usando la función plot con la sintaxis
# plot(1:500,v), siendo v el vector devuelto por la función.

message("b)")
message("")

message("Mostramos graficamente la sucesion x1 = 0.95, r = 2.99, n = 500")
sucesion <- diff.eq(x1 = 0.95, r = 2.99, n = 500)$suc
plot(1:500, sucesion)

# c ) Escribe una segunda función dif.eq2 con argumentos x1 y r que devuelva una
# lista incluyendo, además del vector anterior (v), el número de iteraciones (n)
# necesarias hasta alcanzar el criterio de convergencia siguiente:
# |xn+1 − xn | < 0.02
# Comprueba tu función evaluándola en x1 = 0.95 y r = 2.99, en cuyo caso
# deberías obtener que n = 84

message("c)")
message("")

diff.eq2 <- function(x1, r) {
    # Lista con los elementos que guardamos
    sucesion <- list()

    # Elemento inicial
    xn <- x1
    sucesion <- c(sucesion, xn)

    # Empezamos con cero iteraciones, porque no contamos xn <- x1 como iteracion
    counter <- 0

    # Condicion de parada que empieza siendo falsa
    stop_cond <- FALSE

    # Aplicamos la sucesion
    while(stop_cond == FALSE) {

        # Aplicamos una nueva iteracion
        # Usamos una variable intermedia para calcular la distancia entre dos terminos consecutivos
        xnext <- r * xn * (1 - xn)
        dist_consec <- abs(xnext - xn)
        counter <- counter + 1

        # Una vez que hemos calculado la distancia podemos hacer la asignacion
        xn <- xnext
        sucesion <- c(sucesion, xn)

        # Comprobamos la condicion de parada
        stop_cond <- dist_consec < 0.02
    }

    return(list(xn = xn, sucesion = as.vector(sucesion), iterations = counter))
}

# Realizamos la comprobacion usando el ejemplo dado en el guion de practicas
x1 <- 0.95
r <- 2.99
n_expected <- 84

# Tomamos el resultado y hacemos una asercion
res <- diff.eq2(x1, r)
assert_eq("Comprobacion de seguridad en la segunda funcion", res$iterations, n_expected)

# Ahora que la asercion ha sido comprobada, mostramos por pantalla los resultados
message("Los resultados de la segunda funcion para x1 = 0.95, r = 2.99 son:")
message("\txn: ", res$xn)
message("\titerations: ", res$iterations)
message("\tsucesion: ")
print(res$sucesion)
message("")
