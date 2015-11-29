/*Script de creación de la base de datos del Sistema de Control de Notas
--Creado por Johan Alamo y estudiantes de proyecto sociotecnológico 
--Comenzado en 2012
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
select 'consulta para limpiar el buffer, no borrar.' as resultado;

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




--creación de la tabla unidad curricular
create table sis.t_uni_curricular (
	codigo integer,
	cod_uni_ministerio varchar(40),
	nombre varchar(60) not null,
	hta float not null,
	hti float,
	uni_credito smallint not null,
	dur_semanas smallint not null,
	not_min_aprobatoria smallint not null, 
	not_maxima smallint not null,
	descripcion varchar(100),
	observacion varchar(100),
	contenido text,
	constraint cp_uni_curricular primary key(codigo),
	constraint ca_uni_curricular unique (cod_uni_ministerio),
	constraint chk_uni_curricular_01 check (codigo > 0),
	constraint chk_uni_curricular_02 check (hta >= 0),
	constraint chk_uni_curricular_03 check (hti >= 0),
	constraint chk_uni_curricular_04 check (uni_credito >= 0),
	constraint chk_uni_curricular_05 check (dur_semanas >= 0),
	constraint chk_uni_curricular_06 check (not_min_aprobatoria >= 0),
	constraint chk_uni_curricular_07 check (not_maxima >= not_min_aprobatoria)
);
comment on table sis.t_uni_curricular is 'Tabla que almacena la información de las unidades curriculares';
comment on column sis.t_uni_curricular.codigo is 'Código único de la unidad curricular';
comment on column sis.t_uni_curricular.nombre is 'Nombre de la unidad curricular';
comment on column sis.t_uni_curricular.cod_uni_ministerio is 'Código de la unidad curricular según el ministerio';
comment on column sis.t_uni_curricular.uni_credito is 'Cantidad de unidades de crédito de la unidad curricular';
comment on column sis.t_uni_curricular.dur_semanas is 'Cantidad de semanas que dura la unidad curricular';
comment on column sis.t_uni_curricular.not_min_aprobatoria is 'Nota mínima con la que se aprueba la unidad curricular';
comment on column sis.t_uni_curricular.not_maxima is 'Nota máxima o escala de nota de la unidad curricular';
comment on column sis.t_uni_curricular.hta is 'Horas de Trabajo Acompañado por semana(horas de clase)';
comment on column sis.t_uni_curricular.hti is 'Horas de Trabajo Independiente por semana';
comment on column sis.t_uni_curricular.descripcion is 'descripcion adicional de la unidad curricular';
comment on column sis.t_uni_curricular.observacion is 'observaciones acerca de la unidad curricular';
comment on column sis.t_uni_curricular.contenido is 'contenido de la unidad curricular';
alter table sis.t_uni_curricular owner to sisconot;


-- creación de la tabla tipo de unidad curricular
create table sis.t_tip_uni_curricular(
	codigo char(1),
	nombre varchar(30) not null,
	constraint cp_uni_cur_tipo primary key(codigo)
);
comment on table  sis.t_tip_uni_curricular is 'Almacena los distintos tipos de unidades curriculares';
comment on column sis.t_tip_uni_curricular.codigo is 'Código del tipo de unidad curricular';
comment on column sis.t_tip_uni_curricular.nombre is 'Nombre del tipo de unidad curricular';
alter table sis.t_tip_uni_curricular owner to sisconot;


-- creación de la tabla t_instituto
create table sis.t_instituto(
	codigo smallint,
	nom_corto varchar(20) not null,
	nombre varchar(100) not null,
	direccion varchar(200),
	constraint cp_instituto primary key (codigo),
	constraint ca_instituto unique(nom_corto)
);
alter table sis.t_instituto owner to sisconot;
comment on table sis.t_instituto is 'Tabla que almacena la información básica de los institutos universitarios y/o universidades';
comment on column sis.t_instituto.codigo is 'Código del registro que identifica al instituto';
comment on column sis.t_instituto.nom_corto is 'Nombre corto del instituto, también es una llave alternativa';
comment on column sis.t_instituto.nombre is 'Nombre largo del instituto.';
comment on column sis.t_instituto.direccion is 'Ubicación geográfica del instituto';


-- creación de la tabla para almacenar las prelaciones entre unidades curriculares
create table sis.t_prelacion (
	codigo integer,
	cod_pensum integer not null,
	cod_instituto integer not null,
	cod_uni_curricular integer not null,
	cod_uni_cur_prelada integer not null,
	constraint cp_prelacion primary key (codigo),
	constraint ca_prelacion unique (cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada),
	constraint cf_prelacion__pensum foreign key (cod_pensum)
		references sis.t_pensum(codigo),
	constraint cf_prelacion__instituto foreign key (cod_instituto)
		references sis.t_instituto(codigo),
	constraint cf_prelacion__uni_curricular foreign key (cod_uni_curricular)
		references sis.t_uni_curricular(codigo),
	constraint cf_prelacion__uni_curricular_prelada foreign key (cod_uni_cur_prelada)
		references sis.t_uni_curricular(codigo)
);
comment on table sis.t_prelacion is 'Tabla que almacena las prelaciones entre unidades curriculares';
comment on column sis.t_prelacion.codigo is 'Código único de la prelación';
comment on column sis.t_prelacion.cod_pensum is 'Código del pensum al que pertenece la prelación';
comment on column sis.t_prelacion.cod_instituto is 'Código del instituto donde se está aplicando esta prelación';
comment on column sis.t_prelacion.cod_uni_curricular is 'Código de la unidad curricular a establecerle la prelación';
comment on column sis.t_prelacion.cod_uni_cur_prelada is 'Código de la unidad que no se puede cursar si no se ha aprobado esta';
alter table sis.t_prelacion owner to sisconot;

--creación de la tabla relacional para malla t_uni_tra_pensum
create table sis.t_uni_tra_pensum(
	codigo integer,
	cod_pensum integer not null,
	cod_trayecto integer,
	cod_uni_curricular integer not null,
	cod_tip_uni_curricular char(1) not null,
	constraint cp_uni_tra_pensum primary key (codigo),
	constraint cf_uni_tra_pensum__pensum foreign key(cod_pensum)
		references sis.t_pensum(codigo),
	constraint cf_uni_tra_pensum__trayecto foreign key(cod_trayecto)
		references sis.t_trayecto(codigo),
 	constraint cf_uni_tra_pensum__uni_curricular foreign key(cod_uni_curricular)
		references sis.t_uni_curricular(codigo),
	constraint cf_uni_tra_pensum__tip_uni_curricular foreign key(cod_tip_uni_curricular)
		references sis.t_tip_uni_curricular(codigo)
);
comment on table sis.t_uni_tra_pensum is 'Tabla que indica cuáles unidades curriculares forman parte de un pensum y/o trayecto';
comment on column sis.t_uni_tra_pensum.codigo is 'Código de la relación';
comment on column sis.t_uni_tra_pensum.cod_pensum is 'Código del pensum al que pertenece la unidad curricular';
comment on column sis.t_uni_tra_pensum.cod_trayecto is 'Código del trayecto al que pertence la unidad curricular';
comment on column sis.t_uni_tra_pensum.cod_uni_curricular is 'Código de la unidad curricular que pertenece al pensum indicado con cod_pensum';
comment on column sis.t_uni_tra_pensum.cod_tipo is 'Tipo de la unidad curricular';
alter table sis.t_uni_tra_pensum owner to sisconot;


--************************************ Subsistema de administración de personas ************************************


-- Tabla Archivo
create table sis.t_archivo(
	codigo integer, 
	tipo varchar(30), 
	archivo oid,
	constraint cp_archivo primary key(codigo)
);
alter table sis.t_archivo owner to sisconot;

comment on table sis.t_archivo is 'Tabla que almacena las fotos de las personas y/u otros tipos de archivos';
comment on column sis.t_archivo.codigo is 'Codigo unico con el que se identifica un archivo';
comment on column sis.t_archivo.tipo is 'Tipo de archivo';
comment on column sis.t_archivo.archivo is 'Es en donde va estar almacenada la imagen/archivo';

--tabla persona
create table sis.t_persona(
	codigo integer,
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
	constraint chk_persona_04 check (est_civil in ('S','C','D','V','O')),
	constraint chk_persona_05 check (hijos>=0)
);
alter table sis.t_persona owner to sisconot;

comment on table sis.t_persona is 'Tabla que almacena la informacion general de las personas';
comment on column sis.t_persona.codigo is 'Es el codigo único que solo pertecene a una persona';
comment on column sis.t_persona.cedula is 'Documento de identidad de la persona';
comment on column sis.t_persona.nombre1 is 'El primer nombre de la persona';
comment on column sis.t_persona.apellido1 is 'El primer apellido de la persona';
comment on column sis.t_persona.fec_nacimiento is 'Fecha de nacimiento de la persona';
comment on column sis.t_persona.tip_sangre is 'Es el tipo de sangre que tiene la persona';
comment on column sis.t_persona.telefono1 is 'Teléfono principal de la persona';
comment on column sis.t_persona.cor_personal is 'Correo electrónico personal';
comment on column sis.t_persona.direccion is 'Dirección de habitación de la persona';
comment on column sis.t_persona.discapacidad is 'Información sobre la discapacidad que tiene la persona';
comment on column sis.t_persona.nacionalidad is 'Es la nacionalidad de la persona, es decir, V=Venezolano o E=Extranjero';
comment on column sis.t_persona.hijos is 'Es la cantidad de hijos que tiene la persona';
comment on column sis.t_persona.est_civil is 'Es el estado civil que tiene la persona. C=Casado, D=Divorciado, S=Soltero, V=Viudo, O=Otro.';
comment on column sis.t_persona.observaciones is 'Alguna observación que se le haga a una persona';
comment on column sis.t_persona.cod_foto is 'Es la clave foranea de la tabla archivo que es en donde esta almacenada la fotografía de la persona';
comment on column sis.t_persona.sexo is 'Sexo de la persona. M=Masculino, F=Femenino';


--creacion de la tabla para el estado del docente: activo, retirado, jubilado... etc
create table sis.t_est_docente(
	codigo char not null,
	nombre varchar(40) not null,
	constraint cp_est_docente primary key(codigo)
);
alter table sis.t_est_docente owner to sisconot;

comment on table sis.t_est_docente is 'Tabla que almacena los distintos posibles estados de los docentes (Activo, Jubilado, Permiso, etc)';



--creación de la tabla empleado
create table sis.t_empleado(
	 codigo integer,
	 cod_persona integer not null,
	 cod_instituto integer,
	 cod_pensum integer,
	 cod_estado varchar(1),
	 fec_inicio date NOT NULL,
	 fec_fin date,
	 es_jef_pensum boolean not null default false,
	 es_jef_con_estudio boolean not null default false,
	 es_ministerio boolean not null default false,
	 es_docente boolean not null default false,
	 observaciones varchar(200),
	constraint cp_empleado primary key(codigo),
	constraint ca_empleado unique(cod_persona,cod_instituto,cod_pensum,fec_inicio),
	constraint cf_empleado__persona foreign key(cod_persona)
		references sis.t_persona(codigo),
	constraint cf_empleado__est_docente foreign key(cod_estado)
		references sis.t_est_docente(codigo),
	constraint cf_empleado__instituto foreign key(cod_instituto)
		references sis.t_instituto(codigo),
	constraint cf_empleado__pensum foreign key(cod_pensum)
		references sis.t_pensum(codigo),
	constraint chk_empleado_01 check (fec_fin>fec_inicio),
	constraint chk_empleado_02 check (fec_inicio>'1/1/1970')
);
alter table sis.t_empleado owner to sisconot;

comment on table sis.t_empleado is 'La tabla empleado almacena la informacion de los empledos';
comment on column sis.t_empleado.codigo is 'Es el codigo unico del registro, equivale a la llave alternativa cod_persona, cod_instituto, cod_pensum, fec_inicio';
comment on column sis.t_empleado.cod_persona is 'Codigo de la persona con la que esta relacionada';
comment on column sis.t_empleado.cod_instituto is 'Codigo del instituto al que pertenece';
comment on column sis.t_empleado.cod_pensum is 'Codigo del pensum a la que pertenece';
comment on column sis.t_empleado.cod_estado is 'Codigo del estado que posee el empleado';
comment on column sis.t_empleado.fec_inicio is 'Fecha en la que el empleado empezo a trabajar';
comment on column sis.t_empleado.fec_fin is 'Fecha en la que el empleado termino de trabajar';
comment on column sis.t_empleado.es_jef_pensum is 'Indica si el empleado es un jefe de pensum';
comment on column sis.t_empleado.es_jef_con_estudio is 'Indica si el empleado es jefe de control de estudio';
comment on column sis.t_empleado.es_ministerio is 'Indica si el empelado trabaja en el ministerio';
comment on column sis.t_empleado.es_docente is 'Indica si el empleado trabaja como docente';




--tabla para el manejo del estado de un estudiante: activo, retirado, graduado... etc 
create table sis.t_est_estudiante(
	codigo char not null,
	nombre varchar(20) not null,
	constraint cp_est_estudiante primary key(codigo)
);
alter table sis.t_est_estudiante owner to sisconot;

comment on table sis.t_est_estudiante is 'Almacena los distintos estados que puede tener un estudiante, ej: activo, retirado, etc';




--tabla estudiante
create table sis.t_estudiante(
	codigo integer,  
	cod_persona integer not null,
	cod_instituto integer not null,
	cod_pensum integer not null,
	num_carnet varchar(25),
	num_expediente varchar(25),
	cod_rusnies varchar(20),
	cod_estado char,
	fec_inicio date not null,
	condicion varchar(5),
	fec_fin date,
	observaciones varchar (200),
	constraint cp_estudiante primary key(codigo),
	constraint ca_estudiante_01 unique (cod_persona,cod_instituto,cod_pensum,fec_inicio),
	constraint cf_estudiante__persona foreign key(cod_persona)
		references sis.t_persona(codigo),
	constraint cf_estudiante__est_estado foreign key(cod_estado)
		references sis.t_est_estudiante(codigo), 
	constraint cf_estudiante__instituto foreign key(cod_instituto)
		references sis.t_instituto(codigo),
	constraint cf_estudiante__pensum foreign key(cod_pensum)
		references sis.t_pensum(codigo),
	constraint ca_estudiante_02 unique(num_carnet),
	constraint ca_estudiante_03 unique(num_expediente),
	constraint ca_estudiante_04 unique(cod_rusnies),
	constraint chk_docente_01 check (fec_fin>fec_inicio),
	constraint chk_docente_02 check (fec_inicio>'1/1/1970')
);
alter table sis.t_estudiante owner to sisconot;
comment on table sis.t_estudiante is 'La tabla estudiante almacena informacion sobre los estudiantes';
comment on column sis.t_estudiante.codigo is 'Codigo único del registro, equivale a cod_persona,cod_insituto,cod_pensum,fec_inicio';
comment on column sis.t_estudiante.cod_persona is 'Codigo de la persona con la que se relaciona';
comment on column sis.t_estudiante.cod_instituto is 'Codigo del instituto al que pertenece';
comment on column sis.t_estudiante.cod_pensum is 'Codigo del pensum al que pertenece el estudiante';
comment on column sis.t_estudiante.num_carnet is 'Numero del carnet del estudiante';
comment on column sis.t_estudiante.num_expediente is 'Numero del expediente del estudiante';
comment on column sis.t_estudiante.cod_rusnies is 'Codigo rusnies que tiene el estudiante';
comment on column sis.t_estudiante.cod_estado is 'Codigo del estado que posee el estudiante';
comment on column sis.t_estudiante.fec_inicio is 'Fecha en el que el estudiante empezo a estudiar';
comment on column sis.t_estudiante.condicion is 'Condicion con la que el estudiante entró al instituto y/o pensum';
comment on column sis.t_estudiante.fec_fin is 'Fecha en la que el estudiante dejo de estudiar';
comment on column sis.t_estudiante.observaciones is 'Observaciones sobre el estudiante';





--Estado que determina si el periodo académico ha finalizado o no (abierto o cerrado)
create table sis.t_est_periodo (
	codigo char,
	nombre varchar(20) NOT NULL,
	CONSTRAINT cp_est_periodo PRIMARY KEY(codigo)
);
COMMENT ON TABLE sis.t_est_periodo is 'Estado que determina si el periodo académico ha finalizado o no (abierto o cerrado)';
COMMENT ON COLUMN sis.t_est_periodo.codigo is 'Código del estado.';
COMMENT ON COLUMN sis.t_est_periodo.nombre is 'Nombre del estado del periodo académico.';
alter table sis.t_est_periodo owner to sisconot;


--tabla de que almacena la data de un periodo académico
create table sis.t_periodo (
	codigo INTEGER, 
	nombre varchar(30),
	cod_instituto INTEGER NOT NULL,
	cod_pensum INTEGER NOT NULL,
	fec_inicio DATE NOT NULL,
	fec_final DATE,
	observaciones varchar(150),
	cod_estado char NOT NULL,  
	CONSTRAINT cp_periodo PRIMARY KEY (codigo),
	CONSTRAINT ca_periodo UNIQUE (cod_instituto, cod_pensum, fec_inicio),
	CONSTRAINT cf_periodo__instituto foreign key (cod_instituto)
		REFERENCES sis.t_instituto(codigo),
	CONSTRAINT cf_periodo__pensum foreign key (cod_pensum)
		REFERENCES sis.t_pensum(codigo),
	CONSTRAINT cf_periodo__est_periodo foreign key(cod_estado)
		REFERENCES sis.t_est_periodo(codigo),
	CONSTRAINT chk_periodo_01 check (codigo > 0),
	CONSTRAINT chk_periodo_02 check (fec_inicio < fec_final)
);
COMMENT ON TABLE sis.t_periodo is 'Tabla que almacena la información de un periodo académico.';
COMMENT ON COLUMN sis.t_periodo.codigo is 'Código del periodo';
COMMENT ON COLUMN sis.t_periodo.nombre is 'Nombre del periodo académico';
COMMENT ON COLUMN sis.t_periodo.cod_instituto is 'Clave foránea del instituto que abre el periodo.';
COMMENT ON COLUMN sis.t_periodo.cod_pensum is 'Clave foránea del pensum que se dicta en el periodo.';
COMMENT ON COLUMN sis.t_periodo.fec_inicio is 'Fecha de inicio del periodo académico.';
COMMENT ON COLUMN sis.t_periodo.fec_final is 'Fecha de finalización del periodo académico.';
COMMENT ON COLUMN sis.t_periodo.observaciones is 'Observaciones del periodo académico.';
COMMENT ON COLUMN sis.t_periodo.cod_estado is 'Estado del periodo académico (Abierto o Cerrado en el momento de creación del sistema)';
alter table sis.t_periodo owner to sisconot;


--Secuencia para el código del registro de cada curso
CREATE SEQUENCE sis.s_curso
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER sequence  sis.s_curso OWNER TO sisconot;

CREATE TABLE sis.t_curso(
	codigo integer default nextval('sis.s_curso'),
	cod_periodo INTEGER NOT NULL,
	cod_uni_curricular INTEGER NOT NULL,
	cod_docente INTEGER,
	seccion VARCHAR(5) NOT NULL,
	fec_inicio DATE,
	fec_final DATE,
	capacidad SMALLINT,
	observaciones VARCHAR(300),
	cod_estado char,
	CONSTRAINT cp_curso PRIMARY KEY(codigo),	
	CONSTRAINT cf_curso__periodo FOREIGN KEY(cod_periodo)
		REFERENCES sis.t_periodo(codigo),
	CONSTRAINT cf_curso__uni_curricular FOREIGN KEY(cod_uni_curricular)
		REFERENCES sis.t_uni_curricular(codigo),
	CONSTRAINT cf_curso__docente FOREIGN KEY(cod_docente)
		REFERENCES sis.t_persona(codigo),
	CONSTRAINT ca_curso_01 UNIQUE(cod_periodo,cod_uni_curricular,seccion),
	CONSTRAINT chk_curso_01 CHECK (fec_inicio < fec_final),
	CONSTRAINT chk_curso_02 CHECK (capacidad >= 0),
	CONSTRAINT chk_curso_03 CHECK (length(trim(seccion))>0)
);
COMMENT ON TABLE sis.t_curso is 'Tabla encargada de manejar los cursos abiertos de una unidad curricular.';
COMMENT ON COLUMN sis.t_curso.codigo is 'Código del curso';
COMMENT ON COLUMN sis.t_curso.cod_periodo is 'Código del periodo al que pertenece el curso.';
COMMENT ON COLUMN sis.t_curso.cod_uni_curricular is 'Código de la unidad curricular que se dictará en el curso.';
COMMENT ON COLUMN sis.t_curso.cod_docente is 'Código del docente que dictará el curso.';
COMMENT ON COLUMN sis.t_curso.seccion is 'Sección a la que pertenece el curso.';
COMMENT ON COLUMN sis.t_curso.fec_inicio is 'Fecha de inicio del curso.';
COMMENT ON COLUMN sis.t_curso.fec_final is 'Fecha de finalización del curso.';
COMMENT ON COLUMN sis.t_curso.capacidad is 'Cantidad máxima de estudiantes que se pueden aceptar en el curso.';
COMMENT ON COLUMN sis.t_curso.observaciones is 'Observaciones del curso.';
COMMENT ON COLUMN sis.t_curso.cod_estado is 'Reservado para el estado del curso(abierto, cerrado).';
alter table sis.t_curso owner to sisconot;

CREATE TABLE sis.t_est_cur_estudiante(
	codigo char,
	nombre varchar(30),
	CONSTRAINT cp_est_cur_estudiante PRIMARY KEY(codigo)
);
COMMENT ON TABLE sis.t_est_cur_estudiante is 'Tabla que maneja los estados de un estudiante dentro de un curso.';
COMMENT ON COLUMN sis.t_est_cur_estudiante.codigo is 'Código del estado';
COMMENT ON COLUMN sis.t_est_cur_estudiante.nombre is 'Nombre del estado';
alter table sis.t_est_cur_estudiante owner to sisconot;

--Secuencia para el código del registro de cada estudiante dentro de un curso
CREATE SEQUENCE sis.s_cur_estudiante
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER sequence  sis.s_cur_estudiante OWNER TO sisconot;

create TABLE sis.t_cur_estudiante(
	codigo integer default nextval('sis.s_cur_estudiante'),
	cod_curso INTEGER NOT NULL,
	cod_estudiante INTEGER NOT NULL,
	por_asistencia FLOAT,
	nota float,
	cod_estado CHAR,
	observaciones VARCHAR(300),
	CONSTRAINT cp_cur_estudiante PRIMARY KEY(codigo),
	CONSTRAINT ca_cur_estudiante UNIQUE (cod_curso, cod_estudiante),
	CONSTRAINT cf_cur_estudiante__estudiante FOREIGN KEY(cod_estudiante)
		REFERENCES sis.t_persona(codigo),
	CONSTRAINT cf_cur_estudiante__curso FOREIGN KEY(cod_curso)
		REFERENCES sis.t_curso(codigo),
	CONSTRAINT cf_cur_estudiante__est_cur_estudiante FOREIGN KEY(cod_estado)
		REFERENCES sis.t_est_cur_estudiante(codigo),
	CONSTRAINT chk_cur_estudiante_01 CHECK (nota >= 0),
	CONSTRAINT chk_cur_estudiante_02 CHECK (por_asistencia >= 0)
);
COMMENT ON TABLE sis.t_cur_estudiante is 'Tabla encargada de manejar la información de un estudiante en un curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.codigo is 'Código único del registro, llave primaria';
COMMENT ON COLUMN sis.t_cur_estudiante.cod_estudiante is 'Código del estudiante al que se hace referencia.';
COMMENT ON COLUMN sis.t_cur_estudiante.cod_curso is 'Código del curso en el que está el estudiante.';
COMMENT ON COLUMN sis.t_cur_estudiante.por_asistencia is 'Porcentaje de asistencia del estudiante en el curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.nota is 'Nota del estudiante en el curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.cod_estado is 'Estado del estudiante en el curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.observaciones is 'Observaciones del estudiante en el curso.';
alter table sis.t_cur_estudiante owner to sisconot;


--tabla que almacena la correspondencia de las electivas vistas por un estudiante
--y las ata a un pensum/trayecto
create table sis.t_electiva (
	codigo integer,
	cod_cur_estudiante INTEGER,
	cod_pensum INTEGER not null,
	cod_trayecto INTEGER,
	CONSTRAINT cp_electiva PRIMARY KEY(codigo),
	CONSTRAINT ca_electiva UNIQUE (cod_cur_estudiante, cod_pensum), 
	CONSTRAINT cf_electiva__cur_estudiante FOREIGN KEY(cod_cur_estudiante)
		REFERENCES sis.t_cur_estudiante (codigo),
	CONSTRAINT cf_electiva__pensum FOREIGN KEY(cod_pensum)
		REFERENCES sis.t_pensum (codigo),
	CONSTRAINT cf_electiva__trayecto FOREIGN KEY(cod_trayecto)
		REFERENCES sis.t_trayecto (codigo)
);
COMMENT ON TABLE sis.t_electiva is 'Tabla encargada de manejar las electivas atadas a un estudiante.';
COMMENT ON COLUMN sis.t_electiva.codigo is 'Código único del registro, llave primaria';
COMMENT ON COLUMN sis.t_electiva.cod_cur_estudiante is 'Llave foránea de curso_estudiante, se refiere al curso que respalda la electiva';
COMMENT ON COLUMN sis.t_electiva.cod_pensum is 'Llave foránea del pensum al que pertenece la electiva.';
COMMENT ON COLUMN sis.t_electiva.cod_trayecto is 'Llave foránea del trayecto al que pertenece la electiva.';
alter table sis.t_electiva owner to sisconot;



create TABLE sis.t_acreditable(
	codigo integer,
	cod_estudiante INTEGER NOT NULL,
	cod_pensum INTEGER NOT NULL,
	cod_trayecto INTEGER,
	uni_credito INTEGER NOT NULL,
	fecha DATE,
	descripcion character varying(300) NOT NULL,
	CONSTRAINT cp_acreditable PRIMARY KEY(codigo),
	CONSTRAINT cf_acreditable__estudiante FOREIGN KEY(cod_estudiante)
		REFERENCES sis.t_persona (codigo),
	CONSTRAINT cf_acreditable__pensum FOREIGN KEY(cod_pensum)
		REFERENCES sis.t_pensum(codigo),		
	CONSTRAINT cf_acreditable__trayecto FOREIGN KEY(cod_trayecto)
		REFERENCES sis.t_trayecto(codigo),
	CONSTRAINT chk_acreditable_01 CHECK (uni_credito >= 0)
);
COMMENT ON TABLE sis.t_acreditable is 'Tabla que maneja las unidades de crédito acreditadas por un estudiante.';
COMMENT ON COLUMN sis.t_acreditable.codigo is 'Código de la acreditación.';
COMMENT ON COLUMN sis.t_acreditable.cod_estudiante is 'Código del estudiante que acreditó.';
COMMENT ON COLUMN sis.t_acreditable.cod_pensum is 'Código del pensum en el que acreditó.';
COMMENT ON COLUMN sis.t_acreditable.fecha is 'Fecha en la que se produjo la acreditación.';
COMMENT ON COLUMN sis.t_acreditable.cod_trayecto is 'Código del trayecto en el que se formalizará la acreditación. Si este es null se tomará en cuenta para la carrera.';
COMMENT ON COLUMN sis.t_acreditable.uni_credito is 'Cantidad de unidades de crédito a acreditarse.';
COMMENT ON COLUMN sis.t_acreditable.descripcion is 'Descripción obligatoria de la acreditación. Motivo de la misma.';
alter table sis.t_acreditable owner to sisconot;



create TABLE sis.t_convalidacion(
	codigo INTEGER,
	cod_estudiante INTEGER NOT NULL,
	con_nota BOOLEAN,
	nota FLOAT,
	cod_tip_uni_curricular CHAR,
	cod_pensum INTEGER NOT NULL,
	cod_trayecto INTEGER,
	cod_uni_curricular INTEGER NOT NULL,
	descripcion varchar(300),
	CONSTRAINT cp_convalidacion PRIMARY KEY(codigo),
	CONSTRAINT ca_convalidacion_01 UNIQUE(cod_estudiante,cod_pensum,cod_uni_curricular),
	CONSTRAINT cf_convalidacion__estudiante FOREIGN KEY(cod_estudiante)
		REFERENCES sis.t_estudiante(codigo),
	CONSTRAINT cf_convalidacion__pensum FOREIGN KEY(cod_pensum)
		REFERENCES sis.t_pensum(codigo),
	CONSTRAINT cf_convalidacion__trayecto FOREIGN KEY(cod_trayecto)
		REFERENCES sis.t_trayecto(codigo),
	CONSTRAINT cf_convalidacion__uni_curricular FOREIGN KEY(cod_uni_curricular)
		REFERENCES sis.t_uni_curricular(codigo),
	CONSTRAINT cf_convalidadcion__tip_uni_curricular FOREIGN KEY(cod_tip_uni_curricular)
		REFERENCES sis.t_tip_uni_curricular(codigo),
	CONSTRAINT chk_convalidacion_01 CHECK (nota >= 0)
);
COMMENT ON TABLE sis.t_convalidacion is 'Tabla encargada de manejar las convalidaciones de un estudiante en un pensum.';
COMMENT ON COLUMN sis.t_convalidacion.codigo is 'Código de la convalidación.';
COMMENT ON COLUMN sis.t_convalidacion.cod_estudiante is 'Código foráneo que indica el estudiante que convalidará.';
COMMENT ON COLUMN sis.t_convalidacion.con_nota is 'Boolean que indica si la convalidación lleva (o no) nota.';
COMMENT ON COLUMN sis.t_convalidacion.nota is 'Nota con la que se convalidará (puede ser NULL o estar vacío)';
COMMENT ON COLUMN sis.t_convalidacion.cod_tip_uni_curricular is 'Tipo de unidad curricular a validar';
COMMENT ON COLUMN sis.t_convalidacion.cod_pensum is 'Código del pensum en el que se va a convalidar.';
COMMENT ON COLUMN sis.t_convalidacion.cod_trayecto is 'Código del trayecto en el que se tomará la convalidación.';
COMMENT ON COLUMN sis.t_convalidacion.cod_uni_curricular is 'Código de la unidad curricular que se convalidará.';
COMMENT ON COLUMN sis.t_convalidacion.descripcion is 'Descripción de la convalidación (opcional)';
alter table sis.t_convalidacion owner to sisconot;

