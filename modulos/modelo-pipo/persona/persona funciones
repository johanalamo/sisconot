/*
 * Funciones de CRUD básico para la tabla sis.t_persona
 */
 
 /*
 * Tabla: sis.t_persona
 * Función de insersión en la tabla sis.t_persona
 * 
 * Parámetros de entrada:
 *		  cedula 
 *		  rif 
 *		  nombre1 
 *		  nombre2 
 *		  apellido1 
 * 		  apellido2 
 * 		  sexo 
 *		  fec_nacimiento 
 *		  tip_sangre 
 *		  telefono1 
 *		  telefono2 
 *		  cor_personal 
 *		  cor_institucional 
 *		  direccion 
 *		  discapacidad 
 *		  nacionalidad 
 *		  hijos integer
 *		  est_civil 
 *		  observaciones 
 *		  cod_foto
 * 		
 */
 CREATE OR REPLACE FUNCTION sis.f_persona_ins(p_cedula integer, p_rif text, p_nombre1 text, 
					      p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text,
					      p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text,
					      p_telefono2 text, p_cor_personal text, p_cor_institucional text,
					      p_direccion text, p_discapacidad text, p_nacionalidad text,
					      p_hijos integer, p_est_civil text, p_observaciones text, p_cod_foto integer
					      ) 
  RETURNS INTEGER AS 
$BODY$
DECLARE cod_persona integer := 0;	
BEGIN
	select coalesce(max(codigo),0) from sis.t_persona into cod_persona;
	
	cod_persona := cod_persona + 1;

	
	
	insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,
				   sexo,fec_nacimiento,tip_sangre,telefono1,telefono2,cor_personal,
				   cor_institucional,direccion,discapacidad,nacionalidad,hijos,
				   est_civil,observaciones) 
		    values (cod_persona,p_cedula,p_rif,p_nombre1,p_nombre2,p_apellido1,p_apellido2,p_sexo,p_fec_nacimiento,
			    p_tip_sangre,p_telefono1,p_telefono2,p_cor_personal,p_cor_institucional,p_direccion,
			    p_discapacidad, p_nacionalidad,p_hijos,p_est_civil,p_observaciones);

	--insert into sis.t_fotografia (cod_persona) values (cod_persona);
     
  RETURN cod_persona;
END;
$BODY$
language plpgsql volatile 
			COST 100;
			
ALTER FUNCTION sis.f_persona_ins(integer,text,text,text,text,text,text,date,text,text,
				text,text,text,text,text,text,integer,text,text,integer)
  OWNER TO sisconot;



 /*
 * Tabla: sis.t_persona
 * Función de modificar en la tabla sis.t_persona
 * 
 * Parámetros de entrada:
 *		  codigo 
 *		  cedula 
 *		  rif 
 *		  nombre1 
 *		  nombre2 
 *		  apellido1 
 * 		  apellido2 
 * 		  sexo 
 *		  fec_nacimiento 
 *		  tip_sangre 
 *		  telefono1 
 *		  telefono2 
 *		  cor_personal 
 *		  cor_institucional 
 *		  direccion 
 *		  discapacidad 
 *		  nacionalidad 
 *		  hijos integer
 *		  est_civil 
 *		  observaciones 
 *		  
 * 		
 */
 CREATE OR REPLACE FUNCTION sis.f_persona_mod(p_codigo integer,p_cedula integer, p_rif text, p_nombre1 text, 
					      p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text,
					      p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text,
					      p_telefono2 text, p_cor_personal text, p_cor_institucional text,
					      p_direccion text, p_discapacidad text, p_nacionalidad text,
					      p_hijos integer, p_est_civil text, p_observaciones text
					      ) 
  RETURNS INTEGER AS 
$BODY$
DECLARE r_operacion integer := 0;	
BEGIN

	UPDATE sis.t_persona SET cedula=p_cedula,rif=p_rif,nombre1=p_nombre1,nombre2=p_nombre2,apellido1=p_apellido1,apellido2=p_apellido2,sexo=p_sexo,
				 fec_nacimiento=p_fec_nacimiento,tip_sangre=p_tip_sangre,telefono1=p_telefono1,telefono2=p_telefono2,cor_personal=p_cor_personal,
				 cor_institucional=p_cor_institucional,direccion=p_direccion,discapacidad=p_discapacidad,nacionalidad=p_nacionalidad,
				 hijos=p_hijos,est_civil=p_est_civil,observaciones=p_observaciones
			     WHERE codigo=p_codigo;
	IF found THEN
		r_operacion := 1;
	END IF;
     
  RETURN r_operacion;
END;
$BODY$
language plpgsql volatile 
			COST 100;
			
ALTER FUNCTION sis.f_persona_mod(integer,integer,text,text,text,text,text,text,date,text,text,
				text,text,text,text,text,text,integer,text,text)
  OWNER TO postgres;




 /*
 * Tabla: sis.t_persona
 * Función de consultar en la tabla sis.t_persona
 * 
 * Parámetros de entrada:
 *		  codigo 
 */
 CREATE OR REPLACE FUNCTION sis.f_persona_lis_cod_ced(p_cursor refcursor,p_codigo integer) 
 RETURNS refcursor AS
$BODY$	
BEGIN
	OPEN p_cursor FOR
	select * from sis.t_persona where codigo=p_codigo or cedula=p_codigo;
		
	RETURN p_cursor;

END;
$BODY$
language plpgsql volatile 
			COST 100;
			
ALTER FUNCTION sis.f_persona_lis_cod_ced(refcursor, codigo integer)
  OWNER TO postgres;


/*
 * Tabla: sis.t_persona
 * Función de consultar en la tabla sis.t_persona
 * 
 */
 CREATE OR REPLACE FUNCTION sis.f_persona_listar(p_cursor refcursor) 
 RETURNS refcursor AS
$BODY$	
BEGIN
	OPEN p_cursor FOR
	select * from sis.t_persona;
		
	RETURN p_cursor;

END;
$BODY$
language plpgsql volatile 
			COST 100;
			
ALTER FUNCTION sis.f_persona_listar(refcursor)
  OWNER TO postgres;


select sis.f_persona_lis_cod_ced ('fcursorinst',2);
FETCH ALL IN fcursorinst;