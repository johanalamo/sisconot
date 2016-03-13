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


CREATE OR REPLACE FUNCTION sis.f_prelacion_insertar(integer, integer, integer, integer)
  RETURNS INTEGER  AS   
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE 
  COST 100; 
ALTER FUNCTION sis.f_prelacion_insertar(integer, integer, integer, integer)
  OWNER TO postgres;

select sis.f_prelacion_insertar(1, 12, 1, 1);

select * from sis.t_prelacion;

-- Actualizar ------------------------------------------------------

-- las referencias verlas en insercion

CREATE OR REPLACE FUNCTION sis.f_prelacion_actualizar(integer, integer, integer, integer, integer)
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_prelacion_actualizar(integer, integer, integer, integer, integer)
  OWNER TO postgres;

select sis.f_prelacion_actualizar(1, 1, 12, 2, 1);

select * from sis.t_prelacion;

-- Eliminar ------------------------------------------------------

-- consulta referencias anteriores

CREATE OR REPLACE FUNCTION sis.f_prelacion_eliminar(
    integer
    )
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_prelacion_eliminar(integer)
  OWNER TO postgres;


select * from sis.t_prelacion
select sis.f_prelacion_eliminar(1);

-- SELECTS Standar ------------------------------------------------------

-- ver referencias anterirores 
-- valor de entrada refcursor sirver como nombre para curso 
-- para efectos de trabajo y prueba pasarle el nombre del cursor
-------------------------------------------------------------------------------------
-- selecionar por codigo 

CREATE OR REPLACE FUNCTION sis.f_prelacion_por_codigo_seleccionar(refcursor, integer)
  RETURNS refcursor AS
$BODY$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada
  FROM sis.t_prelacion where codigo = $2;
    
 RETURN $1;   
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer)
  OWNER TO postgres;


 select sis.f_prelacion_por_codigo_seleccionar('fcursorinst',1);
 FETCH ALL IN fcursorinst;
