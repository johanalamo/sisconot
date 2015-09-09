<?php
class PersonaServicio
{
	/*funcion encargada de obtener el codigo mayor de una persona
	de la base de datos
	*/
	private static function obtenerMayorCodigo ()
	{
		try 
		{
			$conexion = Conexion::conectar();
			$consulta = "select coalesce (max(codigo),0) from sis.t_persona";
			$ejecutar = $conexion->query($consulta);
			$consulta=$ejecutar->fetchAll();
			return $consulta [0][0];  				
		}
		catch(Exception $e){
			throw $e;
		}						
	}

	private static function agregar ($persona)
	{
		try
		{
			$conexion = Conexion::conectar();
			$ejecutar = $conexion->prepare("insert into sis.t_persona (codigo,
																		cod_foto,
																		cedula,
																		rif,
																		nombre1,
																		nombre2,
																		apellido1,
																		apellido2,
																		sexo,
																		fec_nacimeinto,
																		tip_sangre,
																		telefono1,
																		telefono2,
																		cor_personal,
																		cor_institucional,
																		direccion,
																		discapacidad,
																		nacionalidad,
																		hijos,
																		est_civil,
																		observaciones
																		) 
																	values (".UtilBdd::repetirInterrogacion(21).");");
			$ejecutar = $consulta->execute(array(
											self::obtenerMayorCodigo(),
											$persona->codFoto,
											$persona->cedula,
											$persona->rif,
											$persona->nombre1,
											$persona->nombre2,
											$persona->apellido1,
											$persona->apellido2,
											$persona->sexo,
											$persona->fecNacimiento,
											$persona->tipSangre,
											$persona->telefono1,
											$persona->telefono2,
											$persona->corPersonal,
											$persona->corInstitucional,
											$persona->direccion,
											$persona->discapacidad,
											$persona->nacionalidad,
											$persona->hijos,
											$persona->estCivil,
											$persona->observaciones
											));
			if($ejecutar->rowCount() == 0)
				throw new Exception("No se pudo agregar a la persona ".$persona->nombre1." ".$persona->apellido1.".");
		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function listar($cedula=null,$rif=null,$corPersonal=null,$corInstitucional=null,$codigo=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			/* listar a todas las personas */
			if($cedula==null && $rif==null && $corPersonal==null && $corInstitucional==null && $codigo==null)
				$ejecutar = $conexion->prepare("select * from sis.t_persona;");

			/* lisar persona por cedula*/
			elseif($cedula!=null && $rif==null && $corPersonal==null && $corInstitucional==null && $codigo==null)
				$ejecutar = $conexion->prepare("select * from sis.t_persona where cedula=$cedula;");

			/*comprobar campos unicos */
			elseif($cedula!=null && $rif!=null && $corPersonal!=null && $corInstitucional==null && $codigo==null)
				$ejecutar = $conexion->prepare("select * from sis.t_persona where cedula=$cedula or rif=$rif or cor_personal=$corPersonal;");
			
			/*listar persona por rif*/
			elseif($cedula==null && $rif!=null && $corPersonal==null && $corInstitucional==null && $codigo==null)
				$ejecutar = $conexion->prepare("select * from sis.t_persona where rif=$rif;");

			/*listar persona por codigo*/
			elseif($cedula==null && $rif==null && $corPersonal==null && $corInstitucional==null && $codigo!=null)
				$ejecutar = $conexion->prepare("select * from sis.t_persona where codigo=$codigo;");					
			
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

	public static function listarPersonaEstudianteEmpleado ($pensum=null, $estado=null, $campo=null, $instituto=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			/*listar personas por pensum*/
			if($pensum &&  !($estado  && $instituto))
				$ejecutar = $conexion->prepare("select * from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where  em.cod_pensum=es.cod_pensum and es.cod_pensum=$pensum and es.cod_persona=p.codigo 
												or em.cod_persona=p.codigo;");
			
			/*listar personas por estado */
			elseif(!$pensum &&  $estado && !( $instituto))
				$ejecutar = $conexion->prepare("select * from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where em.cod_estado=$estado or es.cod_estado=$estado and es.cod_persona=p.codigo 
												or em.cod_persona=p.codigo;");

			/*listar personas por instituto */
			elseif(!($pensum &&  $estado ) && $instituto)
				$ejecutar = $conexion->prepare("select * from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where em.cod_instituto=es.cod_instituto and es.cod_instituto=$instituto 
												and es.cod_persona=p.codigo or em.cod_persona=p.codigo;");

			/*listar personas por instituto y pensum*/
			elseif($pensum &&  !($estado ) && $instituto)
				$ejecutar = $conexion->prepare("select * from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where em.cod_instituto=es.cod_instituto and es.cod_instituto=$instituto  
												and em.cod_pensum=es.cod_pensum and es.cod_pensum=$pensum and es.cod_persona=p.codigo 
												or em.cod_persona=p.codigo");

			/*listar personas por instituto y estado*/
			elseif(!$pensum &&  $estado && $instituto)
				$ejecutar = $conexion->prepare("select * from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where em.cod_instituto=es.cod_instituto and es.cod_instituto=$instituto 
												and em.cod_estado=$estado or es.cod_estado=$estado and es.cod_persona=p.codigo 
												or em.cod_persona=p.codigo;");

			/*listar personas por pensum y estado*/
			elseif($pensum &&  $estado && !($instituto))
				$ejecutar = $conexion->prepare("select * from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where em.cod_pensum=es.cod_pensum and es.cod_pensum=$pensum
												and em.cod_estado=$estado or es.cod_estado=$estado and es.cod_persona=p.codigo 
												or em.cod_persona=p.codigo;");

			/*listar personas por pensum, instituto y estado*/
			elseif($pensum &&  $estado && $instituto)
				$ejecutar = $conexion->prepare("select * from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where em.cod_pensum=es.cod_pensum and es.cod_pensum=$pensum
												and em.cod_estado=$estado or es.cod_estado=$estado
												and em.cod_instituto=es.cod_instituto and es.cod_instituto=$instituto 
												and es.cod_persona=p.codigo or em.cod_persona=p.codigo;");


			$ejecutar->execute(array());
			if($ejecutar->rowCount())
				return $ejecutar->fetchAll();
			else
				return null;
		}
		catch(Exception $e)
		{
			throw $e;
		}
	}

	public static function modificar($persona)
	{
		try
		{
			$conexion = Conexion::conectar();
			$ejecutar = $conexion->prepare("UPDATE sis.t_persona SET 
											cedula=?,
											rif=?,
											nombre1=?,
											nombre2=?,
											apellido1=?,
											apellido2=?,
											sexo=?,
											fec_nacimiento=?,
											tip_sangre=?,
											telefono1=?,
											telefono2=?,
											cor_personal=?,
											cor_institucional=?,
											direccion=?,
											discapacidad=?,
											nacionalidad=?,
											hijos=?,
											est_civil=?,
											observaciones=? WHERE codigo=?;");
			$ejecutar->execute(array(
								$persona->cedula,
								$persona->rif,
								$persona->nombre1,
								$persona->nombre2,
								$persona->apellido1,
								$persona->apellido2,
								$persona->sexo,
								$persona->fecNacimiento,
								$persona->tipSangre,
								$persona->telefono1,
								$persona->telefono2,
								$persona->corPersonal,
								$persona->corInstitucional,
								$persona->direccion,
								$persona->discapacidad,
								$persona->nacionalidad,
								$persona->hijos,
								$persona->estCivil,
								$persona->observaciones,
								$persona->codigo
								));
			if($ejecutar->rowCount()==0)
				throw new Exception("No se logro modificar la informacion de ".$persona->nombre1." ".$persona->apellido1.".");			
		}
		catch(Exception $e){
			throw $e;
		}
	}
}
?>