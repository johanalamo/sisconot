/**
 * copyright 2014 - Instituto Universtiario de Tecnología Dr. Federico Rivero Palacio
 * license GPLv3
 * license http://www.gnu.org/licenses/gpl-3.0.html
 *
 * Script PesumnServicio.sql - Servicio del módulo Instituto.
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

CREATE OR REPLACE FUNCTION sis.f_trayecto_insertar(integer, integer, text, integer, integer, integer, integer)
  RETURNS INTEGER  AS   
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE 
  COST 100; 
ALTER FUNCTION sis.f_trayecto_insertar(integer, integer, text, integer, integer, integer, integer) 
  OWNER TO postgres;

select sis.f_trayecto_insertar(13, 2, 'z-23214 ing Informatica', 120, 8, 6, 5); 



-- Actualizar ------------------------------------------------------

-- las referencias verlas en insercion
CREATE OR REPLACE FUNCTION sis.f_trayecto_actualizar(integer, integer, integer, text, integer, integer, integer, integer)
  RETURNS integer AS
$BODY$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;  v_cod_pensum ALIAS for $2;  
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_trayecto_actualizar(integer, integer, integer, text, integer, integer, integer, integer)
  OWNER TO postgres;

select sis.f_trayecto_actualizar(2,13,2,'z-23215 ing Informatica', 120, 8, 6, 5); 

-- Eliminar ------------------------------------------------------

-- consulta referencias anteriores
CREATE OR REPLACE FUNCTION sis.f_trayecto_eliminar(
    integer
    )
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_trayecto_eliminar(integer)
  OWNER TO postgres;

select  sis.f_trayecto_eliminar(3);


-- SELECTS Standar ------------------------------------------------------

-- ver referencias anterirores 
-- valor de entrada refcursor sirver como nombre para curso 
-- para efectos de trabajo y prueba pasarle el nombre del cursor
-- seleccionar todos

CREATE OR REPLACE FUNCTION sis.f_trayecto_seleccionar(refcursor)
  RETURNS refcursor AS
$BODY$

BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, 
       min_cre_electiva, min_cre_acreditable, min_can_electiva
  FROM sis.t_trayecto;

    
 RETURN $1;   
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_trayecto_seleccionar(refcursor)
  OWNER TO postgres;

 select sis.f_trayecto_seleccionar('fcursor');
 FETCH ALL IN fcursor;



-------------------------------------------------------------------------------------
-- selecionar por codigo 

CREATE OR REPLACE FUNCTION sis.f_trayecto_por_codigo_seleccionar(refcursor, integer)
  RETURNS refcursor AS
$BODY$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, 
       min_cre_electiva, min_cre_acreditable, min_can_electiva
  FROM sis.t_trayecto where codigo = $2;
    
 RETURN $1;   
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_trayecto_por_codigo_seleccionar(refcursor, integer)
  OWNER TO postgres;

 select sis.f_trayecto_por_codigo_seleccionar('fcursorinst',2);
 FETCH ALL IN fcursorinst;

