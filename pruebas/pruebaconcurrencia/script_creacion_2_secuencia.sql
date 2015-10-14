
\connect postgres;


drop database pruebaconcurrencia;


create database pruebaconcurrencia with owner = postgres encoding 'UTF8' connection limit = -1 ;

\connect pruebaconcurrencia;


create table tabla(codigo integer, valor integer);


create sequence secuencia;


CREATE OR REPLACE FUNCTION insertar_valor(valor int)
  RETURNS integer AS
$BODY$
DECLARE
	codigo integer := 0;
	valor ALIAS for $1;
BEGIN

	 SELECT nextval('secuencia') into codigo;-- from tabla;
	 INSERT INTO tabla(codigo,valor)
		VALUES (codigo, valor);
	 RETURN codigo;

END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
