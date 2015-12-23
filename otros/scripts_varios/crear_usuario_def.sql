--create language 'PLPGSQL';

select count(*) from sis.t_persona;
--$1 usuario, $2 clave, $3 rol
drop function crear_usuario_nodef(varchar,varchar,varchar);

CREATE or REPLACE FUNCTION crear_usuario_nodef(varchar,varchar,varchar) RETURNS varchar AS $ini$
BEGIN
   --create user $1 password '$2';
   create table "$1" ();

   return $2;


END;
$ini$ LANGUAGE 'plpgsql';

select crear_usuario_nodef('prueba2','1234','otro');

--select * from alamoj

--- sql dinamico ************************************************************************************


--drop function crear_usuario_nodef(varchar,varchar,varchar);

CREATE or REPLACE FUNCTION crear_usuario_nodef(varchar,varchar,varchar) RETURNS varchar AS $ini$
declare
     cadena text := 'create table prueba();';   
BEGIN
   --create user $1 password '$2';
--   create table $1 ();
   cadena := 'create table ' || $1 || '('  || $2 || ' ' || $3 || ' )';
   execute cadena;
   return cadena;
END;
$ini$ LANGUAGE 'plpgsql';

select crear_usuario_nodef('estudiante','cedula','integer');

select * from a;
