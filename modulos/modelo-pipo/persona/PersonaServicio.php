<?php
class PersonaServicio
{
	public static function agregar ($cod_foto,$cedula,$rif,$nombre1,$nombre2,
									$apellido1,$apellido2,$sexo,$fec_nacimiento,$tip_sangre,
									$telefono1,$telefono2,$cor_personal,$cor_institucional,
									$direccion,$discapacidad,$nacionalidad,$hijos,$est_civil,
									$observaciones)


	{
		try
		{

			$conexion = Conexion::conectar();

			
			
			$consulta="select sis.f_persona_ins(:cedula,:rif,:nombre1, 
											    :nombre2,:apellido1,:apellido2,:sexo,
											    :fec_nacimiento,:tip_sangre,:telefono1,
											    :telefono2,:cor_personal,:cor_institucional,
											    :direccion,:discapacidad,:nacionalidad,
											    :hijos,:est_civil,:observaciones,:cod_foto
											     )";

			$ejecutar=$conexion->prepare($consulta);

			$ejecutar->bindParam(':cedula',$cedula, PDO::PARAM_STR);
			$ejecutar->bindParam(':rif',$rif, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_foto',$cod_foto, PDO::PARAM_STR);			
			$ejecutar->bindParam(':nombre1',$nombre1, PDO::PARAM_STR);
			$ejecutar->bindParam(':nombre2',$nombre2, PDO::PARAM_STR);
			$ejecutar->bindParam(':apellido1',$apellido1, PDO::PARAM_STR);
			$ejecutar->bindParam(':apellido2',$apellido2, PDO::PARAM_STR);
			$ejecutar->bindParam(':sexo',$sexo, PDO::PARAM_STR);
			$ejecutar->bindParam(':fec_nacimiento',$fec_nacimiento, PDO::PARAM_STR);
			$ejecutar->bindParam(':tip_sangre',$tip_sangre, PDO::PARAM_STR);
			$ejecutar->bindParam(':telefono1',$telefono1, PDO::PARAM_STR);
			$ejecutar->bindParam(':telefono2',$telefono2, PDO::PARAM_STR);
			$ejecutar->bindParam(':cor_personal',$cor_personal, PDO::PARAM_STR);
			$ejecutar->bindParam(':cor_institucional',$cor_institucional, PDO::PARAM_STR);
			$ejecutar->bindParam(':direccion',$direccion, PDO::PARAM_STR);
			$ejecutar->bindParam(':discapacidad',$discapacidad, PDO::PARAM_STR);
			$ejecutar->bindParam(':nacionalidad',$nacionalidad, PDO::PARAM_STR);
			$ejecutar->bindParam(':hijos',$hijos, PDO::PARAM_STR);
			$ejecutar->bindParam(':est_civil',$est_civil, PDO::PARAM_STR);
			$ejecutar->bindParam(':observaciones',$observaciones, PDO::PARAM_STR);
			$ejecutar->setFetchMode(PDO::FETCH_ASSOC);
			
				$ejecutar->execute();
			$codigo = $ejecutar->fetchColumn(0);					
				return $codigo;		
		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function listar($codigo=null)
	{
		try
		{
			$conexion = Conexion::conectar();
			$consulta="select sis.f_persona_lis_cod_ced (:cursor,:codigo)";

			$ejecutar=$conexion->prepare($consulta);
			$cursor='fcursorinst';
			$ejecutar->bindParam(':cursor',$cursor, PDO::PARAM_STR);	
			$ejecutar->bindParam(':codigo',$codigo, PDO::PARAM_STR);

			
			$conexion->beginTransaction();
				$ejecutar->execute();			
			$cursors = $ejecutar->fetchAll();
			// cierra cursor
			$ejecutar->closeCursor();
			// array para almacenar resultado del cursor
			$results = array();
			// sirver para leer multiples cursores si es necesario
			foreach($cursors as $k=>$v){
				// ejecutar otro query para leer el cursor
				$ejecutar = $conexion->query('FETCH ALL IN "'. $v[0] .'";');
				$results[$k] = $ejecutar->fetchAll();
				$ejecutar->closeCursor();
				// cierra cursor
			}
			$conexion->commit();			
			if(count($results) > 0)					
				return $results;
			else								
				return null;
		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function listarTodo($codigo=null)
	{
		try
		{
			$conexion = Conexion::conectar();
			$consulta="select sis.f_persona_listar(:cursor)";

			$ejecutar=$conexion->prepare($consulta);
			$cursor='fcursorinst';
			$ejecutar->bindParam(':cursor',$cursor, PDO::PARAM_STR);	

			
			$conexion->beginTransaction();
				$ejecutar->execute();			
			$cursors = $ejecutar->fetchAll();
			// cierra cursor
			$ejecutar->closeCursor();
			// array para almacenar resultado del cursor
			$results = array();
			// sirver para leer multiples cursores si es necesario
			foreach($cursors as $k=>$v){
				// ejecutar otro query para leer el cursor
				$ejecutar = $conexion->query('FETCH ALL IN "'. $v[0] .'";');
				$results[$k] = $ejecutar->fetchAll();
				$ejecutar->closeCursor();
				// cierra cursor
			}
			$conexion->commit();			
			if(count($results) > 0)					
				return $results;
			else								
				return null;
		}
		catch(Exception $e){
			throw $e;
		}
	}


	public static function modificar($codigo,$cedula,$rif,$nombre1,$nombre2,
									$apellido1,$apellido2,$sexo,$fec_nacimiento,$tip_sangre,
									$telefono1,$telefono2,$cor_personal,$cor_institucional,
									$direccion,$discapacidad,$nacionalidad,$hijos,$est_civil,
									$observaciones)
	{
		try
		{
			$conexion = Conexion::conectar();

			$consulta="select sis.f_persona_mod(:codigo,:cedula,:rif,:nombre1, 
											    :nombre2,:apellido1,:apellido2,:sexo,
											    :fec_nacimiento,:tip_sangre,:telefono1,
											    :telefono2,:cor_personal,:cor_institucional,
											    :direccion,:discapacidad,:nacionalidad,
											    :hijos,:est_civil,:observaciones)";								
				$ejecutar=$conexion->prepare($consulta);

			$ejecutar->bindParam(':cedula',$cedula, PDO::PARAM_STR);
			$ejecutar->bindParam(':rif',$rif, PDO::PARAM_STR);
			$ejecutar->bindParam(':codigo',$codigo, PDO::PARAM_STR);			
			$ejecutar->bindParam(':nombre1',$nombre1, PDO::PARAM_STR);
			$ejecutar->bindParam(':nombre2',$nombre2, PDO::PARAM_STR);
			$ejecutar->bindParam(':apellido1',$apellido1, PDO::PARAM_STR);
			$ejecutar->bindParam(':apellido2',$apellido2, PDO::PARAM_STR);
			$ejecutar->bindParam(':sexo',$sexo, PDO::PARAM_STR);
			$ejecutar->bindParam(':fec_nacimiento',$fec_nacimiento, PDO::PARAM_STR);
			$ejecutar->bindParam(':tip_sangre',$tip_sangre, PDO::PARAM_STR);
			$ejecutar->bindParam(':telefono1',$telefono1, PDO::PARAM_STR);
			$ejecutar->bindParam(':telefono2',$telefono2, PDO::PARAM_STR);
			$ejecutar->bindParam(':cor_personal',$cor_personal, PDO::PARAM_STR);
			$ejecutar->bindParam(':cor_institucional',$cor_institucional, PDO::PARAM_STR);
			$ejecutar->bindParam(':direccion',$direccion, PDO::PARAM_STR);
			$ejecutar->bindParam(':discapacidad',$discapacidad, PDO::PARAM_STR);
			$ejecutar->bindParam(':nacionalidad',$nacionalidad, PDO::PARAM_STR);
			$ejecutar->bindParam(':hijos',$hijos, PDO::PARAM_STR);
			$ejecutar->bindParam(':est_civil',$est_civil, PDO::PARAM_STR);
			$ejecutar->bindParam(':observaciones',$observaciones, PDO::PARAM_STR);


			$ejecutar->setFetchMode(PDO::FETCH_ASSOC);
				//ejecuta				
				$ejecutar->execute();
				//primera columana codigo
				$row = $ejecutar->fetchColumn(0);
			if ($row == 0)
					throw new Exception("No se puedo modificar la informacion de la persona");	
			
			return $row;
		}
		catch(Exception $e){
			throw $e;
		}
	}




	public static function eliminar($codigo=null)
	{
		try
		{
			$conexion = Conexion::conectar();
			$consulta="select sis.f_persona_eliminar(:codigo)";

			$ejecutar=$conexion->prepare($consulta);
			$ejecutar->bindParam(':codigo',$codigo, PDO::PARAM_STR);						
			
			$ejecutar->setFetchMode(PDO::FETCH_ASSOC);
				//ejecuta				
				$ejecutar->execute();
				//primera columana codigo
				$row = $ejecutar->fetchColumn(0);					
				var_dump($row);
				if ($row == 0)
					throw new Exception("No se pudo eliminar a la persona");

				return $row;	
		}
		catch(Exception $e){
			throw $e;
		}
	}


}
?>