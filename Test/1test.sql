DELIMITER $$

create procedure cargar_empleado(in num int)
begin

	set @cont = 1;
	set @num_legajo = 1000;
        
	while @cont <= num do
    
		set @nomyap = '';
		set @num_legajo = @num_legajo + (@cont * 10);
            
		select concat(n1.nombre, ' ', n2.apellido) into @nomyap
		from nombres n1, nombres n2
		order by rand()
		limit 1;
            
		insert into empleado(emp_legajo, emp_nombre, emp_edad)
		values( @num_legajo, @nomyap, ( (@cont * 2) + 20) );
            
		set @cont = @cont + 1;
            
	end while;
    
end;

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
    
create procedure cargar_horas_semana(in emp_id int, in pro_id int, in rol_id int, in cli_id int, in horas int)
begin
	
	set @cont = 0;
	set @target = 6;
        
	select sum(hor_horas_dia) into @suma_horas
    from hora
    where emp_legajo = emp_id;
	
    if @sum_horas <= 310 then
    
		while @cont <= @target do
			
			set @fecha = DATE_ADD(SYSDATE(), INTERVAL +@cont DAY);
			
			if weekday(@fecha) != 6 then
        
				insert into hora(emp_legajo, pro_id_proyecto, rol_id_rol, cli_id_cliente, hor_fecha, hor_horas_dia)
				values (emp_id, pro_id, rol_id, cli_id, @fecha, horas);
				set @cont = @cont + 1;
			else
				set @cont = @cont + 1;
				set @target = @target +1;
			end if;
            
		end while;
	else
		select 'Excedio el limite maximo de horas por mes (310).' as Advertencia;
	end if;
    
end;

create procedure cargar_horas_mes(in emp_id int, in pro_id int, in rol_id int, in cli_id int, in horas int)
begin
	
	set @cont = 0;
	set @target = dayofmonth(last_day(sysdate()));
    
    select sum(hor_horas_dia) into @suma_horas
    from hora
    where emp_legajo = emp_id;
	
    if @sum_horas <= 310 then
    
		while @cont <= @target do
			
			set @fecha = DATE_ADD(SYSDATE(), INTERVAL +@cont DAY);
			
			if weekday(@fecha) != 6 then
        
				insert into hora(emp_legajo, pro_id_proyecto, rol_id_rol, cli_id_cliente, hor_fecha, hor_horas_dia)
				values (emp_id, pro_id, rol_id, cli_id, @fecha, horas);
				set @cont = @cont + 1;
			else
				set @cont = @cont + 1;
				set @target = @target +1;
			end if;
            
		end while;
	else
		select 'Excedio el limite maximo de horas por mes (310).' as Advertencia;
	end if;
    
end;

create procedure liquidacion_gastos_cliente(in id_cli int, in id_pro int, in mes int)
begin

	declare total int;

	declare gastos_cliente cursor for

	select sum(r.rol_paga_hora * h.hor_horas_dia)
	from rol r 
		inner join hora h on r.rol_id_rol = h.rol_id_rol
		where h.cli_id_cliente = id_cli and month(h.hor_fecha) = mes;

	declare continue handler for not found set @hecho = true;

	open gastos_cliente;

	loop1: loop

	fetch gastos_cliente into total;

	if @hecho then
		leave loop1;
	end if;

	end loop loop1;

	close gastos_cliente;
    
    insert into liquidaciones(cli_id_cliente, pro_id_proyecto, liq_fecha_consulta, liq_mes_target, liq_total)
    values(id_cli, id_pro, sysdate(), mes, total);
    
    create temporary table result(
		cli_id_cliente int,
		pro_id_proyecto int,
        liq_fecha_consulta datetime,
        liq_mes_target int,
        liq_total int);
	
	insert into result(cli_id_cliente, pro_id_proyecto, liq_fecha_consulta, liq_mes_target, liq_total)
    values(id_cli, id_pro, sysdate(), mes, total);
    
    select *
    from result;

end;

create procedure liquidacion_gastos_proyecto(in id_cli int, in id_pro int, in mes int)
begin

	declare total int;

	declare gastos_proyecto cursor for

	select sum(r.rol_paga_hora * h.hor_horas_dia)
	from rol r 
		inner join hora h on r.rol_id_rol = h.rol_id_rol
		where h.pro_id_proyecto = id_pro and month(h.hor_fecha) = mes;

	declare continue handler for not found set @hecho = true;

	open gastos_proyecto;

	loop1: loop

	fetch gastos_proyecto into total;

	if @hecho then
		leave loop1;
	end if;

	end loop loop1;

	close gastos_proyecto;

    insert into liquidaciones(cli_id_cliente, pro_id_proyecto, liq_fecha_consulta, liq_mes_target, liq_total)
    values(id_cli, id_pro, sysdate(), mes, total);
    
    create temporary table result(
		cli_id_cliente int,
		pro_id_proyecto int,
        liq_fecha_consulta datetime,
        liq_mes_target int,
        liq_total int);
	
	insert into result(cli_id_cliente, pro_id_proyecto, liq_fecha_consulta, liq_mes_target, liq_total)
    values(id_cli, id_pro, sysdate(), mes, total);
    
    select *
    from result;
    
end;

create procedure AjusteHorasCargadas(in emp_id int, in id_cli int, in pro_id int, in horas int, in mes varchar(2))
    begin
    
        update hora
        set hor_horas_dia = horas
        where emp_legajo = emp_id and month(hor_fecha) = mes and pro_id_proyecto = pro_id;
		
        call consulta_gastos_proyecto(id_cli, pro_id, mes);
        
    end;
	
create procedure RendicionDeHoras(in op int, in emp_id int, in pro_id int, in rol_id int, in cli_id int, in horas int)

	case
    when op = 1 then call cargar_horas_dia(emp_id, pro_id, rol_id, cli_id, horas);
	when op = 2 then call cargar_horas_semana(emp_id, pro_id, rol_id, cli_id, horas);
    when op = 3 then call cargar_horas_mes(emp_id, pro_id, rol_id, cli_id, horas);
    else select 'La opcion o alguno de los parametros no son validos';
    
end case;

create procedure CalcularLiquidacionMensual(in op int, in id_cli int, in id_pro int, in mes int)

	case
    when op = 1 then call liquidacion_gastos_cliente(id_cli, id_pro, mes);
	when op = 2 then call liquidacion_gastos_proyecto(id_cli, id_pro, mes);
    else select 'La opcion o alguno de los parametros no son validos';
    
end case;

call cargar_empleado(90);

select *
from empleado;

call RendicionDeHoras(1, 1010, 1, 1, 1, 8);
call RendicionDeHoras(1, 2010, 9, 5, 6, 7);
call RendicionDeHoras(1, 2510, 8, 4, 5, 6);
call RendicionDeHoras(1, 3010, 7, 3, 4, 5);
call RendicionDeHoras(1, 2020, 6, 2, 3, 4);
call RendicionDeHoras(1, 2310, 5, 1, 2, 3);

call RendicionDeHoras(2, 1010, 1, 1, 1, 3);
call RendicionDeHoras(2, 2010, 9, 5, 6, 4);
call RendicionDeHoras(2, 2510, 8, 4, 5, 5);
call RendicionDeHoras(2, 3010, 7, 3, 4, 6);
call RendicionDeHoras(2, 2020, 6, 2, 3, 7);
call RendicionDeHoras(2, 2310, 5, 1, 2, 8);

call RendicionDeHoras(3, 1010, 1, 1, 1, 2);
call RendicionDeHoras(3, 2010, 9, 5, 6, 4);
call RendicionDeHoras(3, 2510, 9, 4, 6, 6);
call RendicionDeHoras(3, 3010, 7, 3, 4, 8);
call RendicionDeHoras(3, 2020, 9, 2, 6, 5);
call RendicionDeHoras(3, 2310, 5, 1, 2, 3);

select *
from hora;

call CalcularLiquidacionMensual(1, 1, 1, 9); 
call CalcularLiquidacionMensual(1, 6, 9, 9);
call CalcularLiquidacionMensual(1, 4, 7, 9);
call CalcularLiquidacionMensual(1, 2, 5, 9);

call CalcularLiquidacionMensual(2, 1, 1, 9); 
call CalcularLiquidacionMensual(2, 6, 9, 9);
call CalcularLiquidacionMensual(2, 4, 7, 9);
call CalcularLiquidacionMensual(2, 2, 5, 9);

select *
from liquidaciones;

call AjusteHorasCargadas(2510, 6, 9, 5, 9);
call AjusteHorasCargadas(3010, 4, 7, 6, 9);
call AjusteHorasCargadas(2020, 6, 9, 7, 9);

select *
from liquidaciones;

$$