# Cargar las librerías necesarias
if (!require(dplyr)) install.packages("dplyr")
if (!require(readr)) install.packages("readr")
library(dplyr)
library(readr)

# 1. Importar el archivo CSV
datos <- read_csv("devops_metrics.csv", show_col_types = FALSE)

# 2. Limpieza y filtrado de datos
datos_limpios <- datos %>%
  # Convertir valores de texto corruptos a NA (ej. "Error_timeout" en build_time_min)
  mutate(build_time_min = suppressWarnings(as.numeric(build_time_min))) %>%
  
  # Eliminar datos incompletos (elimina cualquier fila que contenga valores NA)
  na.omit() %>%
  
  # Filtrar datos incoherentes (restringir a valores lógicamente posibles)
  filter(
    build_time_min >= 0,                     # El tiempo de compilación no puede ser negativo
    deploy_time_min >= 0,                    # El tiempo de despliegue no puede ser negativo
    num_bugs >= 0,                           # La cantidad de bugs no puede ser negativa
    test_coverage_pct >= 0,                  # La cobertura no puede ser menor a 0%
    test_coverage_pct <= 100,                # La cobertura no puede exceder el 100%
    ticket_resolution_h >= 0,                # El tiempo de resolución no puede ser negativo
    commit_size_loc > 0                      # Las líneas de código deben ser mayores a 0
  )

# 3. Guardar el archivo limpio en un nuevo CSV
write_csv(datos_limpios, "devops_metrics_limpio.csv")

# Mostrar un resumen de los datos resultantes en consola
summary(datos_limpios)
