/*
 * Funciones de CRUD básico para la tabla sis.t_periodo
 */
 
 /*
 * Tabla: sis.t_periodo
 * Función de insersión en la tabla sis.t_periodo
 * 
 * Parámetros de entrada:
 *		nombre
 *		cod_instituto
 *		cod_pensum
 *		fec_inicio
 *		fec_final
 *		observaciones
 *		cod_estado
 *		
 */
 
CREATE OR REPLACE FUNCTION sis.f_periodo_ins(
						p_nombre text,
						p_cod_instituto integer,
						p_cod_pensum integer,
						p_fec_inicio text,
						p_fec_final text,
						p_observaciones text,
						p_cod_estado text) 
  RETURNS INTEGER AS 
$BODY$
DECLARE cod_periodo integer := 0;	
BEGIN
	select coalesce(max(codigo),0) from sis.t_periodo into cod_periodo;
	
	INSERT INTO sis.t_periodo(	codigo,
								nombre,
								cod_instituto,
								cod_pensum,
								fec_inicio,
								fec_final,
								observaciones,
								cod_estado)
	VALUES					 (	cod_periodo,
								p_nombre,
								p_cod_instituto,
								p_cod_pensum,
								p_fec_inicio,
								p_fec_final,
								p_observaciones,
								p_cod_estado);
     
  RETURN cod_periodo;
END;
$BODY$
language plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_periodo_ins(text,integer,integer,text,text,text,text)
  OWNER TO sisconot;
 
 
 
 /*
 * Tabla: sis.t_periodo
 * Función de modificación en la tabla sis.t_periodo
 * 
 * Parámetros de entrada:
 *		codigo
 *		nombre
 *		cod_instituto
 *		cod_pensum
 *		fec_inicio
 *		fec_final
 *		observaciones
 *		cod_estado
 */
 
CREATE OR REPLACE FUNCTION sis.f_periodo_mod(
									p_codigo integer,
									p_nombre text,
									p_cod_instituto integer,
									p_cod_pensum integer,
									p_fec_inicio text,
									p_fec_final text,
									p_observaciones text,
									p_cod_estado text) 
  RETURNS INTEGER AS 
$BODY$
DECLARE r_operacion integer := 0;	
BEGIN
	UPDATE sis.t_periodo
		SET
			nombre = p_nombre,
			cod_instituto = p_cod_instituto,
			cod_pensum = p_cod_pensum,
			fec_inicio = p_fec_inicio,
			fec_final = p_fec_final,
			observaciones = p_observaciones,
			cod_estado = p_cod_estado
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
ALTER FUNCTION sis.f_periodo_mod(integer,text,integer,integer,text,text,text,text)
  OWNER TO sisconot;
  
 /*
 * Tabla: sis.t_periodo
 * Función de eliminación en la tabla sis.t_periodo
 * 
 * Parámetros de entrada:
 *		codigo
 */
 
CREATE OR REPLACE FUNCTION sis.f_periodo_del(p_codigo integer)
RETURNS INTEGER AS
$BODY$
	DECLARE r_operacion integer := 0;
BEGIN
	
	DELETE FROM sis.t_periodo WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$BODY$
LANGUAGE plpgsql
	COST 100;
ALTER FUNCTION sis.f_periodo_del(integer)
  OWNER TO sisconot;

 /*
 * Tabla: sis.t_periodo
 * Función de consulta en la tabla sis.t_periodo
 */
 
CREATE OR REPLACE FUNCTION sis.f_periodo_sel(p_cursor refcursor)
RETURNS refcursor AS
$BODY$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo, 
				nombre,
				cod_instituto,
				cod_pensum,
				fec_inicio,
				fec_final,
				cod_estado,
				observaciones
		FROM sis.t_periodo;
	

	RETURN p_cursor;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_periodo_sel(refcursor)
  OWNER TO sisconot;
 
 /*
 * Tabla: sis.t_cur_estudiante
 * Función de consulta en la tabla sis.t_cur_estudiante por código
 *
 * Parámetros de entrada:
 * 		p_cursor 	Nombre del cursor
 *		codigo 		Código a consultar
 */


CREATE OR REPLACE FUNCTION sis.f_periodo_sel_por_codigo(p_cursor refcursor, p_codigo integer)
RETURNS refcursor AS
$BODY$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo, 
				nombre,
				cod_instituto,
				cod_pensum,
				fec_inicio,
				fec_final,
				cod_estado,
				observaciones
		FROM sis.t_periodo 
		WHERE codigo = p_codigo;
	RETURN p_cursor;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_periodo_sel_por_codigo(refcursor, integer)
  OWNER TO sisconot;
