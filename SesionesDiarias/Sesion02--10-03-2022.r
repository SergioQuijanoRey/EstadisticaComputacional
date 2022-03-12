# Sesion 10 Marzo 2022
# Sergio Quijano Rey
# sergioquijano@correo.ugr.es
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion02-10-03-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

# Ejercicio 1
#===================================================================================================
message("EJERCICIO 1")
message("================================================================================")

# Ejecuta las siguientes sentencias y extrae conclusiones sobre el tipo de objeto que de-
# vuelven:

# Generamos una matriz 3x3 con los terminos ordenados de menor a mayor por columnas
A <- matrix(1:9, 3, 3)
message("La matriz A es:") ; print(A)
message("")

# Generamos un vector [1, 2, 3]
x <- 1:3
cat("El vector x es: ", x, "\n")
message("")

# Muestra un vector columna con tres elementos
result <- A %*% x
message("El resultado A%*%x es: ")
print(result)
message("")

# Esta operacion devuelve:
# Error in A %*% t(x) : non-conformable arguments
# El producto matriz vector coloca directamente el vector en formato columna
# Pero cuando trasponemos el vector, obtenemos una matriz en formato fila, que al
# operar no se transforma
# Asi que creo que la conversion automatica vector -> matriz pasa los vectores a formato columna

# Uso try para que el resto del script se pueda ejecutar
message("Computando A %*% t(x")
try({
    result <- A %*% t(x)
    message("El resultado de A %*% t(x) es:")
    print(result)
    return(result)
})
message("")


# Si funciona, devuelve un vector fila con el resultado de la operacion
# Asi que en este caso, R esta haciendo la conversion de vector a matriz para
# multiplicar viendo las dimensiones y concluyendo que tiene que convertirlo en formato fila
result <- x %*% A
message("El resultado de x %*% A es:")
print(result)
message("")

# También funciona y da el mismo resultado
# Parece que R convierte a matriz siempre en formato fila, como ya hemos dicho
# Y en este caso si que sirve
result <- t(x) %*% A
message("El resultado de t(x) %*% A es:")
print(result)
message("")

# Da como resultado una matriz de un unico elemento
# t(x) creo que siempre da la matriz en formato fila
# Al multiplicar matriz por vector, creo que R convierte fijandose en las dimensiones
# para que la operacion tenga sentido. Y en este caso hay que hacer fila * columna
result <- t(x) %*% x
message("El resultado de t(x) %*% A es:")
print(result)
message("")


# Ejercicio 2
#===================================================================================================

message("EJERCICIO 2")
message("================================================================================")
message("")

# Ejecuta las siguientes sentencias en R y formula los sistemas se resuelven en cada caso:

# Sistema 1
# Da como resultado el vector [1]
# Esto era de esperar porque estamos plantenando la ecuacion 2x = 2
message("El resultado de solve(2, 2) es:")
print(solve(2, 2))
message("Estamos resolviendo la ecuacion 2x = 2")
message("")

# Sistema 2
# En este caso da [-4, 6]
# Estamos resolviendo el sistema
# 3x + y = 12
# 4x + 2y = 8
message("Ahora resolvemos el sistema de ecuaciones:")
message("")
message("\t3x + y = 12")
message("\t4x + 2y = 8")
message("El resultado de este sistema de ecuaciones es: ")
A<-matrix(c(3, 1, 4, 2), 2, 2)
b<-c(12, 8)
print(solve(A, b))
message("")

# Sistema 3
# En este caso da la matriz
# 1.0   -2.0
# -0.5  1.5
#
# Estamos resolviendo el sistema AX = Diagonal(2)
# donde Diagonal(2) = [1 0 ; 0 1]
message("Ahora resolvemos el sistem AX = Diag(2)")
message("El resultado es:")
print(solve(A, diag(2)))
message("")

# Ejercicio 2.1
#===================================================================================================
message("EJERCICIO 2.1")
message("================================================================================")
message("")

message("Estamos resolviendo el sistema:")
message("")
message("\t10x + 7y + 8z + 7w = 32")
message("\t7x + 5y + 6z + 5w = 23")
message("\t8x + 6y + 10z + 9w = 33")
message("\t7x + 5y + 9z + 10w = 31")
message("")

# Creamos la matriz de coeficientes
# Por comodidad lo hago creando el vector y luego asignando dimensiones
A <- c(
    10 , 7 , 8 , 7,
    7 , 5 , 6 , 5,
    8 , 6 , 10 , 9,
    7 , 5 , 9 , 10
)
dim(A) <- c(4, 4)

# Creamos el vector de terminos independientes
b <- c(32, 23, 33, 31)

# Resuelvo el sistema con solve
# El resultado es [1, 1, 1, 1]
result <- solve(A, b)
message("El resultado de dicho sistema de ecuaciones es:")
print(result)
message("")

# Perturbo los terminos independientes sumando 0.05
b_pert <- b + 0.05
message("Perturbamos ligeramente los terminos independientes")
cat("Ahora dichos terminos independientes son: ", b_pert, "\n")
message("")

# Resuelvo el sistema perturbado
# El resultado da [0.40 2.00 0.75 1.15]
# Se aleja demasiado de la solucion inicial, parece muy inestable
result <- solve(A, b_pert)
message("El resultado a ese sistema perturbado es:")
print(result)
message("")

# Repetimos el proceso con una perturbacion de 0.1
# El resultado es [-0.2  3.0  0.5  1.3]
# De nuevo, muy alejado del resultado inicial, teniendo en cuenta la magnitud de la perturbacion
b_pert <- b + 0.1
result <- solve(A, b_pert)

message("Perturbamos de nuevo los terminos independientes")
cat("Ahora dichos terminos independientes son: ", b_pert, "\n")
message("")
message("El resultado a ese sistema perturbado es:")
print(result)
message("")


# Calcula el número de condición de la matriz A del sistema anterior así como su recíproco.
# Realiza primero el cálculo con las funciones kappa y rcond y después comprueba que
# coinciden con su denición (kappa(A) como cociente entre máximo y mínimo autovalor
# en valor absoluto y rcond(A) como su inversa). Comenta el resultado.

# Empezamos usando las instrucciones de R para el calulo

# El valor es 3341.215
kappa_A <- kappa(A)

# El valor es 0.0002228164
rcond_A <- rcond(A)

message("Los valores de condicion computados usando R son:")
message("kappa: ", kappa_A)
message("rcond: ", rcond_A)
message("")

# Al tener un alto valor de kappa (y por tanto, un valor reciproco muy cercano a cero)
# podemos concluir que el sistema esta bastante mal condicionado

# Ahora computo estos valores a mano a partir de su definicion, empleando autovalores

# Empiezo tomando los autovalores
# Por consola veo que son todos positivos, asi que no tengo que aplicarles el valor absoluto
eigenvalues_A = eigen(A)$values

# Tomo el valor minimo y maximo
maxeigen <- max(eigenvalues_A)
mineigen <- min(eigenvalues_A)

# Computo el cociente
# Da: 2984.093
# La diferencia con el kappa de R puede ser que esta redondeando los valores maxeigen, mineigen
manually_computed_kappa = maxeigen / mineigen

# Vemos la diferencia en cociente entre los dos valores
# Da 1.119675. Esta diferencia es significativa pero puede atribuirse a problemas con punto flotante
# Aunque no podemos descartar que R este computando dicho valor aplicacando operaciones que alteren
# el resultado debido a distintos problemas de punto flotante
R_vs_manually_q <- kappa_A / manually_computed_kappa

# Ahora computamos el inverso
# Da 0.0003351102
manually_computed_rec <- 1.0 / manually_computed_kappa

# Volvemos a explorar el cociente
# Da 0.6649048, la diferencia es significativa
R_vs_manually_rec <- rcond_A / manually_computed_rec

message("Valores de condicion computados manualmente usando los eigenvalues:")
message("kappa: ", manually_computed_kappa)
message("rcond: ", manually_computed_rec)
message("")

message("Cocientes R / Manual")
message("kappa: ", R_vs_manually_q)
message("rcond: ", R_vs_manually_rec)
message("")

# Ejercicio 3
#===================================================================================================
message("EJERCICIO 3.2")
message("================================================================================")
message("")

# Utiliza el código que aparece a continuación de este cuadro para generar una muestra de
# observaciones de las variables Y y X de tamaño n = 5 de la forma siguiente: las obser-
# vaciones xi corresponden a valores aleatorios desde una distribución normal estándar; y
# las observaciones de yi se obtienen a partir de la ecuación del modelo yi = 1 + xi + ϵi ,
# donde ϵi son valores aleatorios generados desde una normal con media 0 y desviación
# típica 0.1. A partir de esos datos:

# Cargamos unos datos aleatorios
n<-5
set.seed(2)
x<-rnorm(n)
y<-1+x+rnorm(n,0,0.1)

message("Los datos aleatorios para realizar la regresion son:")
cat("Valores de x: ", x, "\n")
cat("Valores de y: ", y, "\n")
message("")

# Generamos los datos para resolver el sistema
X <- cbind(rep(1, n), x)

message("La matriz que vamos a usar para resolver la regresion es:")
print(X)
message("")

# Calculamos (X'X)⁻¹
pre_matrix <- solve(t(X)%*%X)

# Calculamos ahora los coeficientes
# El resultado es [1.0453963 0.9472755]
# Esta cercano a [1 0] que es el resultado esperado en ausencia de ruido
# El procedimiento de resolucion es estable, porque las perturbaciones no han alejado
# demasiado las soluciones de las esperadas
betta_hat <- pre_matrix %*% t(X) %*% y

cat("Los coeficientes de regresion obtenidos son: ", betta_hat, "\n")
message("")

# Representamos graficamente el modelo lineal
message("Mostrando graficamente la regresion")
message("")
curve(1+x,-3,3)
points(x, y)
curve(betta_hat[1] + betta_hat[2]*x, -3, 3, add = TRUE, col = 2 )

# Repetimos el proceso para n = 50
# Cargamos unos datos aleatorios
message("==> Repetimos el proceso para 50 puntos")
message("")

n<-50
set.seed(2)
x<-rnorm(n)
y<-1+x+rnorm(n,0,0.1)

# Generamos los datos para resolver el sistema
X <- cbind(rep(1, n), x)

# Calculamos (X'X)⁻¹
pre_matrix <- solve(t(X) %*% X)

# Calculamos ahora los coeficientes
# El resultado es [0.9872414 0.9957350], todavia mas cercano a [1 1]
betta_hat <- pre_matrix %*% t(X) %*% y

cat("Los coeficientes de regresion ahora son: ", betta_hat, "\n")
message("")

# Representamos graficamente el modelo lineal
message("Representando graficamente la regresion")
message("")

curve(1+x,-3,3)
points(x, y)
curve(betta_hat[1] + betta_hat[2]*x, -3, 3, add = TRUE, col = 2 )

# Repetimos el proceso para n = 500
# Cargamos unos datos aleatorios
message("==> Repetimos el proceso para 500 puntos")
message("")

n<-500
set.seed(2)
x<-rnorm(n)
y<-1+x+rnorm(n,0,0.1)

# Generamos los datos para resolver el sistema
X <- cbind(rep(1, n), x)

# Calculamos (X'X)⁻¹
pre_matrix <- solve(t(X)%*%X)

# Calculamos ahora los coeficientes
# El resultado es [1.0064546 0.9963676]
# Vemos, por tanto, que al aumentar el numero de datos aumenta la precision
# con la que nos acercamos a la solucion verdadera del modelo
betta_hat <- pre_matrix %*% t(X) %*% y

cat("Los coeficientes de regresion ahora son: ", betta_hat, "\n")
message("")

# Representamos graficamente el modelo lineal
message("Representando graficamente la regresion")
message("")

curve(1+x,-3,3)
points(x, y)
curve(betta_hat[1] + betta_hat[2]*x, -3, 3, add = TRUE, col = 2 )


# Qué problema(s) puede tener en la práctica este tipo de implementación directa?

# Que sea poco eficiente al no estar haciendo optimizaciones segun los datos con los que trabajemos
# en cada momento. Por ejemplo, en el siguiente ejecicio vemos la optimizacion usando QR
# Ademas, estas rutinas usan por debajo LAPACK que esta programado en FORTRAN, mucho mas rapido
# que R (que seria el lenguaje usado a la hora de nosotros realizar una implementacion)

# Ejercicio 3.3
#===================================================================================================
message("EJERCICIO 3.3")
message("================================================================================")
message("")

# Volvemos a generar los datos con 5 elementos
n<-5
set.seed(2)
x<-rnorm(n)
y<-1+x+rnorm(n,0,0.1)

message("Los datos aleatorios para realizar la regresion son:")
cat("Valores de x: ", x, "\n")
cat("Valores de y: ", y, "\n")
message("")

# Generamos la matriz para resolver el sistema
# Haremos la descomposicion QR de esta matriz
X <- cbind(rep(1, n), x)

message("La matriz que vamos a usar para resolver la regresion es:")
print(X)
message("")

# Empezamos computando la descomposicion QR
qr_descomp <- qr(X)
X.Q <- qr.Q(qr_descomp)
X.R <- qr.R(qr_descomp)

message("Desomponemos la matriz X usando QR")
message("")
message("La matriz Q es:")
print(X.Q)
message("")
message("La matriz R es:")
print(X.R)
message("")

# Calculamos la matriz intermedia Q'y
inter_matrix <- t(X.Q) %*% y
message("La matriz intermedia Q'y es:")
cat(inter_matrix, "\n")
message("")

# Solucionamos el sistema usando backsolve
result <- backsolve(X.R, inter_matrix)
message("El resultado obtenido usando esta descomposicion es:")
print(result)
message("")

# El resultado obtenido es el mismo que el que obtuvimos previamente
# Esto me hace pensar que R usa este proceso de descomposicion para computar las soluciones
