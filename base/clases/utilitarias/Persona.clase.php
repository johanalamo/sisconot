<?php

class Persona { 
	//atributos de la clase
	private $nombre;
	private $apellido;
	private $sexo;
	private $edad;


	public function __construct($nombre=NULL, $apellido=NULL, $sexo=NULL, $edad=NULL)
	{
		$this->asignarNombre($nombre);
		$this->asignarApellido($apellido);
		$this->asignarSexo($sexo);
		$this->asignarEdad($edad);

	}


	//Coloque aquí los métodos y operaciones de la clase


	//Asignar y obtener de cada atributo
	public function asignarNombre($nombre){
		$this->nombre = $nombre;
	}
	public function obtenerNombre(){
		return $this->nombre;
	}

	public function asignarApellido($apellido){
		$this->apellido = $apellido;
	}
	public function obtenerApellido(){
		return $this->apellido;
	}

	public function asignarSexo($sexo){
		$this->sexo = $sexo;
	}
	public function obtenerSexo(){
		return $this->sexo;
	}

	public function asignarEdad($edad){
		$this->edad = $edad;
	}
	public function obtenerEdad(){
		return $this->edad;
	}

}

?>