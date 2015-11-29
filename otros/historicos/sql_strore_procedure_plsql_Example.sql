-- secuencial 
CREATE SEQUENCE sis.id_squel
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 999999999999999999
  START 10
  CACHE 1;
ALTER TABLE sis.id_squel
  OWNER TO postgres;


-- consulta de secuencial
SELECT nextval('sis.id_squel');


-- justificacio
-- Seguridad: nos dan la posibilidad de no darles acceso directo a los usuarios a las tablas del sistema, sino que por medio de un Store (lo podriamos ver como un puente) dar acceso a ejecutarlo pero que el usuario no tenga acceso directos sobre las tablas, esto tiene enormes ventajas de seguridad ya que no es muy buena idea que un usuario se pueda conectar al servidor y poder hacer un select por ej sobre la tabla Customers y le muestre todos los campos o bien insertar valores como quiere.


-- Centralizacion del codigo: Los Stores estan dentro de la base de datos con lo cual el codigo esta centralizado, si lo tuvieramos en las aplicaciones ese codigo podria estar en mas de un lugar y seria mas complicado luego a la hora de hacer mantenimiento, por ej: agregar una columna: si manejamos Stores es muy simple poder ver cuales afectaban a la tabla modificada para poderlos tocar, de la otra manera hay que hacer un rastreo mucho mayor y mas complicado a la vez.


-- Performance: Depende del Store que hagamos (si hace un simple insert no veremos mucha diferencia) la performance es mayor que si ejecutamos las sentencias desde la aplicacion directamente, esto tiene una explicacion simple y es que los Stores quedan compilados y el motor de base de datos no debe calcular por cada ejecucion (a menos que se lo indiquemos) que vuelva a calcular los planes, esto hace que el proceso sea mas eficiente, si tenemos 100 usuarios que tienen codigo en su aplicacion y los tiran lo mismo hara 100 veces el mismo calculo el motor, pero si en luagar de tenerlo asi esta en un Store el quedara en cache y ademas compilado haciendo que la performance mejore.

-- Function: insert_intituto(smallint, character varying, character varying, character varying)

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
  RAISE EXCEPTION 'violacion de clave foranea';
  RETURN -3; 

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.insert_intituto(integer, text, text, text)
  OWNER TO postgres;

-- select all


CREATE OR REPLACE FUNCTION sis.select_intituto()
  RETURNS refcursor AS
$BODY$
DECLARE
	ref refcursor;
BEGIN
  
  OPEN ref FOR SELECT codigo, nom_corto, nombre, direccion
  FROM sis.t_instituto;
	-- ejemplo Raise NOTICE 'Exito';
  
 RETURN ref;
 EXCEPTION  
  WHEN NO_DATA_FOUND THEN 
  RAISE EXCEPTION 'no data found';	
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.select_intituto()
  OWNER TO postgres;


-- update 

CREATE OR REPLACE FUNCTION sis.update_intituto(
    codigo integer,
    nom_corto text,
    nombre text,
    direccion text)
  RETURNS integer AS
$BODY$
DECLARE
	codigoOperacion integer := 0;
	p_codigo ALIAS for $1;
	p_nom_corto ALIAS for $2;
	p_nombre ALIAS for $3;
	p_direccion ALIAS for $4;
BEGIN

 UPDATE sis.t_instituto 
   SET 
	nom_corto=p_nom_corto, 
	nombre=p_nombre, 
	direccion=p_direccion
 WHERE t_instituto.codigo = p_codigo;

 codigoOperacion:=1;
 RETURN codigoOperacion;
 Raise NOTICE 'Exito';
 
 EXCEPTION
	WHEN datatype_mismatch  THEN 
	-- selecionar observacion
	--RAISE EXCEPTION 'violacion de clave foranea';
	RETURN -2;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.update_intituto(integer, text, text, text)
  OWNER TO postgres;



-- delete

CREATE OR REPLACE FUNCTION sis.delete_intituto(
    codigo integer
    )
  RETURNS integer AS
$BODY$
DECLARE
	codigoOperacion integer := 0;
	p_codigo ALIAS for $1;
	
BEGIN

 DELETE FROM sis.t_instituto
 WHERE t_instituto.codigo = p_codigo;

  codigoOperacion:=1;
  Raise NOTICE 'Exito';
  
 RETURN codigoOperacion;

 

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.delete_intituto(integer)
  OWNER TO postgres;


--


select * from sis.t_instituto;

SELECT sis.insert_intituto(
    7,'preuba235','prueba','prueba'
);

Select sis.select_intituto();

select sis.update_intituto( 7,'presadu','pupdatasde','pupdaasdte');

select sis.delete_intituto(8);


