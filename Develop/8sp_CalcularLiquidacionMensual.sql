DELIMITER $$

create procedure CalcularLiquidacionMensual(in op int, in id_cli int, in id_pro int, in mes int)

	case
    when op = 1 then call liquidacion_gastos_cliente(id_cli, id_pro, mes);
	when op = 2 then call liquidacion_gastos_proyecto(id_cli, id_pro, mes);
    else select 'La opcion o alguno de los parametros no son validos';
    
end case;

$$