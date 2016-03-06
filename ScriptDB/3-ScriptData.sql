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
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('E','Reprobado por Inasistencia');
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('X','Retirado');

insert into sis.t_est_cur_estudiante(codigo,nombre) values ('A','Aprobado');
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('R','Reprobado');
insert into sis.t_est_cur_estudiante(codigo,nombre) values ('N','Reprobado por inasistencia');

INSERT INTO sis.t_tip_uni_curricular(codigo, nombre) VALUES ('E',    'Electiva');
INSERT INTO sis.t_tip_uni_curricular(codigo, nombre) VALUES ('O',    'Obligatoria');

INSERT INTO sis.t_instituto(codigo, nom_corto, nombre, direccion) VALUES (1, 'IUTFRP', 'IUT Federico Rivero Palacio', 'k8 de la panamericana');

INSERT INTO sis.t_pensum(codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva,min_cre_obligatoria, fec_creacion) VALUES (1,	'Programa Nacional de Formación Informática',	'PNFI',	'PNFI 2008' ,	2,	1,	2,	'2008-01-01');




INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (4,      'PIMT113',        'MATEMÁTICA  I',                                            60,     30,     3,              12,           12,                  20,          'Lógica', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (5,      'PIAC113',        'ARQUITECTURA DEL COMPUTADOR  ',                             60,     30,     3,              12,           12,                  20,          'Estructura del computador', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (6,      'PIFC111',        'FORMACIÓN CRÍTICA I',                                       24,     6,      1,              12,           12,                  20,          'DEPORTE , RECREACIÓN Y CULTURA I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                                 hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (7,      'PIFC121',        'FORMACIÓN CRÍTICA I',     24,     6,     1,              12,           12,                  20,          'INFORMÁTICA, POLÍTICA DE ESTADO Y SOBERANÍA I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (8,      'PIAP114',        'ALGORÍTMICA Y PROGRAMACIÓN',                                            78,     42,     4,              12,           12,                  20,          'PROGRAMACIÓN I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (9,      'PIAP124',        'ALGORÍTMICA Y PROGRAMACIÓN',                                            78,     42,     4,              12,           12,                  20,          'PROGRAMACIÓN II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (10,      'PIAP134',        'ALGORÍTMICA Y PROGRAMACIÓN',                                            78,     48,     4,              12,           12,                  20,          'PROGRAMACIÓN II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (11,      'PIPT113',        'PROYECTO SOCIOTECNOLÓGICO I',                              60,     30,     3,              12,           12,                  20,          'SOPORTE TÉCNICO A USUARIOS Y EQUIPOS I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (12,      'PIPT123 ',        'PROYECTO SOCIOTECNOLÓGICO I',                              60,     30,     3,              12,           12,                  20,          'SOPORTE TÉCNICO A USUARIOS Y EQUIPOS II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (13,      'PIPT133 ',        'PROYECTO SOCIOTECNOLÓGICO I',                              60,     30,     3,              12,           12,                  20,          'SOPORTE TÉCNICO A USUARIOS Y EQUIPOS III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (14,      'PIEL123',        'ELECTIVA I',                                              60,     30,     3,              12,           12,                  20,          'DISEÑO INSTRUCCIONAL EN LAS TIC', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (15,      'PIID111',        'IDIOMAS',                                                  24,     06,     1,              12,           12,                  20,          'INGLÉS COMPRENSIÓN LECTORA I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (16,      'PIID121',        'IDIOMAS',                                                  24,     06,     1,              12,           12,                  20,          'INGLÉS COMPRENSIÓN LECTORA II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (17,      'PIID131',        'IDIOMAS',                                                  24,     06,     1,              12,           12,                  20,          'INGLÉS COMPRENSIÓN LECTORA III', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (18,      'PIMT213',        'MATEMÁTICA  II',                                            60,     30,     3,              12,           12,                  20,          'CALCULO II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (19,      'PIMT223 ',        'MATEMÁTICA  II',                                            60,     30,     3,              12,           12,                  20,          'ÁLGEBRA LINEAL', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (20,      'PIRC213',        'REDES DE COMPUTADORAS',                                            60,     30,     3,              12,           12,                  20,          'FUNDAMENTOS Y COMPONENTES DE REDES', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (21,      'PIRC223 ',        'REDES DE COMPUTADORAS',                                            60,     30,     3,              12,           12,                  20,          'ADMINISTRACIÓN, PRINCIPIOS DE ENRUTAMIENTO Y SUBREDES', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (22,      'PIFC211',        'FORMACIÓN CRÍTICA II',                                    60,     30,     1,              12,           12,                  20,          'INFORMÁTICA, TECNOLOGÍA Y SOCIEDAD I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (23,      'PIFC221',        'FORMACIÓN CRÍTICA II',                                    60,     30,     1,              12,           12,                  20,          'INFORMÁTICA, TECNOLOGÍA Y SOCIEDAD II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (24,      'PIFC231',        'PARADIGMAS DE PROGRAMACIÓN',                              72,     48,     4,              12,           12,                  20,          'PROGRAMACIÓN III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (25,      'PIPP214',        'PARADIGMAS DE PROGRAMACIÓN',                              72,     48,     4,              12,           12,                  20,          'PROGRAMACIÓN III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (26,      'PIPP224',        'PARADIGMAS DE PROGRAMACIÓN',                              72,     48,     4,              12,           12,                  20,          'PROGRAMACIÓN IV', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (27,      'PIPP234',        'PARADIGMAS DE PROGRAMACIÓN',                              72,     48,     4,              12,           12,                  20,          'PROGRAMACIÓN V', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (28,      'PIPT213',        'PROYECTO SOCIO TECNOLÓGICO II',                              60,     30,     3,              12,           12,                  20,          'DESARROLLO DE SOLUCIONES INFORMÁTICAS I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (29,      'PIPT223',        'PROYECTO SOCIO TECNOLÓGICO II',                              60,     30,     3,              12,           12,                  20,          'DESARROLLO DE SOLUCIONES INFORMÁTICAS II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (30,      'PIPT233',        'PROYECTO SOCIO TECNOLÓGICO II',                              60,     30,     3,              12,           12,                  20,          'DESARROLLO DE SOLUCIONES INFORMÁTICAS III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (31,      'PIIS233',        'INGENIERÍA DEL SOFTWARE I',                              60,     30,     3,              12,           12,                  20,          'FUNDAMENTOS DE SISTEMAS E INGENIERÍA DEL SOFTWARE', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (32,      'PIBD213',        'BASES DE DATOS',                              60,     30,     3,              12,           12,                  20,          'BASES DE DATOS', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (33,      'PIEL233',        'ELECTIVA II',                              60,     30,     3,              12,           12,                  20,          'VOZ Y TELEFONÍA IP (VoIP)', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (34,      'PIEL243',        'ELECTIVA II',                              60,     30,     3,              12,           12,                  20,          'EDUMATICA', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (35,      'PIID211',        'IDIOMAS',                                          24,     6,     1,              12,           12,                  20,          'INGLÉS ­  REDACCIÓN I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (36,      'PIID221',        'IDIOMAS',                                          24,     6,     1,              12,           12,                  20,          'INGLÉS ­  REDACCIÓN II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (37,      'PIID231',        'IDIOMAS',                                          24,     6,     1,              12,           12,                  20,          'INGLÉS ­  REDACCIÓN III', '','');



INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (38,      'PIMA313 ',        'MATEMÁTICA  APLICADA',                                        60,     30,     3,              12,           12,                  20,          'ESTADÍSTICA Y PROBABILIDADES II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (39,      'PIMA323 ',        'MATEMÁTICA  APLICADA',                                        60,     30,     3,              12,           12,                  20,          'MATEMÁTICA DISCRETA', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (40,      'PIIO333',        'INVESTIGACIÓN DE OPERACIONES',                                        60,     30,     3,              12,           12,                  20,          'INVESTIGACIÓN DE OPERACIONES', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (41,      'PISO313',        'SISTEMAS OPERATIVOS',                                        60,     30,     3,              12,           12,                  20,          'SISTEMAS OPERATIVOS II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (42,      'PIFC311',        'FORMACIÓN CRÍTICA III  ',                                   24,     6,     3,              12,           12,                  20,          'CULTURA, DEPORTE Y RECREACIÓN III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (43,      'PIFC321',        'FORMACIÓN CRÍTICA III  ',                                   24,     6,     1,              12,           12,                  20,          'INFORMÁTICA, COMUNICACIÓN Y TRANSFORMACIÓN I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (44,      'PIFC331',        'FORMACIÓN CRÍTICA III  ',                                   24,     6,     1,              12,           12,                  20,          'INFORMÁTICA, COMUNICACIÓN Y TRANSFORMACIÓN II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (45,      'PIPT313',        'PROYECTO SOCIO TECNOLÓGICO III',                       60,     30,     3,              12,           12,                  20,          'DESARROLLO DE APLICACIONES INFORMÁTICAS I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (46,      'PIPT323 ',        'PROYECTO SOCIO TECNOLÓGICO III',                      60,     30,     3,              12,           12,                  20,          'DESARROLLO DE APLICACIONES INFORMÁTICAS II  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (47,      'PIPT333',        'PROYECTO SOCIO TECNOLÓGICO III',                       60,     30,     3,              12,           12,                  20,          'DESARROLLO DE APLICACIONES INFORMÁTICAS III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (48,      'PIIS313',        'INGENIERÍA DEL SOFTWARE II',                       60,     30,     3,              12,           12,                  20,          'FUNDAMENTOS DE INGENIERÍA DE REQUISITOS Y ANÁLISIS', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (49,      'PIIS323',        'INGENIERÍA DEL SOFTWARE II',                       60,     30,     3,              12,           12,                  20,          'FUNDAMENTOS DEL DISEÑO DE SOFTWARE', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (50,      'PIIS333',        'INGENIERÍA DEL SOFTWARE II',                       60,     30,     3,              12,           12,                  20,          'PRUEBAS Y VALIDACIÓN DE SOFTWARE', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (51,      'PIMB333 ',        'MODELADO  DE BASES DE DATOS',                       60,     30,     3,              12,           12,                  20,          'MODELADO  DE BASES DE DATOS', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (52,      'PIEL323',        'ELECTIVA III',                       60,     30,     3,              12,           12,                  20,          'COMUNICACIONES VÍA SATÉLITE', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (53,      'PIEL324',        'ELECTIVA III',                       60,     30,     3,              12,           12,                  20,          'TECNOLOGÍAS INTERNET', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (54,      'PIRA423',        'REDES AVANZADAS',                       60,     30,     3,              12,           12,                  20,          'REDES DE TELECOMUNICACIONES Y DE DATOS', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (55,      'PIFC411',        'FORMACIÓN CRÍTICA IV',                       24,     6,     1,              12,           12,                  20,          'INFORMÁTICA, GLOBALIZACIÓN Y CULTURA I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (56,      'PIFC421 ',        'FORMACIÓN CRÍTICA IV',                       24,     6,     1,              12,           12,                  20,          'INFORMÁTICA, GLOBALIZACIÓN Y CULTURA II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (57,      'PIFC431 ',        'FORMACIÓN CRÍTICA IV',                       24,     6,     1,              12,           12,                  20,          'CULTURA, DEPORTE Y RECREACIÓN IV', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (58,      'PIPT414 ',        'PROYECTO SOCIOTECNOLÓGICO IV',                       60,     30,     4,              12,           12,                  20,          'GESTIÓN DE PROYECTOS I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (59,      'PIPT424 ',        'PROYECTO SOCIOTECNOLÓGICO IV',                       60,     30,     4,              12,           12,                  20,          'GESTIÓN DE PROYECTOS II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (60,      'PIPT434 ',        'PROYECTO SOCIOTECNOLÓGICO IV',                       72,     48,     4,              12,           12,                  20,          'GESTIÓN DE PROYECTOS III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (61,      'PISI414  ',        'SEGURIDAD INFORMÁTICA',                       72,     48,     4,              12,           12,                  20,          ' SEGURIDAD INFORMÁTICA', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (62,      'PIGP424 ',        'GESTIÓN DE PROYECTOS INFORMÁTICOS',                       72,     48,     4,              12,           12,                  20,          'GESTIÓN DE PROYECTOS INFORMÁTICOS', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (63,      'PIAI434 ',        'AUDITORÍA INFORMÁTICA',                       72,     48,     4,              12,           12,                  20,          'AUDITORÍA INFORMÁTICA', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (64,      'PIAB413 ',        'ADMINISTRACIÓN DE BASES DE DATOS',                     60,     30,     3,              12,           12,                  20,          'AUDITORÍA INFORMÁTICA', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (65,      'PIEL433 ',        'ELECTIVA IV',                     60,     30,     3,              12,           12,                  20,          'APLICACIONES MULTIMEDIA', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (66,      'PIID411 ',        'IDIOMAS',                     24,     6,    1,              12,           12,                  20,          'CONVERSACIONAL I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (67,      'PIID421 ',        'IDIOMAS',                     24,     6,    1,              12,           12,                  20,          'CONVERSACIONAL II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (68,      'PIID431 ',        'IDIOMAS',                     24,     6,    1,              12,           12,                  20,          'CONVERSACIONAL III', '','');


INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (1,   1,   1,   28,   11);

INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (2,   1,   1,   29,   12);

INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (3,   1,   1,   30,   13);

INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (4,   1,   1,   58,   45);

INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (5,   1,   1,   59,   46);

INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (6,   1,   1,   60,   47);



INSERT INTO sis.t_trayecto(
            codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (1,  1,  0,   'TRAYECTO INICIAL',                                       10,              0,                     0,         0);

INSERT INTO sis.t_trayecto(
            codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (2,  1,  1,   'SOPORTE TÉCNICO A USUARIOS Y EQUIPOS',                   48,                8,                   4,         4);

INSERT INTO sis.t_trayecto(
            codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (3,  1,  2,   'TÉCNICO SUPERIOR UNIVERSITARIO EN INFORMÁTICA',          48,               8,             4,                4);

INSERT INTO sis.t_trayecto(
            codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (4,  1,  3,   'DESARROLLADOR DE APLICACIONES',                          39,              3,                  3,            1);

INSERT INTO sis.t_trayecto(
            codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (5,  1,  4,   'INGENIERO EN INFORMÁTICA',                               39,                 4,                   3,        2);




INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (1,  1,  0,  1,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (2,  1,  0,  2,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (3,  1,  0,  3,  'O');




INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (4,  1,  1,  4,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (5,  1,  1,  5,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (6,  1,  1,  6,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (7,  1,  1,  7,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (8,  1,  1,  8,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (9,  1,  1,  9,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (10,  1,  1,  10,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (11,  1,  1,  11,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (12,  1,  1,  12,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (13,  1,  1,  13,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (14,  1,  1,  14,  'E');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (18,  1,  1,  15,  'E');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (19,  1,  1,  16,  'E');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (20,  1,  1,  17,  'E');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (21,  1,  2,  18,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (22,  1,  2,  19,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (23,  1,  2,  20,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (24,  1,  2,  21,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (25,  1,  2,  22,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (26,  1,  2,  23,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (27,  1,  2,  24,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (28,  1,  2,  25,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (29,  1,  2,  26,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (30,  1,  2,  27,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (31,  1,  2,  28,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (32,  1,  2,  29,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (33,  1,  2,  30,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (34,  1,  2,  31,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (35,  1,  2,  32,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (36,  1,  2,  33,  'E');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (37,  1,  2,  34,  'E');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (38,  1,  2,  35,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (39,  1,  2,  36,  'O');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (40,  1,  2,  37,  'O');

---ING ---

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (41,  1,  3,  38,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (42,  1,  3,  39,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (43,  1,  3,  40,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (44,  1,  3,  41,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (45,  1,  3,  42,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (46,  1,  3,  42,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (47,  1,  3,  43,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (48,  1,  3,  44,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (49,  1,  3,  45,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (50,  1,  3,  46,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (51,  1,  3,  47,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (52,  1,  3,  48,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (53,  1,  3,  49,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (54,  1,  3,  50,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (55,  1,  3,  51,  'E');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (56,  1,  3,  52,  'E');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (57,  1,  4,  53,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (58,  1,  4,  54,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (59,  1,  4,  55,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (60,  1,  4,  56,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (61,  1,  4,  57,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (62,  1,  4,  58,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (63,  1,  4,  59,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (64,  1,  4,  60,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (65,  1,  4,  61,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (66,  1,  4,  62,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (67,  1,  4,  63,  'O');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (68,  1,  4,  64,  'O');



INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (69,  1,  4,  65,  'E');

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (70,  1,  4,  66,  'E');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (71,  1,  4,  67,  'E');


INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (72,  1,  4,  68,  'E');


