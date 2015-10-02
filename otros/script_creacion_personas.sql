


--Tabla instituto                             AQUI
create table sis.t_instituto(
	codigo smallint,
	nom_corto varchar(20) not null,
	nombre varchar(100) not null,
	direccion varchar(200),
	constraint cp_instituto primary key (codigo),
	constraint ca_instituto unique(nom_corto)
);
--alter table sis.t_instituo owner to usuarioscn;



--tabla persona, padre de t_estudiante y t_empleado
create table sis.t_persona(
	codigo integer not null,
	cedula integer not null,
	rif varchar(20),
	nombre1 varchar(20) not null,
	nombre2 varchar(20),
	apellido1 varchar(20) not null,
	apellido2 varchar(20),
	sexo varchar(1) not null,
	fec_nacimiento date,
	tip_sangre varchar(5),
	telefono1 varchar(15),
	telefono2 varchar(15),
	cor_personal varchar(50),
	cor_institucional varchar(50),
	direccion varchar(150),
	discapacidad varchar(50),
	nacionalidad varchar(1),
	hijos integer,
	est_civil varchar(1),
	observaciones varchar(200),
	cod_foto integer,
	constraint cp_persona primary key(codigo),
	constraint cf_persona__archivo foreign key(cod_foto)
		references sis.t_archivo(codigo),
	constraint ca_persona_01 unique(cedula),
	constraint ca_persona_02 unique(rif),
	constraint ca_persona_03 unique(cor_personal),
	constraint ca_persona_04 unique (cor_institucional),
	constraint chk_persona_01 check (fec_nacimiento>='01/01/1940' and fec_nacimiento<= current_date),
	constraint chk_persona_02 check (sexo in ('M','F')),
	constraint chk_persona_03 check (nacionalidad in ('V','E')),
	constraint chk_persona_04 check (est_civil in ('S','C','D','V','O'))
);
--alter table sis.t_persona owner to usuarioscn;


--creacion de la tabla para el estado del docente: activo, retirado, jubilado... etc
create table sis.t_est_docente(
	codigo char not null,
	nombre varchar(40) not null,
	constraint cp_est_docente primary key(codigo)
);
--alter table sis.t_est_docente owner to usuarioscn;


--creación de la tabla empleado (hija de persona)
create table sis.t_empleado(
	 codigo integer,
	 cod_persona integer not null,
	 cod_instituto integer,
	 cod_pensum integer,
	 cod_estado varchar(1),
	 fec_inicio date NOT NULL,
	 fec_fin date,
	 es_jef_pensum boolean not null,
	 es_jec_con_estudio boolean not null,
	 es_ministerio boolean not null,
	 es_docente boolean not null,
	 observaciones varchar(200),
	constraint cp_empleado primary key(codigo),
	constraint cf_empleado__persona foreign key(cod_persona)
		references sis.t_persona(codigo),
	constraint cf_empleado__est_docente foreign key(cod_estado)
		references sis.t_est_docente(codigo),
	constraint cf_empleado__instituto foreign key(cod_instituto)
		references sis.t_instituto(codigo),
	constraint cf_empleado__pensum foreign key(cod_pensum)
		references sis.t_pensum(codigo),
	constraint chk_empleado_01 check (fec_fin>fec_inicio)	
);
--alter table sis.t_empleado owner to usuarioscn;

--tabla para el manejo del estado de un estudiante: activo, retirado, graduado... etc 
create table sis.t_est_estudiante(
	codigo char not null,
	nombre varchar(20) not null,
	constraint cp_est_estudiante primary key(codigo)
);
--alter table sis.t_est_estudiante owner to usuarioscn;

--tabla estudiante (hija de persona)
create table sis.t_estudiante(
	codigo integer,  
	cod_persona integer not null,
	cod_instituto integer not null,
	cod_pensum integer not null,
	num_carnet varchar(25),
	num_expediente varchar(25),
	cod_rusnies varchar(20),
	cod_estado char,
	fec_inicio date not ,
	condicion varchar(5),
	fec_fin date,
	observaciones varchar (200),
	constraint cp_estudiante primary key(codigo),
	constraint cf_estudiante__persona foreign key(cod_persona)
		references sis.t_persona(codigo),
	constraint cf_estudiante__est_estado foreign key(cod_estado)
		references sis.t_est_estudiante(codigo), 
	constraint cf_estudiante__instituto foreign key(cod_instituto)
		references sis.t_instituto(codigo),
	constraint cf_estudiante__pensum foreign key(cod_pensum)
		references sis.t_pensum(codigo),
	constraint ca_estudiante_01 unique(num_carnet),
	constraint ca_estudiante_02 unique(num_expediente),
	constraint ca_estudiante_03 unique(cod_rusnies),
	constraint chk_docente_01 check (fec_fin>fec_inicio)
);
--alter table sis.t_estudiante owner to usuarioscn;


create table sis.t_archivo(
	codigo integer not null,
	tipo varchar(30),
	archivo oid,
	constraint cp_archivo primary key(codigo)
);


