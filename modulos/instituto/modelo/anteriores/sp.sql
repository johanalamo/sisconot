-- Function: client."SClientProducts"(integer)

-- DROP FUNCTION client."SClientProducts"(integer);

CREATE OR REPLACE FUNCTION client."SClientProducts"(vcode integer)
  RETURNS text AS
$BODY$
/**************************************************************************
* Nombre: "SClientProducts"
* Descripcion: Devuelve los productos para un cliente, las cuales 
*              se visualizan en el info.
* @vcode: Indica el customerid del cliente
* *************************************************************************
* Realizado por: 
* Fecha: 08/09/2014
* Modificado por:               Fecha:
****************************************************************************/
DECLARE
	SQL text;
	resp text;
	REC record;

BEGIN

	resp = null;

	SQL = 'SELECT p.code as tiempo FROM client.sales s INNER JOIN client.ft_product p ON (s.product_code = p.code) WHERE s.customerid = '||vcode||' GROUP BY TIEMPO;';

	FOR REC IN EXECUTE SQL
	LOOP
		IF (resp IS NULL) THEN 
			resp = REC.TIEMPO;
		ELSE
			resp = resp ||'|'||REC.TIEMPO;
		END IF;
	END LOOP;
	
	return resp;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION client."SClientProducts"(integer)
  OWNER TO clientbd;