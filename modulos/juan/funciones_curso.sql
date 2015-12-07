/*
 * Funciones de CRUD básico para la tabla sis.t_curso
 */
 
 /*
 * Tabla: sis.t_curso
 * Función de insersión en la tabla sis.t_curso
 * 
 * Parámetros de entrada:
 *		cod_periodo
 *		cod_uni_curricular
 *		cod_docente
 *		seccion
 *		fec_inicio
 *		fec_final
 *		capacidad
 * 		observaciones
 */
 
CREATE OR REPLACE FUNCTION sis.f_curso_ins(
						 p_cod_periodo integer, 
						 p_cod_uni_curricular integer,
						 p_cod_docente integer,
						 p_seccion TEXT,
						 p_fec_inicio TEXT,
						 p_fec_final TEXT,
						 p_capacidad integer,
						 p_observaciones TEXT) 
  RETURNS INTEGER AS 
$BODY$
DECLARE cod_curso integer := 0;	
BEGIN
	select nextval('s_curso') into cod_curso;
 
	INSERT INTO sis.t_curso (	codigo, 
								cod_periodo, 
								cod_uni_curricular, 
								cod_docente, 
								seccion, 
								fec_inicio, 
								fec_final, 
								capacidad, 
								observaciones)
	 VALUES ( 					cod_curso,
								p_cod_periodo, 
								p_cod_uni_curricular,
								p_cod_docente,
								p_seccion,
								p_fec_inicio,
								p_fec_final,
								p_capacidad,
								p_observaciones);
     
  RETURN cod_curso;
END;
$BODY$
language plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_curso_ins(integer, integer, integer, text, text, text, integer, text)
  OWNER TO sisconot;
 
 
 
 /*
 * Tabla: sis.t_curso
 * Función de modificación en la tabla sis.t_curso
 * 
 * Parámetros de entrada:
 *		codigo
 *		cod_periodo
 *		cod_uni_curricular
 *		cod_docente
 *		seccion
 *		fec_inicio
 *		fec_final
 *		capacidad
 * 		observaciones
 */
 
CREATE OR REPLACE FUNCTION sis.f_curso_mod(
						 p_codigo integer,
						 p_cod_periodo integer, 
						 p_cod_uni_curricular integer,
						 p_cod_docente integer,
						 p_seccion TEXT,
						 p_fec_inicio TEXT,
						 p_fec_final TEXT,
						 p_capacidad integer,
						 p_observaciones TEXT) 
  RETURNS INTEGER AS 
$BODY$
DECLARE r_operacion integer := 0;	
BEGIN
	UPDATE sis.t_curso
		SET
			cod_periodo = p_cod_periodo,
			cod_uni_curricular = p_cod_uni_curricular,
			cod_docente = p_cod_docente,
			seccion = p_seccion,
			fec_inicio = p_fec_inicio,
			fec_final = p_fec_final,
			capacidad = p_capacidad,
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
ALTER FUNCTION sis.f_curso_mod(integer, integer, integer, integer, text, text, text, integer, text)
  OWNER TO sisconot;
  
 /*
 * Tabla: sis.t_curso
 * Función de eliminación en la tabla sis.t_curso
 * 
 * Parámetros de entrada:
 *		codigo
 */
 
CREATE OR REPLACE FUNCTION sis.f_curso_del(p_codigo integer)
RETURNS INTEGER AS
$BODY$
	DECLARE r_operacion integer := 0;
BEGIN
	
	DELETE FROM sis.t_curso WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$BODY$
LANGUAGE plpgsql
	COST 100;
ALTER FUNCTION sis.f_curso_del(integer)
  OWNER TO sisconot;

 /*
 * Tabla: sis.t_curso
 * Función de consulta en la tabla sis.t_curso
 */
 
CREATE OR REPLACE FUNCTION sis.f_curso_sel(p_cursor refcursor)
RETURNS refcursor AS
$BODY$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				cod_periodo,
				cod_uni_curricular,
				cod_docente,
				seccion,
				fec_inicio,
				fec_final,
				capacidad,
				observaciones  
		FROM sis.t_curso;
	

	RETURN p_cursor;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_curso_sel(refcursor)
  OWNER TO sisconot;
 
 /*
 * Tabla: sis.t_curso
 * Función de consulta en la tabla sis.t_curso por código
 *
 * Parámetros de entrada:
 * 		p_cursor 	Nombre del cursor
 *		codigo 		Código a consultar
 */


CREATE OR REPLACE FUNCTION sis.f_curso_sel_por_codigo(p_cursor refcursor, p_codigo integer)
RETURNS refcursor AS
$BODY$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				cod_periodo,
				cod_uni_curricular,
				cod_docente,
				seccion,
				fec_inicio,
				fec_final,
				capacidad,
				observaciones 
		FROM sis.t_curso 
		WHERE codigo = p_codigo;
	RETURN p_cursor;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_curso_sel_por_codigo(refcursor, integer)
  OWNER TO sisconot;
