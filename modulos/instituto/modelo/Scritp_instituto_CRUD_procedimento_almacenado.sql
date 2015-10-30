/**
 * copyright 2014 - Instituto Universtiario de Tecnología Dr. Federico Rivero Palacio
 * license GPLv3
 * license http://www.gnu.org/licenses/gpl-3.0.html
 *
 * Script InstitutoServicio.sql - Servicio del módulo Instituto.
 *
 * Esta clase ofrece el servicio de conexión a la base de datos, recibe 
 * los parámetros, construye las consultas SQL, hace las peticiones a 
 * la base de datos y retorna los objetos o datos correspondientes a la
 * acción. en este archivo se contiene todo lo relacionado a instituto
 * es el archivo que permite la interacion la lo relacionado a instituto
 * en la base de datos.Todas las funciones de esta clase relanzan las excepciones si son capturadas.
 * Esto con el fin de que la clase manejadora de errores las capture y procese.
 *
 * author Rafael Garcia (rafaelantoniorf@gmail.com)
 * 
 * explicacion de standar de creacion de funciones (Store precedure) 
 */

-- Insertar ------------------------------------------------------
-- nombre del procedure
-- ver documento de nomenclartura de procedure
CREATE OR REPLACE FUNCTION sis.f_instituto_ins(
     p_nom_corto TEXT, 
     p_nombre TEXT,
     p_direccion TEXT) -- parametros de entreda como cualquier funcion
  RETURNS INTEGER  AS  -- tipo de valor de retorno 
$BODY$
DECLARE
	-- aqui se reclara las variables que necesite ejm: codigo (tipo) := ((valor) o (sin valor))
	codigoInstituto integer := 0;
BEGIN
  -- cuerpo de la FUNCTION
  -- obitenes el sequencial y lo guardas en variable
  --	SELECT nextval('id_secuencia') into codigoInstituto;
  -- o
  -- obtienes maximo codigo 
  SELECT COALESCE (max(codigo),0) FROM sis.t_instituto INTO codigoInstituto;
  codigoInstituto := codigoInstituto + 1;	

	 INSERT INTO sis.t_instituto(
		    codigo, nom_corto, nombre, direccion)
	    VALUES (codigoInstituto, p_nom_corto, p_nombre, p_direccion);

  RETURN codigoInstituto;

-- execepcion solo se usaran para transacciones, ya que en caso de error
-- estas rompen el procedimiento y dan el error en la consola de postgres,
-- o en su defecto están manejadas por php
-- ejemplo
-- commit;	 
-- EXCEPTION  
--  WHEN unique_violation THEN 
--  Rollback;
--  RAISE EXCEPTION 'violacion de clave foranea';
-- RETURN -3; 

END;
$BODY$
  LANGUAGE plpgsql VOLATILE -- categoria de la funcion exiten 3 tipos IMMUTABLE | STABLE | VOLATILE
  -- la función puede devolver diferentes valores, incluso dentro de una consulta individual de una tabla 
  -- (valor por defecto)  
  COST 100;
  --Declara el costo por cada fila del resultado valor por defecto 100
ALTER FUNCTION sis.f_instituto_ins( text, text, text) -- usuriao para la funcion
  OWNER TO sisconot;

-- prueba
--~ -- select sis.f_instituto_ins('inst_pserez','instituto universitario pito perez','por ahí cerca de por ahí') ; 
--~ -- select * from sis.t_instituto;

-- Actualizar ------------------------------------------------------

-- las referencias verlas en insercion
CREATE OR REPLACE FUNCTION sis.f_instituto_act(
    p_codigo integer,
    p_nom_corto text,
    p_nombre text,
    p_direccion text) -- si le dan nombre a los parametros
		      -- ADVERTENCIA cuidado con los nombre
		      -- que le den itulicen (p_) como estandar para evitar 
		      -- conflicto con los nombre de los campos 
		      -- hora de ejecutar el store procedure
  RETURNS integer AS
$BODY$
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

   IF found THEN  -- se utiliza para saber si afecto mas de una colunma 
	v_operacion :=1;
   END IF;
  
 RETURN v_operacion;
 -- si es necesario modificacion multiple hacerlo con transaccion

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_instituto_act(integer, text, text, text)
  OWNER TO sisconot;


-- prueba
--~ -- select sis.f_instituto_actualizar(8,'prueba_actulizacion','prueba_actulizacion','prueba_actulizacion');
--~ -- select * from sis.t_instituto;

-- Eliminar ------------------------------------------------------

-- consulta referencias anteriores
CREATE OR REPLACE FUNCTION sis.f_instituto_eli(
    p_codigo integer
    )
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_instituto_eli(integer)
  OWNER TO sisconot;


--select sis.f_instituto_eli(7);
--select * from sis.t_instituto;

--voy por aqui.... johan alamo


-- SELECTS Standar ------------------------------------------------------

-- ver referencias anterirores 
-- valor de entrada refcursor sirver como nombre para curso 
-- para efectos de trabajo y prueba pasarle el nombre del cursor

-- manera de prueba en db 
CREATE OR REPLACE FUNCTION sis.f_instituto_sel(p_cursor refcursor)
RETURNS refcursor AS
$BODY$

BEGIN
  
	OPEN p_cursor FOR
		SELECT codigo, nom_corto, nombre, direccion
		FROM sis.t_instituto;
	  
	RETURN p_cursor; 	
 
END;
$BODY$
	LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_instituto_sel(refcursor)
  OWNER TO sisconot;

--{ para efectos de trabajo y prueba correrlos ambos (ADVERTENCIA No usar mayuscular y minusculas juntas) 
-- select sis.f_instituto_sel('fcursorinst');
-- FETCH ALL IN fcursorinst;
--~ --}


-- manera normal

-- (johan) analiza la nombreclatura para efectos generales



CREATE OR REPLACE FUNCTION sis.f_instituto_sel_por_codigo(p_refcursor refcursor, p_codigo integer) 
RETURNS refcursor AS
$BODY$
BEGIN
	OPEN p_refcursor FOR 
		SELECT codigo, nom_corto, nombre, direccion
		FROM sis.t_instituto 
		where codigo = p_codigo;
	RETURN p_refcursor; 	

END;
$BODY$
	LANGUAGE plpgsql VOLATILE
	COST 100;

ALTER FUNCTION sis.f_instituto_sel_por_codigo(refcursor, integer)
OWNER TO sisconot;

--select sis.f_instituto_sel_por_codigo('cursor',4); 
--FETCH ALL IN "cursor";
