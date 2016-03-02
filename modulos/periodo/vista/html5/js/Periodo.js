/*
 * * * * * * * * * * LICENCIA * * * * * * * * * * * * * * * * * * * * *

Copyright(C) 2015
Instituto Universtiario de Tecnología Dr. Federico Rivero Palacio

Este programa es Software Libre y usted puede redistribuirlo y/o modificarlo
bajo los términos de la versión 3.0 de la Licencia Pública General (GPLv3)
publicada por la Free Software Foundation (FSF), es distribuido sin ninguna
garantía. Usted debe haber recibido una copia de la GPLv3 junto con este
programa, sino, puede encontrarlo en la página web de la FSF, 
específicamente en la dirección http://www.gnu.org/licenses/gpl-3.0.html

 * * * * * * * * * * ARCHIVO * * * * * * * * * * * * * * * * * * * * *

Nombre: Periodo.js
Diseñador: Juan De Sousa
Programador: Juan De Sousa
Fecha:10-1-16
Descripción:  
	Este es el javascript del módulo periodo, encargado de todas las 
	llamadas AJAX, objetos DOM y validaciones de dicho módulo. 

 * * * * * * * * Cambios/Mejoras/Correcciones/Revisiones * * * * * * * *
Diseñador - Programador /   Fecha   / Descripción del cambio
   

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/

/*
 * Función general para obtenerPeriodo(s)
 * 
 * Hace una llamada ajax al módulo periodo con la acción listarPeriodo.
 * 
 * Recibe como parámetros:
 * 
 * 		codigo 				código del periodo a listar (puede ser null para listarlos todos)
 * 		funSucc				Función que se realizará en el success del ajax
 * 		funErr				Función que se realizará en el error del ajax
 */

function obtenerPeriodos(codigo, funSucc, funErr){
	var arr = Array(	"modulo"	,	"periodo",
						"accion"	,	"listarPeriodo",
						"codPeriodo",	codigo);
	
	ajaxMVC(arr, funSucc, funErr);
}

/*
 * Función general para agregar un periodo.
 * 
 * Hace una llamada ajax al módulo periodo con la acción agregarPeriodo
 * 
 * Recibe como parámetros:
 * 		arr					Arreglo con la información del periodo a agregar
 * 		funSucc				Función que se realizará en el success del ajax
 * 		funErr				FUnción que se realizará en el error del ajax
 */

function agregarPeriodo(arr, funSucc, funErr){
	arr['m_modulo'] = 'periodo';
	arr['m_accion'] = 'agregarPeriodo';
	
	ajaxMVC(arr, funSucc, funErr);
}

/*
 * Función general para modificar un periodo.
 * 
 * Hace una llamada ajax al módulo periodo con la acción modificarPeriodo.
 * 
 * Recibe como parámetros:
 * 		arr					Arreglo con la información del periodo a modificar
 * 		funSucc				Función que se realizará en el success del ajax
 * 		funErr				FUnción que se realizará en el error del ajax
 */


function modificarPeriodo(arr, funSucc, funErr){
	arr['m_modulo'] = 'periodo';
	arr['m_accion'] = 'agregarPeriodo';
	
	ajaxMVC(arr, funSucc, funErr);
}

/*
 * Función general para eliminar un periodo
 * 
 * Hace una llamada ajax al módulo curso con la acción eliminarPeriodo.
 * 
 * Recibe como parámetros:
 * 
 * 		codigo 				código del periodo a eliminar
 * 		funSucc				Función que se realizará en el success del ajax
 * 		funErr				Función que se realizará en el error del ajax
 */

function eliminarPeriodo(codigo, funSucc, funErr){
	var arr = Array(	"modulo"	,	"periodo",
						"accion"	,	"eliminarPeriodo",
						"codPeriodo",	codigo);
	
	ajaxMVC(arr, funSucc, funErr);
}
