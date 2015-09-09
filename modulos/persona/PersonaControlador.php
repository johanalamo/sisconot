<?php

	require_once("modulos/persona/modelo/PersonaServicio.php");
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
			else
				throw new Exception ("'PersonaControlador' La accion $accion no es valida");
		}

		public static function listar()
		{
			try
			{
				if($r=PersonaServicio::listar())
				{
					Vista::asignarDato('personas',"ola");
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
	}
?>