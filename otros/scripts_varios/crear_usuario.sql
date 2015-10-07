create user bazor password 'mecanica'

grant all privileges on table sis.t_curso,
				sis.t_uni_curricular,
				sis.t_curso,
				sis.t_departamento,				
				sis.t_docente,						
				sis.t_cur_estudiante,
				sis.t_est_cur_estudiante,
				sis.t_est_estudiante,
				sis.t_est_periodo,
				sis.t_estudiante,
				sis.t_fotografia,
				sis.t_instituto,
				sis.t_pensum,
				sis.t_periodo,
				sis.t_persona,
				sis.t_prelacion,
				sis.t_tip_uni_curricular,
				sis.t_trayecto,
				sis.t_uni_curricular,				
				per.t_menu,
				per.t_mod_usuario,
				per.t_modulo,
				per.t_tabla,
				sis.t_est_estudiante,
				sis.v_estudiante,
				sis.v_docente,		
				sis.t_est_docente,		
				per.t_usuario to bazor
				
grant all privileges on schema sis,per to bazor;
grant all privileges on sequence sis.t_curso_codigo_seq to bazor;



----------hay que agregar por tabla en persona,docente y usuario los datos de login












--insertar en t_uni_cur_tipo: electiva, obligatoria, acreditable
