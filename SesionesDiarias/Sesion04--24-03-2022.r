# Sesion 24 Marzo 2022
# Sergio Quijano Rey
# sergioquijano@correo.ugr.es
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion01-03-03-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

# EJERCICIO 1
#===================================================================================================

message("Ejercicio 1")
message("================================================================================")
message("")

# a) Importa los datos en R dentro de un data frame con nombre censo usando
# la función read.table o read.csv (la que resulte más adecuada a este tipo
# de datos). Hazlo de modo que las columnas cellsource, travel, getlunch y
# gender se almacenen como tipo factor

message("a)")
message("")

# Leo los datos de un fichero
# Uso as.is para que las columnas que indico se lean como un factor
# Realmente con as.is indico las columnas que no quiero convertir a factor
file_name <- "Census.csv"
censo <- read.csv(file = file_name, header = TRUE, as.is = c(1, 3, 5, 7, 8, 9, 10) )

message("Tras leer los datos del fichero Census.csv obtenemos (head):")
print(head(censo))
message("")

# b ) Comprueba con una sola sentencia el tipo de datos de las columnas del data
# frame.

message("b)")
message("")

message("Los tipos de daos del dataframe son:")
print(lapply(censo, class))
message("")

# c ) Observa que en el data frame hay varios valores perdidos (NA). Cuenta cuántos
# valores perdidos hay en cada columna. [Sugerencia: Evalúa lapply(censo,is.na)
# y observa que te devuelve una lista con un vector lógico para cada columna,
# indicando con TRUE en qué la hay un dato perdido. Con esta resultado ya
# tienes casi la solución al problema.]

message("c)")
message("")

# Tomamos una lista logica que indican si es NA o no
na_values <- lapply(censo, is.na)

# Uso dicha lista para sumar valores
# Uso sapply porque se imprime de forma mas compacta el resultado
na_values_count <- sapply(na_values, sum)

message("El numero de valores NA por columnas es:")
print(na_values_count)
message("")

# d ) Cuenta cuántas celdas del data frame están completas, esto es, no tienen nin-
# gún datos perdido (NA), utilizando la función complete.cases.[sugerencia: Co-
# mienza evaluando complete.cases(censo) y observa que como resultado te
# devuelve un vector lógico indicando con TRUE las las completas (sin ningún
# NA). Con este resultado ya casi lo tienes.]

message("d)")
message("")

# Tomamos con complete.cases las filas que estan completas (sin NA)
filas_completas <- complete.cases(censo)

# Usamos esto para realizar el conteo
numero_filas_completas <- sum(filas_completas)

message("Tenemos ", numero_filas_completas, " filas completas en el censo")
message("")

# e ) Crea un nuevo data frame con nombre censo2 copiando en él tan solo las
# las de censo que estén completas. Resuelve esta tarea de dos formas, primero
# con la misma función complete.cases que usaste antes, y después usando la
# función na.omit (consulta la ayuda de esta última función para ver qué hace
# y cómo se usa).

message("e)")
message("")

# Empezamos usando el resultado de complete.cases
censo2 <- censo[filas_completas, ]

message("Usando complete.cases")
message("Numero de filas del dataframe original: ", nrow(censo))
message("Numero de filas del dataframe nuevo: ", nrow(censo2))
message("")

# Ahora lo hacemos usando na.omit
censo2 <- na.omit(censo)
message("Usando na.omit")
message("Numero de filas del dataframe original: ", nrow(censo))
message("Numero de filas del dataframe nuevo: ", nrow(censo2))
message("")

# f ) Escribe el contenido del data frame censo2 en un chero de texto con nom-
# bre censo2.txt con la función write.table. En el chero los nombres de las
# columnas deben aparecer en la primera la, los valores deben estar separados
# por tabulaciones (sep='\t') y no debe contener nombres para las las.

message("f)")
message("")

new_file_name <- "censo2.txt"
write.table(censo2, file = new_file_name, col.names = TRUE, row.names = FALSE, sep = "\t")

# g ) Importa los datos del chero censo2.txt que has creado antes en un data frame
# con nombre datos3. Este data frame debe coincidir en estructura y composición
# con datos2, compruébalo.

message("g)")
message("")

censo3 <- read.table(file = new_file_name, header = TRUE, sep = "\t", as.is = c(1, 3, 5, 7, 8, 9, 10))

message("El dataframe leido es (head):")
print(head(censo3))
message("")

message("La estructura del dataframe original es:")
print(str(censo2))
message("")

message("La estructura del dataframe nuevo es:")
print(str(censo3))
message("")

numero_filas_distintas <- sum(censo2 != censo3)
message("El numero de filas distintas entre los dos dataframes es ", numero_filas_distintas)
message("")

# EJERCICIO 2
#===================================================================================================

message("Ejercicio 2")
message("================================================================================")
message("")

# Como usamos valores aleatorios, establecemos la semilla
set.seed(4)

# Dimensiones de la futura matriz
numero_filas <- 10
numero_columnas <- 5

# Creo un numero necesario de valores aleatorios desde la normal
matriz <- rnorm(numero_filas * numero_columnas)
dim(matriz) <- c(numero_filas, numero_columnas)

message("La matriz generada es:")
print(matriz)
message("")

# a) Asigna nombres a las columnas de la matriz del tipo col1,...col5.

message("a)")
message("")

# Asignamos el nombre a las columnas con colnames y pas te para la generacion de nombres
colnames(matriz) <- paste("col", 1:5)

message("Tras darle nombre a las columnas, la matriz queda: ")
print(matriz)
message("")

# b ) Imprime la matriz anterior en un chero de texto matriz.txt usando la función
# write y separando los valores por comas. En la primera la deben imprimirse
# los nombres de las columnas.

message("b)")
message("")

# Por defecto, el write utiliza 5 columnas asi que no tenemos que preocuparnos de especificar este valor
matriz_file <- "matriz.txt"
write.table(matriz, file = matriz_file, sep = ",", col.names = TRUE, row.names = FALSE)

# c ) Lee el chero que has escrito y almacena su información en el espacio de trabajo
# en forma de data frame. Ten en cuenta que los nombres de las columnas del
# data frame deben tomarse de la primera la del chero.

message("c)")
message("")

datos_matriz <- read.csv(matriz_file, header = TRUE)

message("Tras leer los datos del fichero, el dataframe queda:")
print(datos_matriz)
message("")

# EJERCICIO 3
#===================================================================================================

message("Ejercicio 3")
message("================================================================================")
message("")

file_name <- "Olympics100m.csv"

# a) Importa los datos en R dentro de un data frame con nombre olimpics. Hazlo
# de modo que las columnas que correspondan a factores se almacenen con ese
# tipo.

message("a)")
message("")

# Las tres primeras columnas las queremos dejar sin modificar
olimpics <- read.csv(file_name, header = TRUE, as.is = 1:3)

message("Tras leer los datos, el dataframe queda (head):")
print(head(olimpics))
message("")

message("La estructura del dataframe es:")
print(str(olimpics))
message("")

# b ) Comprueba con una función adecuada si hay algún dato perdido, contando
# cuántos hay en dicho caso.

message("b)")
message("")

# Cuento el numero de filas que tienen algun NA
filas_completas <- complete.cases(olimpics)
numero_filas_con_na <- sum(!filas_completas)

message("El numero de filas con algun NA es: ", numero_filas_con_na)
message("")

# c ) Calcula un resumen descriptivo con summary del data frame. Almacena el va-
# lor devuelto en un objeto resumen, comprueba que se trata de una matriz de
# tipo carácter. Después imprime dicho objeto en un chero de tipo texto (resu-
# men.txt ). Hazlo de forma que puedas leerlo después con read.table y cargarlo
# en formato de data frame.

message("c)")
message("")

resumen <- summary(olimpics)

message("El resumen del dataframe es:")
print(resumen)
message("")

message("El tipo de dato del resumen es (class):")
print(class(resumen))
message("")

message("El tipo de dato del resumen es (typeof):")
print(typeof(resumen))
message("")

# Cargamos el dato en un fichero
write.table(resumen, file = "resumen.txt", sep = " ", row.names = FALSE, col.names = TRUE)

# d ) Calcula un resumen descriptivo ahora solo de la variable TIME para los dis-
# tintos niveles del factor Gender. Hazlo de modo que el objeto resultante sea
# un único data frame. Después imprime dicho data frame en un chero de tipo
# texto (resumen2.txt ). Hazlo de forma que puedas leerlo después con read.csv,
# resultando un data frame conteniendo columnas con los resúmenes descriptivos
# (mínimo, primer cuartil, mediana, etc.) para cada grupo en formato numérico.

message("d)")
message("")

# Usamos la funcion aggregate para aplicar la funcion summary segun los valores de un factor
# Usamos aggregate y no tapply porque queremos la salida en un dataframe y no en una lista
custom_summary <- aggregate(olimpics$TIME, list(olimpics$Gender), summary)

message("El resumen de los tiempos segun el genero es:")
print(custom_summary)
message("")

# Guardamos este resumen en un fichero de texto
file_name <- "resumen2.txt"
write.csv(custom_summary, file = file_name, row.names = FALSE)
