\connect postgres;

\connect bd_sisconot;

insert into sis.t_tip_uni_curricular(codigo,nombre) values ('O','Obligatoria');
insert into sis.t_tip_uni_curricular(codigo,nombre) values ('E','Electiva');
insert into sis.t_tip_uni_curricular(codigo,nombre) values ('A','Acreditable');

insert into sis.t_est_periodo(codigo,nombre) values ('A', 'Abierto');
insert into sis.t_est_periodo(codigo,nombre) values ('C', 'Cerrado');

insert into sis.t_est_docente(codigo,nombre) values ('A', 'Activo');
insert into sis.t_est_docente(codigo,nombre) values ('R', 'Retirado');
insert into sis.t_est_docente(codigo,nombre) values ('J', 'Jubilado');

insert into sis.t_est_estudiante(codigo,nombre) values ('A', 'Activo');
insert into sis.t_est_estudiante(codigo,nombre) values ('I', 'Inactivo');
insert into sis.t_est_estudiante(codigo,nombre) values ('R', 'Retirado');
insert into sis.t_est_estudiante(codigo,nombre) values ('G', 'Graduado');

insert into sis.t_est_cur_estudiante(codigo,nombre) values ('P','Preinscrito');
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('I','Inscrito');
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('C','Cursando');

insert into sis.t_est_cur_estudiante(codigo,nombre) values ('X','Retirado');

insert into sis.t_est_cur_estudiante(codigo,nombre) values ('A','Aprobado');
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('R','Reprobado');
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('N','Reprobado por inasistencia');
