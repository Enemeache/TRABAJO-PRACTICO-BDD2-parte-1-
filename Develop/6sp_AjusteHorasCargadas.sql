DELIMITER $$

create procedure AjusteHorasCargadas(in emp_id int, in id_cli int, in pro_id int, in horas int, in mes varchar(2))
    begin
    
        update hora
        set hor_horas_dia = horas
        where emp_legajo = emp_id and month(hor_fecha) = mes and pro_id_proyecto = pro_id;
		
        call consulta_gastos_proyecto(id_cli, pro_id, mes);
        
    end;
    
$$