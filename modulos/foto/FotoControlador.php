<?php
class FotoControlador{

	//private $ruta;		// Se establece la ruta en de la ubicacion de la imagen.	
	private static $ancho_limite=300;		//Se establece el limite de pixeles de ancho que va a obtener la imagen despues de ser modificada.
	private static $altura_limite=300;		//Se establece el limite de pixeles de alto que va a obtener la imagen despues de ser modificada.


	public static function iniciar($ruta){
		$dimensionesMinimas=self::validar_dimensiones_minimas ($ruta);
		if(!self::validar_dimensiones ($ruta)){
			$dimensiones=self::get_dimensiones ($ruta);
			self::guardar (self::redimensionar ($dimensiones,$ruta),$ruta);
			$a=explode("/",$ruta);
			$destino="modulos/persona/vista/html5/imagen/PersonasImg/".$a[1];
			copy($ruta,$destino);
			unlink($ruta);
			return $destino;

		}
		elseif(!$dimensionesMinimas){
			return $dimensionesMinimas;
		}
		else
		{
			$destino="/var/www/proyecto/todoIntegrado/sisconot/modulos/persona/vista/html5/imagen/PersonasImg/".$a[1];
			copy($ruta,$destino);
			unlink($ruta);
			return $destino;

		}


	}
	/*la funcion abrir imagen abre la imagen de la planilla para poder ser trabajada*/
	public static function obtener_foto($ruta)
	{
		if(!strpos($ruta, ".jpg")===false)
			return imagecreatefromjpeg($ruta);	//Se abre la imagen donde esta la planilla.
		elseif(!strpos($ruta, ".png")===false)
			return imagecreatefrompng($ruta);  //Se guardan los cambios realizados.	
		elseif(!strpos($ruta, ".gif")===false)
			return imagecreatefromgif($ruta);//Se guardan los cambios realizados.	
		elseif(!strpos($ruta, ".JPG")===false)
			return imagecreatefromjpeg($ruta);	//Se abre la imagen donde esta la planilla.
		elseif(!strpos($ruta, ".PNG")===false)
			return imagecreatefrompng($ruta);  //Se guardan los cambios realizados.	
		elseif(!strpos($ruta, ".GIF")===false)
			return imagecreatefromgif($ruta);//Se guardan los cambios realizados.	
	}

	/*La funcion get_dimensiones obtiene la cantidad de pixeles de la imagen
	tanto de largo como se ancho*/
	public static function get_dimensiones ($ruta)
	{
		
		list($ancho_original, $altura_original) = getimagesize($ruta);	// devuelve el ancho y la altura de la imagen en pixeles
		return $ancho_original."|".$altura_original;
	}

	/* Esta funcion se encargar de verificar si las dimensiones de la imagen son lo sufisientemente 
	grande para ser trabajada */
	public static function validar_dimensiones ($ruta)
	{
		$a=explode("|",self::get_dimensiones($ruta));	
		if($a[0]<=350 and $a[1]<=350)	{return true;}
		else 							{return false;}
	}

	public static function validar_dimensiones_minimas ($ruta)
	{
		$a=explode("|",self::get_dimensiones($ruta));	
		if($a[0]<=250 or $a[1]<=250)	{return false;}
		else 							{return true;}
	}

	public static function guardar ($cambio,$ruta)	//pendiente con las extenciones hay que determinar eso.
	{
		
		if($cambio!=null)
		{
			if(!strpos($ruta ,".jpg")===false)
				imagejpeg($cambio,$ruta);  //Se guardan los cambios realizados.	
			elseif(!strpos($ruta, ".png")===false)
				imagepng($cambio,$ruta);  //Se guardan los cambios realizados.	
			elseif(!strpos($ruta, ".gif")===false)
				imagegif($cambio,$ruta);  //Se guardan los cambios realizados.
			elseif(!strpos($ruta ,".JPG")===false)
				imagejpeg($cambio,$ruta);  //Se guardan los cambios realizados.	
			elseif(!strpos($ruta, ".PNG")===false)
				imagepng($cambio,$ruta);  //Se guardan los cambios realizados.	
			elseif(!strpos($ruta, ".GIF")===false)
				imagegif($cambio,$ruta);  //Se guardan los cambios realizados.	
		}
		
	}

	/*La funcion redimencionar redimensiona la imagen a un nuevo tamaño */
	public static function redimensionar ($dimensiones,$ruta)
	{
		$a=explode("|",$dimensiones);	// se obtiene las dimensiones originales de la imagen tanto de ancho como de alto
		$imagen_redimensionada=self::imagen_vacia(self::$ancho_limite."|".self::$altura_limite);	//se obtiene una imagen en blanco
		//se redimensiona la imagen la valiable $a en la posicion cero contiene el ancho original y la variable $a en la posicion 1 contiene la altura original
		imagecopyresized($imagen_redimensionada,self::obtener_foto($ruta), 0, 0, 0, 0, self::$ancho_limite,self::$altura_limite, $a[0] , $a[1]); 
						        	
		return  $imagen_redimensionada;    //se guardan los cambios
	}

	/*La funcion imagen_vacia crea una imagen en blanco para poder albergar 
	los cambios que sufre una imagen*/
	public static function imagen_vacia($dimensiones)
	{
		$a=explode("|", $dimensiones);	//obtiene las dimensiones de la imagen 
		return imagecreatetruecolor($a[0],$a[1]); //se crea una imagen en blanco para guardar los cambios q se efectue
	}
}
?>