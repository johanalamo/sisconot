

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
COMMENT ON COLUMN sis.t_convalidacion.cod_tipo is 'Tipo de unidad curricular a validar';
COMMENT ON COLUMN sis.t_convalidacion.cod_pensum is 'Código del pensum en el que se va a convalidar.';
COMMENT ON COLUMN sis.t_convalidacion.cod_trayecto is 'Código del trayecto en el que se tomará la convalidación.';
COMMENT ON COLUMN sis.t_convalidacion.cod_uni_curricular is 'Código de la unidad curricular que se convalidará.';
COMMENT ON COLUMN sis.t_convalidacion.descripcion is 'Descripción de la convalidación (opcional)';
alter table sis.t_convalidacion owner to sisconot;
