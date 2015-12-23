<?php

class EstudianteServicio
{
	private static function obtenerMayorCodigo ()
	{
		try 
		{
			$conexion = Conexion::conectar();
			$consulta = "select coalesce (max(codigo),0) from sis.t_estudiante";
			$ejecutar = $conexion->query($consulta);
			$consulta=$ejecutar->fetchAll();
			return $consulta [0][0];  				
		}catch(Exception $e){
		throw $e;
		}						
	}

	public static function agregar($codPersona)
	{
		try
		{
			$conexion = Conexion::conectar();
			$ejecutar = $conexion->prepare("insert into sis.t_estudiante (codigo,
																			cod_persona,
																			cod_instituto,
																			cod_pensum,
																			num_carnet,
																			num_expediente,
																			cod_rusnies,
																			cod_estado
																			fec_inicio,
																			condicion,
																			fec_fin,
																			observaciones
																			) 
																		values (".UtilBdd::repetirInterrogacion(12).");");
			$ejecutar->execute(array(
								self::obtenerMayorCodigo(),
								$estudiante->codPersona,
								$estudiante->codInstituto,
								$estudiante->codPensum,
								$estudiante->numCarnet,
								$estudiante->numExpediente,
								$estudiante->codRusnies,
								$estudiante->codEstado,
								$estudiante->fecInicio,
								$estudiante->condicion,
								$estudiante->fecFin,
								$estudiante->observaciones
								));
			if($ejecutar->rowCount() == 0)
					throw new Exception("No se pudo inscribir al estudiante.");
		}
		catch(Exception $e){
			throw $e;
		}
	}
//////////////////////////////////////////////////////////////

	campos de interes para 
	public static function listar (
				$codigo=null, 		$codPersona=null, 	$codInstituto=null, 
				$codPensum=null, 	$numCarnet=null, 	$numExpediente=null, 
				$codRusnies=null, 	$codEstado=null, 	$fecInicio=null, 
				$fecFin=null)
		
		campos: cod_pensum,cod_instituto,cod_estado,cod_persona,                     num_carnet, cod_rusnies

		cod_pensum, y cod_instituto no debe ser con like sino con igual (=)


//////////////////////////////////////////////////////////////////
	public static function listar ($codigo=null, $codPersona=null, $codInstituto=null, $codPensum=null, $numCarnet=null, $numExpediente=null, $codRusnies=null, $codEstado=null, $fecInicio=null, $fecFin=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			/* listar a todos los estudiante en general*/
			if(!($codigo && $codPersona && $codInstituto && $codPensum && $numCarnet && $numExpediente && $codRusnies && $fecInicio && $fecFin && $codEstado)){
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante;");
				$ejecutar->execute(array());
			}

			/*comprobar campos unicos */
			/*elseif(!($codigo) && $codPersona!=null && !($codInstituto && $codPensum &&) $numCarnet!=null && $numExpediente!=null && !($codRusnies && $fecInicio && $fecFin && $codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where cod_persona=$codPersona or num_carnet=$numCarnet or num_expediente=$numExpediente;"); */  //----> Tengo q acomodar el error

			/* listar estudiante por codigo de estudiante*/
			elseif($codigo!=null && !($codPersona && $codInstituto && $codPensum && $numCarnet && $numExpediente && $codRusnies && $fecInicio && $fecFin && $codEstado)){
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where codigo=?");
				$ejecutar->execute(array($codigo));
			}

			/* listar estudiante por codigo de persona*/
			elseif(!($codigo) && $codPersona!=null && !($codInstituto && $codPensum && $numCarnet && $numExpediente && $codRusnies && $fecInicio && $fecFin && $codEstado)){
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where cod_persona=?");
				$ejecutar->execute(array($codPersona));
			}

			/* listar a todos los estudiante por instituto*/
			elseif(!($codigo && $codPersona) && $codInstituto!=null && !($codPensum && $numCarnet && $numExpediente && $codRusnies && $fecInicio && $fecFin && $codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where cod_instituto=$codInstituto;");

			/* listar a todos los estudiante por pensum*/
			elseif(!($codigo && $codPersona && $codInstituto) && $codPensum!=null && !($numCarnet && $numExpediente && $codRusnies && $fecInicio && $fecFin && $codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where cod_pensum=$codPensum;");

			/* listar estudiante por numero de carnet*/
			elseif(!($codigo && $codPersona && $codInstituto && $codPensum) && $numCarnet!=null && !($numExpediente && $codRusnies && $fecInicio && $fecFin && $codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where num_carnet=$numCarnet;");

			/* listar estudiante por numero de expediente*/
			elseif(!($codigo && $codPersona && $codInstituto && $codPensum && $numCarnet) && $numExpediente!=null && !($codRusnies && $fecInicio && $fecFin && $codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where num_expediente=$numExpediente;");

			/* listar estudiante por codigo rusnies*/
			elseif(!($codigo && $codPersona && $codInstituto && $codPensum && $numCarnet && $numExpediente) && $codRusnies!=null && !($fecInicio && $fecFin && $codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where cod_rusnies=$codRusnies;");

			/* listar a todos los estudiante por fecha de inicio*/
			elseif(!($codigo && $codPersona && $codInstituto && $codPensum && $numCarnet && $numExpediente && $codRusnies) && $fecInicio!=null && !($fecFin && $codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where fec_inicio=$fecInicio;");

			/* listar a todos los estudiante por fecha fin*/
			elseif(!($codigo && $codPersona && $codInstituto && $codPensum && $numCarnet && $numExpediente && $codRusnies && $fecInicio) && $fecFin!=null && !($codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where fec_fin=$fecFin;");

			/* listar a todos los estudiante por estado*/
			elseif(!($codigo && $codPersona && $codInstituto && $codPensum && $numCarnet && $numExpediente && $codRusnies && $fecInicio) && $fecFin!=null && !($codEstado))
				$ejecutar = $conexion->prepare("select * from sis.t_estudiante where cod_estado=$codEstado;");

			
			if($ejecutar->rowCount())
				return $ejecutar->fetchAll();
			else
				return null;

		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function listarPersonaEstudiante($pensum=null, $estado=null, $instituto=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			/*listar personas por pensum*/
			if($pensum &&  !($estado  && $instituto)){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p,  sis.t_estudiante  as es 
												where p.codigo=es.cod_persona and es.cod_pensum=?  group by p.codigo");
				$ejecutar->execute(array($pensum));
			}
			
			/*listar personas por estado */
			elseif(!$pensum &&  $estado && !( $instituto)){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p, sis.t_estudiante as es where 
												es.cod_estado=? and es.cod_persona=p.codigo group by p.codigo;");
				$ejecutar->execute(array($estado));
			}

			/*listar personas por instituto */
			elseif(!($pensum &&  $estado ) && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_estudiante  as es 
												where p.codigo=es.cod_persona and  es.cod_instituto=?  group by p.codigo");
				$ejecutar->execute(array($instituto));
			}

			/*listar personas por instituto y pensum*/
			elseif($pensum &&  !($estado ) && $instituto){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p, sis.t_estudiante  as es 
												where p.codigo=es.cod_persona  and es.cod_instituto=? and es.cod_pensum=?  group by p.codigo");
				$ejecutar->execute(array($instituto,$pensum));
			}

			/*listar personas por instituto y estado*/
			elseif(!$pensum &&  $estado && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_estudiante  as es
												where p.codigo=es.cod_persona and  es.cod_instituto=? and es.cod_estado=?  group by p.codigo");
				$ejecutar->execute(array($instituto,$estado));
			}

			/*listar personas por pensum y estado*/
			elseif($pensum &&  $estado && !($instituto)){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_estudiante  as es 
												where p.codigo=es.cod_persona and es.cod_pensum=? and es.cod_estado=?  group by p.codigo");
				$ejecutar->execute(array($pensum,$estado));
			}

			/*listar personas por pensum, instituto y estado*/
			elseif($pensum &&  $estado && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_estudiante  as es 
												where p.codigo=es.cod_persona  and es.cod_pensum=? and es.cod_instituto=? 
												and es.cod_estado=? group by p.codigo");
				$ejecutar->execute(array($pensum,$instituto,$estado));
			}

			elseif(!($pensum &&  $estado && $instituto)){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p join  sis.t_estudiante as es 
												on (p.codigo=es.cod_persona) where p.codigo is not null");
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

	public static function listarPersonaEstudiantePensumInstituto()
	{
		try
		{
			$conexion = Conexion::conectar();	
			$ejecutar = $conexion->prepare("select p.*,i.nom_corto,pen.nom_corto 
											from sis.t_pensum as pen full outer join sis.t_estudiante as es 
											on (es.cod_pensum=pen.codigo) full outer join  sis.t_persona as p 
											on (p.codigo=es.cod_persona) full outer join sis.t_instituto as i 
											on (es.cod_instituto=i.codigo) where  es.codigo is not null");
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

	public static function modificar ($estudiante)
	{
		try
		{
			$conexion = Conexion::conectar();
			$ejecutar = $conexion->ejecutar("UPDATE sis.t_estudiante SET 
												cod_instituto=?,
												cod_pensum=?,
												num_carnet=?,
												num_expediente=?,
												cod_rusnies=?,
												cod_estado=?,
												fec_inicio=?,
												condicion=?,
												fec_fin=?,
												observaciones=?
											where codigo=?;");
			$ejecutar->execute(array(
								$estudiante->codInstituto,
								$estudiante->codPensum,
								$estudiante->numCarnet,
								$estudiante->numExpediente,
								$estudiante->codRusnies,
								$estudiante->codEstado,
								$estudiante->fecInicio,
								$estudiante->condicion,
								$estudiante->fecFin,
								$estudiante->observaciones,
								$estudiante->codigo
								));

			if($ejecutar->rowCount()==0)
				throw new Exception("No se logro modificar la informacion del estudiante.");
		}
		catch(Exception $e){
			throw $e;
		}
	}
}

?>
