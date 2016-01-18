<?php
	require_once("base/clases/utilitarias/UtilBdd.clase.php");
	require_once("modulos/persona/modelo/PersonaServicio.php");
	require_once("modulos/estudiante/modelo/EstudianteServicio.php");
	require_once("modulos/empleado/modelo/EmpleadoServicio.php");
	require_once("modulos/pensum/modelo/PensumServicio.php");
	require_once("modulos/instituto/modelo/InstitutoServicio.php");
	require_once("negocio/Persona.clase.php");
/**
 * @copyright 2015 - Instituto Universtiario de Tecnología Dr. Federico Rivero Palacio
 * @license GPLv3
 * @license http://www.gnu.org/licenses/gpl-3.0.html
 *
 * PersonaControlador.php - Controlador del módulo Persona.
 *
 * Este es el controlador del módulo Persona, permite manejar las 
 * operaciones relacionadas con los errores del sistema (agregar, modificar,
 * eliminar, consultar y buscar) 
 * 
 * Es el intermediario entre la base de datos y la vista.
 *  
 * @author Jean Pierre Sosa Gómez (jean_pipo_10@hotmail.com)  
 * 
 * @package Controladores
 */

	class PersonaControlador
	{
		public static function manejarRequerimiento()
		{
			$accion= PostGet::obtenerPostGet("m_accion");

			if(!$accion)
				$accion="listar";

			if($accion == 'listar')
				self::listar();
			elseif($accion == 'modificar')
				self::modificar();
			elseif($accion == 'agregar')
				self::agregar();
			else
				throw new Exception ("'PersonaControlador' La accion $accion no es valida");
		}

		public static function listar()
		{
			try
			{	
				$pnf=PostGet::obtenerPostGet("pnf");
				$estado=PostGet::obtenerPostGet("estado");
				$instituto=PostGet::obtenerPostGet("instituto");
				$tipo_persona=PostGet::obtenerPostGet("tipo_persona");
				if($pnf=="seleccionar")
					$pnf=null;
				
				if($estado=="seleccionar")
					$estado=null;
								
					
				if($instituto=="seleccionar")
					$instituto=null;
				

				if(!isset($tipo_persona))			
					$personas=PersonaServicio::listarPersonaEstudianteEmpleado($pnf,$estado,$instituto);
				
				elseif($tipo_persona=="estudiante")
					$personas=EstudianteServicio::listarPersonaEstudiante($pnf,$estado,$instituto);
			
				elseif($tipo_persona=="empleado")
					$personas=EmpleadoServicio::listarPersonaEmpleado($pnf,$estado,$instituto);
				
				else
					$personas=PersonaServicio::listarPersonaEstudianteEmpleado($pnf,$estado,$instituto);
				

				if($personas)
				{	
					$instituto=InstitutoServicio::listarInstitutos();					
					$pnf=PensumServicio::listarPNF();
					$estado=PersonaServicio::listarEstado();
					Vista::asignarDato('instituto',$instituto);
					Vista::asignarDato('pnf',$pnf);
					Vista::asignarDato('estado',$estado);
					Vista::asignarDato('persona',$personas);
					Vista::asignarDato('estatus',1);
				}
				else
				{
					Vista::asignarDatos('mensaje','No hay personas para mostrar');
				}
				Vista::Mostrar();
			}
			catch(Exception $e)
			{
				throw $e;
			}
		}

		public static function modificar()
		{
			try
			{		

				$codigo=PostGet::obtenerPostGet("codPersona");

				$persona=PersonaServicio::listar($codigo);
				$empleado=EmpleadoServicio::listar(null,$codigo);
				$estudiante=EstudianteServicio::listar(null,$codigo);				
				if($persona)
				{	
					Vista::asignarDato('persona',$persona);
					Vista::asignarDato('empleado',$empleado);
					Vista::asignarDato('estudiante',$estudiante);
					Vista::asignarDato('estatus',1);
				}
				else
				{
					Vista::asignarDatos('mensaje','No se puede modificar a la persona');
					Vista::asignarDato('estatus',-1);
				}

			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function agregar ()
		{
			try
			{	
				if(PostGet::obtenerPostGet("rifPersona"))
					$rif=PostGet::obtenerPostGet("rifPersona");
				else
					$rif=null;

				if(PostGet::obtenerPostGet("corInstitucional"))
					$corInstitucional=PostGet::obtenerPostGet("corInstitucional");
				else
					$corInstitucional=null;
				
				$persona= new Persona();
				$persona->asignarCedula(PostGet::obtenerPostGet("cedPersona"));
				$persona->asignarRif($rif);
				$persona->asignarNombre1(PostGet::obtenerPostGet("nombre1"));
				$persona->asignarNombre2(PostGet::obtenerPostGet("nombre2"));
				$persona->asignarApellido1(PostGet::obtenerPostGet("apellido1"));
				$persona->asignarApellido2(PostGet::obtenerPostGet("apellido2"));
				$persona->asignarTelefono1(PostGet::obtenerPostGet("telefono1"));
				$persona->asignarTelefono2(PostGet::obtenerPostGet("telefono2"));
				$persona->asignarCorPersonal(PostGet::obtenerPostGet("corPersonal"));
				$persona->asignarCorInstitucional($corInstitucional);
				$persona->asignarDireccion(PostGet::obtenerPostGet("direccion"));
				$persona->asignarDiscapacidad(PostGet::obtenerPostGet("discapacidad"));
				$persona->asignarObservaciones(PostGet::obtenerPostGet("obsPersona"));
				$persona->asignarSexo(PostGet::obtenerPostGet("sexo"));
				$persona->asignarTipSangre(PostGet::obtenerPostGet("tipSangre"));
				$persona->asignarEstCivil(PostGet::obtenerPostGet("estCivil"));
				$persona->asignarhijos(PostGet::obtenerPostGet("hijo"));
				$persona->asignarNacionalidad(PostGet::obtenerPostGet("nacionalidad"));
				PersonaServicio::agregar($persona);
				Vista::asignarDato('mensaje','Se ha agregado la Persona '.$persona->obtenerNombre1().' '.$persona->obtenerApellido1().'.');

				Vista::mostrar();

			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function eliminar ()
		{
			try
			{
				$codigo=PostGet::obtenerPostGet("cod_persona");
				if(!$codigo)
					$codigo=null;

				PersonaServicio::eliminar($codigo);
				Vista::asignarDato('mensaje', 'La persona se ha eliminado correctamente');
				Vista::mostrar();

			}
			catch (Exception $e){
				throw $e;
			}
		}


	}
?>