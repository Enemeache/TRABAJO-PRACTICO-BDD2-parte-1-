DELIMITER $$

create procedure cargar_horas_dia(in emp_id int, in dia varchar(2), in mes varchar(2), in anio varchar(4), in pro_id int, in rol_id int, in cli_id int, in horas int)
begin

	set @suma_horas = 0;
		
	select sum(hor_horas_dia) into @suma_horas
	from hora
	where emp_legajo = emp_id and month(hor_fecha) = mes;
    
    if isnull(@suma_horas) then
		set @suma_horas = 0;
	end if;
	
    if @sum_horas <= 310 then
            
            select concat(anio, ', ', mes, ', ', dia, ', ', ' 00, 00, 00') into @concati;
            
            select str_to_date(@concati, '%Y, %m, %d, %H, %i, %S') into @fecha;
        
			insert into hora(emp_legajo, pro_id_proyecto, rol_id_rol, cli_id_cliente, hor_fecha, hor_horas_dia)
			values (emp_id, pro_id, rol_id, cli_id, @fecha, horas);
            
	end if;
		
end;

$$