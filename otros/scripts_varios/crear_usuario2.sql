create user castrom password '123';
insert into sis.t_persona(codigo, cedula, nombre1, apellido1, sexo) values (2000, 123456, 'Marcos','Castro','M');
insert into sis.t_usu_con_estudios(codigo, cod_estado, cod_instituto) values (2000, 'A',11);
insert into per.t_usuario (nombre,codigo,tipo) values('castrom',2000,'R');

create user olivaress password '123';
insert into sis.t_persona(codigo, cedula, nombre1, apellido1, sexo) values (2002, 123457, 'Olivares','Simon','M');
insert into sis.t_usu_departamento(codigo, cod_estado, cod_departamento) values (2002, 'A',2);
insert into per.t_usuario (nombre,codigo,tipo) values('olivaress',2002,'R');

create user informatica1 password '123';
insert into sis.t_persona(codigo, cedula, nombre1, apellido1, sexo) values (2003, 10000, 'Usuario','Informatica','M');
insert into sis.t_usu_departamento(codigo, cod_estado, cod_departamento) values (2003, 'A',2);
insert into per.t_usuario (nombre,codigo,tipo) values('informatica1',2003,'R');

create user informatica2 password '123';
insert into sis.t_persona(codigo, cedula, nombre1, apellido1, sexo) values (2004, 10001, 'Usuario','Informatica2','M');
insert into sis.t_usu_departamento(codigo, cod_estado, cod_departamento) values (2004, 'A',2);
insert into per.t_usuario (nombre,codigo,tipo) values('informatica2',2004,'R');

create user fernandezm password '123';
insert into sis.t_persona(codigo, cedula, nombre1, apellido1, sexo) values (2001, 123459, 'Manuel','Fernandez','M');
insert into sis.t_usu_ministerio(codigo, cod_estado) values (2001, 'A');
insert into per.t_usuario (nombre,codigo,tipo) values('fernandezm',2001,'R');


grant all privileges on schema sis to fernandezm;
grant all privileges on schema sis to informatica2;
grant all privileges on schema sis to informatica1;
grant all privileges on schema sis to olivaress;
grant all privileges on schema sis to castrom;

grant all privileges on table sis.t_persona,sis.t_departamento,sis.t_pensum,sis.t_est_estudiante,
			      sis.v_estudiante,sis.t_est_docente,sis.v_docente,sis.t_instituto 
			      ,sis.t_trayecto,sis.t_uni_curricular,sis.t_tip_uni_curricular, 
			      sis.t_curso,sis.t_cur_estudiante,sis.t_est_cur_estudiante,sis.t_periodo,sis.t_est_periodo,
			      sis.t_docente to fernandezm;
grant all privileges on table sis.t_persona,sis.t_departamento,sis.t_pensum,sis.t_est_estudiante, 
			      sis.v_estudiante,sis.t_est_docente,sis.v_docente,sis.t_instituto 
			      ,sis.t_trayecto,sis.t_uni_curricular,sis.t_tip_uni_curricular,
			      sis.t_curso,sis.t_cur_estudiante,sis.t_est_cur_estudiante,sis.t_periodo,sis.t_est_periodo, 
			      sis.t_docente to  informatica2;
grant all privileges on table sis.t_persona,sis.t_departamento,sis.t_pensum,sis.t_est_estudiante, 
			      sis.v_estudiante,sis.t_est_docente,sis.v_docente,sis.t_instituto 
			      ,sis.t_trayecto,sis.t_uni_curricular,sis.t_tip_uni_curricular,
			      sis.t_curso,sis.t_cur_estudiante,sis.t_est_cur_estudiante,sis.t_periodo,sis.t_est_periodo,
			      sis.t_docente to informatica1;
grant all privileges on table sis.t_persona,sis.t_departamento,sis.t_pensum,sis.t_est_estudiante, 
			      sis.v_estudiante,sis.t_est_docente,sis.v_docente,sis.t_instituto 
			      ,sis.t_trayecto,sis.t_uni_curricular,sis.t_tip_uni_curricular, 
			      sis.t_curso,sis.t_cur_estudiante,sis.t_est_cur_estudiante,sis.t_periodo,sis.t_est_periodo,
			      sis.t_docente to olivaress;
grant all privileges on table sis.t_persona,sis.t_departamento,sis.t_pensum,sis.t_est_estudiante,
			      sis.v_estudiante,sis.t_est_docente,sis.v_docente,sis.t_instituto 
			      ,sis.t_trayecto,sis.t_uni_curricular,sis.t_tip_uni_curricular, 
			      sis.t_curso,sis.t_cur_estudiante,sis.t_est_cur_estudiante,sis.t_periodo,sis.t_est_periodo,
			      sis.t_docente to castrom;