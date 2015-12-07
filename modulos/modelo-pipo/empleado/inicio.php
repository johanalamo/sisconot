<?php
try{
	require_once '../../../base/clases/basededatos/Conexion.php';
	require_once 'EmpleadoServicio.php';
	Conexion::iniciar("localhost","bd_scnfinal","5432","postgres","12345");
	echo "<pre>";
	
	echo "----------empleado agregar-----------------------\n";
	$ins = EmpleadoServicio::agregar(107,11,2,'J','10/10/2010','6/12/2015','false','true','false','true','sin observacion');
	var_dump($ins);


	echo "----------empleado modificar-----------------------\n";
	$ins2 = EmpleadoServicio::modificar(0,105,11,1,'J','2010-10-10','2015-12-06','false','false','false','false','sin observacion');
	 var_dump($ins2);
	
	 
	echo "----------empleado listar-----------------------\n";
	$ins2 = EmpleadoServicio::listar(0);
	 var_dump($ins2);
	

	 echo "----------empleado listar todo-----------------------\n";
	$ins2 = EmpleadoServicio::listarTodo();
	 var_dump($ins2);

	 echo "----------empleado eliminar-----------------------\n";
	$ins2 = EmpleadoServicio::eliminar(0);
	 var_dump($ins2);
	
	echo "</pre>";
}catch(Exception $e){
	echo $e;
	
}
?>