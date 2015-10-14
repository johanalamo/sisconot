drop table tabla;
create table tabla (codigo integer,-- primary key,
 valor integer);


drop sequence id_squel;
CREATE SEQUENCE id_squel INCREMENT 1
MINVALUE 1
MAXVALUE 99999
START 1
CACHE 1;
  


-- consulta de secuencial


CREATE OR REPLACE FUNCTION insertar_valor(valor int)
  RETURNS integer AS
$BODY$
DECLARE
	codigo integer := 0;
	valor ALIAS for $1;
BEGIN

	 SELECT nextval('id_squel') into codigo;-- from tabla;
	 INSERT INTO tabla(codigo,valor)
		VALUES (codigo, valor);
	 RETURN codigo;

END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

SELECT insertar_valor(19999);

select codigo, count(*) as cant from tabla group by codigo order by cant desc;

select * from tabla;
select count(*) from tabla;