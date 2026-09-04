# Instalar y cargar el paquete 'moments' para calcular asimetría y curtosis si no está instalado
if (!require(moments)) install.packages("moments")
library(moments)

# Seleccionar solo las variables numéricas del dataframe limpio (creado en el script anterior)
variables_numericas <- datos_limpios %>% 
  select(where(is.numeric))

# Calcular las tres familias de estadísticas para cada variable
estadisticas_descriptivas <- data.frame(
  Variable = names(variables_numericas),
  
  # 1. Medidas de Tendencia Central
  Media = sapply(variables_numericas, mean, na.rm = TRUE),
  Mediana = sapply(variables_numericas, median, na.rm = TRUE),
  
  # 2. Medidas de Dispersión
  Desviacion_Estandar = sapply(variables_numericas, sd, na.rm = TRUE),
  Varianza = sapply(variables_numericas, var, na.rm = TRUE),
  Rango_Intercuartil = sapply(variables_numericas, IQR, na.rm = TRUE),
  Minimo = sapply(variables_numericas, min, na.rm = TRUE),
  Maximo = sapply(variables_numericas, max, na.rm = TRUE),
  
  # 3. Medidas de Forma
  Asimetria = sapply(variables_numericas, skewness, na.rm = TRUE),
  Curtosis = sapply(variables_numericas, kurtosis, na.rm = TRUE)
)

# Limpiar los nombres de las filas para una mejor presentación
rownames(estadisticas_descriptivas) <- NULL

# Mostrar los resultados en la consola
cat("\n--- Estadísticas Descriptivas (Tendencia Central, Dispersión y Forma) ---\n")
print(estadisticas_descriptivas)

# Opcional: Guardar los resultados estadísticos en un nuevo archivo CSV
write_csv(estadisticas_descriptivas, "estadisticas_descriptivas.csv")
cat("\nEl resumen estadístico ha sido guardado en 'estadisticas_descriptivas.csv'\n")
