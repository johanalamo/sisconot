drop view sis.v_cur_estudiante_temp;
create or replace view sis.v_cur_estudiante_temp as
select 
   inst.codigo             as ins_codigo,
   inst.nombre             as inst_nombre,
   peri.codigo             as per_codigo,
   peri.nombre             as per_nombre,
   curs.codigo             as cur_codigo,
   curs.seccion            as cur_seccion,
   tray.codigo             as tray_codigo,
   tray.num_trayecto       as tra_numero,
   tray.certificado        as tra_certificado,
   unid.codigo             as uni_cur_codigo,
   unid.nombre             as uni_cur_nombre,
   doce.cedula             as doc_cedula,
   doce.nombre1            as doc_nombre1,
   doce.apellido1          as doc_apellido1,
   doce.cor_personal       as doc_cor_personal,
   estu.codigo             as est_codigo,
   estu.cedula             as est_cedula,
   estu.apellido1          as est_apellido1,
   estu.apellido2          as est_apellido2,
   estu.nombre1            as est_nombre1,
   estu.nombre2            as est_nombre2,
   estu.cor_personal       as est_cor_personal,
   cure.codigo             as cur_est_codigo,
   cure.por_asistencia     as cur_est_por_asistencia,
   cure.nota               as cur_est_nota,
   cure.cod_estado         as cur_est_cod_estado,
   est_estu.nombre         as est_est_nombre,
   cure.observaciones      as cur_est_observaciones
from sis.t_instituto as
   inst inner join  sis.t_periodo as
   peri 
      on inst.codigo = peri.cod_instituto
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
  uni_cur_nombre,
  est_apellido1
   ;



copy (select * from sis.v_cur_estudiante_temp where per_codigo = 102)
  to '/tmp/archivo2.csv'
  null as ''
  delimiter ';'
 csv header
 
  ;
