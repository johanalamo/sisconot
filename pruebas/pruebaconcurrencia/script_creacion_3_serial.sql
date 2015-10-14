--forma tres: utilizar serial

\connect postgres;

-- consulta para limpiar el buffer, no borrar.
select 'consulta para limpiar el buffer, no borrar.' as resultado;

-- Borrar la base de datos en caso de existir
drop database  pruebaconcurrencia;

CREATE DATABASE pruebaconcurrencia WITH OWNER = postgres ENCODING = 'UTF8' CONNECTION LIMIT = -1;

-- Conectarse a la nueva base de datos
\connect pruebaconcurrencia;


create table tabla (codigo serial
                     --  primary key
                        , 
                        valor integer);


CREATE OR REPLACE FUNCTION insertar_valor(val int)
  RETURNS integer AS
$BODY$
DECLARE
	codigo integer := 0;
	val ALIAS for $1;
BEGIN

	 INSERT INTO tabla(valor)
		VALUES (val);
	 --select tabla.codigo  into codigo from tabla where tabla.valor  = val;
	 select max(tabla.codigo) into codigo from tabla;
	 RETURN codigo;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


--SELECT insertar_valor(20);

--select * from tabla;
