
CREATE OR REPLACE FUNCTION sis.f_unicurricular_por_pensum_seleccionar(
    refcursor,
    integer)
  RETURNS refcursor AS
$BODY$

BEGIN

	IF $2 < 1 THEN
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		left join sis.t_tip_uni_curricular tp on tp.codigo = utp.cod_tipo;

	  ELSE
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		left join sis.t_tip_uni_curricular tp on tp.codigo = utp.cod_tipo
		where pen.codigo = $2;

	END IF;

 RETURN $1;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_unicurricular_por_pensum_seleccionar(refcursor, integer)
  OWNER TO sisconot;









CREATE OR REPLACE FUNCTION sis.f_prelacion_por_requeridas(
    refcursor,
    integer,
    integer)
  RETURNS refcursor AS
$BODY$
BEGIN

  OPEN $1 FOR SELECT p.codigo, p.cod_pensum, p.cod_instituto, p.cod_uni_curricular, p.cod_uni_cur_prelada,
  uni.nombre, uni.cod_uni_ministerio   
  FROM sis.t_prelacion p
  inner join sis.t_uni_curricular uni on p.cod_uni_cur_prelada = uni.codigo
  where p.cod_uni_curricular = $2 and p.cod_pensum = $3;

 RETURN $1;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_prelacion_por_requeridas(refcursor, integer, integer)
  OWNER TO sisconot;
 

select sis.f_prelacion_por_requeridas('pcursor',5,1);
FETCH ALL IN pcursor;




CREATE OR REPLACE FUNCTION sis.f_prelacion_por_requisito(
    refcursor,
    integer,
    integer)
  RETURNS refcursor AS
$BODY$
BEGIN

  OPEN $1 FOR SELECT p.codigo, p.cod_pensum, p.cod_instituto, p.cod_uni_curricular, p.cod_uni_cur_prelada,
  uni.nombre, uni.cod_uni_ministerio   
  FROM sis.t_prelacion p
  inner join sis.t_uni_curricular uni on p.cod_uni_curricular = uni.codigo
  where p.cod_uni_cur_prelada = $2 and p.cod_pensum = $3;

 RETURN $1;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sis.f_prelacion_por_requisito(refcursor, integer, integer)
  OWNER TO sisconot;

  select sis.f_prelacion_por_requisito('pcursor',5,1);
FETCH ALL IN pcursor;


 