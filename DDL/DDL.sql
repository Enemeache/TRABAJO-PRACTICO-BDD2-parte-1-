create database tpbdd2;
use tpbdd2;

create table empleado(
	emp_legajo int not null primary key,
    emp_nombre varchar(255),
    emp_edad int
);


create table proyecto(
	pro_id_proyecto int not null primary key,
    pro_nombre varchar(255),
    pro_descripcion varchar(255)
);


create table rol(
	rol_id_rol int not null primary key auto_increment,
    rol_descripcion varchar(255),
    rol_paga_hora int not null
);


create table cliente(
	cli_id_cliente int not null primary key,
    cli_nombre varchar(255),
    cli_costo_dia int null
);
alter table cliente drop column cli_costo_dia; 


create table hora(
	hor_log int auto_increment primary key,
	emp_legajo int not null,
    pro_id_proyecto int not null,
    rol_id_rol int not null,
    cli_id_cliente int not null,
    hor_fecha datetime not null,
    hor_horas_dia int not null
);
alter table hora
add foreign key (emp_legajo) references empleado(emp_legajo),
add foreign key (pro_id_proyecto) references proyecto(pro_id_proyecto),
add foreign key (rol_id_rol) references rol(rol_id_rol),
add foreign key (cli_id_cliente) references cliente(cli_id_cliente);


create table liquidaciones(
	liq_log int auto_increment primary key,
    cli_id_cliente int not null,
    pro_id_proyecto int not null,
    liq_fecha_consulta datetime not null,
    liq_mes_target int not null,
    liq_total int not null
);
alter table liquidaciones
add foreign key (cli_id_cliente) references cliente(cli_id_cliente),
add foreign key (pro_id_proyecto) references proyecto(pro_id_proyecto);


create table nombres(
	nombre varchar(255),
    apellido varchar(255)
);


insert into rol(rol_id_rol, rol_descripcion, rol_paga_hora)
values(1, 'Project Manager', '1000'),
	(2, 'Tester', '1500'),
	(3, 'Desarollador', '2000'),
	(4, 'Administrador', '2500'),
	(5, 'Devops', '3000');

insert into proyecto(pro_id_proyecto, pro_nombre, pro_descripcion)
values(1, 'Gotica','Aplicacion movil para gestion del tiempo'),
	(2, 'Stylo', 'Aplicacion movil para compartir fotos'),
	(3, 'Devermut', 'Aplicacion movil de red social'),
	(4, 'Luzu', 'Pagina web de viajes'),
	(5, 'Crash', 'Videojuego en linea'),
	(6, 'Gambok','Biblioteca online'),
	(7, 'Dakota', 'Software de liquidacion de sueldos'),
	(8, 'Titech', 'Tienda de ropa online'),
	(9, 'Peppers', 'Aplicacion para alquiler de autos');
    
insert into cliente(cli_id_cliente, cli_nombre)
values (1, 'Francisco Walker'),
	(2, 'Oliver Abbey'),
	(3, 'Thomas Harrison'),
	(4, 'George lennox'),
	(5, 'Oscar Miller'),
	(6, 'Charlie Campbell');

insert into nombres(nombre, apellido)
values('James', 'Burnett'),
	('Joseph', 'Henry'),
	('Kendra', 'Thompson'),
	('Luis', 'Dorsey'),
	('Lawrence', 'Mueller'),
	('Jack', 'Jones'),
	('Justin', 'Wilson'),
	('Joseph', 'Taylor'),
	('Ronald', 'Smith'),
	('Joshua', 'Winters');