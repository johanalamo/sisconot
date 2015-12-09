/*
 * Funciones de CRUD básico para la tabla sis.t_empleado
 */
 
 /*
 * Tabla: sis.t_empleado
 * Función de insersión en la tabla sis.t_empleado
 * 
 * Parámetros de entrada:
 *		p_cod_persona
		p_cod_instituto 
		p_cod_pensum
		p_cod_estado
		p_fec_inicio
		p_fec_fin
		p_es_jef_pensum
		p_es_jef_con_estudio
		p_es_ministerio
		es_docente
		p_observaciones
 *		
 */
 
 select * from sis.t_empleado
CREATE OR REPLACE FUNCTION sis.f_empleado_ins(
						p_cod_persona integer,
						p_cod_instituto integer,
						p_cod_pensum integer,
						p_cod_estado text,
						p_fec_inicio date,
						p_fec_fin date,
						p_es_jef_pensum boolean,
						p_es_jef_con_estudio boolean,
						p_es_ministerio boolean,
						es_docente boolean,
						p_observaciones text
						) 
  RETURNS INTEGER AS 
$BODY$
DECLARE cod_empleado integer := 0;	
BEGIN
	select coalesce(max(codigo),0) from sis.t_empleado into cod_empleado;
	cod_empleado:=cod_empleado+1;
	INSERT INTO sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,cod_estado,
				    fec_inicio,fec_fin,es_jef_pensum,es_jef_con_estudio,
				    es_ministerio,es_docente,observaciones) 
		    VALUES (cod_empleado,p_cod_persona,p_cod_instituto,p_cod_pensum,p_cod_estado,p_fec_inicio,
			    p_fec_fin,p_es_jef_pensum,p_es_jef_con_estudio,
			    p_es_ministerio,es_docente,p_observaciones);
     
  RETURN cod_empleado;
END;
$BODY$
language plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_empleado_ins(integer,integer,integer,text,date,date,boolean,boolean,boolean,boolean,text)
  OWNER TO postgres;



 /*
 * Tabla: sis.t_empleado
 * Función de modificar en la tabla sis.t_empleado
 * 
 * Parámetros de entrada:
		p_codigo
 *		p_cod_persona
		p_cod_instituto 
		p_cod_pensum
		p_cod_estado
		p_fec_inicio
		p_fec_fin
		p_es_jef_pensum
		p_es_jef_con_estudio
		p_es_ministerio
		es_docente
		p_observaciones
 *		
 */
 
 select * from sis.t_empleado

 select sis.f_empleado_mod(0,105,11,1,'J','2010-10-10','2015-12-06',false,false,false,false,'sin observacion')
 
CREATE OR REPLACE FUNCTION sis.f_empleado_mod(
						p_codigo integer,
						p_cod_persona integer,
						p_cod_instituto integer,
						p_cod_pensum integer,
						p_cod_estado text,
						p_fec_inicio date,
						p_fec_fin date,
						p_es_jef_pensum boolean,
						p_es_jef_con_estudio boolean,
						p_es_ministerio boolean,
						p_es_docente boolean,
						p_observaciones text
						) 
  RETURNS INTEGER AS 
$BODY$
DECLARE r_operacion integer := 0;	
BEGIN
	UPDATE sis.t_empleado SET cod_instituto=p_cod_instituto ,cod_pensum=p_cod_pensum,cod_estado=p_cod_estado,
				  fec_inicio=p_fec_inicio,fec_fin=p_fec_fin,es_jef_pensum=p_es_jef_pensum,
				  es_jef_con_estudio=p_es_jef_con_estudio,es_ministerio=p_es_ministerio,
				  es_docente=p_es_docente,observaciones=p_observaciones
			      WHERE codigo=p_codigo;
     IF found THEN
	r_operacion := 1;
     END IF;
     
  RETURN r_operacion;
END;
$BODY$
language plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_empleado_mod(integer,integer,integer,integer,text,date,date,boolean,boolean,boolean,boolean,text)
  OWNER TO postgres;



 /*
 * Tabla: sis.t_empleado
 * Función de consultar en la tabla sis.t_empleado
 * 
 * Parámetros de entrada:
		p_codigo
 *		
 *		
 */
 
 
 
CREATE OR REPLACE FUNCTION sis.f_empleado_lis_cod(p_cursor refcursor,p_codigo integer) 
RETURNS refcursor AS
$BODY$	
BEGIN
	OPEN p_cursor FOR
		SELECT * FROM sis.t_empleado;
     
 RETURN p_cursor;
END;
$BODY$
language plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_empleado_lis_cod(refcursor,integer)
  OWNER TO postgres;


 /*
 * Tabla: sis.t_empleado
 * Función de consultar en la tabla sis.t_empleado
 *		
 *		
 */
 
CREATE OR REPLACE FUNCTION sis.f_empleado_listar(p_cursor refcursor) 
RETURNS refcursor AS
$BODY$	
BEGIN
	OPEN p_cursor FOR
		SELECT * FROM sis.t_empleado;
     
 RETURN p_cursor;
END;
$BODY$
language plpgsql volatile 
			COST 100;
ALTER FUNCTION sis.f_empleado_listar(refcursor)
  OWNER TO postgres;


 /*
 * Tabla: sis.t_empleado
 * Función de eliminar en la tabla sis.t_empleado
 * 
 * Parámetros de entrada:
		p_codigo
 *		
 *		
 */
CREATE OR REPLACE FUNCTION sis.f_empleado_eliminar(p_codigo integer)
RETURNS INTEGER AS
$BODY$
	DECLARE r_operacion integer := 0;
BEGIN
	
	DELETE FROM sis.t_empleado WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$BODY$
LANGUAGE plpgsql
	COST 100;
ALTER FUNCTION sis.f_empleado_eliminar(integer)
  OWNER TO postgres;