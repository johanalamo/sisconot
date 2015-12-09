<?php
class EmpleadoServicio
{
	/*funcion encargada de obtener el codigo mayor de una persona
	de la base de datos
	*/


	/* ver la correcciòn de PersonaServicio.php primero, para que pudeas corregir
	 * la forma de colocar los parámetros, 
	 * Ç*************************************************************************************************************
	 * */
	public static function agregar($cod_persona=null,$cod_instituto=null,$cod_pensum=null,$cod_estado=null,
								   $fec_inicio=null,$fec_fin=null,$es_jef_pensum=null,$es_jef_con_estudio=null,
								   $es_ministerio=null,$es_docente=null,$observaciones=null)
	{
		try
		{

			$conexion = Conexion::conectar();
			/* igual aquí, revisar primero PersonaServicio.php **************************************************************/
			$consulta = " select sis.f_empleado_ins(:cod_persona,:cod_instituto,
													:cod_pensum,:cod_estado,:fec_inicio,
													:fec_fin,:es_jef_pensum,:es_jef_con_estudio,
													:es_ministerio,:es_docente,:observaciones);";
			$ejecutar = $conexion->prepare($consulta);

			$ejecutar->bindParam(':cod_persona',$cod_persona, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_instituto',$cod_instituto, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_pensum',$cod_pensum, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_estado',$cod_estado, PDO::PARAM_STR);
			$ejecutar->bindParam(':fec_inicio',$fec_inicio, PDO::PARAM_STR);
			$ejecutar->bindParam(':fec_fin',$fec_fin, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_jef_pensum',$es_jef_pensum, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_jef_con_estudio',$es_jef_con_estudio, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_ministerio',$es_ministerio, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_docente',$es_docente, PDO::PARAM_STR);
			$ejecutar->bindParam(':observaciones',$observaciones, PDO::PARAM_STR);

			$ejecutar->setFetchMode(PDO::FETCH_ASSOC);

			$ejecutar->execute();

			if($ejecutar->rowCount() == 0)
					throw new Exception("No se pudo agregar al empleado.");

			$codigo = $ejecutar->fetchColumn(0);					
				return $codigo;
		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function modificar($codigo=null,$cod_persona=null,$cod_instituto=null,$cod_pensum=null,$cod_estado=null,
								   $fec_inicio=null,$fec_fin=null,$es_jef_pensum=null,$es_jef_con_estudio=null,
								   $es_ministerio=null,$es_docente=null,$observaciones=null)
	{
		try
		{
			$conexion = Conexion::conectar();
			$consulta = " select sis.f_empleado_mod(:codigo,:cod_persona,:cod_instituto,:cod_pensum,:cod_estado,
													:fec_inicio,:fec_fin,:es_jef_pensum,:es_jef_con_estudio,
													:es_ministerio,:es_docente,:observaciones)";
			$ejecutar = $conexion->prepare($consulta);

			$ejecutar->bindParam(':codigo',$codigo, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_persona',$cod_persona, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_instituto',$cod_instituto, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_pensum',$cod_pensum, PDO::PARAM_STR);
			$ejecutar->bindParam(':cod_estado',$cod_estado, PDO::PARAM_STR);
			$ejecutar->bindParam(':fec_inicio',$fec_inicio, PDO::PARAM_STR);
			$ejecutar->bindParam(':fec_fin',$fec_fin, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_jef_pensum',$es_jef_pensum, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_jef_con_estudio',$es_jef_con_estudio, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_ministerio',$es_ministerio, PDO::PARAM_STR);
			$ejecutar->bindParam(':es_docente',$es_docente, PDO::PARAM_STR);
			$ejecutar->bindParam(':observaciones',$observaciones, PDO::PARAM_STR);

			$ejecutar->setFetchMode(PDO::FETCH_ASSOC);

			$ejecutar->execute();

			$row = $ejecutar->fetchColumn(0);	
			if($ejecutar->rowCount()==0)
				throw new Exception("No se logro modificar la informacion del empleado.");	

			return $row;	
		}
		catch(Exception $e){
			throw $e;
		}	
	}

	public static function listar ($codigo=null)
	{
		try
		{
			$conexion = Conexion::conectar();

			//chequea bien, pero aqui creo que puedes pasarle directamente el nombre del cursor**************************************
			// ejemplo:   $consulta= "select sis.f_empleado_lis_cod('micursor',:codigo)";

			$consulta= "select sis.f_empleado_lis_cod(:cursor,:codigo)";
			
			$ejecutar= $conexion->prepare($consulta);
			$cursor='fcursorinst';
			$ejecutar->bindParam(':codigo',$codigo, PDO::PARAM_INT);
			$ejecutar->bindParam(':cursor',$cursor, PDO::PARAM_INT);	
			// inicia transaccion
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
				//si le pasaste el nombre del cursor directamente aquí tambien pudieras hacerlo ****************************************************
				//pasandole el nombre de cursor que decidiste arriba:
				//ejemplo :   $ejecutar = $conexion->query("FETCH ALL IN 'micursor';");
				//pero revisalo tu no estoy seguro ******************************************************************************
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

	public static function listarTodo ()
	{
		try
		{
			$conexion = Conexion::conectar();
			$consulta= "select sis.f_empleado_listar(:cursor)";
			
			$ejecutar= $conexion->prepare($consulta);
			$cursor='fcursorinst';;
			$ejecutar->bindParam(':cursor',$cursor, PDO::PARAM_INT);	
			// inicia transaccion
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

	
	public static function eliminar($codigo=null){
		try{
			$conexion=Conexion::conectar();
			$consulta="select sis.f_empleado_eliminar(:codigo)";								
			$ejecutar=$conexion->prepare($consulta);
			// indica
			// como se indica en parametro y el tipo de parametro que se envia
			$ejecutar->bindParam(':codigo',$codigo, PDO::PARAM_INT);				
			$ejecutar->setFetchMode(PDO::FETCH_ASSOC);
			//ejecuta				
			$ejecutar->execute();
			//primera columana codigo
			$row = $ejecutar->fetchColumn(0);					
			var_dump($row);
			if ($row == 0)
				throw new Exception("No se pudo eliminar el empleado");	

			return $row;
		}catch(Exception $e){
			throw $e;
		 }	 
	}	
}
?>
