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

	public static function agregar ($persona)
	{
		try
		{
			$codigo=self::obtenerMayorCodigo()+1;
			$conexion = Conexion::conectar();
			$ejecutar = $conexion->prepare(
				"insert into sis.t_persona (
					codigo,
					cod_foto,
					cedula,
					rif,
					nombre1,
					nombre2,
					apellido1,
					apellido2,
					sexo,
					fec_nacimiento,
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
			$ejecutar-> execute(array(
											$codigo,
											$persona->obtenerCodFoto(),
											$persona->obtenerCedula(),
											$persona->obtenerRif(),
											$persona->obtenerNombre1(),
											$persona->obtenerNombre2(),
											$persona->obtenerApellido1(),
											$persona->obtenerApellido2(),
											$persona->obtenerSexo(),
											$persona->obtenerFecNacimiento(),
											$persona->obtenerTipSangre(),
											$persona->obtenerTelefono1(),
											$persona->obtenerTelefono2(),
											$persona->obtenerCorPersonal(),
											$persona->obtenerCorInstitucional(),
											$persona->obtenerDireccion(),
											$persona->obtenerDiscapacidad(),
											$persona->obtenerNacionalidad(),
											$persona->obtenerHijos(),
											$persona->obtenerEstCivil(),
											$persona->obtenerObservaciones()
											));
			if($ejecutar->rowCount() == 0)
				throw new Exception("No se pudo agregar a la persona ".$persona->obtenerNombre1().' '.$persona->obtenerApellido1().".");
			else
				Vista::asignarDato('codPersona',$codigo);
		}
		catch(Exception $e){
			throw $e;
		}
	}

/**********************************************************************************************************************
 revision 23 de diciembre de dos mil quince 
 	public static function listar($codigo=null,$cedula=null,$rif=null,$corPersonal=null,$corInstitucional=null)
 	{
		campos: codigo, cedula, correo, nombre1,nombre2,apellido1,apellido2,sexo

		$c = "select * from sis.t_persona where true ";
		
		if ($codigo != null)
			$c .= " and codigo like '%$codigo%'";
			
		if ($cedula != null)
			$c .= " and cedula like '%$cedula%'";
			

	

		ejecutar el select .....


	}
*////////////////////////////////
	public static function listar($codigo=null,$cedula=null,$rif=null,$corPersonal=null,$corInstitucional=null, )
	{
		try
		{
			$conexion = Conexion::conectar();

			/* listar a todas las personas */
			if($cedula==null && $rif==null && $corPersonal==null && $corInstitucional==null && $codigo==null){
				$ejecutar = $conexion->prepare("select * from sis.t_persona;");
				$ejecutar->execute(array());	
			}

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
			elseif($cedula==null && $rif==null && $corPersonal==null && $corInstitucional==null && $codigo!=null){
				$ejecutar = $conexion->prepare("select * from sis.t_persona where codigo=?;");
				$ejecutar->execute(array($codigo));					
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

	public static function listarPersonaEstudianteEmpleado ($pensum=null, $estado=null, $instituto=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			/*listar personas por pensum*/
			if($pensum &&  !($estado  && $instituto)){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante  as es 
												where (p.codigo=es.cod_persona or p.codigo=em.cod_persona and em.cod_pensum=es.cod_pensum) 
												and es.cod_pensum=?  group by p.codigo");
				$ejecutar->execute(array($pensum));
			}
			
			/*listar personas por estado */
			elseif(!$pensum &&  $estado && !( $instituto)){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante as es 
												where em.cod_estado=? or es.cod_estado=? and es.cod_persona=p.codigo 
												or em.cod_persona=p.codigo group by p.codigo;");
				$ejecutar->execute(array($estado));
			}

			/*listar personas por instituto */
			elseif(!($pensum &&  $estado ) && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante  as es 
												where (p.codigo=es.cod_persona or p.codigo=em.cod_persona and em.cod_instituto=es.cod_instituto) 
												and es.cod_instituto=?  group by p.codigo");
				$ejecutar->execute(array($instituto));
			}

			/*listar personas por instituto y pensum*/
			elseif($pensum &&  !($estado ) && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante  as es 
												where (p.codigo=es.cod_persona or p.codigo=em.cod_persona and em.cod_instituto=es.cod_instituto 
												and em.cod_pensum=es.cod_pensum) and es.cod_instituto=? and es.cod_pensum=?  group by p.codigo");
				$ejecutar->execute(array($instituto,$pensum));
			}

			/*listar personas por instituto y estado*/
			elseif(!$pensum &&  $estado && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante  as es 
												where (p.codigo=es.cod_persona or p.codigo=em.cod_persona and em.cod_instituto=es.cod_instituto ) 
												and es.cod_instituto=? and (es.cod_estado=? or em.cod_estado=?) group by p.codigo");
				$ejecutar->execute(array($instituto,$estado));
			}

			/*listar personas por pensum y estado*/
			elseif($pensum &&  $estado && !($instituto)){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante  as es where 
												(p.codigo=es.cod_persona or p.codigo=em.cod_persona and em.cod_pensum=es.cod_pensum ) 
												and es.cod_pensum=? and (es.cod_estado=? or em.cod_estado=?) group by p.codigo");
				$ejecutar->execute(array($pensum,$estado));
			}

			/*listar personas por pensum, instituto y estado*/
			elseif($pensum &&  $estado && $instituto){
				$ejecutar = $conexion->prepare("select p.* from   sis.t_persona as p, sis.t_empleado as em, sis.t_estudiante  as es where 
												(p.codigo=es.cod_persona or p.codigo=em.cod_persona and em.cod_pensum=es.cod_pensum and em.cod_instituto=es.cod_instituto) 
												and es.cod_pensum=? and es.cod_instituto=? and (es.cod_estado=? or em.cod_estado=?) group by p.codigo");
				$ejecutar->execute(array($pensum,$instituto,$estado));
			}

			elseif(!($pensum &&  $estado && $instituto)){
				$ejecutar = $conexion->prepare("select p.* from sis.t_persona as p full outer join  sis.t_empleado as em 
												on (p.codigo=em.cod_persona) full outer join sis.t_estudiante as es 
												on (p.codigo=es.cod_persona) where p.codigo is not null");
				$ejecutar->execute(array());
			}
			
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


	public static function listarEstado($persona=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			if($persona==null){
				$ejecutar = $conexion->prepare("select * from sis.t_est_docente union select * from sis.t_est_estudiante order by nombre;");	
				$ejecutar->execute(array());			
			}
			elseif($persona=="docente"){
				$ejecutar = $conexion->prepare("SELECT * FROM sis.t_est_docente;");
				$ejecutar->execute(array());
			}
			elseif ($persona=="estudiante"){
				$ejecutar = $conexion->prepare("SELECT * FROM sis.t_est_estudiante;");
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
}
?>
