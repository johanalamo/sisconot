create user parelesn password '123';
insert into per.t_usuario (nombre,codigo,tipo) 
       values('parelesn',
               (select codigo from sis.t_persona where cedula = 17559834),
               'R');
select * from per.t_usuario;



grant all privileges on schema sis to mendozao;

grant all privileges on table sis.t_persona,sis.t_pensum,sis.t_est_estudiante,
			      sis.v_estudiante,sis.t_est_docente,sis.v_docente,sis.t_instituto 
			      ,sis.t_trayecto,sis.t_uni_curricular,sis.t_tip_uni_curricular, 
			      sis.t_curso,sis.t_cur_estudiante,sis.t_est_cur_estudiante,sis.t_periodo,sis.t_est_periodo,
			      sis.t_docente to mendozao;

--grant a las tablas de err.
--grant a las tablas de aud
--grant a las tablas de per
