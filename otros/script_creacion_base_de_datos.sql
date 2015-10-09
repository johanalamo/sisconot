/*Script de creación de la base de datos del Sistema de Control de Notas
--Creado por Johan Alamo y estudiantes de proyecto sociotecnológico 
--Comenzado en 2012
--Retomado en febrero de 2014
--Dpto de informática del IUT-RC "Dr. Federico Rivero Palacio"

Última versión
septiembre de 2015.
Participantes:
Tutor/coordinador: Johan Alamo  (johan.alamo@gmail.com)
Estudiantes participantes en la versión final:
	De Sousa, Juan
	García, Rafael
	Sosa, Jean Pierre

Participantes en versiones anteriores
	Castillo, Geraldine
	De Sousa, Juan
	Vielma, Jhonny
	Franco, Cesar
	García, Edson
*/

-- CREACION DE LA BASE DE DATOS   *********************************************
\connect postgres;

-- consulta para limpiar el buffer, no borrar.
select 'consulta para limpiar el buffer, no borrar.';

-- Borrar la base de datos en caso de existir
drop database  bd_sisconot;

drop user sisconot;
create user sisconot password '123';


-- Crear de nuevo la base de datos
CREATE DATABASE bd_sisconot WITH OWNER = sisconot ENCODING = 'UTF8' CONNECTION LIMIT = -1;

--cambia el formato de la fecha a Dia/mes/año para consulta e insercion
alter database bd_sisconot SET DateStyle to 'sql,dmy';


-- Conectarse a la nueva base de datos
\connect bd_sisconot;



--crear el esquema de las tablas del sistema  ****************************************************
create schema sis;

alter schema sis owner to sisconot;
grant usage on schema sis to sisconot;

alter schema public owner to sisconot;
grant usage on schema public to sisconot;





--***************************************  CREACIÓN DE TABLAS DE SUBSITEMA DE MALLAS CURRICULARES *********************************

--creación de la tabla pensum
create table sis.t_pensum(
	codigo integer,
	nombre varchar(50) not null,
	nom_corto varchar(20) not null,
	observaciones varchar(200),
	min_can_electiva smallint not null default 0, -- cantidadad de electivas
	min_cre_electiva smallint not null default 0,
	min_cre_obligatoria smallint not null default 0,
	fec_creacion date,
	constraint cp_pensum primary key (codigo),
	constraint ca_pensum unique(nom_corto),
 	constraint chk_t_pensum_01 check (min_can_electiva >= 0),
	constraint chk_t_pensum_02 check (min_cre_electiva >= 0),
	constraint chk_t_pensum_03 check (min_cre_obligatoria >= 0),
	constraint chk_t_pensum_04 check (fec_creacion >= '01/01/1950') 
);
comment on table sis.t_pensum is 'Tabla padre de un pensum';
comment on column sis.t_pensum.codigo is 'Código del pensum';
comment on column sis.t_pensum.nombre is 'Nombre largo del pensum';
comment on column sis.t_pensum.nom_corto is 'Abreviación del nombre del pensum';
comment on column sis.t_pensum.observaciones is 'Alguna otra información relevante del pensum';
comment on column sis.t_pensum.min_can_electiva is 'Mínima Cantidad de Electivas que se deben cursar en el pesum';
comment on column sis.t_pensum.min_cre_electiva is 'Mínima Cantidad de unidades de créditos que se deben cursar en el pensum en unidades electivas';
comment on column sis.t_pensum.min_cre_obligatoria is 'MInima Cantidad de Creditos que se deben cursar en el pensum en unidades obligatorios';
comment on column sis.t_pensum.fec_creacion is 'Fecha de creacion del pensum';
alter table sis.t_pensum owner to sisconot;



--creación de la tabla trayecto
create table sis.t_trayecto(
	codigo integer,
	cod_pensum integer not null,
	num_trayecto smallint not null,
	certificado varchar(150),
	min_cre_obligatoria smallint not null default 0,
	min_cre_electiva smallint not null default 0,
	min_cre_acreditable smallint not null default 0,
	min_can_electiva smallint not null default 0,
	constraint cp_trayecto primary key(codigo),
	constraint cf_trayecto_pensum foreign key (cod_pensum) 
		references sis.t_pensum(codigo),
	constraint ca_trayecto unique(num_trayecto,cod_pensum),
	constraint chk_t_trayecto_02 check (num_trayecto >= 0),
	constraint chk_t_trayecto_03 check (min_cre_obligatoria >= 0),
	constraint chk_t_trayecto_04 check (min_cre_electiva >= 0),
	constraint chk_t_trayecto_05 check (min_cre_acreditable >= 0),
	constraint chk_t_trayecto_06 check (min_can_electiva >= 0)	
);
comment on table sis.t_trayecto is 'Lista de trayectos, semestres o trimestres de un pensum';
comment on column sis.t_trayecto.codigo is 'Código único del trayecto';
comment on column sis.t_trayecto.cod_pensum is 'Código del pensum al que pertenece';
comment on column sis.t_trayecto.num_trayecto is 'Número de trayecto, año, semestre o trimestre del pensum';
comment on column sis.t_trayecto.certificado is 'Nombre del certificado que se obtiene al finalizar este trayecto';
comment on column sis.t_trayecto.min_cre_obligatoria is 'Mínima cantidad de créditos en unidades curriculares obligatorias que se deben cursar en este trayecto';
comment on column sis.t_trayecto.min_cre_electiva is 'Mínima cantidad de créditos en unidades curriculares electivas que se deben cursar en este trayecto';
comment on column sis.t_trayecto.min_cre_acreditable is 'Mínima cantidad de créditos en actividades acreditables que se deben tener en este trayecto';
comment on column sis.t_trayecto.min_can_electiva is 'Mínima cantidad de unidades electivas que se deben cursar en este trayecto';
alter table sis.t_trayecto owner to sisconot;

