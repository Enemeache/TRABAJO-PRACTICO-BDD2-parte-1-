DELIMITER $$

create procedure RendicionDeHoras(in op int, in emp_id int, in pro_id int, in rol_id int, in cli_id int, in horas int)
begin

	case
		when op = 2 then call cargar_horas_semana(emp_id, pro_id, rol_id, cli_id, horas);
		when op = 3 then call cargar_horas_mes(emp_id, pro_id, rol_id, cli_id, horas);
		else select 'La opcion o alguno de los parametros no son validos';
	end case;

end;

$$