--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE bd_sisgesac;


CREATE ROLE admin;
ALTER ROLE admin WITH SUPERUSER INHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION PASSWORD 'md59dc9d5ed5031367d42543763423c24ee';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION PASSWORD 'md5738d021d4bc194576641fa9936656836';
CREATE ROLE sosajean;
ALTER ROLE sosajean WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION PASSWORD 'md57e773d92d0ddc18da00d71dc241e2f10';


CREATE DATABASE bd_sisgesac WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_VE.UTF-8' LC_CTYPE = 'es_VE.UTF-8';


ALTER DATABASE bd_sisgesac OWNER TO admin;


\connect bd_sisgesac

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 9 (class 2615 OID 24086)
-- Name: aud; Type: SCHEMA; Schema: -; Owner: admin
--

--
-- Name: aud; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA aud;


ALTER SCHEMA aud OWNER TO admin;

--
-- Name: err; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA err;


ALTER SCHEMA err OWNER TO admin;

--
-- Name: per; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA per;


ALTER SCHEMA per OWNER TO admin;

--
-- Name: sis; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA sis;


ALTER SCHEMA sis OWNER TO admin;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = per, pg_catalog;

--
-- Name: f_accion_eliminar(integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_accion_eliminar(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		delete from per.t_accion where codigo=p_codigo;
		IF found THEN
			RETURN 1; 
		ELSE
			RETURN 0; 
		END IF;
	END;
	$$;


ALTER FUNCTION per.f_accion_eliminar(p_codigo integer) OWNER TO admin;

--
-- Name: f_accion_ins(text, text, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_accion_ins(p_nombre text, p_descripcion text, p_cod_modulo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE
		cod_accion integer;
	BEGIN

		SELECT nextval('per.s_accion') into cod_accion; 
		
		insert into per.t_accion  (codigo,nombre,descripcion,cod_modulo) values (cod_accion,p_nombre,p_descripcion,p_cod_modulo);
		RETURN cod_accion;

	END;
	$$;


ALTER FUNCTION per.f_accion_ins(p_nombre text, p_descripcion text, p_cod_modulo integer) OWNER TO admin;

--
-- Name: f_accion_listar(refcursor, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_accion_listar(p_cursor refcursor, p_patron text) RETURNS refcursor
    LANGUAGE plpgsql STABLE
    AS $$
	BEGIN
		p_patron:='%'||p_patron||'%';
		OPEN p_cursor FOR
				SELECT * from per.t_accion where upper(nombre) like upper(p_patron) 
				or cast(codigo as varchar) LIKE p_patron order by codigo;
		return p_cursor;
	END;
$$;


ALTER FUNCTION per.f_accion_listar(p_cursor refcursor, p_patron text) OWNER TO admin;

--
-- Name: f_accion_modificar(text, text, integer, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_accion_modificar(p_nombre text, p_descripcion text, p_cod_modulo integer, p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE per.t_accion SET nombre=p_nombre,descripcion=p_descripcion,cod_modulo=p_cod_modulo WHERE codigo=p_codigo;
			IF found THEN
				RETURN 1;
			ELSE
				RETURN 0; 
			END IF;
	END;
	$$;


ALTER FUNCTION per.f_accion_modificar(p_nombre text, p_descripcion text, p_cod_modulo integer, p_codigo integer) OWNER TO admin;

--
-- Name: f_accion_obtener(refcursor, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_accion_obtener(p_cursor refcursor, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql STABLE
    AS $$
	BEGIN
		OPEN p_cursor FOR
				select * from per.t_accion where codigo=p_codigo;
		RETURN p_cursor;
	END;
$$;


ALTER FUNCTION per.f_accion_obtener(p_cursor refcursor, p_codigo integer) OWNER TO admin;

--
-- Name: f_accion_tabla_eliminar(integer, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_accion_tabla_eliminar(p_cod_accion integer, p_cod_tabla integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		delete from per.t_tab_accion where cod_tabla=p_cod_tabla and cod_accion=p_cod_accion;
		IF found THEN
			RETURN 1; 
		ELSE
			RETURN 0; 
		END IF;
	END;
	$$;


ALTER FUNCTION per.f_accion_tabla_eliminar(p_cod_accion integer, p_cod_tabla integer) OWNER TO admin;

--
-- Name: f_asi_due_bas_datos(text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_asi_due_bas_datos(p_nom_bas_de_datos text, p_usuario text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
	CADENA TEXT;

	BEGIN
	  	
		CADENA:='ALTER DATABASE '|| p_nom_bas_de_datos || ' OWNER TO ' || p_usuario;
		execute	CADENA;	
			
	END;
	$$;


ALTER FUNCTION per.f_asi_due_bas_datos(p_nom_bas_de_datos text, p_usuario text) OWNER TO postgres;

--
-- Name: f_asi_per_esquemas(text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_asi_per_esquemas(p_esquema text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
	CADENA TEXT;

	BEGIN 	
		
		cadena:='grant all on schema '||  p_esquema|| ' to public';
		execute	CADENA;	
			
	END;
	$$;


ALTER FUNCTION per.f_asi_per_esquemas(p_esquema text) OWNER TO postgres;

--
-- Name: f_asi_per_secuencia(text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_asi_per_secuencia(p_secuencia text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	CADENA TEXT;

	BEGIN
 

	cadena:='grant all on sequence '||  p_secuencia|| ' to public';
	execute	CADENA;	
			
	END;
	$$;


ALTER FUNCTION per.f_asi_per_secuencia(p_secuencia text) OWNER TO postgres;

--
-- Name: f_cambiar_dueño_schema(text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION "f_cambiar_dueño_schema"(p_usuario text, p_schema text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	CADENA TEXT;

	BEGIN
  	
	CADENA:='ALTER SCHEMA ' || p_schema || ' OWNER TO '|| p_usuario ;
	execute	CADENA;	
			
	END;
	$$;


ALTER FUNCTION per."f_cambiar_dueño_schema"(p_usuario text, p_schema text) OWNER TO postgres;

--
-- Name: f_cambiar_dueño_sequences(text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION "f_cambiar_dueño_sequences"(p_usuario text, p_sequence text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	CADENA TEXT;

	BEGIN
  	
	CADENA:='ALTER sequence ' || p_sequence || ' OWNER TO '|| p_usuario;
	execute	CADENA;	
			
	END;
	$$;


ALTER FUNCTION per."f_cambiar_dueño_sequences"(p_usuario text, p_sequence text) OWNER TO postgres;

--
-- Name: f_cre_tab_acc_usuario(); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_cre_tab_acc_usuario() RETURNS void
    LANGUAGE plpgsql
    AS $$

	BEGIN
		create table per.t_acc_usuario(
				codigo integer not null,
				cod_usuario integer not null,
				cod_accion integer not null,
				constraint cp_acc_usuario primary key (codigo),
				constraint uni_acc_usuario unique (cod_usuario,cod_accion),
				constraint cf_acc_usu_usuario foreign key(cod_usuario)
				references per.t_usuario(codigo),
				constraint cf_acc_usu_accion foreign key(cod_accion)
				references per.t_accion(codigo)
				 );
			
	END;
	$$;


ALTER FUNCTION per.f_cre_tab_acc_usuario() OWNER TO postgres;

--
-- Name: f_cre_tab_accion(); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_cre_tab_accion() RETURNS void
    LANGUAGE plpgsql
    AS $$

	BEGIN
		create table per.t_accion(
				codigo integer not null,
				nombre varchar(30) not null,
				cod_modulo integer,
				descripcion varchar(100),
				constraint cp_accion primary key (codigo),
				constraint cf_acc_modulo foreign key(cod_modulo)
				references per.t_modulo(codigo),
				constraint uni_accion unique (nombre)
				);
			
	END;
	$$;


ALTER FUNCTION per.f_cre_tab_accion() OWNER TO postgres;

--
-- Name: f_cre_tab_modulo(); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_cre_tab_modulo() RETURNS void
    LANGUAGE plpgsql
    AS $$

	BEGIN
		create table per.t_modulo(
				codigo integer not null,
				nombre varchar(30) not null,
				descripcion varchar(100),
				constraint cp_modulo primary key (codigo),
				constraint uni_modulo unique (nombre)
				 );
			
	END;
	$$;


ALTER FUNCTION per.f_cre_tab_modulo() OWNER TO postgres;

--
-- Name: f_cre_tab_sch_permiso(boolean); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_cre_tab_sch_permiso(p_tip_usuarios boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		PERFORM per.f_cre_tab_usuario(p_tip_usuarios);
		PERFORM per.f_cre_tab_modulo();	
		PERFORM per.f_cre_tab_accion();	
		PERFORM per.f_cre_tab_acc_usuario();	
		if (p_tip_usuarios=true) THEN
			PERFORM per.f_cre_tab_tabla();
			PERFORM per.f_cre_tab_tab_accion();
		END IF;
	END;
	$$;


ALTER FUNCTION per.f_cre_tab_sch_permiso(p_tip_usuarios boolean) OWNER TO postgres;

--
-- Name: f_cre_tab_tab_accion(); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_cre_tab_tab_accion() RETURNS void
    LANGUAGE plpgsql
    AS $$

	BEGIN
		create table per.t_tab_accion(
				codigo integer not null,
				cod_tabla integer not null,
				cod_accion integer not null,
				permiso varchar(4),
				constraint cp_tab_accion primary key (codigo),
				constraint uni_tab_accion unique (cod_tabla,cod_accion),
				constraint cf_tab_accion_tabla foreign key(cod_tabla)
				references per.t_tabla(codigo),
				constraint cf_tab_accion_accion foreign key(cod_accion)
				references per.t_accion(codigo)
				);
			
	END;
	$$;


ALTER FUNCTION per.f_cre_tab_tab_accion() OWNER TO postgres;

--
-- Name: f_cre_tab_tabla(); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_cre_tab_tabla() RETURNS void
    LANGUAGE plpgsql
    AS $$

	BEGIN
		create table per.t_tabla(
				codigo integer not null,
				nombre varchar(30) not null,
				constraint cp_tabla primary key (codigo),
				constraint uni_tabla unique (nombre)
				);
			
	END;
	$$;


ALTER FUNCTION per.f_cre_tab_tabla() OWNER TO postgres;

--
-- Name: f_cre_tab_usuario(boolean); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_cre_tab_usuario(p_tip_usuarios boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
	CADENA TEXT;
	BEGIN
		cadena:= 'create table per.t_usuario(
						codigo integer not null,
						usuario varchar(30) not null, ';	
		if (p_tip_usuarios=false) THEN
			cadena:=cadena || 'pass varchar(100), ';
		END IF;

		cadena:= cadena || 'tipo char(1) not null, 
				campo1 varchar(30), 
				campo2 varchar(30), 
				campo3 varchar(30), 
				constraint cp_usuario primary key (codigo), 
				constraint uni_usuario unique (usuario), 
				constraint chk_usuario_01 check (tipo in (''U'',''R''))
				 );';	
		execute cadena;
			
	END;
	$$;


ALTER FUNCTION per.f_cre_tab_usuario(p_tip_usuarios boolean) OWNER TO postgres;

--
-- Name: f_ins_usu_no_bd(text, text, text, text, text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_ins_usu_no_bd(p_usuario text, p_contrasena text, tipo text DEFAULT 'U'::text, campo1 text DEFAULT ''::text, campo2 text DEFAULT ''::text, campo3 text DEFAULT ''::text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
	codigo integer := 0;

	BEGIN
		SELECT nextval('per.s_usuario') into codigo;
		if (tipo='U')then
		insert into per.t_usuario (codigo,usuario,pass,tipo,campo1,campo2,campo3) 
					values (codigo,p_usuario,p_contrasena,tipo,campo1,campo2,campo3);
		else 
			insert into per.t_usuario (codigo,usuario,tipo,campo1,campo2,campo3) 
					values (codigo,p_usuario,tipo,campo1,campo2,campo3);
		end if;
		RETURN codigo;
			
			
	END;
	$$;


ALTER FUNCTION per.f_ins_usu_no_bd(p_usuario text, p_contrasena text, tipo text, campo1 text, campo2 text, campo3 text) OWNER TO postgres;

--
-- Name: f_ins_usuario(text, text, integer, text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_ins_usuario(p_usuario text, tipo text DEFAULT 'U'::text, campo1 integer DEFAULT 0, campo2 text DEFAULT ''::text, campo3 text DEFAULT ''::text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
	codigo integer := 0;

	BEGIN
		SELECT nextval('per.s_usuario') into codigo;
		insert into per.t_usuario (codigo,usuario,tipo,campo1,campo2,campo3) 
							values (codigo,p_usuario,tipo,campo1,campo2,campo3);
		RETURN codigo;		
	END;
	$$;


ALTER FUNCTION per.f_ins_usuario(p_usuario text, tipo text, campo1 integer, campo2 text, campo3 text) OWNER TO postgres;

--
-- Name: f_instituto_cargar(); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_instituto_cargar() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
		codigo integer := 0;
	BEGIN
		select nextval('sis.s_instituto') into codigo; 
		insert into sis.t_instituto (codigo,nom_corto,nombre,direccion)
		 values (codigo,'IUTFRP', 'Instituto Universitario de Tecnología “Dr. Federico Rivero Palacio”', 'Km 8, Panamericana');

		select nextval('sis.s_instituto') into codigo; 
		insert into sis.t_instituto (codigo,nom_corto,nombre,direccion)
		 values (codigo,'CUC', 'Colegio Universitario de Caracas', 'Chacao');
		
		select nextval('sis.s_instituto') into codigo; 
		insert into sis.t_instituto (codigo,nom_corto,nombre,direccion)
		 values (codigo,'CULTCA', 'Colegio Universitario de Los Teques Cecilio Acosta', 'Km 23, Panamericana');
			
			
	END;
	$$;


ALTER FUNCTION per.f_instituto_cargar() OWNER TO postgres;

--
-- Name: f_modulo_agregar(text, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_modulo_agregar(p_nombre text, p_descripcion text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE
		cod_modulo integer := 0;
	BEGIN

		SELECT nextval('per.s_modulo') into cod_modulo; -- OBTIENES EL SIGUIENTE CÓDIGO DE LA SECUENCIA QUE SE CREO, FUNCIONA COMO SERIAL
		
		insert into per.t_modulo (codigo,nombre,descripcion) values (cod_modulo,p_nombre,p_descripcion);
		RETURN cod_modulo;

	END;
	$$;


ALTER FUNCTION per.f_modulo_agregar(p_nombre text, p_descripcion text) OWNER TO admin;

--
-- Name: f_modulo_eliminar(integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_modulo_eliminar(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		DELETE FROM per.t_modulo WHERE codigo = p_codigo;
		IF found THEN
			RETURN 1; --EXITOSO
		ELSE
			RETURN 0; -- NO ELIMINÓ, NO HAY FILAS AFECTADAS 
		END IF;
	END;
	$$;


ALTER FUNCTION per.f_modulo_eliminar(p_codigo integer) OWNER TO admin;

--
-- Name: f_modulo_filtar(refcursor, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_modulo_filtar(p_cursor refcursor, p_patron text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		p_patron:='%'||p_patron||'%';
		OPEN p_cursor FOR
			select * from per.t_modulo where cast(codigo as varchar) 
 					like p_patron or upper(nombre) like upper(p_patron) order by nombre asc;
		

		RETURN p_cursor; -- CURSOS QUE SE CREA DONDE QUEDA ALMACENADA LA DATA QUE SE SELECCIONO
	END;
	$$;


ALTER FUNCTION per.f_modulo_filtar(p_cursor refcursor, p_patron text) OWNER TO admin;

--
-- Name: f_modulo_modificar(integer, text, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_modulo_modificar(p_codigo integer, p_nombre text, p_descripcion text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE per.t_modulo SET nombre=p_nombre, descripcion= p_descripcion WHERE codigo= p_codigo;
			IF found THEN
				RETURN 1; --ÉXITO 
			ELSE
				RETURN 0; -- NO SE MODIFICÓ, NO HAY FILAS AFECTADAS
			END IF;
	END;
	$$;


ALTER FUNCTION per.f_modulo_modificar(p_codigo integer, p_nombre text, p_descripcion text) OWNER TO admin;

--
-- Name: f_modulo_obtener(integer, refcursor); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_modulo_obtener(p_codigo integer, p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		OPEN p_cursor FOR
			select * from per.t_modulo where codigo=p_codigo;
		RETURN p_cursor;
	END;
	$$;


ALTER FUNCTION per.f_modulo_obtener(p_codigo integer, p_cursor refcursor) OWNER TO admin;

--
-- Name: f_tab_accion_ins(integer, integer, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tab_accion_ins(p_cod_tabla integer, p_cod_accion integer, p_permisos text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE
		cod_tab_accion integer;
	BEGIN

		SELECT nextval('per.s_tab_accion') into cod_tab_accion; 
		
		insert into per.t_tab_accion (codigo,cod_tabla,cod_accion,permiso)
					     values(cod_tab_accion,p_cod_tabla,p_cod_accion,upper(p_permisos));
		RETURN cod_tab_accion;

	END;
	$$;


ALTER FUNCTION per.f_tab_accion_ins(p_cod_tabla integer, p_cod_accion integer, p_permisos text) OWNER TO admin;

--
-- Name: f_tab_accion_modificar(integer, integer, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tab_accion_modificar(p_cod_tabla integer, p_cod_accion integer, p_permisos text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE per.t_tab_accion SET permiso=upper(p_permisos) WHERE cod_accion=p_cod_accion and cod_tabla=p_cod_tabla;
			IF found THEN
				RETURN 1; 
			ELSE
				RETURN 0; 
			END IF;
	END;
	$$;


ALTER FUNCTION per.f_tab_accion_modificar(p_cod_tabla integer, p_cod_accion integer, p_permisos text) OWNER TO admin;

--
-- Name: f_tabla_eliminar(integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_eliminar(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		DELETE FROM per.t_tabla WHERE codigo = p_codigo;
		IF found THEN
			RETURN 1; 
		ELSE
			RETURN 0; 
		END IF;
	END;
	$$;


ALTER FUNCTION per.f_tabla_eliminar(p_codigo integer) OWNER TO admin;

--
-- Name: f_tabla_ins(text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_ins(p_nombre text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE
		cod_tabla integer := 0;
	BEGIN

		SELECT nextval('per.s_tabla') into cod_tabla;
		
		INSERT INTO per.t_tabla(codigo,nombre) VALUES (cod_tabla,p_nombre);
		RETURN cod_tabla;

	END;
	$$;


ALTER FUNCTION per.f_tabla_ins(p_nombre text) OWNER TO admin;

--
-- Name: f_tabla_listar(refcursor, text, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_listar(p_cursor refcursor, p_patron text, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		p_patron:='%'||p_patron||'%';
		OPEN p_cursor FOR
			select tablas.* from
				(select acc_tabla.cod_accion,acc_tabla.permiso,tabla.*  from 
	 			(select tab_accion.* from  per.t_accion as accion inner join per.t_tab_accion as tab_accion
				on accion.codigo=tab_accion.cod_accion where accion.codigo=p_codigo) as acc_tabla
	 			right join per.t_tabla as tabla on tabla.codigo=  acc_tabla.cod_tabla  ) as tablas
			where  upper(tablas.permiso) like upper(p_patron)
	  			or cast(tablas.codigo as varchar) like p_patron
				or upper(tablas.nombre) like upper(p_patron)
	 		order by  codigo;

			RETURN p_cursor; 
	END;
	$$;


ALTER FUNCTION per.f_tabla_listar(p_cursor refcursor, p_patron text, p_codigo integer) OWNER TO admin;

--
-- Name: f_tabla_listar_agregadas_o_no(refcursor, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_listar_agregadas_o_no(p_cursor refcursor, p_patron text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		p_patron:='%'||p_patron||'%';
		OPEN p_cursor FOR
			SELECT coalesce(tabla.codigo,-1) as  codigo,
				coalesce(tabla.nombre,'N') as nombret ,
				coalesce(catalogo.nombre,'I') as nombrec 
			from (select schemaname ||'.'||tablename as nombre from pg_tables where 		schemaname='per' or 
				    schemaname='sis' or 
				    schemaname='aud' or 
				    schemaname='err'or 
				    schemaname='public'
			      ) as catalogo full JOIN per.t_tabla as tabla on tabla.nombre=catalogo.nombre 
			where upper(tabla.nombre) like upper(p_patron) or upper(catalogo.nombre) 
						 like upper(p_patron) 
	    		or cast (codigo as varchar) like p_patron;
			RETURN p_cursor; 
	END;
	$$;


ALTER FUNCTION per.f_tabla_listar_agregadas_o_no(p_cursor refcursor, p_patron text) OWNER TO admin;

--
-- Name: f_tabla_listar_de_catalogo(refcursor, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_listar_de_catalogo(p_cursor refcursor, p_nombre text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		OPEN p_cursor FOR
			select -1 as codigo ,schemaname || '.' || tablename as nombrec,	schemaname || '.' || tablename as nombret from pg_tables 
				where 	schemaname || '.' || tablename  = p_nombre;	
			
			RETURN p_cursor; 
	END;
	$$;


ALTER FUNCTION per.f_tabla_listar_de_catalogo(p_cursor refcursor, p_nombre text) OWNER TO admin;

--
-- Name: f_tabla_listar_de_tabla(refcursor); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_listar_de_tabla(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		OPEN p_cursor FOR
			SELECT codigo,nombre FROM per.t_tabla; 

			RETURN p_cursor;
	END;
	$$;


ALTER FUNCTION per.f_tabla_listar_de_tabla(p_cursor refcursor) OWNER TO admin;

--
-- Name: f_tabla_modificar(text, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_modificar(p_nombre text, p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE per.t_tabla SET nombre=p_nombre WHERE codigo=p_codigo;
			IF found THEN
				RETURN 1; 
			ELSE
				RETURN 0; 
			END IF;
	END;
	$$;


ALTER FUNCTION per.f_tabla_modificar(p_nombre text, p_codigo integer) OWNER TO admin;

--
-- Name: f_tabla_obt_tablas(refcursor, text, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_tabla_obt_tablas(p_cursor refcursor, p_nombre text, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		OPEN p_cursor FOR
			select codigo, nombre as nombret,nombre as nombrec  
				 from per.t_tabla where nombre=p_nombre or codigo=p_codigo;
			RETURN p_cursor;
	END;
	$$;


ALTER FUNCTION per.f_tabla_obt_tablas(p_cursor refcursor, p_nombre text, p_codigo integer) OWNER TO admin;

--
-- Name: f_usuario_acc_usu_eliminar(integer, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_acc_usu_eliminar(p_cod_usuario integer, p_cod_accion integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		DELETE FROM per.t_acc_usuario WHERE cod_usuario = p_cod_usuario and cod_accion=p_cod_accion;
		IF found THEN
			RETURN 1; --EXITOSO
		ELSE
			RETURN 0; -- NO ELIMINO, NO HAY FILAS AFECTADAS 
		END IF;
	END;
	$$;


ALTER FUNCTION per.f_usuario_acc_usu_eliminar(p_cod_usuario integer, p_cod_accion integer) OWNER TO admin;

--
-- Name: f_usuario_asi_per_tab_acciones_usuarios(text[]); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_asi_per_tab_acciones_usuarios(p_usuarios text[]) RETURNS void
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
 
      can_usuarios Integer;
      i Integer;
    BEGIN
       select array_length(p_usuarios, 1) into can_usuarios;
 
	FOR i IN 1..can_usuarios loop
		PERFORM per.f_usuario_asi_per_tablas_usuario(p_usuarios[i]);
        END loop;
    END;
$$;


ALTER FUNCTION per.f_usuario_asi_per_tab_acciones_usuarios(p_usuarios text[]) OWNER TO admin;

--
-- Name: f_usuario_asi_per_tab_usuario(text, text, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_asi_per_tab_usuario(p_usuario text, p_tabla text, p_permisos text) RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
	can_per Integer;
	permiso text;
	i Integer;
	sentencia Text :='grant all privileges on table '||p_tabla||' to '|| p_usuario;
    BEGIN
	select char_length(p_permisos) into can_per;
	IF (can_per=4) THEN
		execute sentencia;
	ELSE
		sentencia:='grant ';
		FOR i IN 1..can_per loop
			select substring(upper(p_permisos) from i for 1) into permiso;
			IF (i<>1) THEN
				sentencia:=sentencia||',';
			END IF;
			
			IF (upper(permiso)='I') THEN
				sentencia:=sentencia||'insert';
			END IF;
			IF (upper(permiso)='D') THEN
				sentencia:=sentencia||'delete';
			END IF;
			IF (upper(permiso)='S') THEN
				sentencia:=sentencia||'select';
			END IF;
			IF (upper(permiso)='U') THEN
				sentencia:=sentencia||'update';
			END IF;
		END loop;
		sentencia:=sentencia||' on table '||p_tabla||' to '||p_usuario;
		execute sentencia;
	END IF;
    END;
$$;


ALTER FUNCTION per.f_usuario_asi_per_tab_usuario(p_usuario text, p_tabla text, p_permisos text) OWNER TO admin;

--
-- Name: f_usuario_asi_per_tablas_usuario(text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_asi_per_tablas_usuario(p_usuario text) RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
	registro record;
	contador Integer :=1;
	
    BEGIN
	FOR registro in select tab_acc.permiso,tabla.nombre from (select * from per.t_usuario where usuario=p_usuario ) 
				as usuario inner join per.t_acc_usuario as acc_usu on acc_usu.cod_usuario= usuario.codigo
					   inner join per.t_tab_accion as tab_acc on  tab_acc.cod_accion= acc_usu.cod_accion
					   inner join per.t_tabla as tabla on tabla.codigo=tab_acc.cod_tabla
		
        LOOP
		PERFORM per.f_usuario_asi_per_tab_usuario(p_usuario,registro.nombre,registro.permiso);
        END LOOP;
    END;
$$;


ALTER FUNCTION per.f_usuario_asi_per_tablas_usuario(p_usuario text) OWNER TO admin;

--
-- Name: f_usuario_cam_clave(text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_cam_clave(p_usuario text, clave text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	consulta text;
	BEGIN

		 consulta:='alter user '|| p_usuario || ' with password '''||clave ||''''; 
		 execute consulta;
	
	END;
	$$;


ALTER FUNCTION per.f_usuario_cam_clave(p_usuario text, clave text) OWNER TO postgres;

--
-- Name: f_usuario_cam_clave_no_usbd(integer, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_cam_clave_no_usbd(p_codigo integer, clave text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	consulta text;
	BEGIN

		UPDATE per.t_usuario SET pass = clave							
				WHERE codigo=p_codigo;
	
	END;
	$$;


ALTER FUNCTION per.f_usuario_cam_clave_no_usbd(p_codigo integer, clave text) OWNER TO postgres;

--
-- Name: f_usuario_crear(text, text, character); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_crear(p_usuario text, p_contrasena text, p_tipo character DEFAULT 'u'::bpchar) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	CADENA TEXT;

	BEGIN
  	IF(p_tipo='u') then 
		CADENA:='CREATE USER ' || p_usuario || ' PASSWORD '''|| p_contrasena ||'''';
	ELSE
		CADENA:='CREATE USER ' || p_usuario || ' PASSWORD '''|| p_contrasena ||'''SUPERUSER';
	END IF;
		
	execute	CADENA;	
			
	END;
	$$;


ALTER FUNCTION per.f_usuario_crear(p_usuario text, p_contrasena text, p_tipo character) OWNER TO postgres;

--
-- Name: f_usuario_eli_bas_datos(text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_eli_bas_datos(p_usuario text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	cadena text;
	
	BEGIN

	cadena:='drop user '|| p_usuario;
	execute cadena;
	
	
	END;
	$$;


ALTER FUNCTION per.f_usuario_eli_bas_datos(p_usuario text) OWNER TO postgres;

--
-- Name: f_usuario_eliminar(integer); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_eliminar(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		DELETE FROM per.t_usuario WHERE codigo = p_codigo;
		IF found THEN
			RETURN 1; --EXITOSO
		ELSE
			RETURN 0; -- NO ELIMINÓ, NO HAY FILAS AFECTADAS 
		END IF;
	END;
	$$;


ALTER FUNCTION per.f_usuario_eliminar(p_codigo integer) OWNER TO postgres;

--
-- Name: f_usuario_filtar(refcursor, text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_filtar(p_cursor refcursor, p_patron text, p_order text DEFAULT 'usuario'::text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	DECLARE
	consulta text;
	BEGIN
		p_patron:='%'||p_patron||'%';
		consulta:='select * from per.t_usuario where cast(codigo as varchar) 
 					like '''||p_patron||''' or upper(usuario) like upper('''||p_patron||''')
 					 or upper(tipo) like upper('''||p_patron||''')
 					 or upper(campo2) like upper('''||p_patron||''')
 					 or upper(campo3) like upper('''||p_patron||''')
 					 order by '||p_order||' asc';
 					 
		OPEN p_cursor FOR execute consulta;
		

		RETURN p_cursor; 
	END;
	$$;


ALTER FUNCTION per.f_usuario_filtar(p_cursor refcursor, p_patron text, p_order text) OWNER TO postgres;

--
-- Name: f_usuario_mod_no_bd(integer, character, text, text, text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_mod_no_bd(p_codigo integer, p_tipo character, p_campo1 text, p_campo2 text, p_campo3 text, p_clave text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE per.t_usuario SET tipo = p_tipo, campo1 = p_campo1, campo2 = p_campo2, campo3 = p_campo3,
							 pass=p_clave
					 WHERE codigo=p_codigo;
			IF found THEN
				RETURN 1; --ÉXITO 
			ELSE
				RETURN 0; -- NO SE MODIFICÓ, NO HAY FILAS AFECTADAS
			END IF;
	END;
	$$;


ALTER FUNCTION per.f_usuario_mod_no_bd(p_codigo integer, p_tipo character, p_campo1 text, p_campo2 text, p_campo3 text, p_clave text) OWNER TO postgres;

--
-- Name: f_usuario_mod_tip_usuario(text, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_mod_tip_usuario(p_usuario text, p_tipo text) RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
	cadena text;
	BEGIN
	cadena:='ALTER ROLE '||p_usuario ||' WITH '|| p_tipo;
	execute cadena;
END;
$$;


ALTER FUNCTION per.f_usuario_mod_tip_usuario(p_usuario text, p_tipo text) OWNER TO admin;

--
-- Name: f_usuario_modificar(integer, character, text, text, text); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_modificar(p_codigo integer, p_tipo character, p_campo1 text, p_campo2 text, p_campo3 text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE per.t_usuario SET tipo = p_tipo, campo1 = p_campo1, campo2 = p_campo2, campo3 = p_campo3
						 WHERE codigo=p_codigo;
			IF found THEN
				RETURN 1; --ÉXITO 
			ELSE
				RETURN 0; -- NO SE MODIFICÓ, NO HAY FILAS AFECTADAS
			END IF;
	END;
	$$;


ALTER FUNCTION per.f_usuario_modificar(p_codigo integer, p_tipo character, p_campo1 text, p_campo2 text, p_campo3 text) OWNER TO postgres;

--
-- Name: f_usuario_obt_usu_acciones(refcursor, text, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_obt_usu_acciones(p_cursor refcursor, p_usuario text, p_patron text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		p_patron:='%'||p_patron||'%';
		OPEN p_cursor FOR
			select usuarios.codigo, usuarios.usuario,usu_acciones.codigo as cod_usu_accion,acciones.nombre,acciones.codigo as cod_accion 
				from (select codigo, usuario from per.t_usuario where usuario= p_usuario )as usuarios
					inner join per.t_acc_usuario as usu_acciones on usu_acciones.cod_usuario= usuarios.codigo
					right join per.t_accion as acciones on acciones.codigo = cod_accion
				where upper(acciones.nombre) like upper(p_patron) or cast (acciones.codigo as varchar) like (p_patron)
				order by usuarios.codigo;
			RETURN p_cursor; -- CURSOS QUE SE CREA DONDE QUEDA ALMACENADA LA DATA QUE SE SELECCIONO
	END;
	$$;


ALTER FUNCTION per.f_usuario_obt_usu_acciones(p_cursor refcursor, p_usuario text, p_patron text) OWNER TO admin;

--
-- Name: f_usuario_obt_usu_por_accion(integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_obt_usu_por_accion(p_cod_accion integer) RETURNS text[]
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
	usu text;
	usuarios text[];
	contador Integer :=1;
    BEGIN
       FOR usu in select usuario.usuario from  (select codigo from per.t_accion where codigo=p_cod_accion)as accion
		inner join per.t_acc_usuario as acc_usuario on acc_usuario.cod_accion= accion.codigo
		inner join per.t_usuario as usuario on usuario.codigo=acc_usuario.cod_usuario
        LOOP
           usuarios[contador]:=usu;
           contador:=contador +1;
        END LOOP;
        return usuarios;
    END;
$$;


ALTER FUNCTION per.f_usuario_obt_usu_por_accion(p_cod_accion integer) OWNER TO admin;

--
-- Name: f_usuario_obtener(integer, refcursor); Type: FUNCTION; Schema: per; Owner: postgres
--

CREATE FUNCTION f_usuario_obtener(p_codigo integer, p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	BEGIN
		OPEN p_cursor FOR
			select * from per.t_usuario where codigo=p_codigo;
		RETURN p_cursor;
	END;
	$$;


ALTER FUNCTION per.f_usuario_obtener(p_codigo integer, p_cursor refcursor) OWNER TO postgres;

--
-- Name: f_usuario_obtener_tablas(); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_obtener_tablas() RETURNS text[]
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
	nombre text;
	tablas text[];
	contador Integer :=1;
    BEGIN
       FOR nombre in SELECT per.t_tabla.nombre from per.t_tabla 
        LOOP
           tablas[contador]:=nombre;
           contador:=contador +1;
        END LOOP;
        return tablas;
    END;
$$;


ALTER FUNCTION per.f_usuario_obtener_tablas() OWNER TO admin;

--
-- Name: f_usuario_res_per_usu_afe_accion(integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_res_per_usu_afe_accion(p_cod_accion integer) RETURNS void
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
      usuarios text[];
    BEGIN
       
       select per.f_usuario_obt_usu_por_accion(p_cod_accion) into usuarios;    
	PERFORM per.f_usuario_rev_per_usuarios(usuarios);
	PERFORM per.f_usuario_asi_per_tab_acciones_usuarios(usuarios);
	
    END;
$$;


ALTER FUNCTION per.f_usuario_res_per_usu_afe_accion(p_cod_accion integer) OWNER TO admin;

--
-- Name: f_usuario_rev_per_tab_usuario(text, text); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_rev_per_tab_usuario(p_usuario text, p_tabla text) RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
	sentencia Text :='revoke all on table '||p_tabla ||' from '||p_usuario;
    BEGIN
	execute sentencia;
    END;
$$;


ALTER FUNCTION per.f_usuario_rev_per_tab_usuario(p_usuario text, p_tabla text) OWNER TO admin;

--
-- Name: f_usuario_rev_per_usuarios(text[]); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_rev_per_usuarios(p_usuarios text[]) RETURNS void
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
      tablas text[];
      can_usuarios Integer;
      can_tablas Integer;
      iu Integer;it Integer;
    BEGIN
       select array_length(p_usuarios, 1) into can_usuarios; --cantidad de usuarios en el arreglo -
       select per.f_usuario_obtener_tablas() into tablas;            --arreglo de tablas.
       select array_length(tablas, 1) into can_tablas;		 --cantidad de tablas en el arreglo
	FOR iu IN 1..can_usuarios loop
		FOR it IN 1..can_tablas loop
			PERFORM per.f_usuario_rev_per_tab_usuario(p_usuarios[iu],tablas[it]);
		END loop;
        END loop;
    END;
$$;


ALTER FUNCTION per.f_usuario_rev_per_usuarios(p_usuarios text[]) OWNER TO admin;

--
-- Name: f_usuario_usu_acc_insertar(integer, integer); Type: FUNCTION; Schema: per; Owner: admin
--

CREATE FUNCTION f_usuario_usu_acc_insertar(p_cod_usuario integer, p_cod_accion integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE
		cod_usu_accion integer := 0;
	BEGIN

		SELECT nextval('per.s_acc_usuario') into cod_usu_accion; 
		
		INSERT INTO per.t_acc_usuario(codigo,cod_usuario,cod_accion) VALUES (cod_usu_accion,p_cod_usuario,p_cod_accion);
		RETURN cod_usu_accion;

	END;
	$$;


ALTER FUNCTION per.f_usuario_usu_acc_insertar(p_cod_usuario integer, p_cod_accion integer) OWNER TO admin;

SET search_path = public, pg_catalog;

--
-- Name: f_cre_schemas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION f_cre_schemas() RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		create schema sis;
		create schema per;
		create schema err;
		create schema aud;	
			
	END;
	$$;


ALTER FUNCTION public.f_cre_schemas() OWNER TO postgres;

SET search_path = sis, pg_catalog;

--
-- Name: f_convalidacion_eli(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_convalidacion_eli(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	DECLARE r_operacion integer := 0;
	p_codigo ALIAS for $1;
BEGIN

	DELETE FROM sis.t_convalidacion WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$_$;


ALTER FUNCTION sis.f_convalidacion_eli(integer) OWNER TO sisconot;

--
-- Name: f_convalidar_ins(integer, boolean, real, date, text, integer, integer, integer, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_convalidar_ins(integer, boolean, real, date, text, integer, integer, integer, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  p_codigo integer := 0;
  p_cod_estudiante integer:=0;
  p_cod_persona ALIAS for $1;
  p_con_nota ALIAS for $2;
  p_nota ALIAS for $3;
  p_fecha ALIAS for $4;
  p_cod_tip_uni_curricular ALIAS for $5;
  p_cod_pensum ALIAS for $6;
  p_cod_trayecto ALIAS for $7;
  p_cod_uni_curricular ALIAS for $8;
  p_descripcion ALIAS FOR $9;

BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_convalidacion INTO p_codigo;
  p_codigo := p_codigo + 1;
  SELECT codigo from sis.t_estudiante where cod_pensum=p_cod_pensum and cod_estado='A' and cod_persona=p_cod_persona INTO p_cod_estudiante;
  INSERT INTO sis.t_convalidacion(codigo,   cod_estudiante,      con_nota,   nota,
          fecha,      cod_tip_uni_curricular,    cod_pensum, cod_trayecto,
          cod_uni_curricular,   descripcion )
          
  VALUES (p_codigo,     p_cod_estudiante,          p_con_nota,   p_nota,
          p_fecha,        p_cod_tip_uni_curricular,    p_cod_pensum, p_cod_trayecto,
          p_cod_uni_curricular,     p_descripcion);

  RETURN p_codigo;

END;
$_$;


ALTER FUNCTION sis.f_convalidar_ins(integer, boolean, real, date, text, integer, integer, integer, text) OWNER TO sisconot;

--
-- Name: f_convalidar_mod(integer, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_convalidar_mod(integer, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  r_operacion integer := 0;
  p_codigo  ALIAS FOR $1;
  p_descripcion ALIAS FOR $2;

BEGIN


  UPDATE sis.t_convalidacion  SET descripcion=p_descripcion  WHERE codigo=p_codigo;

  IF found THEN
  r_operacion := 1;
  END IF;


  RETURN r_operacion;

END;
$_$;


ALTER FUNCTION sis.f_convalidar_mod(integer, text) OWNER TO sisconot;

--
-- Name: f_cur_estudiante_del(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_cur_estudiante_del(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN

	DELETE FROM sis.t_cur_estudiante WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_cur_estudiante_del(p_codigo integer) OWNER TO sisconot;

--
-- Name: f_cur_estudiante_ins(integer, integer, double precision, double precision, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_cur_estudiante_ins(p_cod_estudiante integer, p_cod_curso integer, p_por_asistencia double precision, p_nota double precision, p_cod_estado text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_cur_est integer := 0;
BEGIN
	select nextval('sis.s_cur_estudiante') into cod_cur_est;

	INSERT INTO sis.t_cur_estudiante (	codigo,
										cod_estudiante,
										cod_curso,
										por_asistencia,
										nota,
										cod_estado,
										observaciones)
	 VALUES ( 					cod_cur_est,
								p_cod_estudiante,
								p_cod_curso,
								p_por_asistencia,
								p_nota,
								p_cod_estado,
								p_observaciones);

  RETURN cod_cur_est;
END;
$$;


ALTER FUNCTION sis.f_cur_estudiante_ins(p_cod_estudiante integer, p_cod_curso integer, p_por_asistencia double precision, p_nota double precision, p_cod_estado text, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_cur_estudiante_mod(integer, integer, integer, double precision, double precision, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_cur_estudiante_mod(p_codigo integer, p_cod_estudiante integer, p_cod_curso integer, p_por_asistencia double precision, p_nota double precision, p_cod_estado text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;
BEGIN
	UPDATE sis.t_cur_estudiante
		SET
			cod_estudiante = p_cod_estudiante,
			cod_curso = p_cod_curso,
			por_asistencia = p_por_asistencia,
			nota = p_nota,
			cod_estado = p_cod_estado,
			observaciones = p_observaciones
		WHERE
			codigo = p_codigo;

		IF found THEN
			r_operacion := 1;
		END IF;

  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_cur_estudiante_mod(p_codigo integer, p_cod_estudiante integer, p_cod_curso integer, p_por_asistencia double precision, p_nota double precision, p_cod_estado text, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_cur_estudiante_sel(refcursor); Type: FUNCTION; Schema: sis; Owner: postgres
--

CREATE FUNCTION f_cur_estudiante_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				cod_estudiante,
				cod_curso,
				cod_estado,
				nota,
				por_asistencia,
				observaciones
		FROM sis.t_cur_estudiante;


	RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_cur_estudiante_sel(p_cursor refcursor) OWNER TO postgres;

--
-- Name: f_cur_estudiante_sel_por_codigo(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_cur_estudiante_sel_por_codigo(p_cursor refcursor, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				cod_estudiante,
				cod_curso,
				cod_estado,
				nota,
				por_asistencia,
				observaciones
		FROM sis.t_cur_estudiante
		WHERE codigo = p_codigo;
	RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_cur_estudiante_sel_por_codigo(p_cursor refcursor, p_codigo integer) OWNER TO sisconot;

--
-- Name: f_curso_del(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_curso_del(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN

	DELETE FROM sis.t_curso WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_curso_del(p_codigo integer) OWNER TO sisconot;

--
-- Name: f_curso_ins(integer, integer, integer, text, date, date, integer, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_curso_ins(p_cod_periodo integer, p_cod_uni_curricular integer, p_cod_docente integer, p_seccion text, p_fec_inicio date, p_fec_final date, p_capacidad integer, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_curso integer := 0;
BEGIN
	select nextval('sis.s_curso') into cod_curso;

	INSERT INTO sis.t_curso (	codigo,
								cod_periodo,
								cod_uni_curricular,
								cod_docente,
								seccion,
								fec_inicio,
								fec_final,
								capacidad,
								observaciones)
	 VALUES ( 					cod_curso,
								p_cod_periodo,
								p_cod_uni_curricular,
								p_cod_docente,
								p_seccion,
								p_fec_inicio,
								p_fec_final,
								p_capacidad,
								p_observaciones);

  RETURN cod_curso;
END;
$$;


ALTER FUNCTION sis.f_curso_ins(p_cod_periodo integer, p_cod_uni_curricular integer, p_cod_docente integer, p_seccion text, p_fec_inicio date, p_fec_final date, p_capacidad integer, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_curso_mod(integer, integer, integer, integer, text, date, date, integer, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_curso_mod(p_codigo integer, p_cod_periodo integer, p_cod_uni_curricular integer, p_cod_docente integer, p_seccion text, p_fec_inicio date, p_fec_final date, p_capacidad integer, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;
BEGIN
	UPDATE sis.t_curso
		SET
			cod_periodo = p_cod_periodo,
			cod_uni_curricular = p_cod_uni_curricular,
			cod_docente = p_cod_docente,
			seccion = p_seccion,
			fec_inicio = p_fec_inicio,
			fec_final = p_fec_final,
			capacidad = p_capacidad,
			observaciones = p_observaciones
		WHERE
			codigo = p_codigo;

		IF found THEN
			r_operacion := 1;
		END IF;

  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_curso_mod(p_codigo integer, p_cod_periodo integer, p_cod_uni_curricular integer, p_cod_docente integer, p_seccion text, p_fec_inicio date, p_fec_final date, p_capacidad integer, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_curso_sel(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_curso_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				cod_periodo,
				cod_uni_curricular,
				cod_docente,
				seccion,
				fec_inicio,
				fec_final,
				capacidad,
				observaciones
		FROM sis.t_curso;


	RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_curso_sel(p_cursor refcursor) OWNER TO sisconot;

--
-- Name: f_curso_sel_por_codigo(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_curso_sel_por_codigo(p_cursor refcursor, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				cod_periodo,
				cod_uni_curricular,
				cod_docente,
				seccion,
				fec_inicio,
				fec_final,
				capacidad,
				observaciones
		FROM sis.t_curso
		WHERE codigo = p_codigo;
	RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_curso_sel_por_codigo(p_cursor refcursor, p_codigo integer) OWNER TO sisconot;

--
-- Name: f_empleado_act(integer, integer, integer, integer, text, date, date, boolean, boolean, boolean, boolean, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_empleado_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;
BEGIN
	UPDATE sis.t_empleado SET cod_instituto=p_cod_instituto,	  cod_pensum=p_cod_pensum,
				  cod_estado=p_cod_estado,		  fec_inicio=p_fec_inicio,
				  fec_fin=p_fec_fin,			  es_jef_pensum=p_es_jef_pensum,
				  es_jef_con_estudio=p_es_jef_con_estudio,es_ministerio=p_es_ministerio,
				  es_docente=p_es_docente,		  observaciones=p_observaciones
			      WHERE codigo=p_codigo;
     IF found THEN
	r_operacion := 1;
     END IF;

  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_empleado_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_empleado_eli(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_empleado_eli(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN

	DELETE FROM sis.t_empleado WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_empleado_eli(p_codigo integer) OWNER TO sisconot;

--
-- Name: f_empleado_ins(integer, integer, integer, text, date, date, boolean, boolean, boolean, boolean, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_empleado_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_empleado integer := 0;
BEGIN
	select coalesce(max(codigo),0) from sis.t_empleado into cod_empleado;

	cod_empleado:=cod_empleado+1;

	INSERT INTO sis.t_empleado (codigo,		cod_persona,		cod_instituto,
				    cod_pensum,		cod_estado,	        fec_inicio,
				    fec_fin,		es_jef_pensum,		es_jef_con_estudio,
				    es_ministerio,	es_docente,		observaciones
				 )
			    VALUES (cod_empleado,	p_cod_persona,		p_cod_instituto,
				    p_cod_pensum,	p_cod_estado,		p_fec_inicio,
				    p_fec_fin,		p_es_jef_pensum,	p_es_jef_con_estudio,
				    p_es_ministerio,	p_es_docente,		p_observaciones
				  );

  RETURN cod_empleado;
END;
$$;


ALTER FUNCTION sis.f_empleado_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_es_jef_pensum boolean, p_es_jef_con_estudio boolean, p_es_ministerio boolean, p_es_docente boolean, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_empleado_sel(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_empleado_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT * FROM sis.t_empleado;

 RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_empleado_sel(p_cursor refcursor) OWNER TO sisconot;

--
-- Name: f_empleado_sel_cod(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_empleado_sel_cod(p_cursor refcursor, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT * FROM sis.t_empleado;

 RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_empleado_sel_cod(p_cursor refcursor, p_codigo integer) OWNER TO sisconot;

--
-- Name: f_estudiante_act(integer, integer, integer, integer, text, text, text, text, date, date, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_estudiante_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;
BEGIN

	UPDATE sis.t_estudiante SET cod_instituto=p_cod_instituto, 	cod_pensum=p_cod_pensum,
				    num_carnet=p_num_carnet,		num_expediente=p_num_expediente,
				    cod_rusnies=p_cod_rusnies,	    	cod_estado=p_cod_estado,
				    fec_inicio=p_fec_inicio, 		condicion= p_condicion,
				    fec_fin=p_fec_fin, 			observaciones=p_observaciones
			     WHERE codigo=p_codigo;
	IF found THEN
		r_operacion := 1;
	END IF;

  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_estudiante_act(p_codigo integer, p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_estudiante_eli(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_estudiante_eli(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN

	DELETE FROM sis.t_estudiante WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_estudiante_eli(p_codigo integer) OWNER TO sisconot;

--
-- Name: f_estudiante_ins(integer, integer, integer, text, text, text, text, date, date, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_estudiante_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_estudiante integer := 0;
BEGIN
	select coalesce(max(codigo),0) from sis.t_estudiante into cod_estudiante;

	cod_estudiante := cod_estudiante + 1;

	insert into sis.t_estudiante (	codigo, 		cod_persona, 		cod_instituto,
					cod_pensum, 		num_carnet, 		num_expediente,
					cod_rusnies, 		cod_estado,		fec_inicio,
					fec_fin, 		condicion,		observaciones
				     )
			     values (	cod_estudiante, 	p_cod_persona, 		p_cod_instituto,
					p_cod_pensum, 		p_num_carnet,		p_num_expediente,
					p_cod_rusnies, 		p_cod_estado, 		p_fec_inicio,
					p_fec_fin, 		p_condicion, 		p_observaciones
				    );



  RETURN cod_estudiante;
END;
$$;


ALTER FUNCTION sis.f_estudiante_ins(p_cod_persona integer, p_cod_instituto integer, p_cod_pensum integer, p_num_carnet text, p_num_expediente text, p_cod_rusnies text, p_cod_estado text, p_fec_inicio date, p_fec_fin date, p_condicion text, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_estudiante_sel(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_estudiante_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
	select * from sis.t_estudiante;

	RETURN p_cursor;

END;
$$;


ALTER FUNCTION sis.f_estudiante_sel(p_cursor refcursor) OWNER TO sisconot;

--
-- Name: f_instituto_actualizar(integer, text, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_instituto_actualizar(p_codigo integer, p_nom_corto text, p_nombre text, p_direccion text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	-- ALIAS es como su nombre lo indica
	-- los parametros de entrar se reciben con el signo $(N) donde N
	-- es el orde dado
	v_operacion integer := 0;
	-- no es necesario usar alias
	--v_codigo ALIAS for $1;
	--v_nom_corto ALIAS for $2;
	--v_nombre ALIAS for $3;
	--v_direccion ALIAS for $4;
BEGIN

 UPDATE sis.t_instituto
   SET
	nom_corto=p_nom_corto,
	nombre=p_nombre,
	direccion=p_direccion
 WHERE t_instituto.codigo = p_codigo;

   IF found THEN
	v_operacion :=1;
   END IF;

 RETURN v_operacion;
 -- si es necesario modificacion multiple hacerlo con transaccion

END;
$_$;


ALTER FUNCTION sis.f_instituto_actualizar(p_codigo integer, p_nom_corto text, p_nombre text, p_direccion text) OWNER TO sisconot;

--
-- Name: f_instituto_eliminar(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_instituto_eliminar(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_operacion integer := 0;
BEGIN

  DELETE FROM sis.t_instituto
	WHERE t_instituto.codigo = p_codigo;

  IF found THEN
	v_operacion :=1;
  END IF;

RETURN v_operacion;

END;
$$;


ALTER FUNCTION sis.f_instituto_eliminar(p_codigo integer) OWNER TO sisconot;

--
-- Name: f_instituto_insertar(text, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_instituto_insertar(text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	-- aqui se reclara las variables que necesite ejm: codigo (tipo) := ((valor) o (sin valor))
	codigoInstituto integer := 0;
	--pueden usar alias
	v_nom_corto ALIAS for $1;
	v_nombre ALIAS for $2;
	v_direccion ALIAS for $3;

BEGIN
  -- cuerpo de la FUNCTION
  -- obitenes el sequencian y lo guardas en variable
  --	SELECT nextval('id_squel') into codigoInstituto;
  -- o
  -- obtienes maximo codigo
  SELECT COALESCE (max(codigo),0) FROM sis.t_instituto INTO codigoInstituto;
  codigoInstituto := codigoInstituto + 1;

	 INSERT INTO sis.t_instituto(
		    codigo, nom_corto, nombre, direccion)
	    VALUES (codigoInstituto, v_nom_corto, v_nombre, v_direccion);

  RETURN codigoInstituto;

-- execepcion solo se usaran para transacciones
-- ejemplo
-- commit;
-- EXCEPTION
--  WHEN unique_violation THEN
--  Rollback;
--  RAISE EXCEPTION 'violacion de clave foranea';
-- RETURN -3;

END;
$_$;


ALTER FUNCTION sis.f_instituto_insertar(text, text, text) OWNER TO sisconot;

--
-- Name: f_instituto_seleccionar(); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_instituto_seleccionar() RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
DECLARE
	ref refcursor;
BEGIN

  OPEN ref FOR SELECT codigo, nom_corto, nombre, direccion
  FROM sis.t_instituto;

 RETURN ref;

END;
$$;


ALTER FUNCTION sis.f_instituto_seleccionar() OWNER TO sisconot;

--
-- Name: f_instituto_seleccionar(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_instituto_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

  OPEN $1 FOR SELECT codigo, nom_corto, nombre, direccion
  FROM sis.t_instituto;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_instituto_seleccionar(refcursor) OWNER TO sisconot;

--
-- Name: f_instituto_seleccionar_por_codigo(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_instituto_seleccionar_por_codigo(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

  OPEN $1 FOR SELECT codigo, nom_corto, nombre, direccion
  FROM sis.t_instituto where codigo = $2;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_instituto_seleccionar_por_codigo(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_pensum_actualizar(integer, text, text, text, integer, integer, integer, date); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_actualizar(integer, text, text, text, integer, integer, integer, date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;	v_nombre ALIAS for $2;
	v_nom_corto ALIAS for $3; v_observaciones ALIAS for $4;
	v_min_can_elect ALIAS for $5; v_min_cre_elect ALIAS for $6;
	v_min_cre_obligat ALIAS for $7; v_fec_creac ALIAS for $8;
BEGIN

 UPDATE sis.t_pensum
   SET nombre = v_nombre, nom_corto = v_nom_corto, observaciones = v_observaciones, min_can_electiva = v_min_can_elect,
       min_cre_electiva = v_min_cre_elect, min_cre_obligatoria = v_min_cre_obligat, fec_creacion = v_fec_creac
 WHERE t_pensum.codigo = v_codigo;

   IF found THEN
	v_operacion :=1;
   END IF;

 RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_pensum_actualizar(integer, text, text, text, integer, integer, integer, date) OWNER TO sisconot;

--
-- Name: f_pensum_eliminar(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
BEGIN

  DELETE FROM sis.t_pensum
	WHERE t_pensum.codigo = v_codigo;

  IF found THEN
	v_operacion :=1;
  END IF;

RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_pensum_eliminar(integer) OWNER TO sisconot;

--
-- Name: f_pensum_insertar(text, text, text, integer, integer, integer, date); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_insertar(text, text, text, integer, integer, integer, date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoPensum integer := 0;
	v_nombre ALIAS for $1;
	v_nom_corto ALIAS for $2;
	v_observaciones ALIAS for $3;
	v_min_can_elect ALIAS for $4;
	v_min_cre_elect ALIAS for $5;
	v_min_cre_obligat ALIAS for $6;
	v_fec_creac ALIAS for $7;
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_pensum INTO codigoPensum;
  codigoPensum := codigoPensum + 1;

  INSERT INTO sis.t_pensum(codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva, min_cre_obligatoria, fec_creacion)
  VALUES (codigoPensum, v_nombre, v_nom_corto, v_observaciones, v_min_can_elect, v_min_cre_elect, v_min_cre_obligat, v_fec_creac);

  RETURN codigoPensum;

END;
$_$;


ALTER FUNCTION sis.f_pensum_insertar(text, text, text, integer, integer, integer, date) OWNER TO sisconot;

--
-- Name: f_pensum_por_codigo_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN

  OPEN $1 FOR SELECT codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva,
  min_cre_obligatoria, fec_creacion
  FROM sis.t_pensum where codigo = $2;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_pensum_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_pensum_por_filtro_seleccionar(refcursor, text, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_por_filtro_seleccionar(refcursor, text, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

    IF $2 = '1'  THEN

	IF $3 < 1 THEN/* todos los pensum de de todos los instituto */
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join sis.t_periodo per on pen.codigo = cod_pensum
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo;

	  ELSE  /* todos los pensum de un instituto */
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join sis.t_periodo per on pen.codigo = cod_pensum
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo
		where ins.codigo = $3;

	END IF;

   END IF;

    IF $2 = '2'  THEN

	IF $3 < 1 THEN
	  OPEN $1 FOR select * /*todos los trayectos de de todos los pensum pensum */
		from sis.t_pensum  pen
		inner join sis.t_trayecto tra on pen.codigo = tra.cod_pensum;

	  ELSE
	  OPEN $1 FOR select * /*todos los trayectos de un pensum*/
		from sis.t_pensum  pen
		inner join sis.t_trayecto tra on pen.codigo = tra.cod_pensum
		where pen.codigo = $3;

	END IF;

   END IF;

  IF $2 = '3'  THEN

	IF $3 < 1 THEN
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo;

	  ELSE
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		where pen.codigo = $3;

	END IF;

   END IF;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_pensum_por_filtro_seleccionar(refcursor, text, integer) OWNER TO sisconot;

--
-- Name: f_pensum_por_instituto_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_por_instituto_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

	IF $2 < 1 THEN/* todos los pensum de de todos los instituto */
	  OPEN $1 FOR select  distinct(pen.codigo),
                        pen.nombre,
                        pen.nom_corto,
                        pen.observaciones,
                        pen.min_can_electiva,
                        pen.min_cre_electiva,
                        pen.min_cre_obligatoria,
                        pen.fec_creacion
		from sis.t_pensum  pen
		inner join sis.t_periodo per on pen.codigo = cod_pensum
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo;

	  ELSE  /* todos los pensum de un instituto */
	  OPEN $1 FOR select distinct(pen.codigo),
                        pen.nombre,
                        pen.nom_corto,
                        pen.observaciones,
                        pen.min_can_electiva,
                        pen.min_cre_electiva,
                        pen.min_cre_obligatoria,
                        pen.fec_creacion
		from sis.t_pensum  pen
		inner join sis.t_periodo per on pen.codigo = cod_pensum
		left join sis.t_instituto ins on per.cod_instituto = ins.codigo
		where ins.codigo = $2;
	END IF;


 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_pensum_por_instituto_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_pensum_por_trayecto_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_por_trayecto_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN
/*todos los trayectos de de todos los pensum pensum */
	IF $2 < 1 THEN
	  OPEN $1 FOR select  tra.codigo,
                        tra.cod_pensum,
                        tra.num_trayecto,
                        tra.certificado,
                        tra.min_cre_obligatoria,
                        tra.min_cre_electiva,
                        tra.min_cre_acreditable,
                        tra.min_can_electiva
		from sis.t_pensum  pen
		inner join sis.t_trayecto tra on pen.codigo = tra.cod_pensum
    order by tra.num_trayecto;

	  ELSE
    OPEN $1 FOR select  tra.codigo,
                          tra.num_trayecto,
                          tra.certificado
                          from  sis.t_trayecto tra
                          where tra.cod_pensum = $2
                          group by
                            tra.codigo,
                            tra.num_trayecto, tra.certificado
                          order by
                            tra.num_trayecto;

  END IF;
 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_pensum_por_trayecto_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_pensum_seleccionar(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_pensum_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

  OPEN $1 FOR SELECT codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva,
  min_cre_obligatoria, fec_creacion
  FROM sis.t_pensum;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_pensum_seleccionar(refcursor) OWNER TO sisconot;

--
-- Name: f_periodo_del(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_periodo_del(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN

	DELETE FROM sis.t_periodo WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_periodo_del(p_codigo integer) OWNER TO sisconot;

--
-- Name: f_periodo_ins(text, integer, integer, date, date, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_periodo_ins(p_nombre text, p_cod_instituto integer, p_cod_pensum integer, p_fec_inicio date, p_fec_final date, p_observaciones text, p_cod_estado text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_periodo integer := 0;
BEGIN
	select coalesce(max(codigo)+1,0) from sis.t_periodo into cod_periodo;

	INSERT INTO sis.t_periodo(	codigo,
								nombre,
								cod_instituto,
								cod_pensum,
								fec_inicio,
								fec_final,
								observaciones,
								cod_estado)
	VALUES					 (	cod_periodo,
								p_nombre,
								p_cod_instituto,
								p_cod_pensum,
								p_fec_inicio,
								p_fec_final,
								p_observaciones,
								p_cod_estado);

  RETURN cod_periodo;
END;
$$;


ALTER FUNCTION sis.f_periodo_ins(p_nombre text, p_cod_instituto integer, p_cod_pensum integer, p_fec_inicio date, p_fec_final date, p_observaciones text, p_cod_estado text) OWNER TO sisconot;

--
-- Name: f_periodo_mod(integer, text, integer, integer, date, date, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_periodo_mod(p_codigo integer, p_nombre text, p_cod_instituto integer, p_cod_pensum integer, p_fec_inicio date, p_fec_final date, p_observaciones text, p_cod_estado text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;
BEGIN
	UPDATE sis.t_periodo
		SET
			nombre = p_nombre,
			cod_instituto = p_cod_instituto,
			cod_pensum = p_cod_pensum,
			fec_inicio = p_fec_inicio,
			fec_final = p_fec_final,
			observaciones = p_observaciones,
			cod_estado = p_cod_estado
		WHERE
			codigo = p_codigo;

		IF found THEN
			r_operacion := 1;
		END IF;

  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_periodo_mod(p_codigo integer, p_nombre text, p_cod_instituto integer, p_cod_pensum integer, p_fec_inicio date, p_fec_final date, p_observaciones text, p_cod_estado text) OWNER TO sisconot;

--
-- Name: f_periodo_pensum_sel(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_periodo_pensum_sel(p_cursor refcursor, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_cursor FOR
    select 	per.codigo,
            per.nombre
            from sis.t_periodo per
            where per.cod_pensum = p_codigo;
    RETURN p_cursor;
    END;
    $$;


ALTER FUNCTION sis.f_periodo_pensum_sel(p_cursor refcursor, p_codigo integer) OWNER TO sisconot;

--
-- Name: f_periodo_sel(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_periodo_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				nombre,
				cod_instituto,
				cod_pensum,
				fec_inicio,
				fec_final,
				cod_estado,
				observaciones
		FROM sis.t_periodo;


	RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_periodo_sel(p_cursor refcursor) OWNER TO sisconot;

--
-- Name: f_periodo_sel_por_codigo(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_periodo_sel_por_codigo(p_cursor refcursor, p_codigo integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
		SELECT 	codigo,
				nombre,
				cod_instituto,
				cod_pensum,
				fec_inicio,
				fec_final,
				cod_estado,
				observaciones
		FROM sis.t_periodo
		WHERE codigo = p_codigo;
	RETURN p_cursor;
END;
$$;


ALTER FUNCTION sis.f_periodo_sel_por_codigo(p_cursor refcursor, p_codigo integer) OWNER TO sisconot;

--
-- Name: f_persona_act(integer, integer, text, text, text, text, text, text, date, text, text, text, text, text, text, text, text, integer, text, text); Type: FUNCTION; Schema: sis; Owner: postgres
--

CREATE FUNCTION f_persona_act(p_codigo integer, p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE r_operacion integer := 0;
BEGIN

	UPDATE sis.t_persona SET cedula=p_cedula,			rif=p_rif,
				 nombre1=p_nombre1,			nombre2=p_nombre2,
				 apellido1=p_apellido1,			apellido2=p_apellido2,
				 sexo=p_sexo,				fec_nacimiento=p_fec_nacimiento,
				 tip_sangre=p_tip_sangre,		telefono1=p_telefono1,
				 telefono2=p_telefono2,			cor_personal=p_cor_personal,
				 cor_institucional=p_cor_institucional,	direccion=p_direccion,
				 discapacidad=p_discapacidad,		nacionalidad=p_nacionalidad,
				 hijos=p_hijos,				est_civil=p_est_civil,
				 observaciones=p_observaciones
			     WHERE codigo=p_codigo;

        update sis.t_persona set nombre1 = upper(nombre1), nombre2 = upper(nombre2), apellido1 = upper(apellido1), apellido2 = upper(apellido2);

	IF found THEN
		r_operacion := 1;
	END IF;

  RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_persona_act(p_codigo integer, p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) OWNER TO postgres;

--
-- Name: f_persona_eli(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_persona_eli(p_codigo integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE r_operacion integer := 0;
BEGIN

	DELETE FROM sis.t_persona WHERE codigo = p_codigo;

	IF found THEN
		r_operacion := 1;
	END IF;

	RETURN r_operacion;
END;
$$;


ALTER FUNCTION sis.f_persona_eli(p_codigo integer) OWNER TO sisconot;

--
-- Name: f_persona_ins(integer, text, text, text, text, text, text, date, text, text, text, text, text, text, text, text, integer, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_persona_ins(p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE cod_persona integer := 0;
BEGIN
	select coalesce(max(codigo),0) from sis.t_persona into cod_persona;

	cod_persona := cod_persona + 1;

	insert into sis.t_persona (codigo,		cedula,			rif,
				   nombre1,		nombre2,		apellido1,
				   apellido2,   	sexo,			fec_nacimiento,
				   tip_sangre,		telefono1,		telefono2,
				   cor_personal,	cor_institucional,	direccion,
				   discapacidad,	nacionalidad,		hijos,
				   est_civil,		observaciones
				)

		          values (cod_persona,		p_cedula,		p_rif,
				  p_nombre1,		p_nombre2,		p_apellido1,
				  p_apellido2,		p_sexo,			p_fec_nacimiento,
				  p_tip_sangre,		p_telefono1,		p_telefono2,
				  p_cor_personal,	p_cor_institucional,	p_direccion,
				  p_discapacidad, 	p_nacionalidad,		p_hijos,
				  p_est_civil,		p_observaciones
				);
  update sis.t_persona set nombre1 = upper(nombre1), nombre2 = upper(nombre2), apellido1 = upper(apellido1), apellido2 = upper(apellido2);

  RETURN cod_persona;
END;
$$;


ALTER FUNCTION sis.f_persona_ins(p_cedula integer, p_rif text, p_nombre1 text, p_nombre2 text, p_apellido1 text, p_apellido2 text, p_sexo text, p_fec_nacimiento date, p_tip_sangre text, p_telefono1 text, p_telefono2 text, p_cor_personal text, p_cor_institucional text, p_direccion text, p_discapacidad text, p_nacionalidad text, p_hijos integer, p_est_civil text, p_observaciones text) OWNER TO sisconot;

--
-- Name: f_persona_sel(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_persona_sel(p_cursor refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
	OPEN p_cursor FOR
	select * from sis.t_persona;

	RETURN p_cursor;

END;
$$;


ALTER FUNCTION sis.f_persona_sel(p_cursor refcursor) OWNER TO sisconot;

--
-- Name: f_prelacion_actualizar(integer, integer, integer, integer, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_prelacion_actualizar(integer, integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
	v_cod_pensum ALIAS for $2;
	v_cod_instituto ALIAS for $3;
	v_cod_uni_curricular ALIAS for $4;
	v_cod_uni_cur_prelada ALIAS for $5;
BEGIN

UPDATE sis.t_prelacion
   SET cod_pensum = v_cod_pensum, cod_instituto = v_cod_instituto, cod_uni_curricular = v_cod_uni_curricular, cod_uni_cur_prelada = v_cod_uni_cur_prelada
 WHERE sis.t_prelacion.codigo = v_codigo;

   IF found THEN
	v_operacion :=1;
   END IF;

 RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_prelacion_actualizar(integer, integer, integer, integer, integer) OWNER TO sisconot;

--
-- Name: f_prelacion_eliminar(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_prelacion_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;
BEGIN

  DELETE FROM sis.t_prelacion
  WHERE t_prelacion.codigo = v_codigo;

  IF found THEN
  v_operacion :=1;
  END IF;

RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_prelacion_eliminar(integer) OWNER TO sisconot;

--
-- Name: f_prelacion_insertar(integer, integer, integer, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_prelacion_insertar(integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoPrela integer := 0;
	v_cod_pensum ALIAS for $1;
	v_cod_instituto ALIAS for $2;
	v_cod_uni_curricular ALIAS for $3;
	v_cod_uni_cur_prelada ALIAS for $4;
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_prelacion INTO codigoPrela;
  codigoPrela := codigoPrela + 1;

  INSERT INTO sis.t_prelacion(
            codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada)
    VALUES (codigoPrela, v_cod_pensum, v_cod_instituto, v_cod_uni_curricular, v_cod_uni_cur_prelada);

  RETURN codigoPrela;

END;
$_$;


ALTER FUNCTION sis.f_prelacion_insertar(integer, integer, integer, integer) OWNER TO sisconot;

--
-- Name: f_prelacion_por_codigo_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_prelacion_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN

  OPEN $1 FOR SELECT codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada
  FROM sis.t_prelacion where codigo = $2;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_prelacion_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_trayecto_actualizar(integer, integer, integer, text, integer, integer, integer, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_trayecto_actualizar(integer, integer, integer, text, integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1; 	v_cod_pensum ALIAS for $2;
	v_num_trayecto ALIAS for $3; v_certificado ALIAS for $4;
	v_min_cre_obligatoria ALIAS for $5; v_min_cre_electiva ALIAS for $6;
	v_min_cre_acreditable ALIAS for $7; v_min_can_electiva ALIAS for $8;
BEGIN

 UPDATE sis.t_trayecto
   SET cod_pensum = v_cod_pensum, num_trayecto = v_num_trayecto, certificado = v_certificado, min_cre_obligatoria = v_min_cre_obligatoria,
       min_cre_electiva = v_min_cre_electiva, min_cre_acreditable = v_min_cre_acreditable, min_can_electiva = v_min_can_electiva
 WHERE sis.t_trayecto.codigo = v_codigo;


   IF found THEN
	v_operacion :=1;
   END IF;

 RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_trayecto_actualizar(integer, integer, integer, text, integer, integer, integer, integer) OWNER TO sisconot;

--
-- Name: f_trayecto_eliminar(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_trayecto_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;
BEGIN

  DELETE FROM sis.t_trayecto
  WHERE t_trayecto.codigo = v_codigo;

  IF found THEN
  v_operacion :=1;
  END IF;

RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_trayecto_eliminar(integer) OWNER TO sisconot;

--
-- Name: f_trayecto_insertar(integer, integer, text, integer, integer, integer, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_trayecto_insertar(integer, integer, text, integer, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoTrayecto integer := 0;
	v_cod_pensum ALIAS for $1;
	v_num_trayecto ALIAS for $2;
	v_certificado ALIAS for $3;
	v_min_cre_obligatoria ALIAS for $4;
	v_min_cre_electiva ALIAS for $5;
	v_min_cre_acreditable ALIAS for $6;
	v_min_can_electiva ALIAS for $7;
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_trayecto INTO codigoTrayecto;
  codigoTrayecto := codigoTrayecto + 1;

  INSERT INTO sis.t_trayecto(codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva)
    VALUES (codigoTrayecto, v_cod_pensum, v_num_trayecto, v_certificado, v_min_cre_obligatoria, v_min_cre_electiva, v_min_cre_acreditable, v_min_can_electiva);

  RETURN codigoTrayecto;

END;
$_$;


ALTER FUNCTION sis.f_trayecto_insertar(integer, integer, text, integer, integer, integer, integer) OWNER TO sisconot;

--
-- Name: f_trayecto_por_codigo_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_trayecto_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN

  OPEN $1 FOR SELECT codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria,
       min_cre_electiva, min_cre_acreditable, min_can_electiva
  FROM sis.t_trayecto where codigo = $2;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_trayecto_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_trayecto_por_patron_seleccionar(refcursor, integer, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_trayecto_por_patron_seleccionar(refcursor, integer, text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN

  OPEN $1 FOR select tra.codigo,
      tra.num_trayecto,
        tra.certificado
        from  sis.t_trayecto tra
      where tra.cod_pensum = $2 and
  upper(tra.certificado) like upper('%'||$3||'%');


 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_trayecto_por_patron_seleccionar(refcursor, integer, text) OWNER TO sisconot;

--
-- Name: f_trayecto_seleccionar(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_trayecto_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

  OPEN $1 FOR SELECT codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria,
       min_cre_electiva, min_cre_acreditable, min_can_electiva
  FROM sis.t_trayecto;


 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_trayecto_seleccionar(refcursor) OWNER TO sisconot;

--
-- Name: f_uni_tra_pensu_actualizar(integer, integer, integer, integer, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_uni_tra_pensu_actualizar(integer, integer, integer, integer, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;
  v_cod_pensum ALIAS for $2;
  v_cod_trayecto ALIAS for $3;
  v_cod_uni_curri ALIAS for $4;
  v_cod_tipo ALIAS for $5;
BEGIN

UPDATE sis.t_uni_tra_pensum
   SET cod_pensum = v_cod_pensum, cod_trayecto = v_cod_trayecto, cod_uni_curricular = v_cod_uni_curri, cod_tipo = v_cod_tipo
 WHERE sis.t_uni_tra_pensum.codigo = v_codigo;

   IF found THEN
  v_operacion :=1;
   END IF;

 RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_actualizar(integer, integer, integer, integer, text) OWNER TO sisconot;

--
-- Name: f_uni_tra_pensu_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_uni_tra_pensu_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
	v_cod_pensum ALIAS for $1;
	v_cod_trayecto ALIAS for $2;
	v_cod_uni_curri ALIAS for $3;
	v_cod_tipo ALIAS for $4;

BEGIN

UPDATE sis.t_uni_tra_pensum
   SET cod_pensum = v_cod_pensum, cod_trayecto = v_cod_trayecto, cod_uni_curricular = v_cod_uni_curri, cod_tipo = v_cod_tipo

 WHERE sis.t_uni_tra_pensum.codigo = v_codigo;

   IF found THEN
	v_operacion :=1;
   END IF;

 RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) OWNER TO sisconot;

--
-- Name: f_uni_tra_pensu_eliminar(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_uni_tra_pensu_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;
BEGIN

  DELETE FROM sis.t_uni_tra_pensum
  WHERE t_uni_tra_pensum.codigo = v_codigo;

  IF found THEN
  v_operacion :=1;
  END IF;

RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_eliminar(integer) OWNER TO sisconot;

--
-- Name: f_uni_tra_pensu_insertar(integer, integer, integer, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_uni_tra_pensu_insertar(integer, integer, integer, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  codigoUniTraPen integer := 0;
  v_cod_pensum ALIAS for $1;
  v_trayecto ALIAS for $2;
  v_cod_uni_curri ALIAS for $3;
  v_cod_tipo ALIAS for $4;
BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_uni_tra_pensum INTO codigoUniTraPen;
  codigoUniTraPen := codigoUniTraPen + 1;

  INSERT INTO sis.t_uni_tra_pensum(codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo)
    VALUES (codigoUniTraPen, v_cod_pensum, v_trayecto, v_cod_uni_curri, v_cod_tipo);

  RETURN codigoUniTraPen;

END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_insertar(integer, integer, integer, text) OWNER TO sisconot;

--
-- Name: f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN

  OPEN $1 FOR SELECT utp.codigo, utp.cod_pensum, utp.cod_trayecto, utp.cod_uni_curricular, utp.cod_tipo,
  uni.descripcion
  FROM sis.t_uni_tra_pensum as utp
  left join sis.t_uni_curricular uni on utp.cod_uni_curricular = uni.codigo
  where utp.codigo = $2;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_uni_tra_pensu_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_unicurricular_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_operacion integer := 0;
	v_codigo ALIAS for $1;
	v_cod_uni_ministerio ALIAS for $2;
	v_nombre ALIAS for $3;
	v_hta ALIAS for $4;
	v_hti ALIAS for $5;
	v_uni_credito ALIAS for $6;
	v_dur_semanas ALIAS for $7;
	v_not_min_aprobatoria ALIAS for $8;
	v_not_maxima ALIAS for $9;
	v_descripcion ALIAS for $10;
	v_observacion ALIAS for $11;
	v_contenido ALIAS for $12;

BEGIN


UPDATE sis.t_uni_curricular
   SET codigo = v_codigo, cod_uni_ministerio = v_cod_uni_ministerio, nombre = v_nombre,  hta = v_hta, hti = v_hti, uni_credito = v_uni_credito,
       dur_semanas = v_dur_semanas, not_min_aprobatoria = v_not_min_aprobatoria, not_maxima = v_not_maxima, descripcion = v_descripcion, observacion = v_observacion, contenido = v_contenido
 WHERE sis.t_uni_curricular.codigo = v_codigo;

   IF found THEN
	v_operacion :=1;
   END IF;

 RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_actualizar(integer, text, text, integer, integer, integer, integer, integer, integer, text, text, text) OWNER TO sisconot;

--
-- Name: f_unicurricular_eliminar(integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_eliminar(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  v_operacion integer := 0;
  v_codigo ALIAS for $1;
BEGIN

  DELETE FROM sis.t_uni_curricular
  WHERE t_uni_curricular.codigo = v_codigo;

  IF found THEN
  v_operacion :=1;
  END IF;

RETURN v_operacion;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_eliminar(integer) OWNER TO sisconot;

--
-- Name: f_unicurricular_insertar(text, text, integer, integer, integer, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_insertar(text, text, integer, integer, integer, integer, integer, integer, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	codigoUniCurricular integer := 0;
	v_cod_uni_ministerio ALIAS for $1;
	v_nombre ALIAS for $2;
	v_hta ALIAS for $3;
	v_hti ALIAS for $4;
	v_uni_credito ALIAS for $5;
	v_dur_semanas ALIAS for $6;
	v_not_min_aprobatoria ALIAS for $7;
	v_not_maxima ALIAS for $8;
	v_descripcion ALIAS for $9;
	v_observacion ALIAS for $10;
	v_contenido ALIAS for $11;

BEGIN

  SELECT COALESCE (max(codigo),0) FROM sis.t_uni_curricular INTO codigoUniCurricular;
  codigoUniCurricular := codigoUniCurricular + 1;

  INSERT INTO sis.t_uni_curricular(codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, not_min_aprobatoria, not_maxima, descripcion, observacion, contenido)
            VALUES (codigoUniCurricular, v_cod_uni_ministerio, v_nombre, v_hta, v_hti, v_uni_credito, v_dur_semanas, v_not_min_aprobatoria, v_not_maxima, v_descripcion, v_observacion, v_contenido);

  RETURN codigoUniCurricular;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_insertar(text, text, integer, integer, integer, integer, integer, integer, text, text, text) OWNER TO sisconot;

--
-- Name: f_unicurricular_por_codigo_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_por_codigo_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN

  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas,
       not_min_aprobatoria, not_maxima, descripcion, observacion, contenido
  FROM sis.t_uni_curricular where codigo = $2;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_codigo_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_unicurricular_por_patron_seleccionar(refcursor, text, text); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_por_patron_seleccionar(refcursor, text, text) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN
  -- buscar por 

  if ($3 = '0') then
  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, descripcion
  FROM sis.t_uni_curricular where
     sis.utf(cod_uni_ministerio) ilike sis.utf('%'||$2||'%') or 
     sis.utf(nombre) ilike sis.utf('%'||$2||'%') or
     sis.utf(descripcion) ilike sis.utf('%'||$2||'%')
     ;
  end if;
  
  if ($3 = '1') then
  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, descripcion
  FROM sis.t_uni_curricular where
    upper(sis.utf(cod_uni_ministerio)) ilike upper(sis.utf('%'||$2||'%'));
  end if;

   if ($3 = '2') then
   OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, descripcion
    FROM sis.t_uni_curricular where upper(sis.utf(nombre)) ilike upper(sis.utf('%'||$2||'%'));
   end if;  

     if ($3 = '3') then
   OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, descripcion
    FROM sis.t_uni_curricular where upper(sis.utf(descripcion)) ilike upper(sis.utf('%'||$2||'%'));
   end if;  
    
  
 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_patron_seleccionar(refcursor, text, text) OWNER TO sisconot;

--
-- Name: f_unicurricular_por_pen_usado(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_por_pen_usado(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
BEGIN

  OPEN $1 FOR select distinct (p.nom_corto) as nomcorto from sis.t_uni_tra_pensum v left join sis.t_pensum p on v.cod_pensum = p.codigo
  where cod_uni_curricular = $2 GROUP BY  p.nom_corto;
  
 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_pen_usado(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_unicurricular_por_pen_y_tray_seleccionar(refcursor, integer, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_por_pen_y_tray_seleccionar(refcursor, integer, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		where utp.cod_pensum = $2 and utp.cod_trayecto = $3 ;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_pen_y_tray_seleccionar(refcursor, integer, integer) OWNER TO sisconot;

--
-- Name: f_unicurricular_por_pensum_seleccionar(refcursor, integer); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_por_pensum_seleccionar(refcursor, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

	IF $2 < 1 THEN
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo;

	  ELSE
	  OPEN $1 FOR select *
		from sis.t_pensum  pen
		inner join  sis.t_uni_tra_pensum utp on pen.codigo = utp.cod_pensum
		inner join sis.t_uni_curricular unc on utp.cod_uni_curricular = unc.codigo
		where pen.codigo = $2;

	END IF;

 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_por_pensum_seleccionar(refcursor, integer) OWNER TO sisconot;

--
-- Name: f_unicurricular_seleccionar(refcursor); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION f_unicurricular_seleccionar(refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$

BEGIN

  OPEN $1 FOR SELECT codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas,
       not_min_aprobatoria, not_maxima, descripcion, observacion, contenido
  FROM sis.t_uni_curricular ORDER BY codigo ASC;



 RETURN $1;

END;
$_$;


ALTER FUNCTION sis.f_unicurricular_seleccionar(refcursor) OWNER TO sisconot;

--
-- Name: utf(character varying); Type: FUNCTION; Schema: sis; Owner: sisconot
--

CREATE FUNCTION utf(character varying) RETURNS text
    LANGUAGE sql
    AS $_$
    SELECT TRANSLATE
    ($1,
    'áàâãäéèêëíìïóòôõöúùûüÁÀÂÃÄÉÈÊËÍÌÏÓÒÔÕÖÚÙÛÜçÇ',
    'aaaaaeeeeiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcC');
  $_$;


ALTER FUNCTION sis.utf(character varying) OWNER TO sisconot;

SET search_path = per, pg_catalog;

--
-- Name: s_acc_usuario; Type: SEQUENCE; Schema: per; Owner: admin
--

CREATE SEQUENCE s_acc_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
    CYCLE;


ALTER TABLE per.s_acc_usuario OWNER TO admin;

--
-- Name: s_accion; Type: SEQUENCE; Schema: per; Owner: admin
--

CREATE SEQUENCE s_accion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
    CYCLE;


ALTER TABLE per.s_accion OWNER TO admin;

--
-- Name: s_modulo; Type: SEQUENCE; Schema: per; Owner: admin
--

CREATE SEQUENCE s_modulo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
    CYCLE;


ALTER TABLE per.s_modulo OWNER TO admin;

--
-- Name: s_tab_accion; Type: SEQUENCE; Schema: per; Owner: admin
--

CREATE SEQUENCE s_tab_accion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
    CYCLE;


ALTER TABLE per.s_tab_accion OWNER TO admin;

--
-- Name: s_tabla; Type: SEQUENCE; Schema: per; Owner: admin
--

CREATE SEQUENCE s_tabla
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
    CYCLE;


ALTER TABLE per.s_tabla OWNER TO admin;

--
-- Name: s_usuario; Type: SEQUENCE; Schema: per; Owner: admin
--

CREATE SEQUENCE s_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
    CYCLE;


ALTER TABLE per.s_usuario OWNER TO admin;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: t_acc_usuario; Type: TABLE; Schema: per; Owner: admin; Tablespace: 
--

CREATE TABLE t_acc_usuario (
    codigo integer NOT NULL,
    cod_usuario integer NOT NULL,
    cod_accion integer NOT NULL
);


ALTER TABLE per.t_acc_usuario OWNER TO admin;

--
-- Name: t_accion; Type: TABLE; Schema: per; Owner: admin; Tablespace: 
--

CREATE TABLE t_accion (
    codigo integer NOT NULL,
    nombre character varying(30) NOT NULL,
    cod_modulo integer,
    descripcion character varying(100)
);


ALTER TABLE per.t_accion OWNER TO admin;

--
-- Name: t_modulo; Type: TABLE; Schema: per; Owner: admin; Tablespace: 
--

CREATE TABLE t_modulo (
    codigo integer NOT NULL,
    nombre character varying(30) NOT NULL,
    descripcion character varying(100)
);


ALTER TABLE per.t_modulo OWNER TO admin;

--
-- Name: t_tab_accion; Type: TABLE; Schema: per; Owner: admin; Tablespace: 
--

CREATE TABLE t_tab_accion (
    codigo integer NOT NULL,
    cod_tabla integer NOT NULL,
    cod_accion integer NOT NULL,
    permiso character varying(4)
);


ALTER TABLE per.t_tab_accion OWNER TO admin;

--
-- Name: t_tabla; Type: TABLE; Schema: per; Owner: admin; Tablespace: 
--

CREATE TABLE t_tabla (
    codigo integer NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE per.t_tabla OWNER TO admin;

--
-- Name: t_usuario; Type: TABLE; Schema: per; Owner: admin; Tablespace: 
--

CREATE TABLE t_usuario (
    codigo integer NOT NULL,
    usuario character varying(30) NOT NULL,
    tipo character(1) NOT NULL,
    campo1 integer,
    campo2 character varying(30),
    campo3 character varying(30),
    CONSTRAINT chk_usuario_01 CHECK ((tipo = ANY (ARRAY['U'::bpchar, 'R'::bpchar])))
);


ALTER TABLE per.t_usuario OWNER TO admin;

SET search_path = sis, pg_catalog;

--
-- Name: s_cur_estudiante; Type: SEQUENCE; Schema: sis; Owner: admin
--

CREATE SEQUENCE s_cur_estudiante
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sis.s_cur_estudiante OWNER TO admin;

--
-- Name: s_curso; Type: SEQUENCE; Schema: sis; Owner: admin
--

CREATE SEQUENCE s_curso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sis.s_curso OWNER TO admin;

--
-- Name: s_instituto; Type: SEQUENCE; Schema: sis; Owner: admin
--

CREATE SEQUENCE s_instituto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
    CYCLE;


ALTER TABLE sis.s_instituto OWNER TO admin;

--
-- Name: t_acreditable; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_acreditable (
    codigo integer NOT NULL,
    cod_estudiante integer NOT NULL,
    cod_pensum integer NOT NULL,
    cod_trayecto integer,
    uni_credito integer NOT NULL,
    fecha date,
    descripcion character varying(300) NOT NULL,
    CONSTRAINT chk_acreditable_01 CHECK ((uni_credito >= 0))
);


ALTER TABLE sis.t_acreditable OWNER TO admin;

--
-- Name: TABLE t_acreditable; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_acreditable IS 'Tabla que maneja las unidades de crédito acreditadas por un estudiante.';


--
-- Name: COLUMN t_acreditable.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_acreditable.codigo IS 'Código de la acreditación.';


--
-- Name: COLUMN t_acreditable.cod_estudiante; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_acreditable.cod_estudiante IS 'Código del estudiante que acreditó.';


--
-- Name: COLUMN t_acreditable.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_acreditable.cod_pensum IS 'Código del pensum en el que acreditó.';


--
-- Name: COLUMN t_acreditable.cod_trayecto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_acreditable.cod_trayecto IS 'Código del trayecto en el que se formalizará la acreditación. Si este es null se tomará en cuenta para la carrera.';


--
-- Name: COLUMN t_acreditable.uni_credito; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_acreditable.uni_credito IS 'Cantidad de unidades de crédito a acreditarse.';


--
-- Name: COLUMN t_acreditable.fecha; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_acreditable.fecha IS 'Fecha en la que se produjo la acreditación.';


--
-- Name: COLUMN t_acreditable.descripcion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_acreditable.descripcion IS 'Descripción obligatoria de la acreditación. Motivo de la misma.';


--
-- Name: t_archivo; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_archivo (
    codigo integer NOT NULL,
    tipo character varying(30),
    archivo oid
);


ALTER TABLE sis.t_archivo OWNER TO admin;

--
-- Name: TABLE t_archivo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_archivo IS 'En la tabla Archivo se manejan las fotos de las personas';


--
-- Name: COLUMN t_archivo.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_archivo.codigo IS 'Codigo unico con el que se identifica un archivo';


--
-- Name: COLUMN t_archivo.tipo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_archivo.tipo IS 'Tipo de archivo';


--
-- Name: COLUMN t_archivo.archivo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_archivo.archivo IS 'Es en donde va estar almacenada la imagen/archivo';


--
-- Name: t_convalidacion; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_convalidacion (
    codigo integer NOT NULL,
    cod_estudiante integer NOT NULL,
    con_nota boolean,
    nota double precision,
    fecha date NOT NULL,
    cod_tip_uni_curricular character(1),
    cod_pensum integer NOT NULL,
    cod_trayecto integer,
    cod_uni_curricular integer NOT NULL,
    descripcion character varying(300),
    CONSTRAINT chk_convalidacion_01 CHECK ((nota >= (0)::double precision)),
    CONSTRAINT chk_convalidacion_02 CHECK (((fecha > '1970-01-01'::date) AND (fecha <= ('now'::text)::date)))
);


ALTER TABLE sis.t_convalidacion OWNER TO admin;

--
-- Name: TABLE t_convalidacion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_convalidacion IS 'Tabla encargada de manejar las convalidaciones de un estudiante en un pensum.';


--
-- Name: COLUMN t_convalidacion.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.codigo IS 'Código de la convalidación.';


--
-- Name: COLUMN t_convalidacion.cod_estudiante; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.cod_estudiante IS 'Código foráneo que indica el estudiante que convalidará.';


--
-- Name: COLUMN t_convalidacion.con_nota; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.con_nota IS 'Boolean que indica si la convalidación lleva (o no) nota.';


--
-- Name: COLUMN t_convalidacion.nota; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.nota IS 'Nota con la que se convalidará (puede ser NULL o estar vacío)';


--
-- Name: COLUMN t_convalidacion.cod_tip_uni_curricular; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.cod_tip_uni_curricular IS 'Tipo de unidad curricular a validar';


--
-- Name: COLUMN t_convalidacion.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.cod_pensum IS 'Código del pensum en el que se va a convalidar.';


--
-- Name: COLUMN t_convalidacion.cod_trayecto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.cod_trayecto IS 'Código del trayecto en el que se tomará la convalidación.';


--
-- Name: COLUMN t_convalidacion.cod_uni_curricular; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.cod_uni_curricular IS 'Código de la unidad curricular que se convalidará.';


--
-- Name: COLUMN t_convalidacion.descripcion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_convalidacion.descripcion IS 'Descripción de la convalidación (opcional)';


--
-- Name: t_cur_estudiante; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_cur_estudiante (
    codigo integer DEFAULT nextval('s_cur_estudiante'::regclass) NOT NULL,
    cod_curso integer NOT NULL,
    cod_estudiante integer NOT NULL,
    por_asistencia double precision,
    nota double precision,
    cod_estado character(1),
    observaciones character varying(300),
    CONSTRAINT chk_cur_estudiante_01 CHECK ((nota >= (0)::double precision)),
    CONSTRAINT chk_cur_estudiante_02 CHECK ((por_asistencia >= (0)::double precision))
);


ALTER TABLE sis.t_cur_estudiante OWNER TO admin;

--
-- Name: TABLE t_cur_estudiante; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_cur_estudiante IS 'Tabla encargada de manejar la información de un estudiante en un curso.';


--
-- Name: COLUMN t_cur_estudiante.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_cur_estudiante.codigo IS 'Código único del registro, llave primaria';


--
-- Name: COLUMN t_cur_estudiante.cod_curso; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_cur_estudiante.cod_curso IS 'Código del curso en el que está el estudiante.';


--
-- Name: COLUMN t_cur_estudiante.cod_estudiante; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_cur_estudiante.cod_estudiante IS 'Código del estudiante al que se hace referencia.';


--
-- Name: COLUMN t_cur_estudiante.por_asistencia; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_cur_estudiante.por_asistencia IS 'Porcentaje de asistencia del estudiante en el curso.';


--
-- Name: COLUMN t_cur_estudiante.nota; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_cur_estudiante.nota IS 'Nota del estudiante en el curso.';


--
-- Name: COLUMN t_cur_estudiante.cod_estado; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_cur_estudiante.cod_estado IS 'Estado del estudiante en el curso.';


--
-- Name: COLUMN t_cur_estudiante.observaciones; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_cur_estudiante.observaciones IS 'Observaciones del estudiante en el curso.';


--
-- Name: t_curso; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_curso (
    codigo integer DEFAULT nextval('s_curso'::regclass) NOT NULL,
    cod_periodo integer NOT NULL,
    cod_uni_curricular integer NOT NULL,
    cod_docente integer,
    seccion character varying(5) NOT NULL,
    fec_inicio date,
    fec_final date,
    capacidad smallint,
    observaciones character varying(300),
    cod_estado character(1),
    CONSTRAINT chk_curso_01 CHECK ((fec_inicio < fec_final)),
    CONSTRAINT chk_curso_02 CHECK ((capacidad >= 0)),
    CONSTRAINT chk_curso_03 CHECK ((length(btrim((seccion)::text)) > 0))
);


ALTER TABLE sis.t_curso OWNER TO admin;

--
-- Name: TABLE t_curso; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_curso IS 'Tabla encargada de manejar los cursos abiertos de una unidad curricular.';


--
-- Name: COLUMN t_curso.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.codigo IS 'Código del curso';


--
-- Name: COLUMN t_curso.cod_periodo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.cod_periodo IS 'Código del periodo al que pertenece el curso.';


--
-- Name: COLUMN t_curso.cod_uni_curricular; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.cod_uni_curricular IS 'Código de la unidad curricular que se dictará en el curso.';


--
-- Name: COLUMN t_curso.cod_docente; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.cod_docente IS 'Código del docente que dictará el curso.';


--
-- Name: COLUMN t_curso.seccion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.seccion IS 'Sección a la que pertenece el curso.';


--
-- Name: COLUMN t_curso.fec_inicio; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.fec_inicio IS 'Fecha de inicio del curso.';


--
-- Name: COLUMN t_curso.fec_final; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.fec_final IS 'Fecha de finalización del curso.';


--
-- Name: COLUMN t_curso.capacidad; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.capacidad IS 'Cantidad máxima de estudiantes que se pueden aceptar en el curso.';


--
-- Name: COLUMN t_curso.observaciones; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.observaciones IS 'Observaciones del curso.';


--
-- Name: COLUMN t_curso.cod_estado; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_curso.cod_estado IS 'Reservado para el estado del curso(abierto, cerrado).';


--
-- Name: t_electiva; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_electiva (
    codigo integer NOT NULL,
    cod_cur_estudiante integer,
    cod_pensum integer NOT NULL,
    cod_trayecto integer
);


ALTER TABLE sis.t_electiva OWNER TO admin;

--
-- Name: TABLE t_electiva; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_electiva IS 'Tabla encargada de manejar las electivas atadas a un estudiante.';


--
-- Name: COLUMN t_electiva.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_electiva.codigo IS 'Código único del registro, llave primaria';


--
-- Name: COLUMN t_electiva.cod_cur_estudiante; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_electiva.cod_cur_estudiante IS 'Llave foránea de curso_estudiante, se refiere al curso que respalda la electiva';


--
-- Name: COLUMN t_electiva.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_electiva.cod_pensum IS 'Llave foránea del pensum al que pertenece la electiva.';


--
-- Name: COLUMN t_electiva.cod_trayecto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_electiva.cod_trayecto IS 'Llave foránea del trayecto al que pertenece la electiva.';


--
-- Name: t_empleado; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_empleado (
    codigo integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_instituto integer,
    cod_pensum integer,
    cod_estado character varying(1),
    fec_inicio date NOT NULL,
    fec_fin date,
    es_jef_pensum boolean DEFAULT false NOT NULL,
    es_jef_con_estudio boolean DEFAULT false NOT NULL,
    es_ministerio boolean DEFAULT false NOT NULL,
    es_docente boolean DEFAULT false NOT NULL,
    observaciones character varying(200),
    CONSTRAINT chk_empleado_01 CHECK ((fec_fin > fec_inicio)),
    CONSTRAINT chk_empleado_02 CHECK ((fec_inicio > '1970-01-01'::date))
);


ALTER TABLE sis.t_empleado OWNER TO admin;

--
-- Name: TABLE t_empleado; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_empleado IS 'La tabla empleado almacena la informacion de los empledos';


--
-- Name: COLUMN t_empleado.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.codigo IS 'Es el codigo unico con el que se identifica un empleado';


--
-- Name: COLUMN t_empleado.cod_persona; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.cod_persona IS 'Codigo de la persona con la que esta relacionada';


--
-- Name: COLUMN t_empleado.cod_instituto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.cod_instituto IS 'Codigo del instituto al que pertenece';


--
-- Name: COLUMN t_empleado.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.cod_pensum IS 'Codigo del pensum a la que pertenece';


--
-- Name: COLUMN t_empleado.cod_estado; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.cod_estado IS 'Codigo del estado que posee el empleado';


--
-- Name: COLUMN t_empleado.fec_inicio; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.fec_inicio IS 'Fecha en la que el empleado empezo a trabajar';


--
-- Name: COLUMN t_empleado.fec_fin; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.fec_fin IS 'Fecha en la que el empleado termino de trabajar';


--
-- Name: COLUMN t_empleado.es_jef_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.es_jef_pensum IS 'Dice si un empleado es un jefe de pensum';


--
-- Name: COLUMN t_empleado.es_jef_con_estudio; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.es_jef_con_estudio IS 'Dice si un empleado es jefe de control de estudio';


--
-- Name: COLUMN t_empleado.es_ministerio; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.es_ministerio IS 'Dice si un empelado trabaja en el ministerio';


--
-- Name: COLUMN t_empleado.es_docente; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_empleado.es_docente IS 'Dice si un empleado trabaja como docente';


--
-- Name: t_est_cur_estudiante; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_est_cur_estudiante (
    codigo character(1) NOT NULL,
    nombre character varying(30)
);


ALTER TABLE sis.t_est_cur_estudiante OWNER TO admin;

--
-- Name: TABLE t_est_cur_estudiante; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_est_cur_estudiante IS 'Tabla que maneja los estados de un estudiante dentro de un curso.';


--
-- Name: COLUMN t_est_cur_estudiante.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_est_cur_estudiante.codigo IS 'Código del estado';


--
-- Name: COLUMN t_est_cur_estudiante.nombre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_est_cur_estudiante.nombre IS 'Nombre del estado';


--
-- Name: t_est_empleado; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_est_empleado (
    codigo character(1) NOT NULL,
    nombre character varying(40) NOT NULL
);


ALTER TABLE sis.t_est_empleado OWNER TO admin;

--
-- Name: t_est_estudiante; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_est_estudiante (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_estudiante OWNER TO admin;

--
-- Name: t_est_periodo; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_est_periodo (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_periodo OWNER TO admin;

--
-- Name: TABLE t_est_periodo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_est_periodo IS 'Estado que determina si el periodo académico ha finalizado o no (abierto o cerrado)';


--
-- Name: COLUMN t_est_periodo.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_est_periodo.codigo IS 'Código del estado.';


--
-- Name: COLUMN t_est_periodo.nombre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_est_periodo.nombre IS 'Nombre del estado del periodo académico.';


--
-- Name: t_estudiante; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_estudiante (
    codigo integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_instituto integer NOT NULL,
    cod_pensum integer NOT NULL,
    num_carnet character varying(25),
    num_expediente character varying(25),
    cod_rusnies character varying(20),
    cod_estado character(1),
    fec_inicio date NOT NULL,
    condicion character varying(5),
    fec_fin date,
    observaciones character varying(200),
    CONSTRAINT chk_estudiante_01 CHECK ((fec_fin > fec_inicio)),
    CONSTRAINT chk_estudiante_02 CHECK ((fec_inicio > '1970-01-01'::date))
);


ALTER TABLE sis.t_estudiante OWNER TO admin;

--
-- Name: TABLE t_estudiante; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_estudiante IS 'La tabla estudiante almacena informacion sobre los estudiantes';


--
-- Name: COLUMN t_estudiante.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.codigo IS 'Codigo unico con el que se identifica un estudiante';


--
-- Name: COLUMN t_estudiante.cod_persona; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.cod_persona IS 'Codigo de la persona con la que se relaciona';


--
-- Name: COLUMN t_estudiante.cod_instituto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.cod_instituto IS 'Codigo del instituto al que pertenece';


--
-- Name: COLUMN t_estudiante.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.cod_pensum IS 'Codigo del pensum al que pertenece el estudiante';


--
-- Name: COLUMN t_estudiante.num_carnet; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.num_carnet IS 'Numero del carnet del estudiante';


--
-- Name: COLUMN t_estudiante.num_expediente; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.num_expediente IS 'Numero del expediente del estudiante';


--
-- Name: COLUMN t_estudiante.cod_rusnies; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.cod_rusnies IS 'Codigo rusnies que tiene el estudiante';


--
-- Name: COLUMN t_estudiante.cod_estado; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.cod_estado IS 'Codigo del estado que posee el estudiante';


--
-- Name: COLUMN t_estudiante.fec_inicio; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.fec_inicio IS 'Fecha en el que el estudiante empezo a estudiar';


--
-- Name: COLUMN t_estudiante.condicion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.condicion IS 'Condicion que posee el estudiante';


--
-- Name: COLUMN t_estudiante.fec_fin; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.fec_fin IS 'Fecha en la que el estudiante dejo de estudiar';


--
-- Name: COLUMN t_estudiante.observaciones; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_estudiante.observaciones IS 'Observaciones sobre el estudiante';


--
-- Name: t_instituto; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_instituto (
    codigo smallint NOT NULL,
    nom_corto character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion character varying(200)
);


ALTER TABLE sis.t_instituto OWNER TO admin;

--
-- Name: TABLE t_instituto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_instituto IS 'Tabla que almacena la información básica de los institutos universitarios y/o universidades';


--
-- Name: COLUMN t_instituto.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_instituto.codigo IS 'Código del registro que identifica al instituto';


--
-- Name: COLUMN t_instituto.nom_corto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_instituto.nom_corto IS 'Nombre corto del instituto, también es una llave alternativa';


--
-- Name: COLUMN t_instituto.nombre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_instituto.nombre IS 'Nombre largo del instituto.';


--
-- Name: COLUMN t_instituto.direccion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_instituto.direccion IS 'Ubicación geográfica del instituto';


--
-- Name: t_pensum; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_pensum (
    codigo integer NOT NULL,
    nombre character varying(50) NOT NULL,
    nom_corto character varying(20) NOT NULL,
    observaciones character varying(200),
    min_can_electiva smallint DEFAULT 0 NOT NULL,
    min_cre_electiva smallint DEFAULT 0 NOT NULL,
    min_cre_obligatoria smallint DEFAULT 0 NOT NULL,
    fec_creacion date,
    cod_archivo integer,
    CONSTRAINT chk_t_pensum_01 CHECK ((min_can_electiva >= 0)),
    CONSTRAINT chk_t_pensum_02 CHECK ((min_cre_electiva >= 0)),
    CONSTRAINT chk_t_pensum_03 CHECK ((min_cre_obligatoria >= 0)),
    CONSTRAINT chk_t_pensum_04 CHECK ((fec_creacion >= '1950-01-01'::date))
);


ALTER TABLE sis.t_pensum OWNER TO admin;

--
-- Name: TABLE t_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_pensum IS 'Tabla padre de un pensum';


--
-- Name: COLUMN t_pensum.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.codigo IS 'Código del pensum';


--
-- Name: COLUMN t_pensum.nombre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.nombre IS 'Nombre largo del pensum';


--
-- Name: COLUMN t_pensum.nom_corto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.nom_corto IS 'Abreviación del nombre del pensum';


--
-- Name: COLUMN t_pensum.observaciones; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.observaciones IS 'Alguna otra información relevante del pensum';


--
-- Name: COLUMN t_pensum.min_can_electiva; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.min_can_electiva IS 'Minima Cantidad de Electivas que se deben cursar en el pesum';


--
-- Name: COLUMN t_pensum.min_cre_electiva; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.min_cre_electiva IS 'MInima Cantidad de unidades de créditos que se deben cursar en el pensum en unidades obligatorias';


--
-- Name: COLUMN t_pensum.min_cre_obligatoria; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.min_cre_obligatoria IS 'MInima Cantidad de Creditos de Electivas Obligatorios';


--
-- Name: COLUMN t_pensum.fec_creacion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.fec_creacion IS 'Fecha de creacion del pensum';


--
-- Name: COLUMN t_pensum.cod_archivo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_pensum.cod_archivo IS 'codigo de archivo donde se guardan los PDF de pensums';


--
-- Name: t_periodo; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_periodo (
    codigo integer NOT NULL,
    nombre character varying(30),
    cod_instituto integer NOT NULL,
    cod_pensum integer NOT NULL,
    fec_inicio date NOT NULL,
    fec_final date,
    observaciones character varying(150),
    cod_estado character(1) NOT NULL,
    CONSTRAINT chk_periodo_01 CHECK ((codigo > 0)),
    CONSTRAINT chk_periodo_02 CHECK ((fec_inicio < fec_final))
);


ALTER TABLE sis.t_periodo OWNER TO admin;

--
-- Name: TABLE t_periodo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_periodo IS 'Tabla que almacena la información de un periodo académico.';


--
-- Name: COLUMN t_periodo.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.codigo IS 'Código del periodo';


--
-- Name: COLUMN t_periodo.nombre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.nombre IS 'Nombre del periodo académico';


--
-- Name: COLUMN t_periodo.cod_instituto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.cod_instituto IS 'Clave foránea del instituto que abre el periodo.';


--
-- Name: COLUMN t_periodo.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.cod_pensum IS 'Clave foránea del pensum que se dicta en el periodo.';


--
-- Name: COLUMN t_periodo.fec_inicio; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.fec_inicio IS 'Fecha de inicio del periodo académico.';


--
-- Name: COLUMN t_periodo.fec_final; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.fec_final IS 'Fecha de finalización del periodo académico.';


--
-- Name: COLUMN t_periodo.observaciones; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.observaciones IS 'Observaciones del periodo académico.';


--
-- Name: COLUMN t_periodo.cod_estado; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_periodo.cod_estado IS 'Estado del periodo académico (Abierto o Cerrado en el momento de creación del sistema)';


--
-- Name: t_persona; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_persona (
    codigo integer NOT NULL,
    cedula integer NOT NULL,
    rif character varying(20),
    nombre1 character varying(20) NOT NULL,
    nombre2 character varying(20),
    apellido1 character varying(20) NOT NULL,
    apellido2 character varying(20),
    sexo character varying(1) NOT NULL,
    fec_nacimiento date,
    tip_sangre character varying(5),
    telefono1 character varying(15),
    telefono2 character varying(15),
    cor_personal character varying(50),
    cor_institucional character varying(50),
    direccion character varying(150),
    discapacidad character varying(50),
    nacionalidad character varying(1),
    hijos integer,
    est_civil character varying(1),
    observaciones character varying(200),
    cod_foto integer,
    CONSTRAINT chk_persona_01 CHECK (((fec_nacimiento >= '1940-01-01'::date) AND (fec_nacimiento <= ('now'::text)::date))),
    CONSTRAINT chk_persona_02 CHECK (((sexo)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text]))),
    CONSTRAINT chk_persona_03 CHECK (((nacionalidad)::text = ANY (ARRAY[('V'::character varying)::text, ('E'::character varying)::text]))),
    CONSTRAINT chk_persona_04 CHECK (((est_civil)::text = ANY (ARRAY[('S'::character varying)::text, ('C'::character varying)::text, ('D'::character varying)::text, ('V'::character varying)::text, ('O'::character varying)::text]))),
    CONSTRAINT chk_persona_05 CHECK ((hijos >= 0))
);


ALTER TABLE sis.t_persona OWNER TO admin;

--
-- Name: TABLE t_persona; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_persona IS 'La tabla persona almacena la informacion general de las personas';


--
-- Name: COLUMN t_persona.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.codigo IS 'Es el codigo unico que solo pertecene a una persona';


--
-- Name: COLUMN t_persona.cedula; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.cedula IS 'Documento de identidad de la persona';


--
-- Name: COLUMN t_persona.nombre1; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.nombre1 IS 'El primer nombre de la persona';


--
-- Name: COLUMN t_persona.apellido1; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.apellido1 IS 'El primer apellido de la persona';


--
-- Name: COLUMN t_persona.fec_nacimiento; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.fec_nacimiento IS 'Es la fecha en la que nacio la persona';


--
-- Name: COLUMN t_persona.tip_sangre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.tip_sangre IS 'Es el tipo de sangre que tiene la persona';


--
-- Name: COLUMN t_persona.telefono1; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.telefono1 IS 'Es un numero telefonico a donde se puede contactar a la persona';


--
-- Name: COLUMN t_persona.cor_personal; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.cor_personal IS 'Es el correo electronico que tiene una persona';


--
-- Name: COLUMN t_persona.direccion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.direccion IS 'Es la direccion de habitacion de la persona';


--
-- Name: COLUMN t_persona.discapacidad; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.discapacidad IS 'Informacion sobre la discapacidad que tiene la persona';


--
-- Name: COLUMN t_persona.nacionalidad; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.nacionalidad IS 'Es la nacionalidad de la persona es decir Venezolano o extrangero';


--
-- Name: COLUMN t_persona.hijos; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.hijos IS 'Es la cantidad de hijos que tiene la persona';


--
-- Name: COLUMN t_persona.est_civil; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.est_civil IS 'Es el estado civil que tiene la persona';


--
-- Name: COLUMN t_persona.observaciones; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.observaciones IS 'Alguna observacion que se le haga a una persona';


--
-- Name: COLUMN t_persona.cod_foto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_persona.cod_foto IS 'Es la clave foranea de la tabla archivo que es en donde esta almacenada la foto de la persona';


--
-- Name: t_prelacion; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_prelacion (
    codigo integer NOT NULL,
    cod_pensum integer NOT NULL,
    cod_instituto integer NOT NULL,
    cod_uni_curricular integer NOT NULL,
    cod_uni_cur_prelada integer NOT NULL
);


ALTER TABLE sis.t_prelacion OWNER TO admin;

--
-- Name: TABLE t_prelacion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_prelacion IS 'Tabla que almacena las prelaciones entre unidades curriculares';


--
-- Name: COLUMN t_prelacion.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_prelacion.codigo IS 'Código único de la prelación';


--
-- Name: COLUMN t_prelacion.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_prelacion.cod_pensum IS 'Código del pensum al que pertenece la prelación';


--
-- Name: COLUMN t_prelacion.cod_instituto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_prelacion.cod_instituto IS 'Código del instituto donde se está aplicando esta prelación';


--
-- Name: COLUMN t_prelacion.cod_uni_curricular; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_prelacion.cod_uni_curricular IS 'Código de la unidad curricular a establecerle la prelación';


--
-- Name: COLUMN t_prelacion.cod_uni_cur_prelada; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_prelacion.cod_uni_cur_prelada IS 'Código de la unidad que no se puede cursar si no se ha aprobado esta';


--
-- Name: t_tip_uni_curricular; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_tip_uni_curricular (
    codigo character(1) NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE sis.t_tip_uni_curricular OWNER TO admin;

--
-- Name: TABLE t_tip_uni_curricular; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_tip_uni_curricular IS 'Almacena los distintos tipos de unidades curriculares';


--
-- Name: COLUMN t_tip_uni_curricular.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_tip_uni_curricular.codigo IS 'Código del tipo de unidad curricular';


--
-- Name: COLUMN t_tip_uni_curricular.nombre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_tip_uni_curricular.nombre IS 'Nombre del tipo de unidad curricular';


--
-- Name: t_trayecto; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_trayecto (
    codigo integer NOT NULL,
    cod_pensum integer NOT NULL,
    num_trayecto smallint NOT NULL,
    certificado character varying(150),
    min_cre_obligatoria smallint DEFAULT 0 NOT NULL,
    min_cre_electiva smallint DEFAULT 0 NOT NULL,
    min_cre_acreditable smallint DEFAULT 0 NOT NULL,
    min_can_electiva smallint DEFAULT 0 NOT NULL,
    CONSTRAINT chk_t_trayecto_02 CHECK ((num_trayecto >= 0)),
    CONSTRAINT chk_t_trayecto_03 CHECK ((min_cre_obligatoria >= 0)),
    CONSTRAINT chk_t_trayecto_04 CHECK ((min_cre_electiva >= 0)),
    CONSTRAINT chk_t_trayecto_05 CHECK ((min_cre_acreditable >= 0)),
    CONSTRAINT chk_t_trayecto_06 CHECK ((min_can_electiva >= 0))
);


ALTER TABLE sis.t_trayecto OWNER TO admin;

--
-- Name: TABLE t_trayecto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_trayecto IS 'Lista de trayectos, semestres o trimestres de un pensum';


--
-- Name: COLUMN t_trayecto.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.codigo IS 'Código único del trayecto';


--
-- Name: COLUMN t_trayecto.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.cod_pensum IS 'Código del pensum al que pertenece';


--
-- Name: COLUMN t_trayecto.num_trayecto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.num_trayecto IS 'Número de trayecto, año, semestre o trimestre del pensum';


--
-- Name: COLUMN t_trayecto.certificado; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.certificado IS 'Nombre del certificado que se obtiene al finalizar este trayecto';


--
-- Name: COLUMN t_trayecto.min_cre_obligatoria; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.min_cre_obligatoria IS 'Mínima cantidad de créditos en unidades curriculares obligatorias que se deben cursar en este trayecto';


--
-- Name: COLUMN t_trayecto.min_cre_electiva; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.min_cre_electiva IS 'Mínima cantidad de créditos en unidades curriculares electivas que se deben cursar en este trayecto';


--
-- Name: COLUMN t_trayecto.min_cre_acreditable; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.min_cre_acreditable IS 'Mínima cantidad de créditos en actividades acreditables que se deben tener en este trayecto';


--
-- Name: COLUMN t_trayecto.min_can_electiva; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_trayecto.min_can_electiva IS 'Mínima cantidad de unidades electivas que se deben cursar en este trayecto';


--
-- Name: t_uni_curricular; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_uni_curricular (
    codigo integer NOT NULL,
    cod_uni_ministerio character varying(40),
    nombre character varying(60) NOT NULL,
    hta double precision NOT NULL,
    hti double precision,
    uni_credito smallint NOT NULL,
    dur_semanas smallint NOT NULL,
    not_min_aprobatoria smallint NOT NULL,
    not_maxima smallint NOT NULL,
    descripcion character varying(100),
    observacion character varying(100),
    contenido text,
    CONSTRAINT chk_uni_curricular_01 CHECK ((codigo > 0)),
    CONSTRAINT chk_uni_curricular_02 CHECK ((hta >= (0)::double precision)),
    CONSTRAINT chk_uni_curricular_03 CHECK ((hti >= (0)::double precision)),
    CONSTRAINT chk_uni_curricular_04 CHECK ((uni_credito >= 0)),
    CONSTRAINT chk_uni_curricular_05 CHECK ((dur_semanas >= 0)),
    CONSTRAINT chk_uni_curricular_06 CHECK ((not_min_aprobatoria >= 0)),
    CONSTRAINT chk_uni_curricular_07 CHECK ((not_maxima >= not_min_aprobatoria))
);


ALTER TABLE sis.t_uni_curricular OWNER TO admin;

--
-- Name: TABLE t_uni_curricular; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_uni_curricular IS 'Tabla que almacena la información de las unidades curriculares';


--
-- Name: COLUMN t_uni_curricular.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.codigo IS 'Código único de la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.cod_uni_ministerio; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.cod_uni_ministerio IS 'Código de la unidad curricular según el ministerio';


--
-- Name: COLUMN t_uni_curricular.nombre; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.nombre IS 'Nombre de la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.hta; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.hta IS 'Horas de Trabajo Acompañado por semana(horas de clase)';


--
-- Name: COLUMN t_uni_curricular.hti; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.hti IS 'Horas de Trabajo Independiente por semana';


--
-- Name: COLUMN t_uni_curricular.uni_credito; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.uni_credito IS 'Cantidad de unidades de crédito de la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.dur_semanas; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.dur_semanas IS 'Cantidad de semanas que dura la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.not_min_aprobatoria; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.not_min_aprobatoria IS 'Nota mínima con la que se aprueba la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.not_maxima; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.not_maxima IS 'Nota máxima o escala de nota de la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.descripcion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.descripcion IS 'descripcion adicional de la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.observacion; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.observacion IS 'observaciones acerca de la unidad curricular';


--
-- Name: COLUMN t_uni_curricular.contenido; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_curricular.contenido IS 'contenido de la unidad curricular';


--
-- Name: t_uni_tra_pensum; Type: TABLE; Schema: sis; Owner: admin; Tablespace: 
--

CREATE TABLE t_uni_tra_pensum (
    codigo integer NOT NULL,
    cod_pensum integer NOT NULL,
    cod_trayecto integer,
    cod_uni_curricular integer NOT NULL,
    cod_tipo character(1) NOT NULL
);


ALTER TABLE sis.t_uni_tra_pensum OWNER TO admin;

--
-- Name: TABLE t_uni_tra_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON TABLE t_uni_tra_pensum IS 'Tabla relacional entre unidad , trayecto y pensum para malla';


--
-- Name: COLUMN t_uni_tra_pensum.codigo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_tra_pensum.codigo IS 'Código del pensum';


--
-- Name: COLUMN t_uni_tra_pensum.cod_pensum; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_tra_pensum.cod_pensum IS 'Nombre largo del pensum';


--
-- Name: COLUMN t_uni_tra_pensum.cod_trayecto; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_tra_pensum.cod_trayecto IS 'Abreviación del nombre del pensum';


--
-- Name: COLUMN t_uni_tra_pensum.cod_tipo; Type: COMMENT; Schema: sis; Owner: admin
--

COMMENT ON COLUMN t_uni_tra_pensum.cod_tipo IS 'Alguna otra información relevante del pensum';


SET search_path = per, pg_catalog;

--
-- Name: s_acc_usuario; Type: SEQUENCE SET; Schema: per; Owner: admin
--

SELECT pg_catalog.setval('s_acc_usuario', 34, true);


--
-- Name: s_accion; Type: SEQUENCE SET; Schema: per; Owner: admin
--

SELECT pg_catalog.setval('s_accion', 61, true);


--
-- Name: s_modulo; Type: SEQUENCE SET; Schema: per; Owner: admin
--

SELECT pg_catalog.setval('s_modulo', 15, true);


--
-- Name: s_tab_accion; Type: SEQUENCE SET; Schema: per; Owner: admin
--

SELECT pg_catalog.setval('s_tab_accion', 100, true);


--
-- Name: s_tabla; Type: SEQUENCE SET; Schema: per; Owner: admin
--

SELECT pg_catalog.setval('s_tabla', 27, true);


--
-- Name: s_usuario; Type: SEQUENCE SET; Schema: per; Owner: admin
--

SELECT pg_catalog.setval('s_usuario', 7, true);


--
-- Data for Name: t_acc_usuario; Type: TABLE DATA; Schema: per; Owner: admin
--

COPY t_acc_usuario (codigo, cod_usuario, cod_accion) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	7	1
24	7	19
25	7	23
26	7	24
27	7	29
28	7	33
29	7	41
30	7	53
31	7	37
32	7	45
33	7	49
34	7	57
\.


--
-- Data for Name: t_accion; Type: TABLE DATA; Schema: per; Owner: admin
--

COPY t_accion (codigo, nombre, cod_modulo, descripcion) FROM stdin;
1	IniciarSesion	1	Acción que permite al usuario iniciar sesión
2	AccionListar	2	Acción que permite obtener la lista de acciones
3	AccionAgregar	2	Acción que permite agregar una acción a la base de datos
4	AccionModificar	2	Acción que permite modificar una acción a la base de datos
5	AccionEliminar	2	Acción que permite eliminar una acción a la base de datos
6	TablaListar	5	Acción que permite al usuario obtener la lista de tablas
7	TablaAgregar	5	Acción que permite al usuario agregar tablas
8	TablaModificar	5	Acción que permite al usuario modificar tablas
9	TablaEliminar	5	Acción que permite al usuario eliminar tablas
10	ModuloListar	4	Acción que permite obtener la lista de módulos
11	ModuloAgregar	4	Acción que permite al usuario agregar módulos. 
12	ModuloModificar	4	Acción que permite al usuario modificar módulos. 
13	ModuloEliminar	4	Acción que permite al usuario eliminar módulos. 
14	UsuarioListar	3	Acción que permite al usuario listar los usuarios. 
15	UsuarioModificar	3	Acción que permite al usuario modificar usuario. 
16	UsuarioEliminar	3	Acción que permite al usuario eliminar Usuarios. 
17	UsuarioAgregar	3	Acción que permite al usuario agregar Usuarios. 
18	AdministrarPrivilegios	3	Acción que permite al usuario aadministrar privilegios de otros usuarios. 
19	CursoListar	6	
20	CursoAgregar	6	
21	CursoModificar	6	
22	CursoEliminar	6	
23	DatosPersona	1	
24	CurEstudianteListar	6	
25	CurEstudianteAgregar	6	
26	CurEstudianteModificar	6	
27	CurEstudianteEliminar	6	
29	PeriodoListar	7	
30	PeriodoAgregar	7	
31	PeriodoModificar	7	
32	PeriodoEliminar	7	
33	InstitutoListar	8	
34	InstitutoAgregar	8	
35	InstitutoModificar	8	
36	InstitutoEliminar	8	
37	PensumListar	9	
38	PensumAgregar	9	
39	PensumModificar	9	
40	PensumEliminar	9	
41	TrayectoListar	15	
42	TrayectoAgregar	15	
43	TrayectoModificar	15	
44	TrayectoEliminar	15	
45	UnidadListar	10	
46	UnidadAgregar	10	
47	UnidadModificar	10	
48	UnidadEliminar	10	
49	PersonaListar	11	
50	PersonaAgregar	11	
51	PersonaModificar	11	
52	PersonaEliminar	11	
53	EstudianteListar	13	
54	EstudianteAgregar	13	
55	EstudianteModificar	13	
56	EstudianteEliminar	13	
57	EmpleadoListar	12	
58	EmpleadoAgregar	12	
59	EmpleadoModificar	12	
61	EmpleadoEliminar	13	
\.


--
-- Data for Name: t_modulo; Type: TABLE DATA; Schema: per; Owner: admin
--

COPY t_modulo (codigo, nombre, descripcion) FROM stdin;
1	Login	Módulo que engloba las acciones relacionadas con Login
2	Accion	Módulo que engloba las acciones relacionadas con Acción
3	Usuario	Módulo que engloba las acciones relacionadas con Usuarios
4	Modulo	Módulo que engloba las acciones relacionadas con Módulo
5	Tabla	Módulo que engloba las acciones relacionadas con Tabla
6	curso	Gestión Académica (cursos) del sistema
7	periodo	
8	instituto	
9	pensum	
10	unidad	
11	persona	
12	empleado	
13	estudiante	
14	foto	
15	trayecto	
\.


--
-- Data for Name: t_tab_accion; Type: TABLE DATA; Schema: per; Owner: admin
--

COPY t_tab_accion (codigo, cod_tabla, cod_accion, permiso) FROM stdin;
1	2	1	S
2	4	1	S
3	6	1	S
4	4	2	S
5	4	3	I
6	3	3	S
7	1	3	S
8	5	3	SIDU
9	4	4	U
10	3	4	S
11	1	4	S
12	5	4	SIDU
13	4	5	D
14	1	6	S
15	1	7	I
16	1	8	U
17	1	9	D
18	3	10	S
19	3	11	I
20	3	12	U
21	3	13	D
22	2	14	S
23	2	15	U
24	2	16	D
25	2	17	I
26	2	18	S
27	6	18	SIDU
28	4	18	S
29	20	19	S
30	20	20	IS
31	20	21	US
32	20	22	D
33	10	23	S
34	13	23	S
35	18	23	S
36	20	24	S
37	21	24	S
38	21	25	SI
39	21	26	US
40	21	27	DS
41	24	29	S
42	27	29	S
43	27	30	SI
44	24	30	SI
45	24	31	US
46	27	31	US
47	27	32	DS
48	24	32	DS
49	25	33	S
50	25	34	IS
51	25	35	US
52	25	36	DS
53	8	37	S
54	26	37	S
55	8	38	IS
56	26	38	IS
57	8	39	US
58	26	39	US
59	8	40	DS
60	26	40	DS
61	8	41	S
62	22	41	S
63	8	42	IS
64	22	42	IS
65	8	43	US
66	22	43	US
67	8	44	DS
68	22	44	DS
69	8	45	S
70	14	45	S
71	19	45	S
72	14	46	IS
73	19	46	IS
74	8	46	IS
75	8	47	US
76	19	47	US
77	14	47	US
78	8	48	DS
79	19	48	DS
80	14	48	DS
81	18	49	S
82	18	50	IS
83	18	51	US
84	18	52	DS
85	11	53	S
86	13	53	S
87	11	54	IS
88	13	54	IS
89	13	55	US
90	11	55	US
91	11	56	DS
92	13	56	DS
93	9	57	S
94	10	57	S
95	9	58	IS
96	10	58	IS
97	9	59	US
98	10	59	US
99	9	61	SD
100	10	61	SD
\.


--
-- Data for Name: t_tabla; Type: TABLE DATA; Schema: per; Owner: admin
--

COPY t_tabla (codigo, nombre) FROM stdin;
1	per.t_tabla
2	per.t_usuario
3	per.t_modulo
4	per.t_accion
5	per.t_tab_accion
6	per.t_acc_usuario
7	sis.t_prelacion
8	sis.t_uni_tra_pensum
9	sis.t_est_empleado
10	sis.t_empleado
11	sis.t_est_estudiante
12	sis.t_archivo
13	sis.t_estudiante
14	sis.t_tip_uni_curricular
15	sis.t_convalidacion
16	sis.t_acreditable
17	sis.t_est_cur_estudiante
18	sis.t_persona
19	sis.t_uni_curricular
20	sis.t_curso
21	sis.t_cur_estudiante
22	sis.t_trayecto
23	sis.t_electiva
24	sis.t_est_periodo
25	sis.t_instituto
26	sis.t_pensum
27	sis.t_periodo
\.


--
-- Data for Name: t_usuario; Type: TABLE DATA; Schema: per; Owner: admin
--

COPY t_usuario (codigo, usuario, tipo, campo1, campo2, campo3) FROM stdin;
1	admin	U	\N	\N	\N
7	sosajean	U	1		
\.


SET search_path = sis, pg_catalog;

--
-- Name: s_cur_estudiante; Type: SEQUENCE SET; Schema: sis; Owner: admin
--

SELECT pg_catalog.setval('s_cur_estudiante', 1, false);


--
-- Name: s_curso; Type: SEQUENCE SET; Schema: sis; Owner: admin
--

SELECT pg_catalog.setval('s_curso', 1, true);


--
-- Name: s_instituto; Type: SEQUENCE SET; Schema: sis; Owner: admin
--

SELECT pg_catalog.setval('s_instituto', 3, true);


--
-- Data for Name: t_acreditable; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_acreditable (codigo, cod_estudiante, cod_pensum, cod_trayecto, uni_credito, fecha, descripcion) FROM stdin;
\.


--
-- Data for Name: t_archivo; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_archivo (codigo, tipo, archivo) FROM stdin;
\.


--
-- Data for Name: t_convalidacion; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_convalidacion (codigo, cod_estudiante, con_nota, nota, fecha, cod_tip_uni_curricular, cod_pensum, cod_trayecto, cod_uni_curricular, descripcion) FROM stdin;
\.


--
-- Data for Name: t_cur_estudiante; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_cur_estudiante (codigo, cod_curso, cod_estudiante, por_asistencia, nota, cod_estado, observaciones) FROM stdin;
\.


--
-- Data for Name: t_curso; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_curso (codigo, cod_periodo, cod_uni_curricular, cod_docente, seccion, fec_inicio, fec_final, capacidad, observaciones, cod_estado) FROM stdin;
1	1	4	\N	A	\N	\N	12		\N
\.


--
-- Data for Name: t_electiva; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_electiva (codigo, cod_cur_estudiante, cod_pensum, cod_trayecto) FROM stdin;
\.


--
-- Data for Name: t_empleado; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_empleado (codigo, cod_persona, cod_instituto, cod_pensum, cod_estado, fec_inicio, fec_fin, es_jef_pensum, es_jef_con_estudio, es_ministerio, es_docente, observaciones) FROM stdin;
1	1	1	1	A	1976-12-28	\N	f	f	f	t	sin comentarios
2	2	1	1	A	1982-11-11	\N	t	f	f	f	sin comentarios
3	3	1	1	A	1979-11-19	\N	f	f	f	t	sin comentarios
4	4	1	1	J	1985-02-01	\N	f	f	f	t	sin comentarios
5	5	1	2	A	1971-10-02	\N	t	f	f	t	
6	6	1	4	A	1988-02-03	\N	f	f	f	t	
7	7	2	5	J	1998-07-19	\N	f	f	f	t	
8	8	2	4	I	1986-05-02	\N	f	f	f	f	
9	9	2	5	A	1980-08-27	\N	f	t	f	f	
10	10	2	4	A	1999-11-23	\N	f	f	f	t	
11	11	2	5	J	1998-08-22	\N	f	f	f	f	
12	12	2	4	A	1986-10-25	\N	f	f	f	t	
13	13	3	6	A	1994-09-08	\N	f	f	f	t	
14	14	3	6	A	1988-05-22	\N	f	f	t	t	
15	15	3	6	A	1972-09-16	\N	f	f	t	t	
16	16	3	6	A	1982-01-26	\N	f	f	f	t	
17	17	3	6	A	1998-08-20	\N	f	f	f	t	
18	18	3	6	A	1972-01-23	\N	f	f	f	t	
19	19	1	6	A	1990-03-22	\N	f	f	f	t	
20	20	2	6	A	1974-01-12	\N	f	f	f	t	
\.


--
-- Data for Name: t_est_cur_estudiante; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_est_cur_estudiante (codigo, nombre) FROM stdin;
I	Inscrito
C	Cursando
E	Reprobado por Inasistencia
X	Retirado
A	Aprobado
R	Reprobado
\.


--
-- Data for Name: t_est_empleado; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_est_empleado (codigo, nombre) FROM stdin;
A	Activo
P	Permiso
I	Inactivo
J	Jubilado
\.


--
-- Data for Name: t_est_estudiante; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_est_estudiante (codigo, nombre) FROM stdin;
A	Activo
G	Graduado
R	Retirado
I	Inactivo
\.


--
-- Data for Name: t_est_periodo; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_est_periodo (codigo, nombre) FROM stdin;
A	Abierto
C	Cerrado
\.


--
-- Data for Name: t_estudiante; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_estudiante (codigo, cod_persona, cod_instituto, cod_pensum, num_carnet, num_expediente, cod_rusnies, cod_estado, fec_inicio, condicion, fec_fin, observaciones) FROM stdin;
2	21	1	2	2121	2121	2121	A	1998-01-27	1	\N	sin obersevacion
3	22	1	3	2222	2222	2222	A	1985-07-05	1	\N	
4	23	1	1	2323	2323	2323	A	1974-02-17	1	\N	
5	24	1	2	2424	2424	2424	G	1981-08-06	1	\N	
6	25	1	3	2525	2525	2525	G	1997-06-24	1	\N	
7	26	2	4	2626	2626	2626	A	2000-06-25	1	\N	
8	27	2	5	2727	2727	2727	A	1981-07-25	1	\N	
9	28	2	4	2828	2828	2828	A	1976-07-17	1	\N	
10	29	2	5	2929	2929	2929	I	1974-10-13	1	\N	
11	30	2	4	3030	3030	3030	I	1982-06-23	1	\N	
12	31	2	5	3131	3131	3131	A	1983-05-01	1	\N	tuvo una pelea con el profesor y le pego un golpe
13	32	2	4	3232	3232	3232	A	1979-03-16	1	\N	se encontro al estudiante fumando dentro del salon
14	33	3	6	3333	3333	3333	A	1989-03-12	1	\N	
15	34	3	6	3434	3434	3434	I	1985-06-21	1	\N	el estudinte fue expulsado de la institucion por vender drogas dentro del resinto
16	35	3	6	3535	3535	3535	A	1994-10-07	1	\N	
17	36	3	6	36	36	3636	A	1992-09-19	1	\N	
18	37	3	6	3737	3737	3737	A	1996-03-23	1	\N	
19	38	3	6	3838	3838	3838	A	1973-04-19	1	\N	
20	39	3	6	3939	3939	3939	A	1976-01-04	1	\N	
21	40	3	6	4040	4040	4040	A	1984-10-13	1	\N	
\.


--
-- Data for Name: t_instituto; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_instituto (codigo, nom_corto, nombre, direccion) FROM stdin;
1	IUTFRP	IUT Federico Rivero Palacio	k8 de la panamericana
2	CULCA	CU CECILIO ACOSTA	LOS TEQUES
3	CUC	IUT CU DE CARACAS	CHACAO
\.


--
-- Data for Name: t_pensum; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_pensum (codigo, nombre, nom_corto, observaciones, min_can_electiva, min_cre_electiva, min_cre_obligatoria, fec_creacion, cod_archivo) FROM stdin;
1	Programa Nacional de Formación Informática	PNFI	PNFI 2008	2	1	2	2008-01-01	\N
2	Programa Nacional de Formación MECANICA	PNFM	PNFM 2008	2	1	2	2008-01-01	\N
3	Programa Nacional de Formación QUIMICA	PNFQ	PNFQ 2008	2	1	2	2008-01-01	\N
4	Programa Nacional de Formación TELECOMINICACIONES	PNFT	PNFT 2008	2	1	2	2008-01-01	\N
5	Programa Nacional de Formación ELECTRONICA	PNFE	PNFE 2008	2	1	2	2008-01-01	\N
6	Programa Nacional de Formación ADMINISTRACION	PNFA	PNFA 2008	2	1	2	2008-01-01	\N
\.


--
-- Data for Name: t_periodo; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_periodo (codigo, nombre, cod_instituto, cod_pensum, fec_inicio, fec_final, observaciones, cod_estado) FROM stdin;
1	2016-2016	1	1	2016-01-01	2017-01-01		A
2	2016-2016	1	2	2016-01-01	2017-01-01		A
3	2016-2016	1	3	2016-01-01	2017-01-01		A
4	2016-2016	2	4	2016-01-01	2017-01-01		A
5	2016-2016	2	5	2016-01-01	2017-01-01		A
6	2016-2016	3	6	2016-01-01	2017-01-01		A
\.


--
-- Data for Name: t_persona; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_persona (codigo, cedula, rif, nombre1, nombre2, apellido1, apellido2, sexo, fec_nacimiento, tip_sangre, telefono1, telefono2, cor_personal, cor_institucional, direccion, discapacidad, nacionalidad, hijos, est_civil, observaciones, cod_foto) FROM stdin;
1	11111	\N	JEAN	\N	SOSA	\N	M	1996-01-25	A+	1111111	\N	jean@hotmail.com	\N	san atnnio	\N	V	0	S	\N	\N
2	2222	\N	JORGE	\N	GOMEZ	PEDROZO	M	1968-09-02	A+	222222	\N	jorge@hotmail.com	\N	san atnnio	\N	V	0	S	\N	\N
3	3333	\N	ALICIA	MAGARITA	GOMEZ	LOPEZ	F	1985-12-05	O+	333333	\N	alicia_e@yahoo.com	\N	petare	\N	V	2	C	\N	\N
4	44444	V-444445	KELLY	ANA	ISTURIS	MANSALBA	F	1983-12-20	O+	2356545	\N	la_chiqui@yahoo.com	\N	la urbina frente cdolnlds	le fata un brazo	E	0	S	le falta el titulo	\N
5	6453423	V-444675	RAMON	\N	MORALES	PEREZ	M	1963-03-25	A-	8675645	\N	rmonsqui@gmail.com	\N	manzanares	es mudo	V	3	C	\N	\N
6	5674534	\N	RAFAEL	RAMON	GARCIA	ROJAS	M	1966-02-15	O-	7564543	\N	elrafael420i@gmail.com	\N	buenos aires	\N	E	0	D	\N	\N
7	34532	V-345344	ANGELICA	SABRINA	ROJAS	PEREZ	F	1986-08-12	O-	7564534	\N	angelik@hotmail.com	\N	el picacho	le falta un dedo	V	0	V	\N	\N
8	8676543	\N	EVELYN	\N	ARMAS	\N	F	1973-03-10	AB+	54634523	\N	argrilment@hotmail.com	\N	\N	\N	V	0	V	\N	\N
9	987685	\N	ARIANNA	VALENTINA	DIAZ	ARMAS	F	1988-09-03	AB-	765	\N	ariannita@yahoo.com	\N	\N	\N	E	0	S	\N	\N
10	6757546	\N	STEPHANY	\N	MENDOZA	ROJAS	F	1993-06-02	AB-	76456232	\N	stephanymen@yahoo.com	\N	catia	\N	V	0	S	\N	\N
11	67575333	\N	SIMON	ALFONSO	RODRIGUEZ	\N	M	1994-02-08	O-	798676545	56467576	sminro@yahoo.com	\N	san antonio	\N	V	2	D	\N	\N
12	867546554	V-5546545	ALFONSO	MUNDO	DE LA CRUZ	SOSA	M	1966-08-24	O-	9877686	98766544	alfos@yahoo.com	alfos@iutfrp.com	las bermudez	\N	V	2	D	\N	\N
13	89786	\N	HILDA	ANDREA	LOPEZ	LORENZO	F	1961-09-22	O+	87654	465788	andahil@yahoo.com	andahil@iutfrp.com	las bermudez	\N	V	0	S	\N	\N
14	23345567	\N	GISEL	ALEJANDRA	MASCOLI	SANCHEZ	F	1989-11-26	O+	68574333	5678999	gigiGl@yahoo.com	gigigi@iutfrp.com	las bermudez	\N	E	0	S	\N	\N
15	786574	\N	JOHAN	ALEJANDRO	SANCHEZ	PALOMERA	M	1989-06-20	O+	98765	546576	aleale@gmail.com	alejo@iutfrp.com	catia	le falta una oreja	E	0	S	\N	\N
16	9897228	\N	MARCO	ALEJANDRO	DE SOUSA	\N	M	1973-05-23	O+	23345556	6456453	ellococo@gmail.com	\N	la dolorita	le falta un ojo	V	2	V	\N	\N
17	88767456	\N	MARIA 	JOSE	HERNANDEZ	DE LA PAZ	F	1970-06-05	O-	2132545	3433242	lachica@gmail.com	\N	el hatillo	\N	V	0	S	\N	\N
18	4634524	\N	JOSE	MARIA	PEREZ	LORENZO	M	1981-07-19	O-	1234256	4564534	eljose@gmail.com	\N	la trinidad	\N	V	1	S	\N	\N
19	54635343	\N	JUAN	ARMANNDO	PAREDES	\N	M	1988-10-21	O-	2343564	234355	armandilo@gmail.com	\N	el limon	\N	V	0	S	\N	\N
20	86786	\N	ALEJANDRO	\N	HERNANDEZ	\N	M	1960-06-22	O-	2346655	7833423	elhen@gmail.com	\N	la morita	\N	V	0	S	le falta la foto	\N
21	34242343	\N	CAROLINA	ALEJANDRA	SEGURA	SALCEDO	F	1992-04-01	A+	12324235	12425555	carol@gmail.com	carol@iutfrp.com	el picacho	\N	V	0	S	\N	\N
22	8978675	\N	CINTIA	\N	MALABARES	VEGAS	F	1961-12-29	A+	21454543	355767	chnty@gmail.com	\N	el picacho	\N	V	0	S	\N	\N
23	2134238	\N	KIMBERLIN	ANDREINA	NUÑEZ	CHANG	F	1980-12-02	A+	23132453	13244444	kimim@gmail.com	\N	el cuji	\N	V	0	S	\N	\N
24	12343	\N	ALEJANDRA	\N	NUÑEZ	CHANG	F	1968-08-13	A+	3245465	56453333	alejigmail.com	\N	el cuji	\N	V	0	S	\N	\N
25	5454354	\N	HUGO	\N	HERRADA	\N	M	1965-05-25	A+-	52334	25354	huguo@gmail.com	\N	OPS	\N	V	2	C	\N	\N
26	2423423	\N	GIANFRANCO	\N	BRITO	DIAZ	M	1979-01-04	A+	2423425	324324234	diaznoche@gmail.com	\N	el picacho	\N	V	0	C	\N	\N
27	2324536	\N	ADRIANA	EDITH	ANDRADA	\N	F	1997-02-26	O-	432333423	12321322	andriana@gmail.com	\N	el patio	\N	V	0	S	\N	\N
28	2324324	\N	DIANA	VANESSA	LUGGO	NASTASI	F	1963-08-17	O-	32434	\N	venenasta@gmail.com	\N	san antnio	\N	V	0	S	\N	\N
29	23424234	\N	ALEXANDRA	\N	VALBUENA	NUÑEZ	F	1974-03-01	O-	454465645	\N	elexaval@gmail.com	\N	san antnio	\N	V	0	S	\N	\N
30	4343566	\N	MAIRED	\N	MEJIA	\N	F	1969-08-14	O-	33454	\N	mairedmeji@gmail.com	\N	\N	\N	V	0	S	\N	\N
31	2356777	\N	LAURA	MARIA	SOSA	GARCIAS	F	1975-02-05	O-	35345435	\N	lalalu@yahoo.com	\N	el valle	\N	V	0	S	\N	\N
32	23424324	\N	FABIANA	\N	BETANCUR	\N	F	1985-11-01	O+	142123	\N	fabifabi@yahoo.com	\N	\N	\N	V	0	S	\N	\N
33	2131244	\N	CARLOS	LUIS	BRITO	\N	M	1993-11-24	AB+	5674563	\N	carlillos@yahoo.com	\N	coche	\N	E	0	S	\N	\N
34	4564353	\N	LUIS	ALFONSO	CARRILLO	\N	M	1970-03-25	AB+	5674563	\N	carrillo@gmail.com	\N	\N	\N	E	0	S	\N	\N
35	6765645	\N	GABRIEL	\N	JORDAN	\N	M	1991-06-26	AB+	55445	\N	jordas@gmail.com	\N	\N	\N	V	0	S	\N	\N
36	2345364	\N	DANIEL	\N	PEREZ	PIRELLA	M	1964-12-10	AB+	4353666	\N	456445@gmail.com	\N	\N	\N	V	0	S	\N	\N
37	3455555	\N	MOISES	MATEO	MUÑOZ	RODRIGUEZ	M	1988-10-29	AB+	2243546	\N	moñozmoises@gmail.com	\N	\N	\N	V	0	S	\N	\N
38	234543445	\N	MATEO	\N	SANABRIAS	\N	M	1964-04-28	AB+	134423	\N	meteo@gmail.com	\N	\N	\N	V	0	S	\N	\N
39	3447774	\N	MIGUEL	ANGEL	PISCALLI	MASCIGLA	M	1962-04-18	AB-	4565464	\N	migue@gmail.com	\N	\N	\N	E	0	S	\N	\N
40	3333726	\N	JESUS	ENRIQUE	INGLESIAS	CRUZ	M	1978-02-22	AB-	545435	\N	jesusi@gmail.com	\N	\N	\N	V	0	S	\N	\N
\.


--
-- Data for Name: t_prelacion; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_prelacion (codigo, cod_pensum, cod_instituto, cod_uni_curricular, cod_uni_cur_prelada) FROM stdin;
1	1	1	28	11
2	1	1	29	12
3	1	1	30	13
4	1	1	58	45
5	1	1	59	46
6	1	1	60	47
\.


--
-- Data for Name: t_tip_uni_curricular; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_tip_uni_curricular (codigo, nombre) FROM stdin;
O	Obligatoria
E	Electiva
A	Acreditable
\.


--
-- Data for Name: t_trayecto; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_trayecto (codigo, cod_pensum, num_trayecto, certificado, min_cre_obligatoria, min_cre_electiva, min_cre_acreditable, min_can_electiva) FROM stdin;
1	1	0	TRAYECTO INICIAL	10	0	0	0
2	1	1	SOPORTE TÉCNICO A USUARIOS Y EQUIPOS	48	8	4	4
3	1	2	TÉCNICO SUPERIOR UNIVERSITARIO EN INFORMÁTICA	48	8	4	4
4	1	3	DESARROLLADOR DE APLICACIONES	39	3	3	1
5	1	4	INGENIERO EN INFORMÁTICA	39	4	3	2
\.


--
-- Data for Name: t_uni_curricular; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_uni_curricular (codigo, cod_uni_ministerio, nombre, hta, hti, uni_credito, dur_semanas, not_min_aprobatoria, not_maxima, descripcion, observacion, contenido) FROM stdin;
4	PIMT113	MATEMÁTICA  I	60	30	3	12	12	20	Lógica		
5	PIAC113	ARQUITECTURA DEL COMPUTADOR  	60	30	3	12	12	20	Estructura del computador		
6	PIFC111	FORMACIÓN CRÍTICA I	24	6	1	12	12	20	DEPORTE , RECREACIÓN Y CULTURA I		
7	PIFC121	FORMACIÓN CRÍTICA I	24	6	1	12	12	20	INFORMÁTICA, POLÍTICA DE ESTADO Y SOBERANÍA I		
8	PIAP114	ALGORÍTMICA Y PROGRAMACIÓN	78	42	4	12	12	20	PROGRAMACIÓN I		
9	PIAP124	ALGORÍTMICA Y PROGRAMACIÓN	78	42	4	12	12	20	PROGRAMACIÓN II		
10	PIAP134	ALGORÍTMICA Y PROGRAMACIÓN	78	48	4	12	12	20	PROGRAMACIÓN II		
11	PIPT113	PROYECTO SOCIOTECNOLÓGICO I	60	30	3	12	12	20	SOPORTE TÉCNICO A USUARIOS Y EQUIPOS I		
12	PIPT123 	PROYECTO SOCIOTECNOLÓGICO I	60	30	3	12	12	20	SOPORTE TÉCNICO A USUARIOS Y EQUIPOS II		
13	PIPT133 	PROYECTO SOCIOTECNOLÓGICO I	60	30	3	12	12	20	SOPORTE TÉCNICO A USUARIOS Y EQUIPOS III		
14	PIEL123	ELECTIVA I	60	30	3	12	12	20	DISEÑO INSTRUCCIONAL EN LAS TIC		
15	PIID111	IDIOMAS	24	6	1	12	12	20	INGLÉS COMPRENSIÓN LECTORA I		
16	PIID121	IDIOMAS	24	6	1	12	12	20	INGLÉS COMPRENSIÓN LECTORA II		
17	PIID131	IDIOMAS	24	6	1	12	12	20	INGLÉS COMPRENSIÓN LECTORA III		
18	PIMT213	MATEMÁTICA  II	60	30	3	12	12	20	CALCULO II		
19	PIMT223 	MATEMÁTICA  II	60	30	3	12	12	20	ÁLGEBRA LINEAL		
20	PIRC213	REDES DE COMPUTADORAS	60	30	3	12	12	20	FUNDAMENTOS Y COMPONENTES DE REDES		
21	PIRC223 	REDES DE COMPUTADORAS	60	30	3	12	12	20	ADMINISTRACIÓN, PRINCIPIOS DE ENRUTAMIENTO Y SUBREDES		
22	PIFC211	FORMACIÓN CRÍTICA II	60	30	1	12	12	20	INFORMÁTICA, TECNOLOGÍA Y SOCIEDAD I		
23	PIFC221	FORMACIÓN CRÍTICA II	60	30	1	12	12	20	INFORMÁTICA, TECNOLOGÍA Y SOCIEDAD II		
24	PIFC231	PARADIGMAS DE PROGRAMACIÓN	72	48	4	12	12	20	PROGRAMACIÓN III		
25	PIPP214	PARADIGMAS DE PROGRAMACIÓN	72	48	4	12	12	20	PROGRAMACIÓN III		
26	PIPP224	PARADIGMAS DE PROGRAMACIÓN	72	48	4	12	12	20	PROGRAMACIÓN IV		
27	PIPP234	PARADIGMAS DE PROGRAMACIÓN	72	48	4	12	12	20	PROGRAMACIÓN V		
28	PIPT213	PROYECTO SOCIO TECNOLÓGICO II	60	30	3	12	12	20	DESARROLLO DE SOLUCIONES INFORMÁTICAS I		
29	PIPT223	PROYECTO SOCIO TECNOLÓGICO II	60	30	3	12	12	20	DESARROLLO DE SOLUCIONES INFORMÁTICAS II		
30	PIPT233	PROYECTO SOCIO TECNOLÓGICO II	60	30	3	12	12	20	DESARROLLO DE SOLUCIONES INFORMÁTICAS III		
31	PIIS233	INGENIERÍA DEL SOFTWARE I	60	30	3	12	12	20	FUNDAMENTOS DE SISTEMAS E INGENIERÍA DEL SOFTWARE		
32	PIBD213	BASES DE DATOS	60	30	3	12	12	20	BASES DE DATOS		
33	PIEL233	ELECTIVA II	60	30	3	12	12	20	VOZ Y TELEFONÍA IP (VoIP)		
34	PIEL243	ELECTIVA II	60	30	3	12	12	20	EDUMATICA		
35	PIID211	IDIOMAS	24	6	1	12	12	20	INGLÉS ­  REDACCIÓN I		
36	PIID221	IDIOMAS	24	6	1	12	12	20	INGLÉS ­  REDACCIÓN II		
37	PIID231	IDIOMAS	24	6	1	12	12	20	INGLÉS ­  REDACCIÓN III		
38	PIMA313 	MATEMÁTICA  APLICADA	60	30	3	12	12	20	ESTADÍSTICA Y PROBABILIDADES II		
39	PIMA323 	MATEMÁTICA  APLICADA	60	30	3	12	12	20	MATEMÁTICA DISCRETA		
40	PIIO333	INVESTIGACIÓN DE OPERACIONES	60	30	3	12	12	20	INVESTIGACIÓN DE OPERACIONES		
41	PISO313	SISTEMAS OPERATIVOS	60	30	3	12	12	20	SISTEMAS OPERATIVOS II		
42	PIFC311	FORMACIÓN CRÍTICA III  	24	6	3	12	12	20	CULTURA, DEPORTE Y RECREACIÓN III		
43	PIFC321	FORMACIÓN CRÍTICA III  	24	6	1	12	12	20	INFORMÁTICA, COMUNICACIÓN Y TRANSFORMACIÓN I		
44	PIFC331	FORMACIÓN CRÍTICA III  	24	6	1	12	12	20	INFORMÁTICA, COMUNICACIÓN Y TRANSFORMACIÓN II		
45	PIPT313	PROYECTO SOCIO TECNOLÓGICO III	60	30	3	12	12	20	DESARROLLO DE APLICACIONES INFORMÁTICAS I		
46	PIPT323 	PROYECTO SOCIO TECNOLÓGICO III	60	30	3	12	12	20	DESARROLLO DE APLICACIONES INFORMÁTICAS II  		
47	PIPT333	PROYECTO SOCIO TECNOLÓGICO III	60	30	3	12	12	20	DESARROLLO DE APLICACIONES INFORMÁTICAS III		
48	PIIS313	INGENIERÍA DEL SOFTWARE II	60	30	3	12	12	20	FUNDAMENTOS DE INGENIERÍA DE REQUISITOS Y ANÁLISIS		
49	PIIS323	INGENIERÍA DEL SOFTWARE II	60	30	3	12	12	20	FUNDAMENTOS DEL DISEÑO DE SOFTWARE		
50	PIIS333	INGENIERÍA DEL SOFTWARE II	60	30	3	12	12	20	PRUEBAS Y VALIDACIÓN DE SOFTWARE		
51	PIMB333 	MODELADO  DE BASES DE DATOS	60	30	3	12	12	20	MODELADO  DE BASES DE DATOS		
52	PIEL323	ELECTIVA III	60	30	3	12	12	20	COMUNICACIONES VÍA SATÉLITE		
53	PIEL324	ELECTIVA III	60	30	3	12	12	20	TECNOLOGÍAS INTERNET		
54	PIRA423	REDES AVANZADAS	60	30	3	12	12	20	REDES DE TELECOMUNICACIONES Y DE DATOS		
55	PIFC411	FORMACIÓN CRÍTICA IV	24	6	1	12	12	20	INFORMÁTICA, GLOBALIZACIÓN Y CULTURA I		
56	PIFC421 	FORMACIÓN CRÍTICA IV	24	6	1	12	12	20	INFORMÁTICA, GLOBALIZACIÓN Y CULTURA II		
57	PIFC431 	FORMACIÓN CRÍTICA IV	24	6	1	12	12	20	CULTURA, DEPORTE Y RECREACIÓN IV		
58	PIPT414 	PROYECTO SOCIOTECNOLÓGICO IV	60	30	4	12	12	20	GESTIÓN DE PROYECTOS I		
59	PIPT424 	PROYECTO SOCIOTECNOLÓGICO IV	60	30	4	12	12	20	GESTIÓN DE PROYECTOS II		
60	PIPT434 	PROYECTO SOCIOTECNOLÓGICO IV	72	48	4	12	12	20	GESTIÓN DE PROYECTOS III		
61	PISI414  	SEGURIDAD INFORMÁTICA	72	48	4	12	12	20	 SEGURIDAD INFORMÁTICA		
62	PIGP424 	GESTIÓN DE PROYECTOS INFORMÁTICOS	72	48	4	12	12	20	GESTIÓN DE PROYECTOS INFORMÁTICOS		
63	PIAI434 	AUDITORÍA INFORMÁTICA	72	48	4	12	12	20	AUDITORÍA INFORMÁTICA		
64	PIAB413 	ADMINISTRACIÓN DE BASES DE DATOS	60	30	3	12	12	20	AUDITORÍA INFORMÁTICA		
65	PIEL433 	ELECTIVA IV	60	30	3	12	12	20	APLICACIONES MULTIMEDIA		
66	PIID411 	IDIOMAS	24	6	1	12	12	20	CONVERSACIONAL I		
67	PIID421 	IDIOMAS	24	6	1	12	12	20	CONVERSACIONAL II		
68	PIID431 	IDIOMAS	24	6	1	12	12	20	CONVERSACIONAL III		
\.


--
-- Data for Name: t_uni_tra_pensum; Type: TABLE DATA; Schema: sis; Owner: admin
--

COPY t_uni_tra_pensum (codigo, cod_pensum, cod_trayecto, cod_uni_curricular, cod_tipo) FROM stdin;
1	1	1	4	O
2	1	1	5	O
3	1	1	6	O
7	1	2	7	O
8	1	2	8	O
9	1	2	9	O
10	1	2	10	O
11	1	2	11	O
12	1	2	12	O
13	1	2	13	O
14	1	2	14	E
18	1	2	15	E
19	1	2	16	E
20	1	2	17	E
21	1	3	18	O
22	1	3	19	O
23	1	3	20	O
24	1	3	21	O
25	1	3	22	O
26	1	3	23	O
27	1	3	24	O
28	1	3	25	O
29	1	3	26	O
30	1	3	27	O
31	1	3	28	O
32	1	3	29	O
33	1	3	30	O
34	1	3	31	O
35	1	3	32	O
36	1	3	33	E
37	1	3	34	E
38	1	3	35	O
39	1	3	36	O
40	1	3	37	O
41	1	4	38	O
42	1	4	39	O
43	1	4	40	O
44	1	4	41	O
45	1	4	42	O
46	1	4	42	O
47	1	4	43	O
48	1	4	44	O
49	1	4	45	O
50	1	4	46	O
51	1	4	47	O
52	1	4	48	O
53	1	4	49	O
54	1	4	50	O
55	1	4	51	E
56	1	4	52	E
57	1	5	53	O
58	1	5	54	O
59	1	5	55	O
60	1	5	56	O
61	1	5	57	O
62	1	5	58	O
63	1	5	59	O
64	1	5	60	O
65	1	5	61	O
66	1	5	62	O
67	1	5	63	O
68	1	5	64	O
69	1	5	65	E
70	1	5	66	E
71	1	5	67	E
72	1	5	68	E
\.


SET search_path = per, pg_catalog;

--
-- Name: cp_acc_usuario; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_acc_usuario
    ADD CONSTRAINT cp_acc_usuario PRIMARY KEY (codigo);


--
-- Name: cp_accion; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_accion
    ADD CONSTRAINT cp_accion PRIMARY KEY (codigo);


--
-- Name: cp_modulo; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_modulo
    ADD CONSTRAINT cp_modulo PRIMARY KEY (codigo);


--
-- Name: cp_tab_accion; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_tab_accion
    ADD CONSTRAINT cp_tab_accion PRIMARY KEY (codigo);


--
-- Name: cp_tabla; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_tabla
    ADD CONSTRAINT cp_tabla PRIMARY KEY (codigo);


--
-- Name: cp_usuario; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_usuario
    ADD CONSTRAINT cp_usuario PRIMARY KEY (codigo);


--
-- Name: uni_acc_usuario; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_acc_usuario
    ADD CONSTRAINT uni_acc_usuario UNIQUE (cod_usuario, cod_accion);


--
-- Name: uni_accion; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_accion
    ADD CONSTRAINT uni_accion UNIQUE (nombre);


--
-- Name: uni_modulo; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_modulo
    ADD CONSTRAINT uni_modulo UNIQUE (nombre);


--
-- Name: uni_tab_accion; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_tab_accion
    ADD CONSTRAINT uni_tab_accion UNIQUE (cod_tabla, cod_accion);


--
-- Name: uni_tabla; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_tabla
    ADD CONSTRAINT uni_tabla UNIQUE (nombre);


--
-- Name: uni_usuario; Type: CONSTRAINT; Schema: per; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_usuario
    ADD CONSTRAINT uni_usuario UNIQUE (usuario);


SET search_path = sis, pg_catalog;

--
-- Name: ca_convalidacion_01; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_convalidacion
    ADD CONSTRAINT ca_convalidacion_01 UNIQUE (cod_estudiante, cod_pensum, cod_uni_curricular);


--
-- Name: ca_cur_estudiante; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT ca_cur_estudiante UNIQUE (cod_curso, cod_estudiante);


--
-- Name: ca_curso_01; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT ca_curso_01 UNIQUE (cod_periodo, cod_uni_curricular, seccion);


--
-- Name: ca_electiva; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_electiva
    ADD CONSTRAINT ca_electiva UNIQUE (cod_cur_estudiante, cod_pensum);


--
-- Name: ca_empleado; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_empleado
    ADD CONSTRAINT ca_empleado UNIQUE (cod_persona, cod_instituto, cod_pensum, fec_inicio);


--
-- Name: ca_estudiante; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT ca_estudiante UNIQUE (cod_persona, cod_instituto, cod_pensum, fec_inicio);


--
-- Name: ca_estudiante_01; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT ca_estudiante_01 UNIQUE (num_carnet);


--
-- Name: ca_estudiante_02; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT ca_estudiante_02 UNIQUE (num_expediente);


--
-- Name: ca_estudiante_03; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT ca_estudiante_03 UNIQUE (cod_rusnies);


--
-- Name: ca_instituto; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_instituto
    ADD CONSTRAINT ca_instituto UNIQUE (nom_corto);


--
-- Name: ca_pensum; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_pensum
    ADD CONSTRAINT ca_pensum UNIQUE (nom_corto);


--
-- Name: ca_periodo; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT ca_periodo UNIQUE (cod_instituto, cod_pensum, fec_inicio);


--
-- Name: ca_persona_01; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_01 UNIQUE (cedula);


--
-- Name: ca_persona_02; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_02 UNIQUE (rif);


--
-- Name: ca_persona_03; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_03 UNIQUE (cor_personal);


--
-- Name: ca_persona_04; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_04 UNIQUE (cor_institucional);


--
-- Name: ca_prelacion; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT ca_prelacion UNIQUE (cod_uni_curricular, cod_uni_cur_prelada);


--
-- Name: ca_trayecto; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_trayecto
    ADD CONSTRAINT ca_trayecto UNIQUE (num_trayecto, cod_pensum);


--
-- Name: ca_uni_curricular; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_uni_curricular
    ADD CONSTRAINT ca_uni_curricular UNIQUE (cod_uni_ministerio);


--
-- Name: cp_acreditable; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_acreditable
    ADD CONSTRAINT cp_acreditable PRIMARY KEY (codigo);


--
-- Name: cp_archivo; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_archivo
    ADD CONSTRAINT cp_archivo PRIMARY KEY (codigo);


--
-- Name: cp_convalidacion; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_convalidacion
    ADD CONSTRAINT cp_convalidacion PRIMARY KEY (codigo);


--
-- Name: cp_cur_estudiante; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cp_cur_estudiante PRIMARY KEY (codigo);


--
-- Name: cp_curso; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cp_curso PRIMARY KEY (codigo);


--
-- Name: cp_electiva; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_electiva
    ADD CONSTRAINT cp_electiva PRIMARY KEY (codigo);


--
-- Name: cp_empleado; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_empleado
    ADD CONSTRAINT cp_empleado PRIMARY KEY (codigo);


--
-- Name: cp_est_cur_estudiante; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_est_cur_estudiante
    ADD CONSTRAINT cp_est_cur_estudiante PRIMARY KEY (codigo);


--
-- Name: cp_est_empleado; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_est_empleado
    ADD CONSTRAINT cp_est_empleado PRIMARY KEY (codigo);


--
-- Name: cp_est_estudiante; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_est_estudiante
    ADD CONSTRAINT cp_est_estudiante PRIMARY KEY (codigo);


--
-- Name: cp_est_periodo; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_est_periodo
    ADD CONSTRAINT cp_est_periodo PRIMARY KEY (codigo);


--
-- Name: cp_estudiante; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cp_estudiante PRIMARY KEY (codigo);


--
-- Name: cp_instituto; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_instituto
    ADD CONSTRAINT cp_instituto PRIMARY KEY (codigo);


--
-- Name: cp_pensum; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_pensum
    ADD CONSTRAINT cp_pensum PRIMARY KEY (codigo);


--
-- Name: cp_periodo; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT cp_periodo PRIMARY KEY (codigo);


--
-- Name: cp_persona; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT cp_persona PRIMARY KEY (codigo);


--
-- Name: cp_prelacion; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cp_prelacion PRIMARY KEY (codigo);


--
-- Name: cp_trayecto; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_trayecto
    ADD CONSTRAINT cp_trayecto PRIMARY KEY (codigo);


--
-- Name: cp_uni_cur_tipo; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_tip_uni_curricular
    ADD CONSTRAINT cp_uni_cur_tipo PRIMARY KEY (codigo);


--
-- Name: cp_uni_curricular; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_uni_curricular
    ADD CONSTRAINT cp_uni_curricular PRIMARY KEY (codigo);


--
-- Name: cp_uni_tra_pensum; Type: CONSTRAINT; Schema: sis; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY t_uni_tra_pensum
    ADD CONSTRAINT cp_uni_tra_pensum PRIMARY KEY (codigo);


SET search_path = per, pg_catalog;

--
-- Name: cf_acc_modulo; Type: FK CONSTRAINT; Schema: per; Owner: admin
--

ALTER TABLE ONLY t_accion
    ADD CONSTRAINT cf_acc_modulo FOREIGN KEY (cod_modulo) REFERENCES t_modulo(codigo);


--
-- Name: cf_acc_usu_accion; Type: FK CONSTRAINT; Schema: per; Owner: admin
--

ALTER TABLE ONLY t_acc_usuario
    ADD CONSTRAINT cf_acc_usu_accion FOREIGN KEY (cod_accion) REFERENCES t_accion(codigo);


--
-- Name: cf_acc_usu_usuario; Type: FK CONSTRAINT; Schema: per; Owner: admin
--

ALTER TABLE ONLY t_acc_usuario
    ADD CONSTRAINT cf_acc_usu_usuario FOREIGN KEY (cod_usuario) REFERENCES t_usuario(codigo);


--
-- Name: cf_tab_accion_accion; Type: FK CONSTRAINT; Schema: per; Owner: admin
--

ALTER TABLE ONLY t_tab_accion
    ADD CONSTRAINT cf_tab_accion_accion FOREIGN KEY (cod_accion) REFERENCES t_accion(codigo);


--
-- Name: cf_tab_accion_tabla; Type: FK CONSTRAINT; Schema: per; Owner: admin
--

ALTER TABLE ONLY t_tab_accion
    ADD CONSTRAINT cf_tab_accion_tabla FOREIGN KEY (cod_tabla) REFERENCES t_tabla(codigo);


--
-- Name: t_usuario_campo1_fkey; Type: FK CONSTRAINT; Schema: per; Owner: admin
--

ALTER TABLE ONLY t_usuario
    ADD CONSTRAINT t_usuario_campo1_fkey FOREIGN KEY (campo1) REFERENCES sis.t_persona(codigo);


SET search_path = sis, pg_catalog;

--
-- Name: cf_acreditable__estudiante; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_acreditable
    ADD CONSTRAINT cf_acreditable__estudiante FOREIGN KEY (cod_estudiante) REFERENCES t_persona(codigo);


--
-- Name: cf_acreditable__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_acreditable
    ADD CONSTRAINT cf_acreditable__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_acreditable__trayecto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_acreditable
    ADD CONSTRAINT cf_acreditable__trayecto FOREIGN KEY (cod_trayecto) REFERENCES t_trayecto(codigo);


--
-- Name: cf_convalidacion__estudiante; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_convalidacion
    ADD CONSTRAINT cf_convalidacion__estudiante FOREIGN KEY (cod_estudiante) REFERENCES t_estudiante(codigo);


--
-- Name: cf_convalidacion__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_convalidacion
    ADD CONSTRAINT cf_convalidacion__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_convalidacion__trayecto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_convalidacion
    ADD CONSTRAINT cf_convalidacion__trayecto FOREIGN KEY (cod_trayecto) REFERENCES t_trayecto(codigo);


--
-- Name: cf_convalidacion__uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_convalidacion
    ADD CONSTRAINT cf_convalidacion__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES t_uni_curricular(codigo);


--
-- Name: cf_convalidadcion__tip_uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_convalidacion
    ADD CONSTRAINT cf_convalidadcion__tip_uni_curricular FOREIGN KEY (cod_tip_uni_curricular) REFERENCES t_tip_uni_curricular(codigo);


--
-- Name: cf_cur_estudiante__curso; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cf_cur_estudiante__curso FOREIGN KEY (cod_curso) REFERENCES t_curso(codigo);


--
-- Name: cf_cur_estudiante__est_cur_estudiante; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cf_cur_estudiante__est_cur_estudiante FOREIGN KEY (cod_estado) REFERENCES t_est_cur_estudiante(codigo);


--
-- Name: cf_cur_estudiante__estudiante; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cf_cur_estudiante__estudiante FOREIGN KEY (cod_estudiante) REFERENCES t_persona(codigo);


--
-- Name: cf_curso__periodo; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cf_curso__periodo FOREIGN KEY (cod_periodo) REFERENCES t_periodo(codigo);


--
-- Name: cf_curso__uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cf_curso__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES t_uni_curricular(codigo);


--
-- Name: cf_curso_docente; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cf_curso_docente FOREIGN KEY (cod_docente) REFERENCES t_persona(codigo);


--
-- Name: cf_electiva__cur_estudiante; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_electiva
    ADD CONSTRAINT cf_electiva__cur_estudiante FOREIGN KEY (cod_cur_estudiante) REFERENCES t_cur_estudiante(codigo);


--
-- Name: cf_electiva__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_electiva
    ADD CONSTRAINT cf_electiva__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_electiva__trayecto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_electiva
    ADD CONSTRAINT cf_electiva__trayecto FOREIGN KEY (cod_trayecto) REFERENCES t_trayecto(codigo);


--
-- Name: cf_empleado__instituto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_empleado
    ADD CONSTRAINT cf_empleado__instituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- Name: cf_empleado__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_empleado
    ADD CONSTRAINT cf_empleado__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_empleado__persona; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_empleado
    ADD CONSTRAINT cf_empleado__persona FOREIGN KEY (cod_persona) REFERENCES t_persona(codigo);


--
-- Name: cf_empleado_est_empleado; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_empleado
    ADD CONSTRAINT cf_empleado_est_empleado FOREIGN KEY (cod_estado) REFERENCES t_est_empleado(codigo);


--
-- Name: cf_estudiante__est_estado; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cf_estudiante__est_estado FOREIGN KEY (cod_estado) REFERENCES t_est_estudiante(codigo);


--
-- Name: cf_estudiante__instituto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cf_estudiante__instituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- Name: cf_estudiante__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cf_estudiante__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_estudiante__persona; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cf_estudiante__persona FOREIGN KEY (cod_persona) REFERENCES t_persona(codigo);


--
-- Name: cf_pensum__archivo; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_pensum
    ADD CONSTRAINT cf_pensum__archivo FOREIGN KEY (cod_archivo) REFERENCES t_archivo(codigo);


--
-- Name: cf_periodo__est_periodo; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT cf_periodo__est_periodo FOREIGN KEY (cod_estado) REFERENCES t_est_periodo(codigo);


--
-- Name: cf_periodo__instituto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT cf_periodo__instituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- Name: cf_periodo__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT cf_periodo__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_persona__archivo; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT cf_persona__archivo FOREIGN KEY (cod_foto) REFERENCES t_archivo(codigo);


--
-- Name: cf_prelacion__instituto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cf_prelacion__instituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- Name: cf_prelacion__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cf_prelacion__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_prelacion__uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cf_prelacion__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES t_uni_curricular(codigo);


--
-- Name: cf_prelacion__uni_curricular_prelada; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cf_prelacion__uni_curricular_prelada FOREIGN KEY (cod_uni_cur_prelada) REFERENCES t_uni_curricular(codigo);


--
-- Name: cf_trayecto_pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_trayecto
    ADD CONSTRAINT cf_trayecto_pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_uni_tra_pensum__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- Name: cf_uni_tra_pensum__tip_uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__tip_uni_curricular FOREIGN KEY (cod_tipo) REFERENCES t_tip_uni_curricular(codigo);


--
-- Name: cf_uni_tra_pensum__trayecto; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__trayecto FOREIGN KEY (cod_trayecto) REFERENCES t_trayecto(codigo);


--
-- Name: cf_uni_tra_pensum__uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: admin
--

ALTER TABLE ONLY t_uni_tra_pensum
    ADD CONSTRAINT cf_uni_tra_pensum__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES t_uni_curricular(codigo);


--
-- Name: aud; Type: ACL; Schema: -; Owner: admin
--

REVOKE ALL ON SCHEMA aud FROM PUBLIC;
REVOKE ALL ON SCHEMA aud FROM admin;
GRANT ALL ON SCHEMA aud TO admin;
GRANT ALL ON SCHEMA aud TO PUBLIC;


--
-- Name: err; Type: ACL; Schema: -; Owner: admin
--

REVOKE ALL ON SCHEMA err FROM PUBLIC;
REVOKE ALL ON SCHEMA err FROM admin;
GRANT ALL ON SCHEMA err TO admin;
GRANT ALL ON SCHEMA err TO PUBLIC;


--
-- Name: per; Type: ACL; Schema: -; Owner: admin
--

REVOKE ALL ON SCHEMA per FROM PUBLIC;
REVOKE ALL ON SCHEMA per FROM admin;
GRANT ALL ON SCHEMA per TO admin;
GRANT ALL ON SCHEMA per TO PUBLIC;


--
-- Name: public; Type: ACL; Schema: -; Owner: admin
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM admin;
GRANT ALL ON SCHEMA public TO admin;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: sis; Type: ACL; Schema: -; Owner: admin
--

REVOKE ALL ON SCHEMA sis FROM PUBLIC;
REVOKE ALL ON SCHEMA sis FROM admin;
GRANT ALL ON SCHEMA sis TO admin;
GRANT ALL ON SCHEMA sis TO PUBLIC;


SET search_path = per, pg_catalog;

--
-- Name: s_acc_usuario; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON SEQUENCE s_acc_usuario FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_acc_usuario FROM admin;
GRANT ALL ON SEQUENCE s_acc_usuario TO admin;
GRANT ALL ON SEQUENCE s_acc_usuario TO PUBLIC;


--
-- Name: s_accion; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON SEQUENCE s_accion FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_accion FROM admin;
GRANT ALL ON SEQUENCE s_accion TO admin;
GRANT ALL ON SEQUENCE s_accion TO PUBLIC;


--
-- Name: s_modulo; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON SEQUENCE s_modulo FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_modulo FROM admin;
GRANT ALL ON SEQUENCE s_modulo TO admin;
GRANT ALL ON SEQUENCE s_modulo TO PUBLIC;


--
-- Name: s_tab_accion; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON SEQUENCE s_tab_accion FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_tab_accion FROM admin;
GRANT ALL ON SEQUENCE s_tab_accion TO admin;
GRANT ALL ON SEQUENCE s_tab_accion TO PUBLIC;


--
-- Name: s_tabla; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON SEQUENCE s_tabla FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_tabla FROM admin;
GRANT ALL ON SEQUENCE s_tabla TO admin;
GRANT ALL ON SEQUENCE s_tabla TO PUBLIC;


--
-- Name: s_usuario; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON SEQUENCE s_usuario FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_usuario FROM admin;
GRANT ALL ON SEQUENCE s_usuario TO admin;
GRANT ALL ON SEQUENCE s_usuario TO PUBLIC;


--
-- Name: t_acc_usuario; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON TABLE t_acc_usuario FROM PUBLIC;
REVOKE ALL ON TABLE t_acc_usuario FROM admin;
GRANT ALL ON TABLE t_acc_usuario TO admin;
GRANT SELECT ON TABLE t_acc_usuario TO sosajean;


--
-- Name: t_accion; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON TABLE t_accion FROM PUBLIC;
REVOKE ALL ON TABLE t_accion FROM admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE t_accion TO admin;
GRANT SELECT ON TABLE t_accion TO sosajean;


--
-- Name: t_modulo; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON TABLE t_modulo FROM PUBLIC;
REVOKE ALL ON TABLE t_modulo FROM admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE t_modulo TO admin;


--
-- Name: t_tab_accion; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON TABLE t_tab_accion FROM PUBLIC;
REVOKE ALL ON TABLE t_tab_accion FROM admin;
GRANT ALL ON TABLE t_tab_accion TO admin;


--
-- Name: t_tabla; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON TABLE t_tabla FROM PUBLIC;
REVOKE ALL ON TABLE t_tabla FROM admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE t_tabla TO admin;


--
-- Name: t_usuario; Type: ACL; Schema: per; Owner: admin
--

REVOKE ALL ON TABLE t_usuario FROM PUBLIC;
REVOKE ALL ON TABLE t_usuario FROM admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE t_usuario TO admin;
GRANT SELECT ON TABLE t_usuario TO sosajean;


SET search_path = sis, pg_catalog;

--
-- Name: s_instituto; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON SEQUENCE s_instituto FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_instituto FROM admin;
GRANT ALL ON SEQUENCE s_instituto TO admin;
GRANT ALL ON SEQUENCE s_instituto TO PUBLIC;


--
-- Name: t_acreditable; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_acreditable FROM PUBLIC;
REVOKE ALL ON TABLE t_acreditable FROM admin;


--
-- Name: t_archivo; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_archivo FROM PUBLIC;
REVOKE ALL ON TABLE t_archivo FROM admin;


--
-- Name: t_convalidacion; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_convalidacion FROM PUBLIC;
REVOKE ALL ON TABLE t_convalidacion FROM admin;


--
-- Name: t_cur_estudiante; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_cur_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_cur_estudiante FROM admin;
GRANT SELECT ON TABLE t_cur_estudiante TO sosajean;


--
-- Name: t_curso; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_curso FROM PUBLIC;
REVOKE ALL ON TABLE t_curso FROM admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE t_curso TO admin;
GRANT SELECT ON TABLE t_curso TO sosajean;


--
-- Name: t_electiva; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_electiva FROM PUBLIC;
REVOKE ALL ON TABLE t_electiva FROM admin;


--
-- Name: t_empleado; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_empleado FROM PUBLIC;
REVOKE ALL ON TABLE t_empleado FROM admin;
GRANT SELECT ON TABLE t_empleado TO sosajean;


--
-- Name: t_est_cur_estudiante; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_est_cur_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_est_cur_estudiante FROM admin;


--
-- Name: t_est_empleado; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_est_empleado FROM PUBLIC;
REVOKE ALL ON TABLE t_est_empleado FROM admin;
GRANT SELECT ON TABLE t_est_empleado TO sosajean;


--
-- Name: t_est_estudiante; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_est_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_est_estudiante FROM admin;
GRANT SELECT ON TABLE t_est_estudiante TO sosajean;


--
-- Name: t_est_periodo; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_est_periodo FROM PUBLIC;
REVOKE ALL ON TABLE t_est_periodo FROM admin;
GRANT SELECT ON TABLE t_est_periodo TO sosajean;


--
-- Name: t_estudiante; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_estudiante FROM admin;
GRANT SELECT ON TABLE t_estudiante TO sosajean;


--
-- Name: t_instituto; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_instituto FROM PUBLIC;
REVOKE ALL ON TABLE t_instituto FROM admin;
GRANT SELECT ON TABLE t_instituto TO sosajean;


--
-- Name: t_pensum; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_pensum FROM PUBLIC;
REVOKE ALL ON TABLE t_pensum FROM admin;
GRANT SELECT ON TABLE t_pensum TO sosajean;


--
-- Name: t_periodo; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_periodo FROM PUBLIC;
REVOKE ALL ON TABLE t_periodo FROM admin;
GRANT SELECT ON TABLE t_periodo TO sosajean;


--
-- Name: t_persona; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_persona FROM PUBLIC;
REVOKE ALL ON TABLE t_persona FROM admin;
GRANT SELECT ON TABLE t_persona TO sosajean;


--
-- Name: t_prelacion; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_prelacion FROM PUBLIC;
REVOKE ALL ON TABLE t_prelacion FROM admin;


--
-- Name: t_tip_uni_curricular; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_tip_uni_curricular FROM PUBLIC;
REVOKE ALL ON TABLE t_tip_uni_curricular FROM admin;
GRANT SELECT ON TABLE t_tip_uni_curricular TO sosajean;


--
-- Name: t_trayecto; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_trayecto FROM PUBLIC;
REVOKE ALL ON TABLE t_trayecto FROM admin;
GRANT SELECT ON TABLE t_trayecto TO sosajean;


--
-- Name: t_uni_curricular; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_uni_curricular FROM PUBLIC;
REVOKE ALL ON TABLE t_uni_curricular FROM admin;
GRANT SELECT ON TABLE t_uni_curricular TO sosajean;


--
-- Name: t_uni_tra_pensum; Type: ACL; Schema: sis; Owner: admin
--

REVOKE ALL ON TABLE t_uni_tra_pensum FROM PUBLIC;
REVOKE ALL ON TABLE t_uni_tra_pensum FROM admin;
GRANT SELECT ON TABLE t_uni_tra_pensum TO sosajean;


--
-- PostgreSQL database dump complete
--

