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
            codigo, cod_uni_ministerio, nombre,                 hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (1,      'PIMT005',            'MATEMATICA',         96,     96,     5,              12,           12,                  20,          'MATEMATICA 0 ', 'Prácticas formativas Prácticas sumativas ',          ' Unidad 1  Operaciones en R  o Suma  o Resta  o Multiplicación y  o División  ');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio, nombre,                                         hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion,                                            contenido)
    VALUES (2,      'PIPN003',            'PROYECTO NACIONAL Y NUEVA CIUDADANIA ',     48,     48,     3,              12,          12,                  20,          'FORMACIÓN CRÍTICA', 'Material Instruccional sobre Proyecto Nacional y Nueva Ciudadanía.    ',          ' Unidad 1 La sociedad multiétnica y pluricultural. o Origen cultural de la sociedad venezolana. ');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (3,      'PITI002  ',        'TALLER DE INTRODUCCIÓN A LA UNIVERSIDAD Y AL PROGRAMA',     20,     30,     2,              12,           12,                  20,          '1.  Interacción  Participante  –  Universidad  ­  Comunidad. 2.  ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (4,      'PIMT113',        ' MATEMÁTICA  I ',                                            60,     30,     3,              12,           12,                  20,          'Lógica ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (5,      'PIAC113',        ' ARQUITECTURA DEL COMPUTADOR  ',                             60,     30,     3,              12,           12,                  20,          'Estructura del computador ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (6,      'PIFC111',        ' FORMACIÓN CRÍTICA I',                                       24,     6,      1,              12,           12,                  20,          ' DEPORTE , RECREACIÓN Y CULTURA I ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                                 hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (7,      'PIFC121',        '  FORMACIÓN CRÍTICA I  ',     24,     6,     1,              12,           12,                  20,          'INFORMÁTICA, POLÍTICA DE ESTADO Y SOBERANÍA I ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (8,      'PIAP114',        ' ALGORÍTMICA Y PROGRAMACIÓN  ',                                            78,     42,     4,              12,           12,                  20,          'PROGRAMACIÓN I.', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (9,      'PIAP124',        ' ALGORÍTMICA Y PROGRAMACIÓN  ',                                            78,     42,     4,              12,           12,                  20,          '  PROGRAMACIÓN II  .', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (10,      'PIAP134',        ' ALGORÍTMICA Y PROGRAMACIÓN  ',                                            78,     48,     4,              12,           12,                  20,          '  PROGRAMACIÓN II  .', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (11,      'PIPT113',        ' PROYECTO SOCIOTECNOLÓGICO I ',                              60,     30,     3,              12,           12,                  20,          '   SOPORTE TÉCNICO A USUARIOS Y EQUIPOS I  .', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (12,      'PIPT123 ',        ' PROYECTO SOCIOTECNOLÓGICO I ',                              60,     30,     3,              12,           12,                  20,          '   SOPORTE TÉCNICO A USUARIOS Y EQUIPOS II .', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (13,      'PIPT133 ',        ' PROYECTO SOCIOTECNOLÓGICO I ',                              60,     30,     3,              12,           12,                  20,          '   SOPORTE TÉCNICO A USUARIOS Y EQUIPOS III .', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (14,      'PIEL123',        '  ELECTIVA I   ',                                              60,     30,     3,              12,           12,                  20,          '   DISEÑO INSTRUCCIONAL EN LAS TIC .', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (15,      'PIID111',        'IDIOMAS   ',                                                  24,     06,     1,              12,           12,                  20,          '     INGLÉS COMPRENSIÓN LECTORA I  .', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (16,      'PIID121',        'IDIOMAS   ',                                                  24,     06,     1,              12,           12,                  20,          '     INGLÉS COMPRENSIÓN LECTORA II  .', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (17,      'PIID131',        'IDIOMAS   ',                                                  24,     06,     1,              12,           12,                  20,          '     INGLÉS COMPRENSIÓN LECTORA III .', '','');



INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (18,      'PIMT213',        ' MATEMÁTICA  II',                                            60,     30,     3,              12,           12,                  20,          'CALCULO II . ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (19,      'PIMT223 ',        ' MATEMÁTICA  II',                                            60,     30,     3,              12,           12,                  20,          ' ÁLGEBRA LINEAL . ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (20,      'PIRC213',        ' REDES DE COMPUTADORAS ',                                            60,     30,     3,              12,           12,                  20,          '  FUNDAMENTOS Y COMPONENTES DE REDES ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (21,      'PIRC223 ',        ' REDES DE COMPUTADORAS ',                                            60,     30,     3,              12,           12,                  20,          ' ADMINISTRACIÓN, PRINCIPIOS DE ENRUTAMIENTO Y SUBREDES ', '','');



INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (22,      'PIFC211',        ' FORMACIÓN CRÍTICA II  ',                                    60,     30,     1,              12,           12,                  20,          '   INFORMÁTICA, TECNOLOGÍA Y SOCIEDAD I  ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (23,      'PIFC221',        ' FORMACIÓN CRÍTICA II  ',                                    60,     30,     1,              12,           12,                  20,          '     INFORMÁTICA, TECNOLOGÍA Y SOCIEDAD II  ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (24,      'PIFC231',        '  PARADIGMAS DE PROGRAMACIÓN ',                              72,     48,     4,              12,           12,                  20,          '   PROGRAMACIÓN III ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (25,      'PIPP214',        '  PARADIGMAS DE PROGRAMACIÓN ',                              72,     48,     4,              12,           12,                  20,          '   PROGRAMACIÓN III ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (26,      'PIPP224',        '  PARADIGMAS DE PROGRAMACIÓN ',                              72,     48,     4,              12,           12,                  20,          '  PROGRAMACIÓN IV ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (27,      'PIPP234',        '  PARADIGMAS DE PROGRAMACIÓN ',                              72,     48,     4,              12,           12,                  20,          '   PROGRAMACIÓN V ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (28,      'PIPT213',        '   PROYECTO SOCIO TECNOLÓGICO II  ',                              60,     30,     3,              12,           12,                  20,          ' DESARROLLO DE SOLUCIONES INFORMÁTICAS I', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (29,      'PIPT223',        '   PROYECTO SOCIO TECNOLÓGICO II  ',                              60,     30,     3,              12,           12,                  20,          ' DESARROLLO DE SOLUCIONES INFORMÁTICAS II', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (30,      'PIPT233',        '   PROYECTO SOCIO TECNOLÓGICO II  ',                              60,     30,     3,              12,           12,                  20,          ' DESARROLLO DE SOLUCIONES INFORMÁTICAS III', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (31,      'PIIS233',        '  INGENIERÍA DEL SOFTWARE I   ',                              60,     30,     3,              12,           12,                  20,          ' FUNDAMENTOS DE SISTEMAS E INGENIERÍA DEL SOFTWARE ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (32,      'PIBD213',        ' BASES DE DATOS  ',                              60,     30,     3,              12,           12,                  20,          ' BASES DE DATOS ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (33,      'PIEL233',        '  ELECTIVA II    ',                              60,     30,     3,              12,           12,                  20,          '  VOZ Y TELEFONÍA IP (VoIP) ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (34,      'PIEL243',        '  ELECTIVA II    ',                              60,     30,     3,              12,           12,                  20,          '   EDUMATICA  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (35,      'PIID211',        ' IDIOMAS  ',                                          24,     6,     1,              12,           12,                  20,          '     INGLÉS ­  REDACCIÓN I   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (36,      'PIID221',        ' IDIOMAS  ',                                          24,     6,     1,              12,           12,                  20,          '     INGLÉS ­  REDACCIÓN II   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (37,      'PIID231',        ' IDIOMAS  ',                                          24,     6,     1,              12,           12,                  20,          '     INGLÉS ­  REDACCIÓN III   ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (38,      'PIMA313 ',        'MATEMÁTICA  APLICADA ',                                        60,     30,     3,              12,           12,                  20,          '  ESTADÍSTICA Y PROBABILIDADES II  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (39,      'PIMA323 ',        'MATEMÁTICA  APLICADA ',                                        60,     30,     3,              12,           12,                  20,          '   MATEMÁTICA DISCRETA   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (40,      'PIIO333',        ' INVESTIGACIÓN DE OPERACIONES   ',                                        60,     30,     3,              12,           12,                  20,          '   INVESTIGACIÓN DE OPERACIONES   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (41,      'PISO313',        ' SISTEMAS OPERATIVOS  ',                                        60,     30,     3,              12,           12,                  20,          '   SISTEMAS OPERATIVOS II   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (42,      'PIFC311',        '  FORMACIÓN CRÍTICA III  ',                                   24,     6,     3,              12,           12,                  20,          ' CULTURA, DEPORTE Y RECREACIÓN III  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (43,      'PIFC321',        '  FORMACIÓN CRÍTICA III  ',                                   24,     6,     1,              12,           12,                  20,          '   INFORMÁTICA, COMUNICACIÓN Y TRANSFORMACIÓN I ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (44,      'PIFC331',        '  FORMACIÓN CRÍTICA III  ',                                   24,     6,     1,              12,           12,                  20,          '   INFORMÁTICA, COMUNICACIÓN Y TRANSFORMACIÓN II  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (45,      'PIPT313',        '   PROYECTO SOCIO TECNOLÓGICO III   ',                       60,     30,     3,              12,           12,                  20,          '   DESARROLLO DE APLICACIONES INFORMÁTICAS I  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (46,      'PIPT323 ',        '   PROYECTO SOCIO TECNOLÓGICO III   ',                      60,     30,     3,              12,           12,                  20,          '   DESARROLLO DE APLICACIONES INFORMÁTICAS II  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (47,      'PIPT333',        '   PROYECTO SOCIO TECNOLÓGICO III   ',                       60,     30,     3,              12,           12,                  20,          '   DESARROLLO DE APLICACIONES INFORMÁTICAS III  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (48,      'PIIS313',        '    INGENIERÍA DEL SOFTWARE II    ',                       60,     30,     3,              12,           12,                  20,          '  FUNDAMENTOS DE INGENIERÍA DE REQUISITOS Y ANÁLISIS ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (49,      'PIIS323',        '    INGENIERÍA DEL SOFTWARE II    ',                       60,     30,     3,              12,           12,                  20,          '    FUNDAMENTOS DEL DISEÑO DE SOFTWARE   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (50,      'PIIS333',        '    INGENIERÍA DEL SOFTWARE II    ',                       60,     30,     3,              12,           12,                  20,          '   PRUEBAS Y VALIDACIÓN DE SOFTWARE    ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (51,      'PIMB333 ',        '   MODELADO  DE BASES DE DATOS   ',                       60,     30,     3,              12,           12,                  20,          '  MODELADO  DE BASES DE DATOS  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (52,      'PIEL323',        '    ELECTIVA III    ',                       60,     30,     3,              12,           12,                  20,          '   COMUNICACIONES VÍA SATÉLITE   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (53,      'PIEL324',        '    ELECTIVA III    ',                       60,     30,     3,              12,           12,                  20,          '    TECNOLOGÍAS INTERNET   ', '','');



INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (54,      'PIRA423',        '   REDES AVANZADAS    ',                       60,     30,     3,              12,           12,                  20,          '   REDES DE TELECOMUNICACIONES Y DE DATOS   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (55,      'PIFC411',        '    FORMACIÓN CRÍTICA IV  ',                       24,     6,     1,              12,           12,                  20,          '    INFORMÁTICA, GLOBALIZACIÓN Y CULTURA I   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (56,      'PIFC421 ',        '    FORMACIÓN CRÍTICA IV  ',                       24,     6,     1,              12,           12,                  20,          '    INFORMÁTICA, GLOBALIZACIÓN Y CULTURA II  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (57,      'PIFC431 ',        '    FORMACIÓN CRÍTICA IV  ',                       24,     6,     1,              12,           12,                  20,          '    CULTURA, DEPORTE Y RECREACIÓN IV    ', '','');


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (58,      'PIPT414 ',        '   PROYECTO SOCIOTECNOLÓGICO IV   ',                       60,     30,     4,              12,           12,                  20,          '  GESTIÓN DE PROYECTOS I ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (59,      'PIPT424 ',        '   PROYECTO SOCIOTECNOLÓGICO IV   ',                       60,     30,     4,              12,           12,                  20,          '  GESTIÓN DE PROYECTOS II ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (60,      'PIPT434 ',        '   PROYECTO SOCIOTECNOLÓGICO IV   ',                       72,     48,     4,              12,           12,                  20,          '  GESTIÓN DE PROYECTOS III ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (61,      'PISI414  ',        '   SEGURIDAD INFORMÁTICA   ',                       72,     48,     4,              12,           12,                  20,          '   SEGURIDAD INFORMÁTICA  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (62,      'PIGP424 ',        '   GESTIÓN DE PROYECTOS INFORMÁTICOS  ',                       72,     48,     4,              12,           12,                  20,          '  GESTIÓN DE PROYECTOS INFORMÁTICOS  ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (63,      'PIAI434 ',        '   AUDITORÍA INFORMÁTICA  ',                       72,     48,     4,              12,           12,                  20,          '   AUDITORÍA INFORMÁTICA   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (64,      'PIAB413 ',        '    ADMINISTRACIÓN DE BASES DE DATOS   ',                     60,     30,     3,              12,           12,                  20,          '   AUDITORÍA INFORMÁTICA   ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (65,      'PIEL433 ',        '    ELECTIVA IV   ',                     60,     30,     3,              12,           12,                  20,          '    APLICACIONES MULTIMEDIA ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (66,      'PIID411 ',        '   IDIOMAS   ',                     24,     6,    1,              12,           12,                  20,          '  CONVERSACIONAL I ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (67,      'PIID421 ',        '   IDIOMAS   ',                     24,     6,    1,              12,           12,                  20,          '  CONVERSACIONAL II ', '','');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio,  nombre,                                                    hta,    hti,    uni_credito,    dur_semanas, not_min_aprobatoria, not_maxima,  descripcion,         observacion, contenido)
    VALUES (68,      'PIID431 ',        '   IDIOMAS   ',                     24,     6,    1,              12,           12,                  20,          '  CONVERSACIONAL III ', '','');


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


