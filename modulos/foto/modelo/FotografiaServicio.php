<?php

/*
 * * * * * * * * * * LICENCIA * * * * * * * * * * * * * * * * * * * * *

Copyright(C) 2012
Instituto Universtiario de Tecnología Dr. Federico Rivero Palacio

Este programa es Software Libre y usted puede redistribuirlo y/o modificarlo
bajo los términos de la versión 3.0 de la Licencia Pública General (GPLv3)
publicada por la Free Software Foundation (FSF), es distribuido sin ninguna
garantía. Usted debe haber recibido una copia de la GPLv3 junto con este
programa, sino, puede encontrarlo en la página web de la FSF, 
específicamente en la dirección http://www.gnu.org/licenses/gpl-3.0.html

 * * * * * * * * * * ARCHIVO * * * * * * * * * * * * * * * * * * * * *

Nombre: FotografiaServicio.clase.php
Diseñador: Geraldine Castillo (geritha_19@hotmmail.com)
Programador: Geraldine Castillo
Fecha: Diciembre de 2013
Descripción: 

	Esta clase sólo contiene métodos estáticos y no posee atributos. Permite agilizar el manejo de todos los datos y acciones de una fotografía en la base de datos. 

 * * * * * * * * Cambios/Mejoras/Correcciones/Revisiones * * * * * * * *
               /      / .
---                         ----      ---------

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/?>
<?php

class FotografiaServicio {
	/* método público que permite verificar si existe una fotografía mediante un código  único por persona  . Retornará true en 		caso de existir y false en caso de error.
	Parámetros de entrada:
	$codigo_persona: tipo: cadena.
	Código de la persona por el cual se verificará si existe .
	Valor de retorno:
	En  caso exitoso true  , false en caso de error.
	Excepciones que lanza: 
	Exception: si ocurre un error en la conexión a la base de datos..	
	*/
	
	static public function existe($codigo) {
		try{
			//var_dump($codigo);
			$conexion = Conexion::conectar();
			$consulta = "SELECT * FROM sis.t_archivo WHERE 
					codigo= ?";
			
			$ejecutar=$conexion->prepare($consulta);		
			$ejecutar-> execute(array($codigo));			
 			//var_dump($ejecutar->fetchAll());
			if($ejecutar->rowCount() != 0)
				return $ejecutar->fetchAll();
			else
				return null;
		}
		catch(Exception $e){
			throw $e;
		}
			
	}
	
	
	/*método público que permite eliminar una fotografía de la base de datos.
	Parámetros de entrada: 
	$codigo: tipo: cadena.
	Código de la fotografía a eliminar.
	Valor de retorno: true: en caso de éxito, false: en caso de error. 
	Excepciones que lanza: 
	Exception: si ocurre un error en la conexión a la base de datos.	
	*/	
	static public function eliminar($codigo){
		global $gbConectorBD;
		$sql = "delete from ts_fotografia 
		         where cast(cod_persona as varchar(10)) = $1;";           
		$parametros = array($codigo);
		
		$result = $gbConectorBD->ejecutarDMLDirecto($sql,$parametros);
		if ($result === FALSE) 
		throw new Exception ("no se puede realizar la accion por no poseer conexion a la base de datos ") ;
		if  ( $result == 0) 
			return false;
		else 
			return true;
		
	}

	/* método público que permite guardar  todos los datos referentes a una fotografía en la base de datos. 
	Parámetros de entrada: 
	$cod_persona: tipo: cadena.
	Código de la persona en la cual se guardará la fotografía.
	$ruta: tipo: cadena.
	Indica la ruta en donde se encuentra la imagen a incluir en la base de datos. Por ejemplo: “/tmp/foto.jpg”.
	$tipo: tipo: cadena.
	Tipo de archivo que se esta guarando. Por ejemplo: jpg, docx, rar  entre otros .
	Valor de retorno: true: en caso de éxito, false: en caso de error .
	Excepciones que lanza: 
	Exception: si ocurre un error en la conexión a la base de datos.
	Exception:si los campos están vacios.	
	*/
	static public function guardar($cod_persona,$tipo,$ruta){
		try{

			$conexion = Conexion::conectar();
			if(FotografiaServicio::existe($cod_persona)== false ){
				$consulta = "INSERT INTO sis.t_archivo (codigo,tipo,archivo) 				
								VALUES 
								(?,?,lo_import(?));";
				$ejecutar=$conexion->prepare($consulta);		
				$ejecutar-> execute(array($cod_persona,$tipo,$ruta));
			}
			else{

				$consulta="UPDATE sis.t_archivo SET archivo= lo_import('$ruta'),
							tipo='$tipo' WHERE codigo= $cod_persona";
				$ejecutar=$conexion->prepare($consulta);
				$ejecutar-> execute(array());
			}

						
 		
			if($ejecutar->rowCount() != 0)
				return $ejecutar->fetchAll();
			else
				return null;
						

		}
		catch(Exception $e){
			throw $e;
		}
		
	}
	/* método público que permite extraer una fotografía de la base de datos en la dirección deseada.
	Parámetros de entrada: 
	$cod_persona: tipo: cadena.
	Código de la persona de la cual se extraerá la fotografía.
 	$ruta: tipo: cadena.
	Indica el lugar donde se guardará la fotografía. Por ejemplo: “/tmp/foto.jpg”.
	Valor de retorno: true: en caso de éxito, false: en caso de error. 
	Excepciones que lanza: 
	Exception: si ocurre un error en la conexión a la base de datos.	

	*/
	
	static public function extraerEn($cod_persona,$ruta){
		
			 $conexion = Conexion::conectar();
			// $ruta="'/var/www/proyecto/GitHub/sisconot/aqui.JPG'";
			$consulta = "SELECT lo_export(sis.t_archivo.archivo,'$ruta') FROM sis.t_archivo WHERE 
				codigo= $cod_persona";

				$ejecutar=$conexion->prepare($consulta);
			//	var_dump($consulta);		
			$ejecutar-> execute(array());			
 		
			if($ejecutar->rowCount() != 0)
				return $ejecutar->fetchAll();
			else
				return null;
		//lanza una exception si falla la conexion	
		
	}
}

?>
