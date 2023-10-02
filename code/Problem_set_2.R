## Rafael Sanchez 202123676 Maria Jose Medellin 202122960 Juan Camilo Bejarano 202121927
## R version 4.3.1 (2023-06-16 ucrt)
## Problem Set 2 


require(pacman) ## instalar/llamar pacman 
 
p_load(rio 
       ,data.table
       ,tidyverse) ## usar p_load para instalar/llamar librerias especificadas 

## IMPORTAR/EXPORTAR BASE DE DATOS 

## Importar
location= import(file="Input/Módulo de sitio o ubicación.dta") # importa base de datos 'Modulo de sitio' en objeto 'location'

identification=import(file = "Input/Módulo de identificación.dta") # importa base de datos 'Modulo de identificacion' en objeto 'identification'

## Exportar
export(x=location,"output/location.rds") # exporta objeto 'location' como 'location.rds'(formato R)

export(x=identification,"output/identification.rds") # exporta objeto 'identification' como 'identification.rds' (formato R)


##GENERAR VARIABLES

identification= mutate(identification, bussiness_type= case_when(GRUPOS4=="01"~"Agriculutra",
                                                                 GRUPOS4=="02"~"Industria manufacturera",
                                                                 GRUPOS4=="03"~"comercio",
                                                                 GRUPOS4=="04" ~"servicios")) # sobre el objeto 'identification' se crean las variables 'Agricultura', 'Industria manufacturera', 'comercio' y 'servicios'


location$local = ifelse(test=location$P3053==6|location$P3053==7 , yes=1, no =0) # del objeto 'location' genera variable 'local' que es igual a '1' si la variable P3053 es 6 o 7. De lo contrario es '0'.


##ELIMINAR FILAS/COLUMNAS DE UN CONJUNTO DE DATOS 

identification_sub= subset(x=identification, bussiness_type=="Industria manufacturera") # crea un subset con el conjunto de observaciones que pertenecen a la industria manufacturera.

location_sub= select(.data=location[1:length(location)], "DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P3054","P469", "COD_DEPTO","F_EXP") # del objeto 'location' selecciona variables y las guarda en nuevo objeto 'location_sub'.

vars=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P35","P241","P3032_1","P3032_2","P3032_3", "P3033","P3034") # vector con las variables de interes
identification_sub=select(.data=identification_sub[1:length(identification_sub)],all_of(vars)) # sobrescribe 'identification_sub' con las variables de interes


##COMBINAR BASE DE DATOS 
datos=merge(location_sub,identification_sub, by=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA")) # une en una unica base de datos para las variables de interes los objetos 'location_sub' y 'identification_sub'
