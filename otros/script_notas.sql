
/*
 * SCRIPT DE CREACIÓN DE TABLAS.
 *
 * Script de creación de las tablas curso, cur_estudiante, acreditable,
 * convalidación y est_cur_estudiante para el sistema control de notas
 * del IUT-FRP (SisCoNot).
 * 
 * Fecha de Creación: 29 de noviembre de 2015.
 * 
 * Juan M. De Sousa - juanmdsousa@gmail.com
 */
Revisado por johan alamo el 9 de octubre de 2015

RESUMEN GENERAL
	No estaban todas las tablas que te correspondían.
	Parece que no fue hecho de manera cuidadosa sino apurada.
	Hay que prestarle atención a las llaves foráneas
	No se interpretó ni se tradujo bien lo que estaba en el MER (papel bond).



debes ordenar las tablas de modo que no de error al crearlas
faltaba la tabla est_periodo, y periodo, yo las agregué
falta la tabla electiva:

El orden de las tablas es el siguiente:
est_periodo
periodo
curso
est_cur_estudiante
cur_estudiante
electiva                 FALTA ESTA TABLA   (ELECTIVA)
acreditable
convalidacion

--Estado que determina si el periodo académico ha finalizado o no (abierto o cerrado)
create table sis.t_est_periodo (
	codigo char,
	nombre varchar(20) not null,
	constraint cp_est_periodo primary key(codigo)
);
alter table sis.t_est_periodo owner to sisconot;

Esta no estaba, yo la coloqué, colócale los comentarios
 
-- Tabla que almacena la información del período. instituto, pensum, fecha de inicio y fin
-- y el estado del período (abierto, cerrado)
create table sis.t_periodo (
	codigo integer, 
	nombre varchar(30),
	cod_departamento integer NOT NULL,
	cod_pensum integer NOT NULL,
	fec_inicio date not null,
	fec_final date not null,
	observaciones varchar(150),
	cod_estado char not null,  
	constraint cp_periodo primary key (codigo),
	constraint ca_periodo unique (cod_departamento, cod_pensum, fec_inicio),
	constraint fk_periodo__departamento foreign key (cod_departamento)
		references sis.t_departamento(codigo),
	constraint cf_periodo__pensum foreign key (cod_pensum)
		references sis.t_pensum(codigo),
	constraint cf_periodo__est_periodo foreign key(cod_estado)
		references sis.t_est_periodo(codigo),
	constraint chk_periodo_01 check (codigo > 0),
	constraint chk_periodo_02 check (fec_inicio < fec_final)
);
alter table sis.t_periodo owner to sisconot;

Esta tabla la coloqué yo porque no estaba en tu script
hacerle los siguientes cambios (ver las fotos de esta tabla en el MER)
* eliminar el campo cod_departamento y su clave foranea
* agregar el campo cod_instituto y suc clave foranea.
* fec_final no es not null, es decir, puede ser nulo. 
* cambiar la clave alternativa actual por: cod_insituto, cod_pensum, fec_inicio
* colocarle los comentarios a la tabla y a cada uno de los campos




/* SIS.T.EST_CURSO */

CREATE TABLE sis.t_curso(
	codigo serial,
	cod_periodo INTEGER NOT NULL,
	cod_uni_curricular INTEGER NOT NULL,
	cod_docente INTEGER,
	seccion VARCHAR(5) NOT NULL,
	fec_inicio DATE,
	fec_final DATE,
	capacidad SMALLINT,
	observaciones VARCHAR(300),
	CONSTRAINT cp_curso PRIMARY KEY(codigo),	
	CONSTRAINT cf_curso__periodo FOREIGN KEY(cod_periodo)
		references sis.t_periodo(codigo),
	CONSTRAINT cf_curso__uni_curricular FOREIGN KEY(cod_uni_curricular)
		references sis.t_uni_curricular(codigo),
	CONSTRAINT cf_curso__docente FOREIGN KEY(cod_docente)
		references sis.t_empleado(codigo),
	CONSTRAINT ca_curso_01 unique(cod_periodo,cod_uni_curricular,seccion),
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

alter table sis.t_curso owner to sisconot;

correcciones
la clave foránea de cod_docente no puede apuntar a t_empleado, debe ser a t_persona
acomodé los comentarios de los campos: codigo, fecha fin, capacidad


/* SIS.T_EST_CUR_ESTUDIANTE */

CREATE TABLE sis.t_est_cur_estudiante(
	codigo CHAR,
	nombre varCHAR(30),
	
	CONSTRAINT cp_est_cur_estudiante PRIMARY KEY(codigo)
);
COMMENT ON TABLE sis.t_est_cur_estudiante is 'Tabla que maneja los estados de un estudiante dentro de un curso.';

COMMENT ON COLUMN sis.t_est_cur_estudiante.codigo is 'Código del estado';
COMMENT ON COLUMN sis.t_est_cur_estudiante.nombre is 'Nombre del estado.';

correcciones
faltaba el largo del campo nombre, ya se lo coloqué


/* SIS.T_CUR_ESTUDIANTE */

create TABLE sis.t_cur_estudiante(
	codigo serial,
	cod_estudiante INTEGER NOT NULL,
	cod_curso INTEGER NOT NULL,
	por_asistencia FLOAT,
	nota float,
	cod_estado CHAR,
	observaciones VARCHAR(200),
	CONSTRAINT cp_cur_estudiante PRIMARY KEY(codigo),
	CONSTRAINT cf_cur_estudiante__estudiante FOREIGN KEY(cod_estudiante)
		references sis.t_estudiante(codigo),
	CONSTRAINT cf_cur_estudiante__curso FOREIGN KEY(cod_curso)
		references sis.t_curso(codigo),
	CONSTRAINT cf_cur_estudiante__est_cur_estudiante FOREIGN KEY(cod_estado)
		references sis.t_est_cur_estudiante(codigo),
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

correcciones
  la clave foranea cod_estudiante no debe apuntar a estudiante sino a t_persona. 
  observaciones no tenia longitud, le coloquè 200
  cambié nota a float
  falta clave alternativa cod_curso, cod_estudiante
  corregi los comentarios, codigo,

create table sis.t_electiva (
	FALTA ESTA TABLA...
)




/* SIS.T_CONVALIDACION */

create TABLE sis.t_convalidacion(
	codigo INTEGER,
	cod_estudiante INTEGER NOT NULL,
	cod_pensum INTEGER NOT NULL,
	cod_curso INTEGER NOT NULL,
	nota INTEGER,
	uc INTEGER,
	cod_uni_curricular INTEGER NOT NULL,
	CONSTRAINT cp_convalidacion PRIMARY KEY(codigo),
	CONSTRAINT cf_convalidacion__estudiante FOREIGN KEY(cod_estudiante)
		references sis.t_estudiante(codigo),
	CONSTRAINT cf_convalidacion__pensum FOREIGN KEY(cod_pensum)
		references sis.t_curso(codigo),
	CONSTRAINT cf_convalidacion__curso FOREIGN KEY(cod_curso)
		references sis.t_curso(codigo),
	CONSTRAINT cf_convalidacion__uni_curricular FOREIGN KEY(cod_uni_curricular)
		references sis.t_uni_curricular(codigo),
	CONSTRAINT chk_curso_01 CHECK (nota >= 0),
	CONSTRAINT chk_curso_02 CHECK (uc >= 0)
);
COMMENT ON TABLE sis.t_convalidacion is 'Tabla encargada de manejar las convalidaciones de un estudiante en un pensum.';

COMMENT ON COLUMN sis.t_convalidacion.codigo is 'Código de la convalidación.';
COMMENT ON COLUMN sis.t_convalidacion.cod_pensum is 'Código del pensum en el que se va a convalidar.';
COMMENT ON COLUMN sis.t_convalidacion.cod_curso is 'Código del curso que se va a convalidar.';
COMMENT ON COLUMN sis.t_convalidacion.nota is 'Nota con la que se convalidará (puede ser NULL o estar vacío)';
COMMENT ON COLUMN sis.t_convalidacion.uc is 'Unidades de Crédito que se convalidarán.';
COMMENT ON COLUMN sis.t_convalidacion.cod_uni_curricular is 'Código de la unidad curricular que se tomará como referencia.';

CORRECCIONES:
Cambié el tipo de datos del código a integer (en vez de serial)

DEBES REVISAR COMPLETA ESTA TABLA, ESTÁ MUY DIFERENTE A LA QUE ESTÁ EN EL PAPEL BOND...
     


/* SIS.T_ACREDITABLE */

create TABLE sis.t_acreditable(
	codigo serial,
	cod_estudiante INTEGER NOT NULL,
	cod_pensum INTEGER NOT NULL,
	cod_trayecto INTEGER,
	uni_credito INTEGER,	
	CONSTRAINT cp_acreditable PRIMARY KEY(codigo),
	CONSTRAINT cf_acreditable__estudiante FOREIGN KEY(cod_estudiante)
		references sis.t_estudiante(codigo),
	CONSTRAINT cf_acreditable__pensum FOREIGN KEY(cod_pensum)
		references sis.t_curso(codigo),		
	CONSTRAINT cf_acreditable__trayecto FOREIGN KEY(cod_trayecto)
		references sis.t_trayecto(codigo)
);
COMMENT ON TABLE sis.t_acreditable is 'Tabla que maneja las unidades de crédito acreditadas por un estudiante.';
COMMENT ON COLUMN sis.t_acreditable.codigo is 'Código de la acreditación.';
COMMENT ON COLUMN sis.t_acreditable.cod_estudiante is 'Código del estudiante que acreditó.';
COMMENT ON COLUMN sis.t_acreditable.cod_pensum is 'Código del pensum en el que acreditó.';
COMMENT ON COLUMN sis.t_acreditable.cod_trayecto is 'Código del trayecto en el que se formalizará la acreditación. Si este es null se tomará en cuenta para la carrera.';
COMMENT ON COLUMN sis.t_acreditable.uni_credito is 'Cantidad de unidades de crédito a acreditarse.';

CAMBIOS
CAMBIE EL TIPO DE DAOS DE codigo a integer (era serial)
la clave foranea debe apuntar a t_persona y no t_estudiante
la clave foranea cod_pensum debe apuntar a pensum y no a t_curso
falta restrincción de que uni_credito sea mayor o igual a cero
falta la fecha de la acreditación (campo "fecha")
falta el campo descripcion que debe ser NOT NULL de ancho doscientos
uni_credito es not null con restricción mayor o igual a cero
comentarios corregidos: cod_trayecto





