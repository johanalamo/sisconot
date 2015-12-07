/*
 * Funciones de CRUD básico para la tabla sis.t_cur_estudiante
 */
 
 /*
 * Tabla: sis.t_curso
 * Función de insersión en la tabla sis.t_cur_estudiante
 * 
 * Parámetros de entrada:
 *		cod_estudiante
 *		cod_curso
 *		por_asistencia
 *		nota
 *		cod_estado
 *		observaciones
 *		
 */
 
CREATE OR REPLACE FUNCTION sis.f_cur_estudiante_ins(
						p_cod_estudiante integer,
						p_cod_curso integer, 
						p_por_asistencia float,
						p_nota float,
						p_cod_estado text,
						p_observaciones text) 
  RETURNS INTEGER AS 
$BODY$
DECLARE cod_cur_est integer := 0;	
BEGIN
	select nextval('s_cur_estudiante') into cod_cur_est;
 
	INSERT INTO sis.t_cur_estudiante (	codigo, 
										cod_estudiante, 
										cod_curso, 
										por_asistencia, 
										nota, 
										cod_estado, 
										observaciones)
	 VALUES ( 					cod_cur_est,
								p_cod_estudiante, 
								p_cod_curso, 
								p_por_asistencia, 
								p_nota, 
								p_cod_estado, 
								p_observaciones);
     
  RETURN cod_cur_est;
END;
$BODY$
language plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_cur_estudiante_ins(integer, integer, float, float, text, text)
  OWNER TO sisconot;
 
 
 
 /*
 * Tabla: sis.t_curso
 * Función de modificación en la tabla sis.t_cur_estudiante
 * 
 * Parámetros de entrada:
 *		codigo
 *		cod_estudiante
 *		cod_curso
 *		por_asistencia
 *		nota
 *		cod_estado
 *		observaciones
 */
 
CREATE OR REPLACE FUNCTION sis.f_cur_estudiante_mod(
						 p_codigo integer,
						 p_cod_estudiante integer, 
						 p_cod_curso integer,
						 p_por_asistencia float,
						 p_nota float,
						 p_cod_estado text,
						 p_observaciones TEXT) 
  RETURNS INTEGER AS 
$BODY$
DECLARE r_operacion integer := 0;	
BEGIN
	UPDATE sis.t_cur_estudiante
		SET
			cod_estudiante = p_cod_estudiante,
			cod_curso = p_cod_curso,
			por_asistencia = p_por_asistencia,
			nota = p_nota,
			cod_estado = p_cod_estado,
			observaciones = p_observaciones
		WHERE
			codigo = p_codigo;
		
		IF found THEN
			r_operacion := 1;
		END IF;
     
  RETURN r_operacion;
END;
$BODY$
language 	plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_cur_estudiante_mod(integer, integer, integer, float, float, text, text)
  OWNER TO sisconot;
  
 /*
 * Tabla: sis.t_cur_estudiante
 * Función de eliminación en la tabla sis.t_cur_estudiante
 * 
 * Parámetros de entrada:
 *		codigo
 */
 
CREATE OR REPLACE FUNCTION sis.f_cur_estudiante_del(p_codigo integer)
RETURNS INTEGER AS
$BODY$
	DECLARE r_operacion integer := 0;
BEGIN
	
	DELETE FROM sis.t_cur_estudiante WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$BODY$
LANGUAGE plpgsql
	COST 100;
ALTER FUNCTION sis.f_cur_estudiante_del(integer)
  OWNER TO sisconot;

 /*
 * Tabla: sis.t_cur_estudiante
 * Función de consulta en la tabla sis.t_cur_estudiante
 */
 
CREATE OR REPLACE FUNCTION sis.f_cur_estudiante_sel(p_cursor refcursor)
RETURNS refcursor AS
$BODY$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo, 
				cod_estudiante, 
				cod_curso, 
				cod_estado, 
				nota, 
				por_asistencia, 
				observaciones
		FROM sis.t_cur_estudiante;
	

	RETURN p_cursor;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_curso_sel(refcursor)
  OWNER TO sisconot;
 
 /*
 * Tabla: sis.t_cur_estudiante
 * Función de consulta en la tabla sis.t_cur_estudiante por código
 *
 * Parámetros de entrada:
 * 		p_cursor 	Nombre del cursor
 *		codigo 		Código a consultar
 */


CREATE OR REPLACE FUNCTION sis.f_cur_estudiante_sel_por_codigo(p_cursor refcursor, p_codigo integer)
RETURNS refcursor AS
$BODY$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo, 
				cod_estudiante, 
				cod_curso, 
				cod_estado, 
				nota, 
				por_asistencia, 
				observaciones 
		FROM sis.t_cur_estudiante 
		WHERE codigo = p_codigo;
	RETURN p_cursor;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_cur_estudiante_sel_por_codigo(refcursor, integer)
  OWNER TO sisconot;
