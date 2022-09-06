# TPBDD2 (Fase 1)

Se necesita implementar una aplicación de seguimiento de proyectos, focalizado en la gestión de las personas participantes del mismo.

Proponemos un modelo de datos para su debida administración y generamos puntos de acceso a través de una interfaz programática.


## Creación y carga de la base de datos

Ejecutar archivo " " en la carpeta " ".


## Uso

  1. Ejecutar archivo "DDL.sql" de la carpeta "DDL"
  2. Ejecutar archivo "1test.sql" de la carpeta "Test"


# Carga de empleados en base a opción (se deben especificar los parámetros de carga: Opción(1, 2 o 3), ID del empleado, ID del proyecto en el que carga las horas, ID del cliente al que debe rendirle las horas, ID del rol que cumplió en ese proyecto, cantidad de horas rendidas )

RendicionDeHoras(op int, emp_id, pro_id, cli_id, rol_id, cant_horas)

Opción 1: Carga de horas diaria
Opción 2: Carga de horas semanal
Opción 3: Carga de horas mensual

# Liquidación mensual de horas en base a opción (se deben especificar los parámetros de carga: Opción (1 o 2), ID del proyecto el cual se quiere liquidar, ID del cliente que desea liquidar, mes que se desea obtener la liquidación). La misma se guarda en la tabla liquidaciones.

LiquidacionMensual(op int, pro_id int, cli_id int, mes int)

Opción 1: Liquidación de hora por cliente
Opción 2: Liquidación de hora por proyecto

#Ajuste de horas cargadas en caso de falla a la hora de cargar datos(se deben especificar los parámetros de ajuste: ID del empleado que desea ajustar las horas, ID del proyecto donde hubo error de carga, mes en el cual ocurrió el error, cantidad de horas correcta). La misma guarda un nuevo registro en la tabla liquidaciones y muestra los resultados en el momento a través de una tabla temporal.

AjusteHorasMensual(emp_id int, pro_id int, mes int, cant_horas int)


## Participantes

. Félix Fernández Rolón
. Ignacio Montero Horianski
. Camila Matozza