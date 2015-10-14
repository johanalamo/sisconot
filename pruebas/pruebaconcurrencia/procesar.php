<?php
	$val = $_REQUEST["valor"];
	
	//insercion en la bd y generación de cod
	$cod;
	try
	{
		$con = new PDO('pgsql:host=localhost;dbname=pruebaconcurrencia', 'postgres', '1234');
		$con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		$datos = $con->query("SELECT insertar_valor($val);");
		foreach($datos as $row){
		//	echo $row[0] . '<br/>';
			$cod = $row[0];// * (9+1);
		}
	}
	catch(PDOException $e)
	{
//	echo 'Error conectando con la base de datos: ' . $e->getMessage();
	}
	
	
	
	
	
	
	
//	$cod = $val;
	
	echo '{' 
	      .'"codigo":"' . $cod . '",'
	      .'"valor":"' . $val . '"'
	 . '}';

?>
