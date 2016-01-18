<?php
require_once("base/clases/utilitarias/UtilBdd.clase.php");
require_once("modulos/estudiante/modelo/EstudianteServicio.php");
require_once("negocio/Estudiante.clase.php");
require_once("modulos/pensum/modelo/PensumServicio.php");
require_once("modulos/persona/modelo/PersonaServicio.php");
require_once("modulos/instituto/modelo/InstitutoServicio.php");
class EstudianteControlador
{
	public static function manejarRequerimiento()
	{
		
		$accion = PostGet::obtenerPostGet('m_accion');		

		//si $accion viene null se tomara por defecto la accion de listar
		if(!$accion)
			$accion = 'listar';

		if($accion == 'listar')
			self::listar();
		else if($accion == 'agregar')
			self::agregar();
		else
			throw new Exception ("'EstudianteControlador' La accion $accion no es valida");
	}



	public static function listar()
	{
		try
		{
			$instituto=InstitutoServicio::listarInstitutos();					
			$pnf=PensumServicio::listarPNF();
			$estado=PersonaServicio::listarEstado("estudiante");
			Vista::asignarDato('instituto',$instituto);
			Vista::asignarDato('pnf',$pnf);
			Vista::asignarDato('estado',$estado);
			Vista::asignarDato('estatus',1);
		}
		catch(Exception $e){
			throw $e;
		}
	}


	public static function agregar()
	{
		try
		{
			$codPersona=PostGet::obtenerPostGet("codPersona");
			$estudiante= new Estudiante();

			EstudianteServicio::agregar($estudiante);
		}
		catch(Exception $e){
			throw $e;
		}
	}
}
?>