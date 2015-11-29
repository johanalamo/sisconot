﻿drop view sis.v_cur_estudiante_temp;
create or replace view sis.v_cur_estudiante_temp as
select 
   inst.codigo as cod_instituto,
   inst.nombre as nom_instituto,
   depa.codigo as cod_departamento,
   depa.nombre as nom_departamento,
   peri.codigo as cod_periodo,
   peri.nombre as nom_periodo,
   curs.codigo as cod_curso,
   curs.seccion,
   tray.codigo as cod_trayecto,
   tray.num_trayecto as num_trayecto,
   tray.certificado as cer_trayecto,
   unid.codigo as cod_uni_curricular,
   unid.nombre as nom_uni_curricular,
   doce.cedula as ced_docente,
   doce.nombre1 as doc_nombre1,
   doce.apellido1 as doc_apellido1,
   doce.cor_personal as cor_doc_personal,
   estu.codigo as cod_estudiante,
   estu.cedula as ced_estudiante,
   estu.apellido1 as est_apellido1,
   estu.nombre1 as est_nombre1,
   estu.cor_personal as cor_est_personal,
   cure.codigo as cod_cur_estudiante,
   cure.por_asistencia,
   cure.nota,
   cure.cod_estado,
   est_estu.nombre as nom_est_estudiante,
   cure.observaciones as observaciones
from sis.t_instituto as
   inst inner join sis.t_departamento as
   depa 
      on inst.codigo = depa.cod_instituto
      inner join sis.t_periodo as
   peri 
      on depa.codigo = peri.cod_departamento
      inner join sis.t_curso as
   curs
      on peri.codigo = curs.cod_periodo
      left join sis.t_persona as
   doce
      on curs.cod_docente = doce.codigo
      inner join sis.t_uni_curricular as
   unid
      on curs.cod_uni_curricular = unid.codigo
      left join sis.t_trayecto as
   tray
      on unid.cod_trayecto = tray.codigo
      left join sis.t_cur_estudiante as
   cure
      on curs.codigo = cure.cod_curso
      inner join sis.t_persona as 
   estu
      on cure.cod_estudiante = estu.codigo
      inner join sis.t_est_cur_estudiante as
   est_estu
      on cure.cod_estado = est_estu.codigo
order by
  cod_instituto,
  cod_periodo,
  seccion,
  nom_uni_curricular,
  ced_estudiante
   ;



copy (select * from sis.v_cur_estudiante_temp where cod_periodo = 102)
  to '/home/alamoj/Documentos/archivo.csv'
  null as ''
  delimiter ';'
 csv header
 
  ;
