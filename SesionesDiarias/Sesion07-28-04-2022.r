# Sesion 28/04/2022
# Sergio Quijano Rey
# sergioquijano@correo.ugr.es
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion07-28-04-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

message("Ejercicio 1")
message("================================================================================")

# Cargamos los datos
message("-> Carga de los datos ")
message("")
employees <- read.table("Employee.txt", header = TRUE, sep = " ", as.is = NA)

message("La estructura de los datos cargados es:")
print(str(employees))
message("")

# Ponemos nombres a los factores usando la instruccion within
employees <- within(employees, {
    gender <- factor(gender, labels = c("female", "male"))
})

message("La estructura de los datos tras cambiar el nombre del factor gender es:")
print(str(employees))
message("")

# Simplificamos el codigo haciendo un attach del dataframe
attach(employees)

# Mostramos un histograma basico del salario
message("Histograma basico del salario:")
hist(salary)
message("")

# Mostramos los metadatos del histograma
res<-hist(salary,plot=FALSE)
message("Los datos del histograma anterior son:")
print(res)
message("")

# Mostramos un histograma mas avanzado
message("Histograma mas avanzado:")
hist(salary,breaks=100)
x1 <-seq(15000,40000,by=5000)
x2 <-seq(50000,80000,by=10000)
x3 <-seq(100000,140000,by=20000)
hist(salary,breaks=c(x1,x2,x3))
message("")

# Histograma con distribucion superpuesta
message("Histograma con distribucion superpuesta")
hist(salary,breaks=c(x1,x2,x3))
lines(density(salary),col='blue')
message("")

# Sobre gráfico anterior dibuja también la función de densidad de una Normal cuya media
# y desviación típica sean las de los datos de salary. ¾Te parece que este podría ser un
# buen modelo de probabilidad para describir estos datos?
message("Histograma con distribucion normal superpuesta")
distribucion <- dnorm(salary, mean = mean(salary), sd = sd(salary))
hist(salary, breaks = c(x1, x2, x3))
curve(dnorm(x, mean = mean(salary), sd = sd(salary)), col = 'blue', add = TRUE)
message("")

# No parece un buen modelo. No se ajusta bien a los datos, como comprobamos visualmente.

message("Grafica qqnorm:")
qqnorm(salary)
message("")

message("Test de kolmogorov")
ks.test(salary,pnorm,mean=mean(salary),sd=sd(salary))
message("")

message("Test de Shapiro")
shapiro.test(salary)
message("")

message("Grafico boxplot")
boxplot(salary)
message("")

message("Resumen de la variable salary")
print(summary(salary))
message("")

message("Grafico combinado:")
hist(salary,probability=TRUE,main="",axes=FALSE)
axis(1)
lines(density(salary),col='red',lwd=2)
par(new=TRUE) ## Para que el próximo gráfico se superponga al anterior
boxplot(salary,horizontal=TRUE, axes=FALSE,lwd=2)
message("")

message("Graficos comparando salarios, generio, minorias y categoria de trabajo")
boxplot(salary~gender)
boxplot(salary~minority)
boxplot(salary~jobcat)
# A continuación salario con una doble clasificación
boxplot(salary~gender*jobcat)
message("Algunas conclusiones")
message("\tLos hombres comienzan con un salario mayor que las mujeres")
message("\tPersonas que no pertenecen a una minoria comienzan con un salario mayor que aquellas personas que si pertenecen")
message("\tManager es el puesto con mayor salario inicial, seguido por guarda de seguridad, y en ultimo lugar 'clerical'")
message("\tSigue siendo clara la brecha salarial por genero cuando separamos por genero y puesto de trabajo")
message("\tAdemas, vemos que no hay mujeres en el puesto 'custodial'")
message("")

# Realiza un análisis similar con las variables startsal y age.
message("Ahora comparamos startsal con las variables anteriores")
boxplot(startsal~gender)
boxplot(startsal~minority)
boxplot(startsal~jobcat)
boxplot(startsal~gender*jobcat)
message("")
boxplot(age~gender)
boxplot(age~minority)
boxplot(age~jobcat)
boxplot(age~gender*jobcat)
message("Algunas conclusiones")
message("\tLa mediana de edad de las mujeres es menor que la de los hombres, pero las mujeres presentan una mayor variedad en la edad")
message("\tLas personas que no pertenecen a una minoria presentan una mediana de edad mucho mas bajas que las que si pertenecen")
message("\tAdemas, la distribucion de las personas que pertenecen a una minoria es mucho mas simetrica")
message("\tLas personas 'custodial' son mayores que los otros dos puestos de trabajo")
message("\tLas mujeres manager son mas jovenes que los hombres manager, y con menos rango en la edad")
message("\tLas mujeres 'clerical' tienen una mediana de edad parecida a los hombres 'clerical', pero presentan muchisima mas variedad en la edad")
message("")

message("Diagrama de dispersion de sal y startsal")
plot(startsal,salary)
message("")

message("Regresion lineal entre salary y startsal")
mod<-lm(salary~startsal)
plot(startsal,salary)
abline(mod,col='blue')
message("Resultado de la regresion")
print(mod)
message("")

# Realiza un estudio similar que permita descubrir una posible relación entre: (i) las va-
# riables salary y age; y (ii) las variables salary y edu. ¾Qué puedes interpretar de los
# grácos?

message("Repetimos el estudio para salary y age")
mod<-lm(salary~age)
plot(age,salary)
abline(mod,col='blue')
message("Resultado de la regresion")
print(mod)
message("Conclusiones:")
message("\tCada año que pasa parece que se pierden ~200$")
message("\tSin embargo, no parece que haya mucha correlacion (por lo que muestra el grafico, no calculamos coeficientes)")
message("")

message("Repetimos el estudio para salary y educacion")
mod<-lm(salary~edu)
plot(edu,salary)
abline(mod,col='blue')
message("Resultado de la regresion")
print(mod)
message("Conclusiones:")
message("\tConforme aumenta el valor de la educacion, aumenta el salario notablemente")
message("\tEsto tiene logica si en los datos un mayor valor del factor 'edu' corresponde a una educacion mayor")
message("")

