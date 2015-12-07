<?php
try{
	require_once '../../../base/clases/basededatos/Conexion.php';
	require_once 'PersonaServicio.php';
	Conexion::iniciar("localhost","bd_scnfinal","5432","postgres","12345");
	echo "<pre>";
	
	echo "----------persona agregar-----------------------\n";
	//$ins = PersonaServicio::agregar(5,77292,'72229','jean','pierre','sosa','gomez',
	//								'M','7/4/1993','O+','373c57','711c728','jenpc2ipo@9gmil.com',
	//								'je2cn@it9frp.com','san antonio','sin discapacidad','V',0,'S',
	//								'sin observaciones');
	 //var_dump($ins);


	echo "----------persona modificar-----------------------\n";
	$ins2 = PersonaServicio::modificar(108,8772,'8722','jean','pierre','sosa','gomez',
									'M','8/8/1993','O+','373c57','711c728','8jenpcipo@gmil.com',
									'99jecn@itfrp.com','san antonio','sin discapacidad','V',0,'S',
									'sin observaciones');
	 var_dump($ins2);
	
	 
	echo "----------persona listar-----------------------\n";
	$ins2 = PersonaServicio::listar(2);
	 var_dump($ins2);
	

	 echo "----------persona listar todo-----------------------\n";
	$ins2 = PersonaServicio::listarTodo();
	 var_dump($ins2);

	 echo "----------persona eliminar-----------------------\n";
	$ins2 = PersonaServicio::eliminar(108);
	 var_dump($ins2);
	
	echo "</pre>";
}catch(Exception $e){
	echo $e;
	
}
?>