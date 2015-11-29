drop view sis.v_prelacion;
create view sis.v_prelacion as
select ta.num_trayecto as num_tra_a,
   a.nombre as nom_a,
   '==>' as sep,
   tb.num_trayecto as num_tra_b,
    b.nombre as nom_b
from sis.t_trayecto as 
   ta inner join sis.t_uni_curricular as  
   a on ta.codigo = a.cod_trayecto 
      inner join sis.t_prelacion as 
   p on a.codigo = p.cod_uni_curricular 
      inner join sis.t_uni_curricular as
   b on p.cod_uni_cur_prelada = b.codigo
      inner join sis.t_trayecto tb
      on b.cod_trayecto = tb.codigo;
  


select * from sis.v_prelacion;
select * from sis.t_prelacion;