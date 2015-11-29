

-- DROP FUNCTION insert_intituto(smallint, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION sis.insert_intituto(
    codigo integer,
    nom_corto text,
    nombre text,
    direccion text)
  RETURNS integer AS
$BODY$
DECLARE
	codigoOperacion integer := 0;
	codigo ALIAS for $1;
	nom_corto ALIAS for $2;
	nombre ALIAS for $3;
	direccion ALIAS for $4;
BEGIN

 INSERT INTO sis.t_instituto(
            codigo, nom_corto, nombre, direccion)
    VALUES (codigo, nom_corto, nombre, direccion);

 codigoOperacion:=1;
 RETURN codigoOperacion;

 EXCEPTION  
  WHEN unique_violation THEN 
 -- selecionar observacion 
  RAISE log 'log: violacion de clave foranea';
  --RAISE info 'info: violacion de clave foranea';
  --RAISE debug 'debug: violacion de clave foranea';
  --RAISE warning 'warning: violacion de clave foranea';
  --RAISE notice 'notice: violacion de clave foranea';
--  RAISE notice 'violacion de clave foranea';
  RETURN -3; 

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.insert_intituto(integer, text, text, text)
  OWNER TO postgres;


SELECT sis.insert_intituto(
    7,'preuba235','prueba','prueba2'
);



