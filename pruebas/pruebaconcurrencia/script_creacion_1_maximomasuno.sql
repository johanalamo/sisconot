--forma uno: seleccionar el maximo código y sumarle uno e insertar

\connect postgres;

-- consulta para limpiar el buffer, no borrar.
select 'consulta para limpiar el buffer, no borrar.' as resultado;

-- Borrar la base de datos en caso de existir
drop database  pruebaconcurrencia;

CREATE DATABASE pruebaconcurrencia WITH OWNER = postgres ENCODING = 'UTF8' CONNECTION LIMIT = -1;

-- Conectarse a la nueva base de datos
\connect pruebaconcurrencia;


create table tabla (codigo integer
--                    primary key
                    , 
			        valor integer);


CREATE OR REPLACE FUNCTION insertar_valor(valor int)
  RETURNS integer AS
$BODY$
DECLARE
	codigo integer := 0;
	valor ALIAS for $1;
BEGIN

	 select coalesce(max (tabla.codigo),1-1) + 1  into codigo from tabla;
	 INSERT INTO tabla(codigo,valor)
		VALUES (codigo, valor);
	 RETURN codigo;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


--SELECT insertar_valor(20);

--select * from tabla;
