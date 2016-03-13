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



CREATE OR REPLACE FUNCTION sis.f_uni_tra_pensu_insertar(integer, integer, integer, integer)
  RETURNS INTEGER  AS   
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE 
  COST 100; 
ALTER FUNCTION sis.f_uni_tra_pensu_insertar(integer, integer, integer, integer)
  OWNER TO postgres;


select * from sis.t_uni_tra_pensum;

select * from sis.t_pensum;

select * from sis.t_uni_curricular;

select sis.f_uni_tra_pensu_insertar(1, null, 1, 2);
-- Actualizar ------------------------------------------------------

-- las referencias verlas en insercion
CREATE OR REPLACE FUNCTION sis.f_uni_tra_pensu_actualizar(integer, integer, integer, integer, integer)
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_uni_tra_pensu_actualizar(integer, integer, integer, integer, integer)
  OWNER TO postgres;


select * from sis.t_uni_tra_pensum ;
select sis.f_uni_tra_pensu_actualizar(1, 1, null, 1, 2);
-- Eliminar ------------------------------------------------------

-- consulta referencias anteriores
CREATE OR REPLACE FUNCTION sis.f_uni_tra_pensu_eliminar(
    integer
    )
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_uni_tra_pensu_eliminar(integer)
  OWNER TO postgres;


select sis.f_uni_tra_pensu_eliminar(2); 

select * from sis.t_uni_tra_pensum ;



-- SELECTS Standar ------------------------------------------------------

-- ver referencias anterirores 
-- valor de entrada refcursor sirver como nombre para curso 
-- para efectos de trabajo y prueba pasarle el nombre del cursor
-- seleccionar todos

-------------------------------------------------------------------------------------
-- selecionar por codigo 


CREATE OR REPLACE FUNCTION sis.f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer)
  RETURNS refcursor AS
$BODY$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo
  FROM sis.t_uni_tra_pensum where codigo = $2;
    
 RETURN $1;   
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer)
  OWNER TO postgres;

 select sis.f_uni_tra_pensu_por_codigo_seleccionar('fcursorinst',1);
 FETCH ALL IN fcursorinst;
