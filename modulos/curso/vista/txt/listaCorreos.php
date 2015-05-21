<?php

$estudiante=Vista::obtenerDato('estudiante');

if ($estudiante){
//	echo"entro";
	$arc=fopen(Vista::$nombreArchivoDestino,"w");
	
	fwrite ($arc,"Docente: " .$estudiante[0]['nom_docente'] . "\r\n");
	fwrite ($arc,"Unidad Curricular: " .$estudiante[0]['uni_nombre'] . "\r\n");
	fwrite ($arc,"Sección: " .$estudiante[0]['seccion'] . "\r\n");
	fwrite ($arc,"-----------------------------------------------------------\r\n");


	
	foreach ($estudiante as $es ){
		fwrite ($arc,$es['cor_personal'] .",\r\n");
	}
	
	fclose($arc);
}
	//readfile("curso.txt");
	
/*
else 
*/
/*
	echo "no hay estudiantes ";
*/
//$arc=fopen(

//echo"jajaja";
//$arc=fopen('archivo.txt',"w");
//fwrite($arc,"hola");
//fclose($arc);	



?>
