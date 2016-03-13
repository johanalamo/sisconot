
CREATE OR REPLACE FUNCTION sis.f_instituto_seleccionar(refcursor)
RETURNS refcursor AS
$BODY$

BEGIN
  
	OPEN $1 FOR
		SELECT codigo, nom_corto, nombre, direccion
		FROM sis.t_instituto;	  
	RETURN $1; 	
 
END;
$BODY$
	LANGUAGE plpgsql VOLATILE
	COST 100;
ALTER FUNCTION sis.f_instituto_seleccionar(refcursor)
  OWNER TO sisconot;

 select sis.f_instituto_seleccionar('fcursorinst');

 FETCH ALL IN fcursorinst;
--epa darry, esta forma anterior no me gusta porque hay que hacer el select de la función
-- y luego esa instrucción fetch all, y además pasa el refcursos como parámetro. 
-- hay alguna manera de solamente hacer el select sin necesidad
-- de hacer el fecth all????????



CREATE OR REPLACE FUNCTION sis.f_instituto_seleccionar_por_codigo(integer) 
RETURNS refcursor AS
$BODY$
DECLARE
	ref refcursor;
BEGIN

	OPEN ref FOR 
		SELECT codigo, nom_corto, nombre, direccion
		FROM sis.t_instituto 
		where codigo = $1;

	RETURN ref; 	

END;
$BODY$
	LANGUAGE plpgsql VOLATILE
	COST 100;

ALTER FUNCTION sis.f_instituto_seleccionar_por_codigo(integer)
OWNER TO sisconot;

select sis.f_instituto_seleccionar_por_codigo(8); 
FETCH ALL IN "<unnamed portal 19>";
--en esta segunda forma, también hay que hacer select y fetch all, con un nombre
-- de cursor generado consecutivamente..








--~ 
CREATE TABLE foo (fooid INT, foosubid INT, fooname TEXT);
INSERT INTO foo VALUES (1, 2, 'three');
INSERT INTO foo VALUES (4, 5, 'six');
INSERT INTO foo VALUES (8, 9, 'nine');
INSERT INTO foo VALUES (11, 12, 'eleven');

CREATE OR REPLACE FUNCTION getAllFoo() RETURNS SETOF foo AS
$BODY$
DECLARE
    r foo%rowtype;
BEGIN
    FOR r IN SELECT * FROM foo
    WHERE fooid > 0
    LOOP
        -- can do some processing here
        RETURN NEXT r; -- return current row of SELECT
    END LOOP;
    RETURN;
END
$BODY$
LANGUAGE 'plpgsql' ;

SELECT fooid,fooname FROM getallfoo() where fooid = 1;

--en esta tercera retorna un setof, pero es como manejar una tabla,
-- lo que veo es que recorre todo el cursor e imagino que eso lo hace lento
-- qué me recomiendas aquí????

--gracias....
