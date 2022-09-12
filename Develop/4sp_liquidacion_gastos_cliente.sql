DELIMITER $$

create procedure liquidacion_gastos_cliente(in id_cli int, in id_pro int, in mes int)
begin

	select sum(r.rol_paga_hora * h.hor_horas_dia) into @total
	from rol r 
	inner join hora h on r.rol_id_rol = h.rol_id_rol
	where h.cli_id_cliente = id_cli and month(h.hor_fecha) = mes;

	insert into liquidaciones(cli_id_cliente, pro_id_proyecto, liq_fecha_consulta, liq_mes_target, liq_total)
    values(id_cli, id_pro, sysdate(), mes, @total);

end;

$$