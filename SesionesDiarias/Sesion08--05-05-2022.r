# Autor: Sergio Quijano Rey
# Fecha: 05.05.2022
#
# NOTA: como estamos mostrando mensajes por pantalla, lo recomendable es ejecutar o bien el script
# por lineas en un REPL o bien ejecutar todo el script usando `R --no-echo -f Sesion08--05-05-2022.r`
# para evitar que se muestren por pantalla tambien las lineas de codigo, haciendo que los mensajes
# por pantalla sean ilegibles

# Cargamos los datos
message("Cargando los datos")
message("")

# Hacemos as.is = NA para que todos los factores se identifiquen en el dataframe como tal
hatco <- read.csv("hatco2.csv", header = TRUE, as.is = NA)
message("Las primeras filas de los datos leidos son:")
print(head(hatco, 10))
message("")

message("La estructura de los datos leidos es:")
print(str(hatco))
message("")

# Representamos graficamente las variables con las que vamos a estar trabajando
# Nos interesa ver las correlaciones entre las variables
message("Mostrando graficamente las variables con las que trabajamos")
plot(hatco[,c(6:13)])
message("")

message("Podemos ver que la fidelidad (variable que queremos predecir en base a las otras) esta ligeramente correlada linealmente con:")
message("   - Velocidad")
message("   - Servconj")
message("   - Flexprec (ligeramente)")
message("")

message("Algunas variables explicativas parecen ser algo colineales:")
message("   - Imgfvent y Imgfabri")
message("   - Servconj y velocidad")
message("   - Servconj y precio (muy ligeramente)")
message("")

# Realizamos el ajuste lineal
mod1 <- lm(fidelidad~velocidad+precio+flexprec+imgfabri+servconj+imgfvent+calidadp, hatco)
message("El ajuste lineal realizado es:")
print(mod1)
message("")

# Miramos la bondad del ajuste
message("Bondad del ajuste realizado:")
print(summary(mod1))
message("")

# Realizamos el test ANOVA
anovares <- anova(mod1)
message("El resultado de hacer el test ANOVA es:")
print(anovares)
message("")

message("Usamos summary para ver si las percepciones son relevantes en la variable de salida:")
message("Viendo los p-valores que estan por debajo de 0.05, las unicas variables relevantes son (las que rechazan H0):")
message("- Flexprec")
message("- Servconj")
message("- Y ademas el parametro independiente \\beta_0")
message("")

message("A un nivel de significación del 1%")
message("- Intercept (\\beta_0) se rechaza pues su p-valor es 0.044 > 0.01")
message("")

# Estudiamos la homocedasticidad
message("ESTUDIAMOS LA HOMOCEDASTICIDAD")
message("==============================")
residuos <- rstandard(mod1)
predicciones <- mod1$fitted.values # Las predicciones ya nos las da el objeto devuelto por lm
message("")

message("Grafico de dispersion de los pares \\hat{y_i}, r_i:")
plot(predicciones, residuos)
message("")

message("Grafico de dispersion de los pares (x_{ij}, r_i)")
for(j in 6:13){
    plot(hatco[, j], residuos)
}
message("-> Todos estos graficos muestran nubes de puntos aleatorias")
message("-> Ademas, la dispersion parece uniforme, salvo en valores de la variable x_i donde tenemos pocos puntos")
message("")


# Estudiamos la incorrelacion
message("ESTUDIAMOS LA INCORRELACION")
message("==============================")
