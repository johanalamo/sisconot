<?php
class EmpleadoServicio
{
	/*funcion encargada de obtener el codigo mayor de una persona
	de la base de datos
	*/
	private static function obtenerMayorCodigo ()
	{
		try 
		{
			$conexion = Conexion::conectar();
			$consulta = "select coalesce (max(codigo),0) from sis.t_empleado";
			$ejecutar = $conexion->query($consulta);
			$consulta=$ejecutar->fetchAll();
			return $consulta [0][0];  				
		}
		catch(Exception $e){
			throw $e;
		}						
	}

	public static function agregar($empleado)
	{
		try
		{
			$conexion = Conexion::conectar();
			$ejecutar = $conexion->prepare("INSERT INTO sis.t_empleado (codigo,
																		 cod_persona,
																		 cod_instituto,
																		 cod_pensum,
																		 cod_estado,
																		 fec_inicio,
																		 fec_fin,
																		 es_jef_pensum,
																		 es_jec_con_estudio,
																		 es_ministerio,
																		 es_docente,
																		 observaciones) 
											VALUES (".UtilBdd::repetirInterrogacion(12).");");
			$ejecutar->execute(self::obtenerMayorCodigo(),
								$empleado->codPersona,
								$empleado->codInstituto,
								$empleado->codPensum,
								$empleado->codEstado,
								$empleado->fecInicio,
								$empleado->fecFin,
								$empleado->esJefPensum,
								$empleado->esJecConEstudio,
								$empleado->esMinisterio,
								$empleado->esDocente,
								$empleado->observaciones
								);

			if($ejecutar->rowCount() == 0)
					throw new Exception("No se pudo agregar al empleado.");
		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function modificar($empleado)
	{
		try
		{
			$conexion = Conexion::conectar();
			$ejecutar = $conexion->prepare("UPDATE sis.t_empleado SET 
											cod_instituto=?,
											cod_pensum=?,
											cod_estado=?,
											fec_inicio=?,
											fec_fin=?,
											es_jef_pensum=?,
											es_jec_con_estudio=?,
											es_ministerio=?,
											es_docente=?,
											observaciones=?
											WHERE codigo=?;");

			$ejecutar->execute($empleado->codInstituto,
								$empleado->codPensum,
								$empleado->codEstado,
								$empleado->fecInicio,
								$empleado->fecFin,
								$empleado->esJefPensum,
								$empleado->esJecConEstudio,
								$empleado->esMinisterio,
								$empleado->esDocente,
								$empleado->observaciones,
								$empleado->codigo
								);

			if($ejecutar->rowCount()==0)
				throw new Exception("No se logro modificar la informacion del empleado.");		
		}
		catch(Exception $e){
			throw $e;
		}	
	}

	public static function listar ($codigo=null, $codPersona=null, $esDocente=null)
	{
		try
		{
			$conexion = Conexion::conectar();
			if(!($codigo && $codPersona && $esDocente)){
				$ejecutar = $conexion->prepare("select * from sis.t_empleado;");
				$ejecutar->execute(array());
			}

			elseif($codigo!=null && !($codPersona && $esDocente)){
				$ejecutar = $conexion->prepare("select * from sis.t_empleado where codigo=?");
				$ejecutar->execute(array($codigo));
			}
			
			elseif(!$codigo && $codPersona!=null && !$esDocente){
				$ejecutar = $conexion->prepare("select * from sis.t_empleado where cod_persona=?");
				$ejecutar->execute(array($codPersona));
			}

			
			if($ejecutar->rowCount())
				return $ejecutar->fetchAll();
			else
				return null;			

		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function listarPersonaEmpleado($pensum=null, $estado=null, $instituto=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			/*listar personas por pensum*/
			if($pensum &&  !($estado  && $instituto)){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p,  sis.t_empleado  as em 
												where p.codigo=em.cod_persona and em.cod_pensum=?  group by p.codigo");
				$ejecutar->execute(array($pensum));
			}
			
			/*listar personas por estado */
			elseif(!$pensum &&  $estado && !( $instituto)){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p, sis.t_empleado as em 
												where em.cod_estado=? and em.cod_persona=p.codigo group by p.codigo;");
				$ejecutar->execute(array($estado,$estado));
			}

			/*listar personas por instituto */
			elseif(!($pensum &&  $estado ) && $instituto){
				$ejecutar = $conexion->prepare("select p.* from  sis.t_persona as p, sis.t_empleado  as em 
												where p.codigo=em.cod_persona and  em.cod_instituto=?  group by p.codigo");
				$ejecutar->execute(array($instituto));
			}

			/*listar personas por instituto y pensum*/
			elseif($pensum &&  !($estado ) && $instituto){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p, sis.t_empleado  as em 
												where p.codigo=em.cod_persona  and em.cod_instituto=? and em.cod_pensum=?  group by p.codigo");
				$ejecutar->execute(array($instituto,$pensum));
			}

			/*listar personas por instituto y estado*/
			elseif(!$pensum &&  $estado && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado as em 
												where p.codigo=em.cod_persona and  em.cod_instituto=? and em.cod_estado=?  group by p.codigo");
				$ejecutar->execute(array($instituto,$estado,$estado));
			}

			/*listar personas por pensum y estado*/
			elseif($pensum &&  $estado && !($instituto)){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado  as em 
												where p.codigo=em.cod_persona and em.cod_pensum=? and em.cod_estado=?  group by p.codigo");
				$ejecutar->execute(array($pensum,$estado,$estado));
			}

			/*listar personas por pensum, instituto y estado*/
			elseif($pensum &&  $estado && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado  as em 
												where p.codigo=em.cod_persona  and em.cod_pensum=? and em.cod_instituto=? 
												and em.cod_estado=? group by p.codigo");
				$ejecutar->execute(array($pensum,$instituto,$estado,$estado));
			}

			elseif(!($pensum &&  $estado && $instituto)){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p join  sis.t_empleado as em 
												on (p.codigo=em.cod_persona) where p.codigo is not null");
				$ejecutar->execute(array());
			}

			if($ejecutar->rowCount())
				return $ejecutar->fetchAll();
			else
				return null;

		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function listarPersonaEmpleadoPensumInstituto()
	{
		try
		{
			$conexion = Conexion::conectar();	
			$ejecutar = $conexion->prepare("select p.*,i.nom_corto,pen.nom_corto 
											from sis.t_pensum as pen full outer join sis.t_empleado as em 
											on (em.cod_pensum=pen.codigo) full outer join  sis.t_persona as p 
											on (p.codigo=em.cod_persona) full outer join sis.t_instituto as i 
											on (em.cod_instituto=i.codigo) where  em.codigo is not null");
			$ejecutar->execute(array());
			

			if($ejecutar->rowCount())
				return $ejecutar->fetchAll();
			else
				return null;
		}
		catch(Exception $e){
			throw $e;
		}
	}
}
?>