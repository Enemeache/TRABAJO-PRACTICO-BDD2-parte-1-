
call cargar_empleado(90);

select *
from empleado;

call cargar_horas_dia(1, 1, 1, 2022, 1, 1, 1, 8);
call cargar_horas_dia(2, 1, 1, 2022, 9, 5, 2, 8);
call cargar_horas_dia(3, 1, 1, 2022, 8, 4, 3, 8);
call cargar_horas_dia(4, 1, 1, 2022, 9, 3, 2, 8);
call cargar_horas_dia(5, 1, 1, 2022, 6, 2, 5, 8);
call cargar_horas_dia(6, 1, 1, 2022, 8, 1, 3, 8);

call RendicionDeHoras(2, 1, 1, 1, 1, 8);
call RendicionDeHoras(2, 2, 9, 5, 2, 7);
call RendicionDeHoras(2, 3, 8, 4, 3, 6);
call RendicionDeHoras(2, 4, 9, 3, 2, 5);
call RendicionDeHoras(2, 5, 6, 2, 5, 4);
call RendicionDeHoras(2, 6, 8, 1, 3, 3);

call RendicionDeHoras(3, 1, 1, 1, 1, 8);
call RendicionDeHoras(3, 2, 9, 5, 2, 7);
call RendicionDeHoras(3, 3, 8, 4, 3, 6);
call RendicionDeHoras(3, 4, 9, 3, 2, 5);
call RendicionDeHoras(3, 5, 6, 2, 5, 4);
call RendicionDeHoras(3, 6, 8, 1, 3, 3);

select *
from hora;

call CalcularLiquidacionMensual(1, 1, 1, 9); 
call CalcularLiquidacionMensual(1, 2, 9, 9);
call CalcularLiquidacionMensual(1, 3, 8, 9);
call CalcularLiquidacionMensual(1, 5, 6, 9);

call CalcularLiquidacionMensual(2, 1, 1, 9); 
call CalcularLiquidacionMensual(2, 2, 9, 9);
call CalcularLiquidacionMensual(2, 3, 8, 9);
call CalcularLiquidacionMensual(2, 5, 6, 9);

select *
from liquidaciones;

call AjusteHorasCargadas(2, 2, 9, 5, 9);
call AjusteHorasCargadas(3, 3, 8, 6, 9);
call AjusteHorasCargadas(6, 3, 8, 7, 9);

select *
from liquidaciones;
