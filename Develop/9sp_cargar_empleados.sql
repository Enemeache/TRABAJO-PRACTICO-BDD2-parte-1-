DELIMITER $$

create procedure cargar_empleado(in num int)
begin
    
	select max(emp_legajo) into @max_id
    from empleado;
	
    set @cont = 0; 
    set @cont = @cont + @max_id + 1;
    set @target = @cont + num;
    
	while @cont < @target do

		set @nomyap = '';
            
		select concat(n1.nombre, ' ', n2.apellido) into @nomyap
		from nombres n1, nombres n2
		order by rand()
		limit 1;
        
        select edades into @edat
        from edad
        order by rand()
        limit 1;
            
		insert into empleado(emp_legajo, emp_nombre, emp_edad)
		values(@cont, @nomyap, @edat);
        
		set @cont = @cont + 1;
        
	end while;
    
end;
$$