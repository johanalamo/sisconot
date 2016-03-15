<?php
try{

	require_once '../../../base/clases/basededatos/Conexion.php';

	require_once 'TrayectoServicio.php';
		
	require_once "../../../negocio/Pensum.php";

	Conexion::iniciar("localhost","bd_scnfinal","5432","postgres","5455");
	echo "<pre>";
	
	echo "----------lista de TrayectoServicio -----------------------\n";
	
	$ins = TrayectoServicio::listarTrayectos();

	 var_dump($ins);

	
	echo "----------------obtener por codigo un TrayectoServicio-------------------\n";
	
	 $ins2 = TrayectoServicio::obtener(2);

		var_dump($ins2);

	echo "----------------Agregar un TrayectoServicio-------------------\n";


	//$a   = InstitutoServicio::agregarInstituto("iut federico palacio","iut3", "km8");
	//echo "Código del TrayectoServicio agregado:   $a\n";
	

	echo "----------------Eliminar un TrayectoServicio-------------------\n";

	// InstitutoServicio::eliminar(10);

	echo "----------------Modificar un TrayectoServicio-------------------\n";


//	 InstitutoServicio::modificarInstituto(10,"iut federico 3","iut3 mod", "km8");


	echo "</pre>";

}catch(Exception $e){
	echo $e;
	
}





?>
