/*Script de creación de la base de datos del Sistema de Control de Notas
--Creado por Johan Alamo y estudiantes de proyecto sociotecnológico 
--Comenzado en 2012
--Dpto de informática del IUT-RC "Dr. Federico Rivero Palacio"

Última versión
frebrero de 2016.
Participantes:
Tutor/coordinador: Johan Alamo  (johan.alamo@gmail.com)
Crado por: rafael
Estudiantes participantes en la versión final:
	De Sousa, Juan
	García, Rafael
	Sosa, Jean Pierre
*/

-- CREACION DE LA BASE DE DATOS   *********************************************
\connect postgres;

-- consulta para limpiar el buffer, no borrar.
select 'consulta para limpiar el buffer, no borrar.' as resultado;

-- Borrar la base de datos en caso de existir
drop database  bd_sisconot;

drop user sisconot;
create user sisconot password '123';


-- Crear de nuevo la base de datos
CREATE DATABASE bd_sisconot WITH OWNER = sisconot ENCODING = 'UTF8' CONNECTION LIMIT = -1;

--cambia el formato de la fecha a Dia/mes/año para consulta e insercion
alter database bd_sisconot SET DateStyle to 'sql,dmy';


-- Conectarse a la nueva base de datos
\connect bd_sisconot;

--crear el esquema de las tablas del sistema  ****************************************************
create schema sis;

alter schema sis owner to sisconot;
grant usage on schema sis to sisconot;

alter schema public owner to sisconot;
grant usage on schema public to sisconot;



/*----------------------------------------FUNCIONES DE ALMACENADO-------------------------------------------------*/


CREATE FUNCTION sis.f_instituto_actualizar(p_codigo integer, p_nom_corto text, p_nombre text, p_direccion text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	-- ALIAS es como su nombre lo indica
	-- los parametros de entrar se reciben con el signo $(N) donde N
	-- es el orde dado
	v_operacion integer := 0;
	-- no es necesario usar alias	
	--v_codigo ALIAS for $1;
	--v_nom_corto ALIAS for $2;
	--v_nombre ALIAS for $3;
	--v_direccion ALIAS for $4;
BEGIN

 UPDATE sis.t_instituto 
   SET 
	nom_corto=p_nom_corto, 
	nombre=p_nombre, 
	direccion=p_direccion
 WHERE t_instituto.codigo = p_codigo;

   IF found THEN  
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 -- si es necesario modificacion multiple hacerlo con transaccion

END;
$_$;


ALTER FUNCTION sis.f_instituto_actualizar(p_codigo integer, p_nom_corto text, p_nombre text, p_direccion text) OWNER TO sisconot;


CREATE FUNCTION sis.f_instituto_eliminar(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_operacion integer := 0;	
BEGIN

  DELETE FROM sis.t_instituto
	WHERE t_instituto.codigo = p_codigo;

  IF found THEN  
	v_operacion :=1;
  END IF;

RETURN v_operacion; 

END;
$$;


ALTER FUNCTION sis.f_instituto_eliminar(p_codigo integer) OWNER TO sisconot;

CREATE FUNCTION sis.f_instituto_insertar(text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	-- aqui se reclara las variables que necesite ejm: codigo (tipo) := ((valor) o (sin valor))
	codigoInstituto integer := 0;
	--pueden usar alias		
	v_nom_corto ALIAS for $1;
	v_nombre ALIAS for $2;
	v_direccion ALIAS for $3;
	
BEGIN
  -- cuerpo de la FUNCTION
  -- obitenes el sequencian y lo guardas en variable
  --	SELECT nextval('id_squel') into codigoInstituto;
  -- o
  -- obtienes maximo codigo 
  SELECT COALESCE (max(codigo),0) FROM sis.t_instituto INTO codigoInstituto;
  codigoInstituto := codigoInstituto + 1;	

	 INSERT INTO sis.t_instituto(
		    codigo, nom_corto, nombre, direccion)
	    VALUES (codigoInstituto, v_nom_corto, v_nombre, v_direccion);

  RETURN codigoInstituto;

-- execepcion solo se usaran para transacciones 
-- ejemplo
-- commit;	 
-- EXCEPTION  
--  WHEN unique_violation THEN 
--  Rollback;
--  RAISE EXCEPTION 'violacion de clave foranea';
-- RETURN -3; 

END;
$_$;


ALTER FUNCTION sis.f_instituto_insertar(text, text, text) OWNER TO sisconot;


CREATE FUNCTION sis.f_instituto_seleccionar() RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
DECLARE
	ref refcursor;
BEGIN
  
  OPEN ref FOR SELECT codigo, nom_corto, nombre, direccion
  FROM sis.t_instituto;
	  
 RETURN ref; 	
 
END;
$$;


ALTER FUNCTION sis.f_instituto_seleccionar() OWNER TO sisconot;


CREATE FUNCTION sis.f_instituto_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN
  
  OPEN $1 FOR SELECT codigo, nom_corto, nombre, direccion
  FROM sis.t_instituto;
	  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_instituto_seleccionar(refcursor) OWNER TO sisconot;


CREATE FUNCTION sis.f_instituto_seleccionar_por_codigo(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN
  
  OPEN $1 FOR SELECT codigo, nom_corto, nombre, direccion
  FROM sis.t_instituto where codigo = $2;
	  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_instituto_seleccionar_por_codigo(refcursor, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_pensum_actualizar(integer, text, text, text, integer, integer, integer, date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;	v_nombre ALIAS for $2;	
	v_nom_corto ALIAS for $3; v_observaciones ALIAS for $4;
	v_min_can_elect ALIAS for $5; v_min_cre_elect ALIAS for $6;
	v_min_cre_obligat ALIAS for $7; v_fec_creac ALIAS for $8;		
BEGIN

 UPDATE sis.t_pensum
   SET nombre = v_nombre, nom_corto = v_nom_corto, observaciones = v_observaciones, min_can_electiva = v_min_can_elect, 
       min_cre_electiva = v_min_cre_elect, min_cre_obligatoria = v_min_cre_obligat, fec_creacion = v_fec_creac       
 WHERE t_pensum.codigo = v_codigo;

   IF found THEN  
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 
END;
$_$;


ALTER FUNCTION sis.f_pensum_actualizar(integer, text, text, text, integer, integer, integer, date) OWNER TO sisconot;

CREATE FUNCTION sis.f_pensum_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;	
BEGIN

  DELETE FROM sis.t_pensum
	WHERE t_pensum.codigo = v_codigo;

  IF found THEN  
	v_operacion :=1;
  END IF;

RETURN v_operacion; 

END;
$_$;


ALTER FUNCTION sis.f_pensum_eliminar(integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_pensum_insertar(text, text, text, integer, integer, integer, date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoPensum integer := 0;
	v_nombre ALIAS for $1;	
	v_nom_corto ALIAS for $2;
	v_observaciones ALIAS for $3;
	v_min_can_elect ALIAS for $4;
	v_min_cre_elect ALIAS for $5;
	v_min_cre_obligat ALIAS for $6;
	v_fec_creac ALIAS for $7;	
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_pensum INTO codigoPensum;
  codigoPensum := codigoPensum + 1;	

  INSERT INTO sis.t_pensum(codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva, min_cre_obligatoria, fec_creacion)
  VALUES (codigoPensum, v_nombre, v_nom_corto, v_observaciones, v_min_can_elect, v_min_cre_elect, v_min_cre_obligat, v_fec_creac);

  RETURN codigoPensum;

END;
$_$;


ALTER FUNCTION sis.f_pensum_insertar(text, text, text, integer, integer, integer, date) OWNER TO sisconot;


CREATE FUNCTION sis.f_pensum_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN
  
  OPEN $1 FOR SELECT codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva,
  min_cre_obligatoria, fec_creacion
  FROM sis.t_pensum where codigo = $2;
    
 RETURN $1;   
 
END;
$_$;


ALTER FUNCTION sis.f_pensum_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_pensum_por_filtro_seleccionar(refcursor, text, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

    IF $2 = '1'  THEN 

	IF $3 < 1 THEN/* todos los pensum de de todos los instituto */
	  OPEN $1 FOR select *
		from sis.t_pensum  pen 
		inner join sis.t_periodo per on pen.codigo = cod_pensum 
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo;	
		
	  ELSE  /* todos los pensum de un instituto */	
	  OPEN $1 FOR select *
		from sis.t_pensum  pen 
		inner join sis.t_periodo per on pen.codigo = cod_pensum 
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo
		where ins.codigo = $3;

	END IF;  
	  
   END IF;  

    IF $2 = '2'  THEN 

	IF $3 < 1 THEN
	  OPEN $1 FOR select * /*todos los trayectos de de todos los pensum pensum */
		from sis.t_pensum  pen 
		inner join sis.t_trayecto tra on pen.codigo = tra.cod_pensum;	
		
	  ELSE  	
	  OPEN $1 FOR select * /*todos los trayectos de un pensum*/
		from sis.t_pensum  pen 
		inner join sis.t_trayecto tra on pen.codigo = tra.cod_pensum
		where pen.codigo = $3;

	END IF;  
	  
   END IF;  

  IF $2 = '3'  THEN 

	IF $3 < 1 THEN
	  OPEN $1 FOR select * 
		from sis.t_pensum  pen 
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo;	
		
	  ELSE  	
	  OPEN $1 FOR select * 
		from sis.t_pensum  pen 
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		where pen.codigo = $3;

	END IF;  
	  
   END IF;  
	  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_pensum_por_filtro_seleccionar(refcursor, text, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_pensum_por_instituto_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

	IF $2 < 1 THEN/* todos los pensum de de todos los instituto */
	  OPEN $1 FOR select *
		from sis.t_pensum  pen 
		inner join sis.t_periodo per on pen.codigo = cod_pensum 
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo;	
		
	  ELSE  /* todos los pensum de un instituto */	
	  OPEN $1 FOR select *
		from sis.t_pensum  pen 
		inner join sis.t_periodo per on pen.codigo = cod_pensum 
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo
		where ins.codigo = $2;
	END IF;  
	  
  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_pensum_por_instituto_seleccionar(refcursor, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_pensum_por_trayecto_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

	IF $2 < 1 THEN
	  OPEN $1 FOR select * /*todos los trayectos de de todos los pensum pensum */
		from sis.t_pensum  pen 
		inner join sis.t_trayecto tra on pen.codigo = tra.cod_pensum;	
		
	  ELSE  	
	  OPEN $1 FOR select * /*todos los trayectos de un pensum*/
		from sis.t_pensum  pen 
		inner join sis.t_trayecto tra on pen.codigo = tra.cod_pensum
		where pen.codigo = $2;
	 
	END IF;  	  
  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_pensum_por_trayecto_seleccionar(refcursor, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_pensum_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN
  
  OPEN $1 FOR SELECT codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva,
  min_cre_obligatoria, fec_creacion
  FROM sis.t_pensum;
	  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_pensum_seleccionar(refcursor) OWNER TO sisconot;


CREATE FUNCTION sis.f_prelacion_actualizar(integer, integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
	v_cod_pensum ALIAS for $2;
	v_cod_instituto ALIAS for $3;
	v_cod_uni_curricular ALIAS for $4;
	v_cod_uni_cur_prelada ALIAS for $5; 	
BEGIN

UPDATE sis.t_prelacion
   SET cod_pensum = v_cod_pensum, cod_instituto = v_cod_instituto, cod_uni_curricular = v_cod_uni_curricular, cod_uni_cur_prelada = v_cod_uni_cur_prelada   
 WHERE sis.t_prelacion.codigo = v_codigo;

   IF found THEN  
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 
END;
$_$;


ALTER FUNCTION sis.f_prelacion_actualizar(integer, integer, integer, integer, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_prelacion_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;  
BEGIN

  DELETE FROM sis.t_prelacion
  WHERE t_prelacion.codigo = v_codigo;

  IF found THEN  
  v_operacion :=1;
  END IF;

RETURN v_operacion; 

END;
$_$;


ALTER FUNCTION sis.f_prelacion_eliminar(integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_prelacion_insertar(integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoPrela integer := 0;
	v_cod_pensum ALIAS for $1;
	v_cod_instituto ALIAS for $2;
	v_cod_uni_curricular ALIAS for $3;
	v_cod_uni_cur_prelada ALIAS for $4; 
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_prelacion INTO codigoPrela;
  codigoPrela := codigoPrela + 1;	

  INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (codigoPrela, v_cod_pensum, v_cod_instituto, v_cod_uni_curricular, v_cod_uni_cur_prelada);

  RETURN codigoPrela;

END;
$_$;


ALTER FUNCTION sis.f_prelacion_insertar(integer, integer, integer, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_prelacion_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada
  FROM sis.t_prelacion where codigo = $2;
    
 RETURN $1;   
 
END;
$_$;


ALTER FUNCTION sis.f_prelacion_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_trayecto_actualizar(integer, integer, integer, text, integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1; 	v_cod_pensum ALIAS for $2;	
	v_num_trayecto ALIAS for $3; v_certificado ALIAS for $4;
	v_min_cre_obligatoria ALIAS for $5; v_min_cre_electiva ALIAS for $6;
	v_min_cre_acreditable ALIAS for $7; v_min_can_electiva ALIAS for $8;		
BEGIN

 UPDATE sis.t_trayecto
   SET cod_pensum = v_cod_pensum, num_trayecto = v_num_trayecto, certificado = v_certificado, min_cre_obligatoria = v_min_cre_obligatoria, 
       min_cre_electiva = v_min_cre_electiva, min_cre_acreditable = v_min_cre_acreditable, min_can_electiva = v_min_can_electiva
 WHERE sis.t_trayecto.codigo = v_codigo;


   IF found THEN  
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 
END;
$_$;


ALTER FUNCTION sis.f_trayecto_actualizar(integer, integer, integer, text, integer, integer, integer, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_trayecto_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;  
BEGIN

  DELETE FROM sis.t_trayecto
  WHERE t_trayecto.codigo = v_codigo;

  IF found THEN  
  v_operacion :=1;
  END IF;

RETURN v_operacion; 

END;
$_$;


ALTER FUNCTION sis.f_trayecto_eliminar(integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_trayecto_insertar(integer, integer, text, integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoTrayecto integer := 0;
	v_cod_pensum ALIAS for $1;	
	v_num_trayecto ALIAS for $2;
	v_certificado ALIAS for $3;
	v_min_cre_obligatoria ALIAS for $4;
	v_min_cre_electiva ALIAS for $5;
	v_min_cre_acreditable ALIAS for $6;
	v_min_can_electiva ALIAS for $7;	
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_trayecto INTO codigoTrayecto;
  codigoTrayecto := codigoTrayecto + 1;	
  
  INSERT INTO sis.t_trayecto(codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (codigoTrayecto, v_cod_pensum, v_num_trayecto, v_certificado, v_min_cre_obligatoria, v_min_cre_electiva, v_min_cre_acreditable, v_min_can_electiva);	

  RETURN codigoTrayecto;

END;
$_$;


ALTER FUNCTION sis.f_trayecto_insertar(integer, integer, text, integer, integer, integer, integer) OWNER TO sisconot;

CREATE FUNCTION sis.f_trayecto_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, 
       min_cre_electiva, min_cre_acreditable, min_can_electiva
  FROM sis.t_trayecto where codigo = $2;
    
 RETURN $1;   
 
END;
$_$;


ALTER FUNCTION sis.f_trayecto_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_trayecto_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, 
       min_cre_electiva, min_cre_acreditable, min_can_electiva
  FROM sis.t_trayecto;

	  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_trayecto_seleccionar(refcursor) OWNER TO sisconot;


CREATE FUNCTION sis.f_uni_tra_pensu_actualizar(integer, integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
	v_cod_pensum ALIAS for $2;
	v_cod_trayecto ALIAS for $3;
	v_cod_uni_curri ALIAS for $4;
	v_cod_tipo ALIAS for $5; 	
BEGIN

UPDATE sis.t_uni_tra_pensum
   SET cod_pensum = v_cod_pensum, cod_trayecto = v_cod_trayecto, cod_uni_curricular = v_cod_uni_curri, cod_tipo = v_cod_tipo      
 WHERE sis.t_uni_tra_pensum.codigo = v_codigo;

   IF found THEN  
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 
END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_actualizar(integer, integer, integer, integer, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_uni_tra_pensu_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
	v_cod_pensum ALIAS for $1;
	v_cod_trayecto ALIAS for $2;
	v_cod_uni_curri ALIAS for $3;
	v_cod_tipo ALIAS for $4; 
	
BEGIN

UPDATE sis.t_uni_tra_pensum
   SET cod_pensum = v_cod_pensum, cod_trayecto = v_cod_trayecto, cod_uni_curricular = v_cod_uni_curri, cod_tipo = v_cod_tipo
      
 WHERE sis.t_uni_tra_pensum.codigo = v_codigo;

   IF found THEN  
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 
END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) OWNER TO sisconot;


CREATE FUNCTION sis.f_uni_tra_pensu_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;  
BEGIN

  DELETE FROM sis.t_uni_tra_pensum
  WHERE t_uni_tra_pensum.codigo = v_codigo;

  IF found THEN  
  v_operacion :=1;
  END IF;

RETURN v_operacion; 

END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_eliminar(integer) OWNER TO sisconot;

CREATE FUNCTION sis.f_uni_tra_pensu_insertar(integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoUniTraPen integer := 0;
	v_cod_pensum ALIAS for $1;
	v_trayecto ALIAS for $2;
	v_cod_uni_curri ALIAS for $3;
	v_cod_tipo ALIAS for $4; 
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_uni_tra_pensum INTO codigoUniTraPen;
  codigoUniTraPen := codigoUniTraPen + 1;	
  
  INSERT INTO sis.t_uni_tra_pensum(codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (codigoUniTraPen, v_cod_pensum, v_trayecto, v_cod_uni_curri, v_cod_tipo);
        
  RETURN codigoUniTraPen;

END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_insertar(integer, integer, integer, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo
  FROM sis.t_uni_tra_pensum where codigo = $2;
    
 RETURN $1;   
 
END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;

CREATE FUNCTION sis.f_unicurricular_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
	v_cod_uni_ministerio ALIAS for $2;
	v_nombre ALIAS for $3;
	v_hta ALIAS for $4;
	v_hti ALIAS for $5; 
	v_uni_credito ALIAS for $6;
	v_dur_semanas ALIAS for $7; 
	v_not_min_aprobatoria ALIAS for $8;
	v_not_maxima ALIAS for $9;
	v_descripcion ALIAS for $10;
	v_observacion ALIAS for $11; 
	v_contenido ALIAS for $12;
	
BEGIN


UPDATE sis.t_uni_curricular
   SET codigo = v_codigo, cod_uni_ministerio = v_cod_uni_ministerio, nombre = v_nombre,  hta = v_hta, hti = v_hti, uni_credito = v_uni_credito, 
       dur_semanas = v_dur_semanas, not_min_aprobatoria = v_not_min_aprobatoria, not_maxima = v_not_maxima, descripcion = v_descripcion, observacion = v_observacion, contenido = v_contenido
 WHERE sis.t_uni_curricular.codigo = v_codigo;

   IF found THEN  
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 
END;
$_$;


ALTER FUNCTION sis.f_unicurricular_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) OWNER TO sisconot;

CREATE FUNCTION sis.f_unicurricular_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;  
BEGIN

  DELETE FROM sis.t_uni_curricular
  WHERE t_uni_curricular.codigo = v_codigo;

  IF found THEN  
  v_operacion :=1;
  END IF;

RETURN v_operacion; 

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_eliminar(integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_unicurricular_insertar(text, text, integer, integer, integer, integer, integer, integer, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoUniCurricular integer := 0;
	v_cod_uni_ministerio ALIAS for $1;
	v_nombre ALIAS for $2;
	v_hta ALIAS for $3;
	v_hti ALIAS for $4; 
	v_uni_credito ALIAS for $5;
	v_dur_semanas ALIAS for $6; 
	v_not_min_aprobatoria ALIAS for $7;
	v_not_maxima ALIAS for $8;
	v_descripcion ALIAS for $9;
	v_observacion ALIAS for $10; 
	v_contenido ALIAS for $11;

BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_uni_curricular INTO codigoUniCurricular;
  codigoUniCurricular := codigoUniCurricular + 1;	
  
  INSERT INTO sis.t_uni_curricular(codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, not_min_aprobatoria, not_maxima, descripcion, observacion, contenido)
            VALUES (codigoUniCurricular, v_cod_uni_ministerio, v_nombre, v_hta, v_hti, v_uni_credito, v_dur_semanas, v_not_min_aprobatoria, v_not_maxima, v_descripcion, v_observacion, v_contenido);

  RETURN codigoUniCurricular;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_insertar(text, text, integer, integer, integer, integer, integer, integer, text, text, text) OWNER TO sisconot;

CREATE FUNCTION sis.f_unicurricular_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, 
       not_min_aprobatoria, not_maxima, descripcion, observacion, contenido
  FROM sis.t_uni_curricular where codigo = $2;
    
 RETURN $1;   
 
END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;

CREATE FUNCTION sis.f_unicurricular_por_patron_seleccionar(refcursor, text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, descripcion
  FROM sis.t_uni_curricular where  
		upper(cod_uni_ministerio) like upper('%'||$2||'%')
		or	upper(nombre) like upper('%'||$2||'%');
    
 RETURN $1;   
 
END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_patron_seleccionar(refcursor, text) OWNER TO sisconot;

CREATE FUNCTION sis.f_unicurricular_por_pen_y_tray_seleccionar(refcursor, integer, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN
	
	  OPEN $1 FOR select * 
		from sis.t_pensum  pen 
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		where utp.cod_pensum = $2 and utp.cod_trayecto = $3 ;
	  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_pen_y_tray_seleccionar(refcursor, integer, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_unicurricular_por_pensum_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

	IF $2 < 1 THEN
	  OPEN $1 FOR select * 
		from sis.t_pensum  pen 
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo;	
		
	  ELSE  	
	  OPEN $1 FOR select * 
		from sis.t_pensum  pen 
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		where pen.codigo = $2;

	END IF;  
	  
 RETURN $1; 	
 
END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_pensum_seleccionar(refcursor, integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_unicurricular_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, 
       not_min_aprobatoria, not_maxima, descripcion, observacion, contenido
  FROM sis.t_uni_curricular;


    
 RETURN $1;   
 
END;
$_$;


ALTER FUNCTION sis.f_unicurricular_seleccionar(refcursor) OWNER TO sisconot;


 
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
	select nextval('sis.s_curso') into cod_curso;
 
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
	select nextval('sis.s_cur_estudiante') into cod_cur_est;
 
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


 
CREATE OR REPLACE FUNCTION sis.f_periodo_ins(
						p_nombre text,
						p_cod_instituto integer,
						p_cod_pensum integer,
						p_fec_inicio date,
						p_fec_final date,
						p_observaciones text,
						p_cod_estado text) 
  RETURNS INTEGER AS 
$BODY$
DECLARE cod_periodo integer := 0;	
BEGIN
	select coalesce(max(codigo)+1,0) from sis.t_periodo into cod_periodo;
	
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
ALTER FUNCTION sis.f_periodo_ins(text,integer,integer,date,date,text,text)
  OWNER TO sisconot;
 

 
CREATE OR REPLACE FUNCTION sis.f_periodo_mod(
									p_codigo integer,
									p_nombre text,
									p_cod_instituto integer,
									p_cod_pensum integer,
									p_fec_inicio date,
									p_fec_final date,
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
ALTER FUNCTION sis.f_periodo_mod(integer,text,integer,integer,date,date,text,text)
  OWNER TO sisconot;
  

 
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



CREATE FUNCTION sis.f_empleado_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;	
BEGIN
	UPDATE sis.t_empleado SET cod_instituto=p_cod_instituto,	  cod_pensum=p_cod_pensum,
				  cod_estado=p_cod_estado,		  fec_inicio=p_fec_inicio,
				  fec_fin=p_fec_fin,			  es_jef_pensum=p_es_jef_pensum,
				  es_jef_con_estudio=p_es_jef_con_estudio,es_ministerio=p_es_ministerio,
				  es_docente=p_es_docente,		  observaciones=p_observaciones
			      WHERE codigo=p_codigo;
     IF found THEN
	r_operacion := 1;
     END IF;
     
  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_empleado_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) OWNER TO sisconot;


CREATE FUNCTION sis.f_empleado_eli(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN
	
	DELETE FROM sis.t_empleado WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_empleado_eli(p_codigo integer) OWNER TO sisconot;

CREATE FUNCTION sis.f_empleado_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_empleado integer := 0;	
BEGIN
	select coalesce(max(codigo),0) from sis.t_empleado into cod_empleado;
	
	cod_empleado:=cod_empleado+1;
	
	INSERT INTO sis.t_empleado (codigo,		cod_persona,		cod_instituto,
				    cod_pensum,		cod_estado,	        fec_inicio,
				    fec_fin,		es_jef_pensum,		es_jef_con_estudio,
				    es_ministerio,	es_docente,		observaciones
				 ) 
			    VALUES (cod_empleado,	p_cod_persona,		p_cod_instituto,
				    p_cod_pensum,	p_cod_estado,		p_fec_inicio,
				    p_fec_fin,		p_es_jef_pensum,	p_es_jef_con_estudio,
				    p_es_ministerio,	p_es_docente,		p_observaciones
				  );
     
  RETURN cod_empleado;
END;
$$;


ALTER FUNCTION sis.f_empleado_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) OWNER TO sisconot;

CREATE FUNCTION sis.f_empleado_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$	
BEGIN
	OPEN p_cursor FOR
		SELECT * FROM sis.t_empleado;
     
 RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_empleado_sel(p_cursor refcursor) OWNER TO sisconot;


CREATE FUNCTION sis.f_empleado_sel_cod(p_cursor refcursor, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$	
BEGIN
	OPEN p_cursor FOR
		SELECT * FROM sis.t_empleado;
     
 RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_empleado_sel_cod(p_cursor refcursor, p_codigo integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_estudiante_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;	
BEGIN

	UPDATE sis.t_estudiante SET cod_instituto=p_cod_instituto, 	cod_pensum=p_cod_pensum, 
				    num_carnet=p_num_carnet,		num_expediente=p_num_expediente, 
				    cod_rusnies=p_cod_rusnies,	    	cod_estado=p_cod_estado,
				    fec_inicio=p_fec_inicio, 		condicion= p_condicion,
				    fec_fin=p_fec_fin, 			observaciones=p_observaciones
			     WHERE codigo=p_codigo;
	IF found THEN
		r_operacion := 1;
	END IF;
     
  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_estudiante_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) OWNER TO sisconot;


CREATE FUNCTION sis.f_estudiante_eli(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN
	
	DELETE FROM sis.t_estudiante WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_estudiante_eli(p_codigo integer) OWNER TO sisconot;


CREATE FUNCTION sis.f_estudiante_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_estudiante integer := 0;	
BEGIN
	select coalesce(max(codigo),0) from sis.t_estudiante into cod_estudiante;
	
	cod_estudiante := cod_estudiante + 1;	
	
	insert into sis.t_estudiante (	codigo, 		cod_persona, 		cod_instituto, 
					cod_pensum, 		num_carnet, 		num_expediente,
					cod_rusnies, 		cod_estado,		fec_inicio, 
					fec_fin, 		condicion,		observaciones
				     )
			     values (	cod_estudiante, 	p_cod_persona, 		p_cod_instituto, 
					p_cod_pensum, 		p_num_carnet,		p_num_expediente, 
					p_cod_rusnies, 		p_cod_estado, 		p_fec_inicio, 
					p_fec_fin, 		p_condicion, 		p_observaciones
				    );

	
     
  RETURN cod_estudiante;
END;
$$;


ALTER FUNCTION sis.f_estudiante_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) OWNER TO sisconot;

CREATE FUNCTION sis.f_estudiante_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$	
BEGIN
	OPEN p_cursor FOR
	select * from sis.t_estudiante;
		
	RETURN p_cursor;

END;
$$;


ALTER FUNCTION sis.f_estudiante_sel(p_cursor refcursor) OWNER TO sisconot;

CREATE FUNCTION sis.f_persona_act(p_codigo integer, p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;	
BEGIN

	UPDATE sis.t_persona SET cedula=p_cedula,			rif=p_rif,
				 nombre1=p_nombre1,			nombre2=p_nombre2,
				 apellido1=p_apellido1,			apellido2=p_apellido2,
				 sexo=p_sexo,				fec_nacimiento=p_fec_nacimiento,
				 tip_sangre=p_tip_sangre,		telefono1=p_telefono1,
				 telefono2=p_telefono2,			cor_personal=p_cor_personal,
				 cor_institucional=p_cor_institucional,	direccion=p_direccion,
				 discapacidad=p_discapacidad,		nacionalidad=p_nacionalidad,
				 hijos=p_hijos,				est_civil=p_est_civil,
				 observaciones=p_observaciones
			     WHERE codigo=p_codigo;
	IF found THEN
		r_operacion := 1;
	END IF;
     
  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_persona_act(p_codigo integer, p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) OWNER TO sisconot;

CREATE FUNCTION sis.f_persona_eli(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN
	
	DELETE FROM sis.t_persona WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_persona_eli(p_codigo integer) OWNER TO sisconot;

CREATE FUNCTION sis.f_persona_ins(p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_persona integer := 0;	
BEGIN
	select coalesce(max(codigo),0) from sis.t_persona into cod_persona;
	
	cod_persona := cod_persona + 1;	
	
	insert into sis.t_persona (codigo,		cedula,			rif,
				   nombre1,		nombre2,		apellido1,
				   apellido2,   	sexo,			fec_nacimiento,
				   tip_sangre,		telefono1,		telefono2,
				   cor_personal,	cor_institucional,	direccion,
				   discapacidad,	nacionalidad,		hijos,
				   est_civil,		observaciones
				) 
				 
		          values (cod_persona,		p_cedula,		p_rif,
				  p_nombre1,		p_nombre2,		p_apellido1,
				  p_apellido2,		p_sexo,			p_fec_nacimiento,
				  p_tip_sangre,		p_telefono1,		p_telefono2,
				  p_cor_personal,	p_cor_institucional,	p_direccion,
				  p_discapacidad, 	p_nacionalidad,		p_hijos,
				  p_est_civil,		p_observaciones
				);

	--insert into sis.t_fotografia (cod_persona) values (cod_persona);
     
  RETURN cod_persona;
END;
$$;


ALTER FUNCTION sis.f_persona_ins(p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) OWNER TO sisconot;


CREATE FUNCTION sis.f_persona_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$	
BEGIN
	OPEN p_cursor FOR
	select * from sis.t_persona;
		
	RETURN p_cursor;

END;
$$;


ALTER FUNCTION sis.f_persona_sel(p_cursor refcursor) OWNER TO sisconot;


/*****************************************SECUANCIALES ***********************************************************/

CREATE SEQUENCE sis.s_cur_estudiante
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sis.s_cur_estudiante OWNER TO sisconot;

CREATE SEQUENCE sis.s_curso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sis.s_curso OWNER TO sisconot;

/*----------------------------------------TABLAS DEL SISTEMA------------------------------------------------ --*/

CREATE TABLE sis.t_instituto (
    codigo smallint NOT NULL,
    nom_corto character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion character varying(200)
);

ALTER TABLE sis.t_instituto OWNER TO sisconot;

COMMENT ON TABLE sis.t_instituto IS 'Tabla que almacena la información básica de los institutos universitarios y/o universidades';
COMMENT ON COLUMN sis.t_instituto.codigo IS 'Código del registro que identifica al instituto';
COMMENT ON COLUMN sis.t_instituto.nom_corto IS 'Nombre corto del instituto, también es una llave alternativa';
COMMENT ON COLUMN sis.t_instituto.nombre IS 'Nombre largo del instituto.';
COMMENT ON COLUMN sis.t_instituto.direccion IS 'Ubicación geográfica del instituto';


CREATE TABLE sis.t_pensum (
    codigo integer NOT NULL,
    nombre character varying(50) NOT NULL,
    nom_corto character varying(20) NOT NULL,
    observaciones character varying(200),
    min_can_electiva smallint DEFAULT 0 NOT NULL,
    min_cre_electiva smallint DEFAULT 0 NOT NULL,
    min_cre_obligatoria smallint DEFAULT 0 NOT NULL,
    fec_creacion date,
    CONSTRAINT chk_t_pensum_01 CHECK ((min_can_electiva >= 0)),
    CONSTRAINT chk_t_pensum_02 CHECK ((min_cre_electiva >= 0)),
    CONSTRAINT chk_t_pensum_03 CHECK ((min_cre_obligatoria >= 0)),
    CONSTRAINT chk_t_pensum_04 CHECK ((fec_creacion >= '1950-01-01'::date))
);


ALTER TABLE sis.t_pensum OWNER TO sisconot;

COMMENT ON TABLE sis.t_pensum IS 'Tabla padre de un pensum';
COMMENT ON COLUMN sis.t_pensum.codigo IS 'Código del pensum';
COMMENT ON COLUMN sis.t_pensum.nombre IS 'Nombre largo del pensum';
COMMENT ON COLUMN sis.t_pensum.nom_corto IS 'Abreviación del nombre del pensum';
COMMENT ON COLUMN sis.t_pensum.observaciones IS 'Alguna otra información relevante del pensum';
COMMENT ON COLUMN sis.t_pensum.min_can_electiva IS 'Minima Cantidad de Electivas que se deben cursar en el pesum';
COMMENT ON COLUMN sis.t_pensum.min_cre_electiva IS 'MInima Cantidad de unidades de créditos que se deben cursar en el pensum en unidades obligatorias';
COMMENT ON COLUMN sis.t_pensum.min_cre_obligatoria IS 'MInima Cantidad de Creditos de Electivas Obligatorios';
COMMENT ON COLUMN sis.t_pensum.fec_creacion IS 'Fecha de creacion del pensum';


CREATE TABLE sis.t_prelacion (
    codigo integer NOT NULL,
    cod_pensum integer NOT NULL,
    cod_instituto integer NOT NULL,
    cod_uni_curricular integer NOT NULL,
    cod_uni_cur_prelada integer NOT NULL
);


ALTER TABLE sis.t_prelacion OWNER TO sisconot;


COMMENT ON TABLE sis.t_prelacion IS 'Tabla que almacena las prelaciones entre unidades curriculares';
COMMENT ON COLUMN sis.t_prelacion.codigo IS 'Código único de la prelación';
COMMENT ON COLUMN sis.t_prelacion.cod_pensum IS 'Código del pensum al que pertenece la prelación';
COMMENT ON COLUMN sis.t_prelacion.cod_instituto IS 'Código del instituto donde se está aplicando esta prelación';
COMMENT ON COLUMN sis.t_prelacion.cod_uni_curricular IS 'Código de la unidad curricular a establecerle la prelación';
COMMENT ON COLUMN sis.t_prelacion.cod_uni_cur_prelada IS 'Código de la unidad que no se puede cursar si no se ha aprobado esta';

CREATE TABLE sis.t_tip_uni_curricular (
    codigo character(1) NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE sis.t_tip_uni_curricular OWNER TO sisconot;

COMMENT ON TABLE sis.t_tip_uni_curricular IS 'Almacena los distintos tipos de unidades curriculares';
COMMENT ON COLUMN sis.t_tip_uni_curricular.codigo IS 'Código del tipo de unidad curricular';
COMMENT ON COLUMN sis.t_tip_uni_curricular.nombre IS 'Nombre del tipo de unidad curricular';


CREATE TABLE sis.t_trayecto (
    codigo integer NOT NULL,
    cod_pensum integer NOT NULL,
    num_trayecto smallint NOT NULL,
    certificado character varying(150),
    min_cre_obligatoria smallint DEFAULT 0 NOT NULL,
    min_cre_electiva smallint DEFAULT 0 NOT NULL,
    min_cre_acreditable smallint DEFAULT 0 NOT NULL,
    min_can_electiva smallint DEFAULT 0 NOT NULL,
    CONSTRAINT chk_t_trayecto_02 CHECK ((num_trayecto >= 0)),
    CONSTRAINT chk_t_trayecto_03 CHECK ((min_cre_obligatoria >= 0)),
    CONSTRAINT chk_t_trayecto_04 CHECK ((min_cre_electiva >= 0)),
    CONSTRAINT chk_t_trayecto_05 CHECK ((min_cre_acreditable >= 0)),
    CONSTRAINT chk_t_trayecto_06 CHECK ((min_can_electiva >= 0))
);


ALTER TABLE sis.t_trayecto OWNER TO sisconot;

COMMENT ON TABLE sis.t_trayecto IS 'Lista de trayectos, semestres o trimestres de un pensum';
COMMENT ON COLUMN sis.t_trayecto.codigo IS 'Código único del trayecto';
COMMENT ON COLUMN sis.t_trayecto.cod_pensum IS 'Código del pensum al que pertenece';
COMMENT ON COLUMN sis.t_trayecto.num_trayecto IS 'Número de trayecto, año, semestre o trimestre del pensum';
COMMENT ON COLUMN sis.t_trayecto.certificado IS 'Nombre del certificado que se obtiene al finalizar este trayecto';
COMMENT ON COLUMN sis.t_trayecto.min_cre_obligatoria IS 'Mínima cantidad de créditos en unidades curriculares obligatorias que se deben cursar en este trayecto';
COMMENT ON COLUMN sis.t_trayecto.min_cre_electiva IS 'Mínima cantidad de créditos en unidades curriculares electivas que se deben cursar en este trayecto';
COMMENT ON COLUMN sis.t_trayecto.min_cre_acreditable IS 'Mínima cantidad de créditos en actividades acreditables que se deben tener en este trayecto';
COMMENT ON COLUMN sis.t_trayecto.min_can_electiva IS 'Mínima cantidad de unidades electivas que se deben cursar en este trayecto';


CREATE TABLE sis.t_uni_curricular (
    codigo integer NOT NULL,
    cod_uni_ministerio character varying(40),
    nombre character varying(60) NOT NULL,
    hta double precision NOT NULL,
    hti double precision,
    uni_credito smallint NOT NULL,
    dur_semanas smallint NOT NULL,
    not_min_aprobatoria smallint NOT NULL,
    not_maxima smallint NOT NULL,
    descripcion character varying(100),
    observacion character varying(100),
    contenido text,
    CONSTRAINT chk_uni_curricular_01 CHECK ((codigo > 0)),
    CONSTRAINT chk_uni_curricular_02 CHECK ((hta >= (0)::double precision)),
    CONSTRAINT chk_uni_curricular_03 CHECK ((hti >= (0)::double precision)),
    CONSTRAINT chk_uni_curricular_04 CHECK ((uni_credito >= 0)),
    CONSTRAINT chk_uni_curricular_05 CHECK ((dur_semanas >= 0)),
    CONSTRAINT chk_uni_curricular_06 CHECK ((not_min_aprobatoria >= 0)),
    CONSTRAINT chk_uni_curricular_07 CHECK ((not_maxima >= not_min_aprobatoria))
);


ALTER TABLE sis.t_uni_curricular OWNER TO sisconot;


COMMENT ON TABLE sis.t_uni_curricular IS 'Tabla que almacena la información de las unidades curriculares';
COMMENT ON COLUMN sis.t_uni_curricular.codigo IS 'Código único de la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.cod_uni_ministerio IS 'Código de la unidad curricular según el ministerio';
COMMENT ON COLUMN sis.t_uni_curricular.nombre IS 'Nombre de la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.hta IS 'Horas de Trabajo Acompañado por semana(horas de clase)';
COMMENT ON COLUMN sis.t_uni_curricular.hti IS 'Horas de Trabajo Independiente por semana';
COMMENT ON COLUMN sis.t_uni_curricular.uni_credito IS 'Cantidad de unidades de crédito de la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.dur_semanas IS 'Cantidad de semanas que dura la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.not_min_aprobatoria IS 'Nota mínima con la que se aprueba la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.not_maxima IS 'Nota máxima o escala de nota de la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.descripcion IS 'descripcion adicional de la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.observacion IS 'observaciones acerca de la unidad curricular';
COMMENT ON COLUMN sis.t_uni_curricular.contenido IS 'contenido de la unidad curricular';


CREATE TABLE sis.t_uni_tra_pensum (
    codigo integer NOT NULL,
    cod_pensum integer NOT NULL,
    cod_trayecto integer,
    cod_uni_curricular integer NOT NULL,
    cod_tipo character(1) NOT NULL
);


ALTER TABLE sis.t_uni_tra_pensum OWNER TO sisconot;

COMMENT ON TABLE sis.t_uni_tra_pensum IS 'Tabla relacional entre unidad , trayecto y pensum para malla';
COMMENT ON COLUMN sis.t_uni_tra_pensum.codigo IS 'Código del pensum';
COMMENT ON COLUMN sis.t_uni_tra_pensum.cod_pensum IS 'Nombre largo del pensum';
COMMENT ON COLUMN sis.t_uni_tra_pensum.cod_trayecto IS 'Abreviación del nombre del pensum';
COMMENT ON COLUMN sis.t_uni_tra_pensum.cod_tipo IS 'Alguna otra información relevante del pensum';

/************ PIPO *****************/


CREATE TABLE sis.t_archivo (
    codigo integer NOT NULL,
    tipo character varying(30),
    archivo oid
);


ALTER TABLE sis.t_archivo OWNER TO sisconot;

COMMENT ON TABLE sis.t_archivo IS 'En la tabla Archivo se manejan las fotos de las personas';
COMMENT ON COLUMN sis.t_archivo.codigo IS 'Codigo unico con el que se identifica un archivo';
COMMENT ON COLUMN sis.t_archivo.tipo IS 'Tipo de archivo';
COMMENT ON COLUMN sis.t_archivo.archivo IS 'Es en donde va estar almacenada la imagen/archivo';

CREATE TABLE sis.t_empleado (
    codigo integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_instituto integer,
    cod_pensum integer,
    cod_estado character varying(1),
    fec_inicio date NOT NULL,
    fec_fin date,
    es_jef_pensum boolean DEFAULT false NOT NULL,
    es_jef_con_estudio boolean DEFAULT false NOT NULL,
    es_ministerio boolean DEFAULT false NOT NULL,
    es_docente boolean DEFAULT false NOT NULL,
    observaciones character varying(200),
    CONSTRAINT chk_empleado_01 CHECK ((fec_fin > fec_inicio)),
    CONSTRAINT chk_empleado_02 CHECK ((fec_inicio > '1970-01-01'::date))
);


ALTER TABLE sis.t_empleado OWNER TO sisconot;

COMMENT ON TABLE sis.t_empleado IS 'La tabla empleado almacena la informacion de los empledos';
COMMENT ON COLUMN sis.t_empleado.codigo IS 'Es el codigo unico con el que se identifica un empleado';
COMMENT ON COLUMN sis.t_empleado.cod_persona IS 'Codigo de la persona con la que esta relacionada';
COMMENT ON COLUMN sis.t_empleado.cod_instituto IS 'Codigo del instituto al que pertenece';
COMMENT ON COLUMN sis.t_empleado.cod_pensum IS 'Codigo del pensum a la que pertenece';
COMMENT ON COLUMN sis.t_empleado.cod_estado IS 'Codigo del estado que posee el empleado';
COMMENT ON COLUMN sis.t_empleado.fec_inicio IS 'Fecha en la que el empleado empezo a trabajar';
COMMENT ON COLUMN sis.t_empleado.fec_fin IS 'Fecha en la que el empleado termino de trabajar';
COMMENT ON COLUMN sis.t_empleado.es_jef_pensum IS 'Dice si un empleado es un jefe de pensum';
COMMENT ON COLUMN sis.t_empleado.es_jef_con_estudio IS 'Dice si un empleado es jefe de control de estudio';
COMMENT ON COLUMN sis.t_empleado.es_ministerio IS 'Dice si un empelado trabaja en el ministerio';
COMMENT ON COLUMN sis.t_empleado.es_docente IS 'Dice si un empleado trabaja como docente';


CREATE TABLE sis.t_est_docente (
    codigo character(1) NOT NULL,
    nombre character varying(40) NOT NULL
);


ALTER TABLE sis.t_est_docente OWNER TO sisconot;

CREATE TABLE sis.t_est_estudiante (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);

ALTER TABLE sis.t_est_estudiante OWNER TO sisconot;


CREATE TABLE sis.t_estudiante (
    codigo integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_instituto integer NOT NULL,
    cod_pensum integer NOT NULL,
    num_carnet character varying(25),
    num_expediente character varying(25),
    cod_rusnies character varying(20),
    cod_estado character(1),
    fec_inicio date NOT NULL,
    condicion character varying(5),
    fec_fin date,
    observaciones character varying(200),
    CONSTRAINT chk_docente_01 CHECK ((fec_fin > fec_inicio)),
    CONSTRAINT chk_docente_02 CHECK ((fec_inicio > '1970-01-01'::date))
);


ALTER TABLE sis.t_estudiante OWNER TO sisconot;

COMMENT ON TABLE sis.t_estudiante IS 'La tabla estudiante almacena informacion sobre los estudiantes';
COMMENT ON COLUMN sis.t_estudiante.codigo IS 'Codigo unico con el que se identifica un estudiante';
COMMENT ON COLUMN sis.t_estudiante.cod_persona IS 'Codigo de la persona con la que se relaciona';
COMMENT ON COLUMN sis.t_estudiante.cod_instituto IS 'Codigo del instituto al que pertenece';
COMMENT ON COLUMN sis.t_estudiante.cod_pensum IS 'Codigo del pensum al que pertenece el estudiante';
COMMENT ON COLUMN sis.t_estudiante.num_carnet IS 'Numero del carnet del estudiante';
COMMENT ON COLUMN sis.t_estudiante.num_expediente IS 'Numero del expediente del estudiante';
COMMENT ON COLUMN sis.t_estudiante.cod_rusnies IS 'Codigo rusnies que tiene el estudiante';
COMMENT ON COLUMN sis.t_estudiante.cod_estado IS 'Codigo del estado que posee el estudiante';
COMMENT ON COLUMN sis.t_estudiante.fec_inicio IS 'Fecha en el que el estudiante empezo a estudiar';
COMMENT ON COLUMN sis.t_estudiante.condicion IS 'Condicion que posee el estudiante';
COMMENT ON COLUMN sis.t_estudiante.fec_fin IS 'Fecha en la que el estudiante dejo de estudiar';
COMMENT ON COLUMN sis.t_estudiante.observaciones IS 'Observaciones sobre el estudiante';


CREATE TABLE sis.t_fotografia (
    cod_persona integer NOT NULL,
    tipo character varying(20),
    imagen oid
);


ALTER TABLE sis.t_fotografia OWNER TO sisconot;



CREATE TABLE sis.t_persona (
    codigo integer NOT NULL,
    cedula integer NOT NULL,
    rif character varying(20),
    nombre1 character varying(20) NOT NULL,
    nombre2 character varying(20),
    apellido1 character varying(20) NOT NULL,
    apellido2 character varying(20),
    sexo character varying(1) NOT NULL,
    fec_nacimiento date,
    tip_sangre character varying(5),
    telefono1 character varying(15),
    telefono2 character varying(15),
    cor_personal character varying(50),
    cor_institucional character varying(50),
    direccion character varying(150),
    discapacidad character varying(50),
    nacionalidad character varying(1),
    hijos integer,
    est_civil character varying(1),
    observaciones character varying(200),
    cod_foto integer,
    CONSTRAINT chk_persona_01 CHECK (((fec_nacimiento >= '1940-01-01'::date) AND (fec_nacimiento <= ('now'::text)::date))),
    CONSTRAINT chk_persona_02 CHECK (((sexo)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying])::text[]))),
    CONSTRAINT chk_persona_03 CHECK (((nacionalidad)::text = ANY ((ARRAY['V'::character varying, 'E'::character varying])::text[]))),
    CONSTRAINT chk_persona_04 CHECK (((est_civil)::text = ANY ((ARRAY['S'::character varying, 'C'::character varying, 'D'::character varying, 'V'::character varying, 'O'::character varying])::text[]))),
    CONSTRAINT chk_persona_05 CHECK ((hijos >= 0))
);


ALTER TABLE sis.t_persona OWNER TO sisconot;



COMMENT ON TABLE sis.t_persona IS 'La tabla persona almacena la informacion general de las personas';
COMMENT ON COLUMN sis.t_persona.codigo IS 'Es el codigo unico que solo pertecene a una persona';
COMMENT ON COLUMN sis.t_persona.cedula IS 'Documento de identidad de la persona';
COMMENT ON COLUMN sis.t_persona.nombre1 IS 'El primer nombre de la persona';
COMMENT ON COLUMN sis.t_persona.apellido1 IS 'El primer apellido de la persona';
COMMENT ON COLUMN sis.t_persona.fec_nacimiento IS 'Es la fecha en la que nacio la persona';
COMMENT ON COLUMN sis.t_persona.tip_sangre IS 'Es el tipo de sangre que tiene la persona';
COMMENT ON COLUMN sis.t_persona.telefono1 IS 'Es un numero telefonico a donde se puede contactar a la persona';
COMMENT ON COLUMN sis.t_persona.cor_personal IS 'Es el correo electronico que tiene una persona';
COMMENT ON COLUMN sis.t_persona.direccion IS 'Es la direccion de habitacion de la persona';
COMMENT ON COLUMN sis.t_persona.discapacidad IS 'Informacion sobre la discapacidad que tiene la persona';
COMMENT ON COLUMN sis.t_persona.nacionalidad IS 'Es la nacionalidad de la persona es decir Venezolano o extrangero';
COMMENT ON COLUMN sis.t_persona.hijos IS 'Es la cantidad de hijos que tiene la persona';
COMMENT ON COLUMN sis.t_persona.est_civil IS 'Es el estado civil que tiene la persona';
COMMENT ON COLUMN sis.t_persona.observaciones IS 'Alguna observacion que se le haga a una persona';
COMMENT ON COLUMN sis.t_persona.cod_foto IS 'Es la clave foranea de la tabla archivo que es en donde esta almacenada la foto de la persona';



/************ JUAN **************/

CREATE TABLE sis.t_acreditable (
    codigo integer NOT NULL,
    cod_estudiante integer NOT NULL,
    cod_pensum integer NOT NULL,
    cod_trayecto integer,
    uni_credito integer NOT NULL,
    fecha date,
    descripcion character varying(300) NOT NULL,
    CONSTRAINT chk_acreditable_01 CHECK ((uni_credito >= 0))
);


ALTER TABLE sis.t_acreditable OWNER TO sisconot;

COMMENT ON TABLE sis.t_acreditable IS 'Tabla que maneja las unidades de crédito acreditadas por un estudiante.';
COMMENT ON COLUMN sis.t_acreditable.codigo IS 'Código de la acreditación.';
COMMENT ON COLUMN sis.t_acreditable.cod_estudiante IS 'Código del estudiante que acreditó.';
COMMENT ON COLUMN sis.t_acreditable.cod_pensum IS 'Código del pensum en el que acreditó.';
COMMENT ON COLUMN sis.t_acreditable.cod_trayecto IS 'Código del trayecto en el que se formalizará la acreditación. Si este es null se tomará en cuenta para la carrera.';
COMMENT ON COLUMN sis.t_acreditable.uni_credito IS 'Cantidad de unidades de crédito a acreditarse.';
COMMENT ON COLUMN sis.t_acreditable.fecha IS 'Fecha en la que se produjo la acreditación.';
COMMENT ON COLUMN sis.t_acreditable.descripcion IS 'Descripción obligatoria de la acreditación. Motivo de la misma.';


CREATE TABLE sis.t_convalidacion (
    codigo integer NOT NULL,
    cod_estudiante integer NOT NULL,
    con_nota boolean,
    nota double precision,
    cod_tip_uni_curricular character(1),
    cod_pensum integer NOT NULL,
    cod_trayecto integer,
    cod_uni_curricular integer NOT NULL,
    descripcion character varying(300),
    CONSTRAINT chk_convalidacion_01 CHECK ((nota >= (0)::double precision))
);

ALTER TABLE sis.t_convalidacion OWNER TO sisconot;

COMMENT ON TABLE sis.t_convalidacion IS 'Tabla encargada de manejar las convalidaciones de un estudiante en un pensum.';
COMMENT ON COLUMN sis.t_convalidacion.codigo IS 'Código de la convalidación.';
COMMENT ON COLUMN sis.t_convalidacion.cod_estudiante IS 'Código foráneo que indica el estudiante que convalidará.';
COMMENT ON COLUMN sis.t_convalidacion.con_nota IS 'Boolean que indica si la convalidación lleva (o no) nota.';
COMMENT ON COLUMN sis.t_convalidacion.nota IS 'Nota con la que se convalidará (puede ser NULL o estar vacío)';
COMMENT ON COLUMN sis.t_convalidacion.cod_tip_uni_curricular IS 'Tipo de unidad curricular a validar';
COMMENT ON COLUMN sis.t_convalidacion.cod_pensum IS 'Código del pensum en el que se va a convalidar.';
COMMENT ON COLUMN sis.t_convalidacion.cod_trayecto IS 'Código del trayecto en el que se tomará la convalidación.';
COMMENT ON COLUMN sis.t_convalidacion.cod_uni_curricular IS 'Código de la unidad curricular que se convalidará.';
COMMENT ON COLUMN sis.t_convalidacion.descripcion IS 'Descripción de la convalidación (opcional)';

CREATE TABLE sis.t_cur_estudiante (
    codigo integer DEFAULT nextval('sis.s_cur_estudiante'::regclass) NOT NULL,
    cod_curso integer NOT NULL,
    cod_estudiante integer NOT NULL,
    por_asistencia double precision,
    nota double precision,
    cod_estado character(1),
    observaciones character varying(300),
    CONSTRAINT chk_cur_estudiante_01 CHECK ((nota >= (0)::double precision)),
    CONSTRAINT chk_cur_estudiante_02 CHECK ((por_asistencia >= (0)::double precision))
);

ALTER TABLE sis.t_cur_estudiante OWNER TO sisconot;

COMMENT ON TABLE sis.t_cur_estudiante IS 'Tabla encargada de manejar la información de un estudiante en un curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.codigo IS 'Código único del registro, llave primaria';
COMMENT ON COLUMN sis.t_cur_estudiante.cod_curso IS 'Código del curso en el que está el estudiante.';
COMMENT ON COLUMN sis.t_cur_estudiante.cod_estudiante IS 'Código del estudiante al que se hace referencia.';
COMMENT ON COLUMN sis.t_cur_estudiante.por_asistencia IS 'Porcentaje de asistencia del estudiante en el curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.nota IS 'Nota del estudiante en el curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.cod_estado IS 'Estado del estudiante en el curso.';
COMMENT ON COLUMN sis.t_cur_estudiante.observaciones IS 'Observaciones del estudiante en el curso.';


CREATE TABLE sis.t_curso (
    codigo integer DEFAULT nextval('sis.s_curso'::regclass) NOT NULL,
    cod_periodo integer NOT NULL,
    cod_uni_curricular integer NOT NULL,
    cod_docente integer,
    seccion character varying(5) NOT NULL,
    fec_inicio date,
    fec_final date,
    capacidad smallint,
    observaciones character varying(300),
    cod_estado character(1),
    CONSTRAINT chk_curso_01 CHECK ((fec_inicio < fec_final)),
    CONSTRAINT chk_curso_02 CHECK ((capacidad >= 0)),
    CONSTRAINT chk_curso_03 CHECK ((length(btrim((seccion)::text)) > 0))
);

ALTER TABLE sis.t_curso OWNER TO sisconot;

COMMENT ON TABLE sis.t_curso IS 'Tabla encargada de manejar los cursos abiertos de una unidad curricular.';
COMMENT ON COLUMN sis.t_curso.codigo IS 'Código del curso';
COMMENT ON COLUMN sis.t_curso.cod_periodo IS 'Código del periodo al que pertenece el curso.';
COMMENT ON COLUMN sis.t_curso.cod_uni_curricular IS 'Código de la unidad curricular que se dictará en el curso.';
COMMENT ON COLUMN sis.t_curso.cod_docente IS 'Código del docente que dictará el curso.';
COMMENT ON COLUMN sis.t_curso.seccion IS 'Sección a la que pertenece el curso.';
COMMENT ON COLUMN sis.t_curso.fec_inicio IS 'Fecha de inicio del curso.';
COMMENT ON COLUMN sis.t_curso.fec_final IS 'Fecha de finalización del curso.';
COMMENT ON COLUMN sis.t_curso.capacidad IS 'Cantidad máxima de estudiantes que se pueden aceptar en el curso.';
COMMENT ON COLUMN sis.t_curso.observaciones IS 'Observaciones del curso.';
COMMENT ON COLUMN sis.t_curso.cod_estado IS 'Reservado para el estado del curso(abierto, cerrado).';


CREATE TABLE sis.t_electiva (
    codigo integer NOT NULL,
    cod_cur_estudiante integer,
    cod_pensum integer NOT NULL,
    cod_trayecto integer
);


ALTER TABLE sis.t_electiva OWNER TO sisconot;

COMMENT ON TABLE sis.t_electiva IS 'Tabla encargada de manejar las electivas atadas a un estudiante.';
COMMENT ON COLUMN sis.t_electiva.codigo IS 'Código único del registro, llave primaria';
COMMENT ON COLUMN sis.t_electiva.cod_cur_estudiante IS 'Llave foránea de curso_estudiante, se refiere al curso que respalda la electiva';
COMMENT ON COLUMN sis.t_electiva.cod_pensum IS 'Llave foránea del pensum al que pertenece la electiva.';
COMMENT ON COLUMN sis.t_electiva.cod_trayecto IS 'Llave foránea del trayecto al que pertenece la electiva.';

CREATE TABLE sis.t_est_cur_estudiante (
    codigo character(1) NOT NULL,
    nombre character varying(30)
);


ALTER TABLE sis.t_est_cur_estudiante OWNER TO sisconot;

COMMENT ON TABLE sis.t_est_cur_estudiante IS 'Tabla que maneja los estados de un estudiante dentro de un curso.';
COMMENT ON COLUMN sis.t_est_cur_estudiante.codigo IS 'Código del estado';
COMMENT ON COLUMN sis.t_est_cur_estudiante.nombre IS 'Nombre del estado';


CREATE TABLE sis.t_est_periodo (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_periodo OWNER TO sisconot;

COMMENT ON TABLE sis.t_est_periodo IS 'Estado que determina si el periodo académico ha finalizado o no (abierto o cerrado)';
COMMENT ON COLUMN sis.t_est_periodo.codigo IS 'Código del estado.';
COMMENT ON COLUMN sis.t_est_periodo.nombre IS 'Nombre del estado del periodo académico.';


CREATE TABLE sis.t_periodo (
    codigo integer NOT NULL,
    nombre character varying(30),
    cod_instituto integer NOT NULL,
    cod_pensum integer NOT NULL,
    fec_inicio date NOT NULL,
    fec_final date,
    observaciones character varying(150),
    cod_estado character(1) NOT NULL,
    CONSTRAINT chk_periodo_01 CHECK ((codigo > 0)),
    CONSTRAINT chk_periodo_02 CHECK ((fec_inicio < fec_final))
);

ALTER TABLE sis.t_periodo OWNER TO sisconot;

COMMENT ON TABLE sis.t_periodo IS 'Tabla que almacena la información de un periodo académico.';
COMMENT ON COLUMN sis.t_periodo.codigo IS 'Código del periodo';
COMMENT ON COLUMN sis.t_periodo.nombre IS 'Nombre del periodo académico';
COMMENT ON COLUMN sis.t_periodo.cod_instituto IS 'Clave foránea del instituto que abre el periodo.';
COMMENT ON COLUMN sis.t_periodo.cod_pensum IS 'Clave foránea del pensum que se dicta en el periodo.';
COMMENT ON COLUMN sis.t_periodo.fec_inicio IS 'Fecha de inicio del periodo académico.';
COMMENT ON COLUMN sis.t_periodo.fec_final IS 'Fecha de finalización del periodo académico.';
COMMENT ON COLUMN sis.t_periodo.observaciones IS 'Observaciones del periodo académico.';
COMMENT ON COLUMN sis.t_periodo.cod_estado IS 'Estado del periodo académico (Abierto o Cerrado en el momento de creación del sistema)';


/*********       llaves alternaticas y primarias                              *********/

ALTER TABLE ONLY sis.t_instituto
    ADD CONSTRAINT ca_instituto UNIQUE (nom_corto);
ALTER TABLE ONLY sis.t_pensum
    ADD CONSTRAINT ca_pensum UNIQUE (nom_corto);
ALTER TABLE ONLY sis.t_prelacion
    ADD CONSTRAINT ca_prelacion UNIQUE (cod_uni_curricular, cod_uni_cur_prelada);
ALTER TABLE ONLY sis.t_trayecto
    ADD CONSTRAINT ca_trayecto UNIQUE (num_trayecto, cod_pensum);
ALTER TABLE ONLY sis.t_uni_curricular
    ADD CONSTRAINT ca_uni_curricular UNIQUE (cod_uni_ministerio);

ALTER TABLE ONLY sis.t_empleado
    ADD CONSTRAINT ca_empleado UNIQUE (cod_persona, cod_instituto, cod_pensum, fec_inicio);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT ca_estudiante UNIQUE (cod_persona, cod_instituto, cod_pensum, fec_inicio);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT ca_estudiante_01 UNIQUE (num_carnet);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT ca_estudiante_02 UNIQUE (num_expediente);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT ca_estudiante_03 UNIQUE (cod_rusnies);
ALTER TABLE ONLY sis.t_persona
    ADD CONSTRAINT ca_persona_01 UNIQUE (cedula);
ALTER TABLE ONLY sis.t_persona
    ADD CONSTRAINT ca_persona_02 UNIQUE (rif);
ALTER TABLE ONLY sis.t_persona
    ADD CONSTRAINT ca_persona_03 UNIQUE (cor_personal);
ALTER TABLE ONLY sis.t_persona
    ADD CONSTRAINT ca_persona_04 UNIQUE (cor_institucional);

ALTER TABLE ONLY sis.t_convalidacion
    ADD CONSTRAINT ca_convalidacion_01 UNIQUE (cod_estudiante, cod_pensum, cod_uni_curricular);
ALTER TABLE ONLY sis.t_cur_estudiante
    ADD CONSTRAINT ca_cur_estudiante UNIQUE (cod_curso, cod_estudiante);
ALTER TABLE ONLY sis.t_curso
    ADD CONSTRAINT ca_curso_01 UNIQUE (cod_periodo, cod_uni_curricular, seccion);
ALTER TABLE ONLY sis.t_electiva
    ADD CONSTRAINT ca_electiva UNIQUE (cod_cur_estudiante, cod_pensum);
ALTER TABLE ONLY sis.t_periodo
    ADD CONSTRAINT ca_periodo UNIQUE (cod_instituto, cod_pensum, fec_inicio);

ALTER TABLE ONLY sis.t_instituto
    ADD CONSTRAINT cp_instituto PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_pensum
    ADD CONSTRAINT cp_pensum PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_prelacion
    ADD CONSTRAINT cp_prelacion PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_trayecto
    ADD CONSTRAINT cp_trayecto PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_tip_uni_curricular
    ADD CONSTRAINT cp_uni_cur_tipo PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_uni_curricular
    ADD CONSTRAINT cp_uni_curricular PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_uni_tra_pensum
    ADD CONSTRAINT cp_uni_tra_pensum PRIMARY KEY (codigo);

ALTER TABLE ONLY sis.t_archivo
    ADD CONSTRAINT cp_archivo PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_empleado
    ADD CONSTRAINT cp_empleado PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_est_docente
    ADD CONSTRAINT cp_est_docente PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT cp_estudiante PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_fotografia
    ADD CONSTRAINT cp_fotografia PRIMARY KEY (cod_persona);
ALTER TABLE ONLY sis.t_persona
    ADD CONSTRAINT cp_persona PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_est_estudiante
    ADD CONSTRAINT cp_est_estudiante PRIMARY KEY (codigo);


ALTER TABLE ONLY sis.t_convalidacion
    ADD CONSTRAINT cp_convalidacion PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_acreditable
    ADD CONSTRAINT cp_acreditable PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_cur_estudiante
    ADD CONSTRAINT cp_cur_estudiante PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_curso
    ADD CONSTRAINT cp_curso PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_electiva
    ADD CONSTRAINT cp_electiva PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_est_cur_estudiante
    ADD CONSTRAINT cp_est_cur_estudiante PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_est_periodo
    ADD CONSTRAINT cp_est_periodo PRIMARY KEY (codigo);
ALTER TABLE ONLY sis.t_periodo
    ADD CONSTRAINT cp_periodo PRIMARY KEY (codigo);


ALTER TABLE ONLY sis.t_prelacion
    ADD CONSTRAINT cf_prelacion__instituto FOREIGN KEY (cod_instituto) REFERENCES sis.t_instituto(codigo);
ALTER TABLE ONLY sis.t_prelacion
    ADD CONSTRAINT cf_prelacion__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_prelacion
    ADD CONSTRAINT cf_prelacion__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES sis.t_uni_curricular(codigo);
ALTER TABLE ONLY sis.t_prelacion
    ADD CONSTRAINT cf_prelacion__uni_curricular_prelada FOREIGN KEY (cod_uni_cur_prelada) REFERENCES sis.t_uni_curricular(codigo);
ALTER TABLE ONLY sis.t_trayecto
    ADD CONSTRAINT cf_trayecto_pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__tip_uni_curricular FOREIGN KEY (cod_tipo) REFERENCES sis.t_tip_uni_curricular(codigo);
ALTER TABLE ONLY sis.t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__trayecto FOREIGN KEY (cod_trayecto) REFERENCES sis.t_trayecto(codigo);
ALTER TABLE ONLY sis.t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES sis.t_uni_curricular(codigo);

ALTER TABLE ONLY sis.t_empleado
    ADD CONSTRAINT cf_empleado__est_docente FOREIGN KEY (cod_estado) REFERENCES sis.t_est_docente(codigo);
ALTER TABLE ONLY sis.t_empleado
    ADD CONSTRAINT cf_empleado__instituto FOREIGN KEY (cod_instituto) REFERENCES sis.t_instituto(codigo);
ALTER TABLE ONLY sis.t_empleado
    ADD CONSTRAINT cf_empleado__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_empleado
    ADD CONSTRAINT cf_empleado__persona FOREIGN KEY (cod_persona) REFERENCES sis.t_persona(codigo);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT cf_estudiante__est_estado FOREIGN KEY (cod_estado) REFERENCES sis.t_est_estudiante(codigo);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT cf_estudiante__instituto FOREIGN KEY (cod_instituto) REFERENCES sis.t_instituto(codigo);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT cf_estudiante__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_estudiante
    ADD CONSTRAINT cf_estudiante__persona FOREIGN KEY (cod_persona) REFERENCES sis.t_persona(codigo);
ALTER TABLE ONLY sis.t_persona
    ADD CONSTRAINT cf_persona__archivo FOREIGN KEY (cod_foto) REFERENCES sis.t_archivo(codigo);

ALTER TABLE ONLY sis.t_convalidacion
    ADD CONSTRAINT cf_convalidacion__estudiante FOREIGN KEY (cod_estudiante) REFERENCES sis.t_estudiante(codigo);
ALTER TABLE ONLY sis.t_convalidacion
    ADD CONSTRAINT cf_convalidacion__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_convalidacion
    ADD CONSTRAINT cf_convalidacion__trayecto FOREIGN KEY (cod_trayecto) REFERENCES sis.t_trayecto(codigo);
ALTER TABLE ONLY sis.t_convalidacion
    ADD CONSTRAINT cf_convalidacion__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES sis.t_uni_curricular(codigo);
ALTER TABLE ONLY sis.t_convalidacion
    ADD CONSTRAINT cf_convalidadcion__tip_uni_curricular FOREIGN KEY (cod_tip_uni_curricular) REFERENCES sis.t_tip_uni_curricular(codigo);
ALTER TABLE ONLY sis.t_acreditable
    ADD CONSTRAINT cf_acreditable__estudiante FOREIGN KEY (cod_estudiante) REFERENCES sis.t_persona(codigo);
ALTER TABLE ONLY sis.t_acreditable
    ADD CONSTRAINT cf_acreditable__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_acreditable
    ADD CONSTRAINT cf_acreditable__trayecto FOREIGN KEY (cod_trayecto) REFERENCES sis.t_trayecto(codigo);
ALTER TABLE ONLY sis.t_cur_estudiante
    ADD CONSTRAINT cf_cur_estudiante__curso FOREIGN KEY (cod_curso) REFERENCES sis.t_curso(codigo);
ALTER TABLE ONLY sis.t_cur_estudiante
    ADD CONSTRAINT cf_cur_estudiante__est_cur_estudiante FOREIGN KEY (cod_estado) REFERENCES sis.t_est_cur_estudiante(codigo);
ALTER TABLE ONLY sis.t_cur_estudiante
    ADD CONSTRAINT cf_cur_estudiante__estudiante FOREIGN KEY (cod_estudiante) REFERENCES sis.t_persona(codigo);
ALTER TABLE ONLY sis.t_curso
    ADD CONSTRAINT cf_curso__docente FOREIGN KEY (cod_docente) REFERENCES sis.t_persona(codigo);
ALTER TABLE ONLY sis.t_curso
    ADD CONSTRAINT cf_curso__periodo FOREIGN KEY (cod_periodo) REFERENCES sis.t_periodo(codigo);
ALTER TABLE ONLY sis.t_curso
    ADD CONSTRAINT cf_curso__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES sis.t_uni_curricular(codigo);
ALTER TABLE ONLY sis.t_electiva
    ADD CONSTRAINT cf_electiva__cur_estudiante FOREIGN KEY (cod_cur_estudiante) REFERENCES sis.t_cur_estudiante(codigo);
ALTER TABLE ONLY sis.t_electiva
    ADD CONSTRAINT cf_electiva__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);
ALTER TABLE ONLY sis.t_electiva
    ADD CONSTRAINT cf_electiva__trayecto FOREIGN KEY (cod_trayecto) REFERENCES sis.t_trayecto(codigo);
ALTER TABLE ONLY sis.t_periodo
    ADD CONSTRAINT cf_periodo__est_periodo FOREIGN KEY (cod_estado) REFERENCES sis.t_est_periodo(codigo);
ALTER TABLE ONLY sis.t_periodo
    ADD CONSTRAINT cf_periodo__instituto FOREIGN KEY (cod_instituto) REFERENCES sis.t_instituto(codigo);
ALTER TABLE ONLY sis.t_periodo
    ADD CONSTRAINT cf_periodo__pensum FOREIGN KEY (cod_pensum) REFERENCES sis.t_pensum(codigo);



/**------------------------  DATA PARA PREUBA -----------------------------------------------------------------------**/


INSERT INTO sis.t_est_periodo(
            codigo, nombre)
    VALUES (1, 'Abierto');
INSERT INTO sis.t_est_periodo(
            codigo, nombre)
    VALUES (2, 'Cerrado');

INSERT INTO sis.t_instituto(
            codigo, nom_corto, nombre, direccion)
    VALUES (1, 'iutfrp', 'IUT Federico Ribero', 'k8 de la panamericana');

INSERT INTO sis.t_instituto(
            codigo, nom_corto, nombre, direccion)
    VALUES (2, 'iutculca', 'IUT culcat de los teques', 'los teques frente al metro');
INSERT INTO sis.t_instituto(
            codigo, nom_corto, nombre, direccion)
    VALUES (3, 'iutrfn', 'IUT rufino ', 'caracas');

INSERT INTO sis.t_pensum(
            codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva, 
            min_cre_obligatoria, fec_creacion)
    VALUES (3,	'pnf_informatica_ing',	'pnfg',	'pensum de informatica ing 2016' ,	2,	1,	2,	'2016-05-13');

INSERT INTO sis.t_pensum(
            codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva, 
            min_cre_obligatoria, fec_creacion)
    VALUES (2,	'pnf_quimica',	'pnq',	'pensum de quimica 2016', 	2,	4,	9,	'2016-03-02');

INSERT INTO sis.t_pensum(
            codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva, 
            min_cre_obligatoria, fec_creacion)
    VALUES (1,	'pnf_informatica',	'pnf',	'pensum de informativa 2016' ,	2,	4,	2,	'2008-05-13');

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, 
            not_min_aprobatoria, not_maxima, descripcion, observacion, contenido)
    VALUES (1	,"PNS019",	"PROYECTO NACIONAL Y NUEVA CIUDADANÍA",	50,	50,	4,	12,	10,	20,	"PROYECTO NACIONAL Y NUEVA CIUDADANÍA de trayecto inicial",		"1) tema 1 la vida 2) la exposicion 3)examen"
);


INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, 
            not_min_aprobatoria, not_maxima, descripcion, observacion, contenido)
    VALUES (2	,"PNS025",	"PROYECTO NACIONAL",	50,	55,	46,	10,	15,	20,	"PROYECTO de trayecto inicial",		"1) tema la exposicion 3)examen"
);

INSERT INTO sis.t_uni_curricular(
            codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, 
            not_min_aprobatoria, not_maxima, descripcion, observacion, contenido)
    VALUES (3	,"MAC015",	"MATEMÁTICA",	50,	55,	46,	10,	15,	20,	"matematica de trayecto inicial",		"1) tema la exposicion 3)examen"
);

INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (1	1	1	1	1);

INSERT INTO sis.t_tip_uni_curricular(
            codigo, nombre)
    VALUES (1,	'Electiva');

INSERT INTO sis.t_tip_uni_curricular(
            codigo, nombre)
    VALUES (2,	'Obligatoria');

INSERT INTO sis.t_trayecto(
            codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, 
            min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (1,	1,	2,	'z-23213 tsu informatica',	105,	8,	4,	4);

INSERT INTO sis.t_trayecto(
            codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, 
            min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (2,	13,	2,	'z-23215 ing Informatica',	120,	8,	6,	5);

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (1,	1,	null,	1,	2);

INSERT INTO sis.t_uni_tra_pensum(
            codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (2,	1,	2,	1,	2);


INSERT INTO sis.t_est_periodo values('A','Abierto');
INSERT INTO sis.t_est_periodo values('C','Cerrado');
INSERT INTO sis.t_est_cur_estudiante values('C','Cursando');
INSERT INTO sis.t_est_cur_estudiante values('A','Aprobado');
INSERT INTO sis.t_est_cur_estudiante values('R','Reprobado');

INSERT INTO sis.t_periodo values(1,'2016-2016',1,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(2,'2016-2016',2,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(3,'2016-2016',3,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(4,'2016-2016',4,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(5,'2016-2016',5,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(6,'2016-2016',6,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(7,'2016-2016',7,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(8,'2016-2016',8,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(9,'2016-2016',9,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(10,'2016-2016',10,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(11,'2016-2016',11,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(12,'2016-2016',12,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(13,'2016-2016',13,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(14,'2016-2016',14,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(15,'2016-2016',15,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(16,'2016-2016',16,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(17,'2016-2016',17,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(18,'2016-2016',18,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(19,'2016-2016',19,1,'2016-01-01','2017-01-01','','A');
INSERT INTO sis.t_periodo values(20,'2016-2016',20,1,'2016-01-01','2017-01-01','','A');

INSERT INTO sis.t_curso values(1,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(1,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(1,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(1,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(1,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(2,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(2,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(2,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(2,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(2,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(3,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(3,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(3,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(3,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(3,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(4,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(4,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(4,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(4,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(4,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(5,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(5,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(5,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(5,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(5,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(6,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(6,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(6,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(6,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(6,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(7,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(7,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(7,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(7,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(7,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(8,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(8,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(8,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(8,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(8,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(9,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(9,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(9,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(9,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(9,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(10,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(10,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(10,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(10,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(10,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(11,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(11,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(11,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(11,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(11,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(12,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(12,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(12,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(12,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(12,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(13,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(13,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(13,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(13,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(13,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(14,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(14,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(14,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(14,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(14,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(15,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(15,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(15,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(15,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(15,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(16,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(16,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(16,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(16,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(16,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(17,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(17,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(17,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(17,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(17,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(18,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(18,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(18,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(18,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(18,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(19,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(19,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(19,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(19,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(19,1,5,5,'A','','',30,'','');
INSERT INTO sis.t_curso values(20,1,1,1,'A','','',30,'','');
INSERT INTO sis.t_curso values(20,1,2,2,'A','','',30,'','');
INSERT INTO sis.t_curso values(20,1,3,3,'A','','',30,'','');
INSERT INTO sis.t_curso values(20,1,4,4,'A','','',30,'','');
INSERT INTO sis.t_curso values(20,1,5,5,'A','','',30,'','');

INSERT INTO sis.t_cur_estudiante values(1,1,1,'','','C','');
INSERT INTO sis.t_cur_estudiante values(1,2,1,'','','C','');
INSERT INTO sis.t_cur_estudiante values(1,3,1,'','','C','');
INSERT INTO sis.t_cur_estudiante values(1,4,1,'','','C','');
INSERT INTO sis.t_cur_estudiante values(1,5,1,'','','C','');
INSERT INTO sis.t_cur_estudiante values(2,1,2,'','','C','');
INSERT INTO sis.t_cur_estudiante values(2,2,2,'','','C','');
INSERT INTO sis.t_cur_estudiante values(2,3,2,'','','C','');
INSERT INTO sis.t_cur_estudiante values(2,4,2,'','','C','');
INSERT INTO sis.t_cur_estudiante values(2,5,2,'','','C','');
INSERT INTO sis.t_cur_estudiante values(3,1,3,'','','C','');
INSERT INTO sis.t_cur_estudiante values(3,2,3,'','','C','');
INSERT INTO sis.t_cur_estudiante values(3,3,3,'','','C','');
INSERT INTO sis.t_cur_estudiante values(3,4,3,'','','C','');
INSERT INTO sis.t_cur_estudiante values(3,5,3,'','','C','');
INSERT INTO sis.t_cur_estudiante values(4,1,4,'','','C','');
INSERT INTO sis.t_cur_estudiante values(4,2,4,'','','C','');
INSERT INTO sis.t_cur_estudiante values(4,3,4,'','','C','');
INSERT INTO sis.t_cur_estudiante values(4,4,4,'','','C','');
INSERT INTO sis.t_cur_estudiante values(4,5,4,'','','C','');
INSERT INTO sis.t_cur_estudiante values(5,1,5,'','','C','');
INSERT INTO sis.t_cur_estudiante values(5,2,5,'','','C','');
INSERT INTO sis.t_cur_estudiante values(5,3,5,'','','C','');
INSERT INTO sis.t_cur_estudiante values(5,4,5,'','','C','');
INSERT INTO sis.t_cur_estudiante values(5,5,5,'','','C','');
INSERT INTO sis.t_cur_estudiante values(6,1,6,'','','C','');
INSERT INTO sis.t_cur_estudiante values(6,2,6,'','','C','');
INSERT INTO sis.t_cur_estudiante values(6,3,6,'','','C','');
INSERT INTO sis.t_cur_estudiante values(6,4,6,'','','C','');
INSERT INTO sis.t_cur_estudiante values(6,5,6,'','','C','');
INSERT INTO sis.t_cur_estudiante values(7,1,7,'','','C','');
INSERT INTO sis.t_cur_estudiante values(7,2,7,'','','C','');
INSERT INTO sis.t_cur_estudiante values(7,3,7,'','','C','');
INSERT INTO sis.t_cur_estudiante values(7,4,7,'','','C','');
INSERT INTO sis.t_cur_estudiante values(7,5,7,'','','C','');
INSERT INTO sis.t_cur_estudiante values(8,1,8,'','','C','');
INSERT INTO sis.t_cur_estudiante values(8,2,8,'','','C','');
INSERT INTO sis.t_cur_estudiante values(8,3,8,'','','C','');
INSERT INTO sis.t_cur_estudiante values(8,4,8,'','','C','');
INSERT INTO sis.t_cur_estudiante values(8,5,8,'','','C','');
INSERT INTO sis.t_cur_estudiante values(9,1,9,'','','C','');
INSERT INTO sis.t_cur_estudiante values(9,2,9,'','','C','');
INSERT INTO sis.t_cur_estudiante values(9,3,9,'','','C','');
INSERT INTO sis.t_cur_estudiante values(9,4,9,'','','C','');
INSERT INTO sis.t_cur_estudiante values(9,5,9,'','','C','');

INSERT INTO sis.t_cur_estudiante values(10,1,10,'','','C','');
INSERT INTO sis.t_cur_estudiante values(10,2,10,'','','C','');
INSERT INTO sis.t_cur_estudiante values(10,3,10,'','','C','');
INSERT INTO sis.t_cur_estudiante values(10,4,10,'','','C','');
INSERT INTO sis.t_cur_estudiante values(10,5,10,'','','C','');
INSERT INTO sis.t_cur_estudiante values(11,1,11,'','','C','');
INSERT INTO sis.t_cur_estudiante values(11,2,11,'','','C','');
INSERT INTO sis.t_cur_estudiante values(11,3,11,'','','C','');
INSERT INTO sis.t_cur_estudiante values(11,4,11,'','','C','');
INSERT INTO sis.t_cur_estudiante values(11,5,11,'','','C','');
INSERT INTO sis.t_cur_estudiante values(12,1,12,'','','C','');
INSERT INTO sis.t_cur_estudiante values(12,2,12,'','','C','');
INSERT INTO sis.t_cur_estudiante values(12,3,12,'','','C','');
INSERT INTO sis.t_cur_estudiante values(12,4,12,'','','C','');
INSERT INTO sis.t_cur_estudiante values(12,5,12,'','','C','');
INSERT INTO sis.t_cur_estudiante values(13,1,13,'','','C','');
INSERT INTO sis.t_cur_estudiante values(13,2,13,'','','C','');
INSERT INTO sis.t_cur_estudiante values(13,3,13,'','','C','');
INSERT INTO sis.t_cur_estudiante values(13,4,13,'','','C','');
INSERT INTO sis.t_cur_estudiante values(13,5,13,'','','C','');
INSERT INTO sis.t_cur_estudiante values(14,1,14,'','','C','');
INSERT INTO sis.t_cur_estudiante values(14,2,14,'','','C','');
INSERT INTO sis.t_cur_estudiante values(14,3,14,'','','C','');
INSERT INTO sis.t_cur_estudiante values(14,4,14,'','','C','');
INSERT INTO sis.t_cur_estudiante values(14,5,14,'','','C','');
INSERT INTO sis.t_cur_estudiante values(15,1,15,'','','C','');
INSERT INTO sis.t_cur_estudiante values(15,2,15,'','','C','');
INSERT INTO sis.t_cur_estudiante values(15,3,15,'','','C','');
INSERT INTO sis.t_cur_estudiante values(15,4,15,'','','C','');
INSERT INTO sis.t_cur_estudiante values(15,5,15,'','','C','');
INSERT INTO sis.t_cur_estudiante values(16,1,16,'','','C','');
INSERT INTO sis.t_cur_estudiante values(16,2,16,'','','C','');
INSERT INTO sis.t_cur_estudiante values(16,3,16,'','','C','');
INSERT INTO sis.t_cur_estudiante values(16,4,16,'','','C','');
INSERT INTO sis.t_cur_estudiante values(16,5,16,'','','C','');
INSERT INTO sis.t_cur_estudiante values(17,1,17,'','','C','');
INSERT INTO sis.t_cur_estudiante values(17,2,17,'','','C','');
INSERT INTO sis.t_cur_estudiante values(17,3,17,'','','C','');
INSERT INTO sis.t_cur_estudiante values(17,4,17,'','','C','');
INSERT INTO sis.t_cur_estudiante values(17,5,17,'','','C','');
INSERT INTO sis.t_cur_estudiante values(18,1,18,'','','C','');
INSERT INTO sis.t_cur_estudiante values(18,2,18,'','','C','');
INSERT INTO sis.t_cur_estudiante values(18,3,18,'','','C','');
INSERT INTO sis.t_cur_estudiante values(18,4,18,'','','C','');
INSERT INTO sis.t_cur_estudiante values(18,5,18,'','','C','');
INSERT INTO sis.t_cur_estudiante values(19,1,19,'','','C','');
INSERT INTO sis.t_cur_estudiante values(19,2,19,'','','C','');
INSERT INTO sis.t_cur_estudiante values(19,3,19,'','','C','');
INSERT INTO sis.t_cur_estudiante values(19,4,19,'','','C','');
INSERT INTO sis.t_cur_estudiante values(19,5,19,'','','C','');
INSERT INTO sis.t_cur_estudiante values(20,1,20,'','','C','');
INSERT INTO sis.t_cur_estudiante values(20,2,20,'','','C','');
INSERT INTO sis.t_cur_estudiante values(20,3,20,'','','C','');
INSERT INTO sis.t_cur_estudiante values(20,4,20,'','','C','');
INSERT INTO sis.t_cur_estudiante values(20,5,20,'','','C','');

INSERT INTO sis.t_electiva values (1,1,1,1);
INSERT INTO sis.t_electiva values (1,2,1,1);
INSERT INTO sis.t_electiva values (1,3,1,1);
INSERT INTO sis.t_electiva values (1,4,1,1);
INSERT INTO sis.t_electiva values (1,5,1,1);

INSERT INTO sis.t_convalidacion values (1,1,false,20,O,1,1,1,'');
INSERT INTO sis.t_convalidacion values (1,2,false,20,O,1,1,1,'');
INSERT INTO sis.t_convalidacion values (1,3,false,20,O,1,1,1,'');

insert into sis.t_est_estudiante (codigo, nombre) values ('A','Activo');
insert into sis.t_est_estudiante (codigo, nombre) values ('G','Graduado');
insert into sis.t_est_estudiante (codigo, nombre) values ('R','Retirado');
insert into sis.t_est_estudiante (codigo, nombre) values ('I','Inactivo');


insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(1,11111,null,'jean',null,'sosa',null,'M','25/1/1996','A+','1111111',null,'jean@hotmail.com',null,'san atnnio',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(2,2222,null,'jorge',null,'gomez','pedrozo','M','2/9/1968','A+','222222',null,'jorge@hotmail.com',null,'san atnnio',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(3,3333,null,'alicia','magarita','gomez','lopez','F','5/12/1985','O+','333333',null,'alicia_e@yahoo.com',null,'petare',null,'V',2,'C',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(4,44444,'V-444445','Kelly','ana','isturis','mansalba','F','20/12/1983','O+','2356545',null,'la_chiqui@yahoo.com',null,'la urbina frente cdolnlds','le fata un brazo','E',0,'S','le falta el titulo');insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(5,6453423,'V-444675','ramon',null,'morales','perez','M','25/3/1963','A-','8675645',null,'rmonsqui@gmail.com',null,'manzanares','es mudo','V',3,'C',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(6,5674534,null,'rafael','ramon','garcia','rojas','M','15/2/1966','O-','7564543',null,'elrafael420i@gmail.com',null,'buenos aires',null,'E',0,'D',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(7,34532,'V-345344','Angelica','sabrina','rojas','perez','F','12/8/1986','O-','7564534',null,'angelik@hotmail.com',null,'el picacho','le falta un dedo','V',0,'V',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(8,8676543,null,'evelyn',null,'armas',null,'F','10/3/1973','AB+','54634523',null,'argrilment@hotmail.com',null,null,null,'V',0,'V',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(9,987685,null,'arianna','valentina','diaz','armas','F','3/9/1988','AB-','765',null,'ariannita@yahoo.com',null,null,null,'E',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(10,6757546,null,'stephany',null,'mendozA','rojas','F','2/6/1993','AB-','76456232',null,'stephanymen@yahoo.com',null,'catia',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(11,67575333,null,'simon','alfonso','rodriguez',null,'M','8/2/1994','O-','798676545','56467576','sminro@yahoo.com',null,'san antonio',null,'V',2,'D',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(12,867546554,'V-5546545','alfonso','mundo','de la cruz','sosa','M','24/8/1966','O-','9877686','98766544','alfos@yahoo.com','alfos@iutfrp.com','las bermudez',null,'V',2,'D',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(13,89786,null,'hilda','andrea','lopez','lorenzo','F','22/9/1961','O+','87654','465788','andahil@yahoo.com','andahil@iutfrp.com','las bermudez',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(14,23345567,null,'gisel','alejandra','mascoli','sanchez','F','26/11/1989','O+','68574333','5678999','gigiGl@yahoo.com','gigigi@iutfrp.com','las bermudez',null,'E',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(15,786574,null,'johan','alejandro','sanchez','palomera','M','20/6/1989','O+','98765','546576','aleale@gmail.com','alejo@iutfrp.com','catia','le falta una oreja','E',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(16,9897228,null,'marco','alejandro','de sousa',null,'M','23/5/1973','O+','23345556','6456453','ellococo@gmail.com',null,'la dolorita','le falta un ojo','V',2,'V',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(17,88767456,null,'maria ','jose','hernandez','de la paz','F','5/6/1970','O-','2132545','3433242','lachica@gmail.com',null,'el hatillo',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(18,4634524,null,'jose','maria','perez','lorenzo','M','19/7/1981','O-','1234256','4564534','eljose@gmail.com',null,'la trinidad',null,'V',1,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(19,54635343,null,'juan','armanndo','paredes',null,'M','21/10/1988','O-','2343564','234355','armandilo@gmail.com',null,'el limon',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(20,86786,null,'alejandro',null,'hernandez',null,'M','22/6/1960','O-','2346655','7833423','elhen@gmail.com',null,'la morita',null,'V',0,'S','le falta la foto');insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(21,34242343,null,'carolina','alejandra','segura','salcedo','F','1/4/1992','A+','12324235','12425555','carol@gmail.com','carol@iutfrp.com','el picacho',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(22,8978675,null,'cintia',null,'malabares','vegas','F','29/12/1961','A+','21454543','355767','chnty@gmail.com',null,'el picacho',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(23,2134238,null,'kimberlin','andreina','nuñez','chang','F','2/12/1980','A+','23132453','13244444','kimim@gmail.com',null,'el cuji',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(24,12343,null,'alejandra',null,'nuñez','chang','F','13/8/1968','A+','3245465','56453333','alejigmail.com',null,'el cuji',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(25,5454354,null,'hugo',null,'herrada',null,'M','25/5/1965','A+-','52334','25354','huguo@gmail.com',null,'OPS',null,'V',2,'C',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(26,2423423,null,'gianfranco',null,'brito','diaz','M','4/1/1979','A+','2423425','324324234','diaznoche@gmail.com',null,'el picacho',null,'V',0,'C',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(27,2324536,null,'adriana','edith','andrada',null,'F','26/2/1997','O-','432333423','12321322','andriana@gmail.com',null,'el patio',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(28,2324324,null,'diana','vanessa','luggo','nastasi','F','17/8/1963','O-','32434',null,'venenasta@gmail.com',null,'san antnio',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(29,23424234,null,'alexandra',null,'valbuena','nuñez','F','1/3/1974','O-','454465645',null,'elexaval@gmail.com',null,'san antnio',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(30,4343566,null,'maired',null,'mejia',null,'F','14/8/1969','O-','33454',null,'mairedmeji@gmail.com',null,null,null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(31,2356777,null,'laura','maria','sosa','garcias','F','5/2/1975','O-','35345435',null,'lalalu@yahoo.com',null,'el valle',null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(32,23424324,null,'fabiana',null,'betancur',null,'F','1/11/1985','O+','142123',null,'fabifabi@yahoo.com',null,null,null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(33,2131244,null,'carlos','luis','brito',null,'M','24/11/1993','AB+','5674563',null,'carlillos@yahoo.com',null,'coche',null,'E',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(34,4564353,null,'luis','alfonso','carrillo',null,'M','25/3/1970','AB+','5674563',null,'carrillo@gmail.com',null,null,null,'E',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(35,6765645,null,'gabriel',null,'jordan',null,'M','26/6/1991','AB+','55445',null,'jordas@gmail.com',null,null,null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(36,2345364,null,'daniel',null,'perez','pirella','M','10/12/1964','AB+','4353666',null,'456445@gmail.com',null,null,null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(37,3455555,null,'moises','mateo','muñoz','rodriguez','M','29/10/1988','AB+','2243546',null,'moñozmoises@gmail.com',null,null,null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(38,234543445,null,'mateo',null,'sanabrias',null,'M','28/4/1964','AB+','134423',null,'meteo@gmail.com',null,null,null,'V',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(39,3447774,null,'miguel','angel','piscalli','mascigla','M','18/4/1962','AB-','4565464',null,'migue@gmail.com',null,null,null,'E',0,'S',null);insert into sis.t_persona (codigo,cedula,rif,nombre1,nombre2,apellido1,apellido2,sexo,
fec_nacimiento, tip_sangre, telefono1,telefono2, cor_personal,
cor_institucional,direccion,discapacidad, nacionalidad, hijos,
est_civil,observaciones) values(40,3333726,null,'jesus','enrique','inglesias','cruz','M','22/2/1978','AB-','545435',null,'jesusi@gmail.com',null,null,null,'V',0,'S',null);



insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(1,1,1,1,'A','28/12/1976',false,false,false,true,'sin comentarios');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(2,2,1,1,'A','11/11/1982',true,false,false,false,'sin comentarios');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(3,3,1,1,'A','19/11/1979',false,false,false,true,'sin comentarios');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(4,4,1,1,'J','1/2/1985',false,false,false,true,'sin comentarios');
insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(5,5,1,2,'A','2/10/1971',true,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(6,6,1,2,'A','3/2/1988',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(7,7,1,2,'J','19/7/1998',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(8,8,1,2,'I','2/5/1986',false,false,false,false,'');
insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(9,9,1,3,'A','27/8/1980',false,true,false,false,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(10,10,1,3,'A','23/11/1999',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(11,11,1,3,'J','22/8/1998',false,false,false,false,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(12,12,1,3,'A','25/10/1986',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(13,13,1,4,'A','8/9/1994',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(14,14,1,4,'A','22/5/1988',false,false,true,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(15,15,1,4,'A','16/9/1972',false,false,true,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(16,16,1,4,'A','26/1/1982',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(17,17,1,5,'A','20/8/1998',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(18,18,1,5,'A','23/1/1972',false,false,false,true,'');
insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(19,19,1,5,'A','22/3/1990',false,false,false,true,'');insert into sis.t_empleado (codigo,cod_persona,cod_instituto,cod_pensum,
cod_estado, fec_inicio, es_jef_pensum,es_jef_con_estudio, es_ministerio,
es_docente,observaciones) values(20,20,1,5,'A','12/1/1974',false,false,false,true,'');

insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(1,1,1,1,'111','111','111','A','25/8/1980',01,'sin obersevacion');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(2,21,1,1,'2121','2121','2121','A','27/1/1998',01,'sin obersevacion');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(3,22,1,1,'2222','2222','2222','A','5/7/1985',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(4,23,1,1,'2323','2323','2323','A','17/2/1974',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(5,24,1,1,'2424','2424','2424','G','6/8/1981',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(6,25,1,2,'2525','2525','2525','G','24/6/1997',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(7,26,1,2,'2626','2626','2626','A','25/6/2000',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(8,27,1,2,'2727','2727','2727','A','25/7/1981',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(9,28,1,3,'2828','2828','2828','A','17/7/1976',01,'');
insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(10,29,1,3,'2929','2929','2929','I','13/10/1974',01,'');
insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(11,30,1,3,'3030','3030','3030','I','23/6/1982',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(12,31,1,3,'3131','3131','3131','A','1/5/1983',01,'tuvo una pelea con el profesor y le pego un golpe');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(13,32,1,3,'3232','3232','3232','A','16/3/1979',01,'se encontro al estudiante fumando dentro del salon');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(14,33,1,4,'3333','3333','3333','A','12/3/1989',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(15,34,1,4,'3434','3434','3434','I','21/6/1985',01,'el estudinte fue expulsado de la institucion por vender drogas dentro del resinto');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(16,35,1,4,'3535','3535','3535','A','7/10/1994',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(17,36,1,4,'36','36','3636','A','19/9/1992',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(18,37,1,5,'3737','3737','3737','A','23/3/1996',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(19,38,1,5,'3838','3838','3838','A','19/4/1973',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(20,39,1,5,'3939','3939','3939','A','4/1/1976',01,'');insert into sis.t_estudiante (codigo,cod_persona,cod_instituto,cod_pensum,
num_carnet,num_expediente,cod_rusnies,cod_estado, fec_inicio,
condicion,observaciones) values(21,40,1,5,'4040','4040','4040','A','13/10/1984',01,'');


