## Rafael Sanchez 202123676 Maria Jose Medellin 202122960 Juan Camilo Bejarano 202121927
## R version 4.31
## Problem Set 2 
require(pacman) ## se llama a la biblioteca pacman 
p_load(rio,data.table,tidyverse) ## se usa p load para llamar a las librerias especificadas 

## Importar exportar bases de datos 
location= import(file="Input/Módulo de sitio o ubicación.dta")
identification=import(file = "Input/Módulo de identificación.dta")

## Exportar
export(x=location,"output/location.rds")
export(x=identification,"output/identification.rds")

##Generar variables 
identification= mutate(identification, bussiness_type= case_when(GRUPOS4=="01"~"Agriculutra",
                                                                 GRUPOS4=="02"~"Industria manufacturera",
                                                                 GRUPOS4=="03"~"comercio",
                                                                 GRUPOS4=="04" ~"servicios"))


location$local = ifelse(test=location$P3053==6|location$P3053==7 , yes=1, no =0) 


##Eliminar filas columnas de un conjunto de datos 

identification_sub= subset(x=identification, bussiness_type=="Industria manufacturera")

location_sub= select(.data=location[1:length(location)], "DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P3054","P469", "COD_DEPTO","F_EXP") 

vars=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P35","P241","P3032_1","P3032_2","P3032_3", "P3033","P3034")
identification_sub=select(.data=identification_sub[1:length(identification_sub)],all_of(vars))

## Juntar base de datos 

datos=bind_rows (identification_sub,location_sub, .DIRECTORIO="a" ) 
