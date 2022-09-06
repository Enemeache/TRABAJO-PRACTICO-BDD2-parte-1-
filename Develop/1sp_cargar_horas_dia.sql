DELIMITER $$

create procedure cargar_horas_dia(in emp_id int, in pro_id int, in rol_id int, in cli_id int, in horas int)
begin
	
    select sum(hor_horas_dia) into @suma_horas
    from hora
    where emp_legajo = 1010;
	
    if @sum_horas <= 310 then
    
		insert into hora(emp_legajo, pro_id_proyecto, rol_id_rol, cli_id_cliente, hor_fecha, hor_horas_dia)
		values (emp_id, pro_id, rol_id, cli_id, now(), horas);
	else
		select 'Excedio el limite maximo de horas por mes (310).' as Advertencia;
	end if;
		
end;

$$