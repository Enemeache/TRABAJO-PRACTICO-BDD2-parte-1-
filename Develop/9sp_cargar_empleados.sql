DELIMITER $$

create procedure cargar_empleado(in num int)
begin

	set @cont = 1;
        
	while @cont <= num do
    		
		set @num_legajo = 1000;
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

$$