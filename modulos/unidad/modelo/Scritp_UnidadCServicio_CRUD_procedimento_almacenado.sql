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

CREATE OR REPLACE FUNCTION sis.f_unicurricular_insertar(text, text, integer, integer, integer, integer, integer, integer, text, text ,text)
  RETURNS INTEGER  AS   
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE 
  COST 100; 
ALTER FUNCTION sis.f_unicurricular_insertar(text, text, integer, integer, integer, integer, integer, integer, text, text ,text)
  OWNER TO postgres;

select sis.f_unicurricular_insertar('MAC015', 'MATEMÁTICA', 50, 50, 4, 12, 10, 20, 'matematica de trayecto inicial', 'rolo de beta', ' 1) tema 1 la vida 2) la exposicion 3)examen'); 

select sis.f_unicurricular_insertar('PNS013', 'PROYECTO NACIONAL Y NUEVA CIUDADANÍA', 50, 50, 4, 12, 10, 20, 'matematica de trayecto inicial', 'rolo de beta', ' 1) tema 1 la vida 2) la exposicion 3)examen'); 

select * from sis.t_uni_curricular;



-- Actualizar ------------------------------------------------------

-- las referencias verlas en insercion
CREATE OR REPLACE FUNCTION sis.f_unicurricular_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text ,text)
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_unicurricular_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text ,text)
  OWNER TO postgres;

select sis.f_unicurricular_actualizar(2,'PNS014', 'PROYECTO NACIONAL Y NUEVA CIUDADANÍA', 50, 50, 4, 12, 10, 20, 'matematica de trayecto inicial', 'rolo de beta', ' 1) tema 1 la vida 2) la exposicion 3)examen'); 


-- Eliminar ------------------------------------------------------

-- consulta referencias anteriores
CREATE OR REPLACE FUNCTION sis.f_unicurricular_eliminar(
    integer
    )
  RETURNS integer AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_unicurricular_eliminar(integer)
  OWNER TO postgres;


select sis.f_unicurricular_eliminar(3); 
select * from sis.t_uni_curricular ;



-- SELECTS Standar ------------------------------------------------------

-- ver referencias anterirores 
-- valor de entrada refcursor sirver como nombre para curso 
-- para efectos de trabajo y prueba pasarle el nombre del cursor
-- seleccionar todos


CREATE OR REPLACE FUNCTION sis.f_unicurricular_seleccionar(refcursor)
  RETURNS refcursor AS
$BODY$

BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, 
       not_min_aprobatoria, not_maxima, descripcion, observacion, contenido
  FROM sis.t_uni_curricular;


    
 RETURN $1;   
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_unicurricular_seleccionar(refcursor)
  OWNER TO postgres;

 select sis.f_unicurricular_seleccionar('fcursor');
 FETCH ALL IN fcursor;


-------------------------------------------------------------------------------------
-- selecionar por codigo 


CREATE OR REPLACE FUNCTION sis.f_unicurricular_por_codigo_seleccionar(refcursor, integer)
  RETURNS refcursor AS
$BODY$
BEGIN
  
  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, 
       not_min_aprobatoria, not_maxima, descripcion, observacion, contenido
  FROM sis.t_uni_curricular where codigo = $2;
    
 RETURN $1;   
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_unicurricular_por_codigo_seleccionar(refcursor, integer)
  OWNER TO postgres;

 select sis.f_unicurricular_por_codigo_seleccionar('fcursorinst',1);
 FETCH ALL IN fcursorinst;
