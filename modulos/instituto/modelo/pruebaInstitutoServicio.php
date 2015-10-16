<?php
try{

	require_once '../../../base/clases/basededatos/Conexion.php';

	require_once 'InstitutoServicio.php';
	Conexion::iniciar("localhost","bd_sisconot","5432","sisconot","123");
	echo "<pre>";
	
	echo "----------lista de institutos -----------------------\n";
	
	$ins = InstitutoServicio::listarInstitutos();

	var_dump($ins);

	
	echo "----------------agregar un instituto-------------------\n";
	
	
	$a   = InstitutoServicio::agregarInsituto("iut federico","iut2", "km8");
	echo "Código del instituto agregado:   $a\n";
	

	echo "</pre>";

}catch(Exception $e){
	echo $e;
	
}





?>
