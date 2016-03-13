<?php
/**
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

Nombre: CursoControlador.php
Diseñador: Juan De Sousa (juanmdsousa@gmail.com)
Programador: Juan De Sousa
Fecha: Diciembre de 2015
Descripción:
	Controlador del módulo curso, encargado de procesar todas las peticiones del módulo.

 * * * * * * * * Cambios/Mejoras/Correcciones/Revisiones * * * * * * * *
---                         ----      ---------

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/

	require_once("modulos/curso/modelo/CursoServicio.php");

	class CursoControlador{

		/*
		 * Método manejarRequerimiento de CursoControlador.
		 *
		 * Se encarga de manejar la petición e invocar a la función pertinente a la misma.
		 *
		 * Obtiene la acción de la vista y llama a la función pertinente dentro
		 * del controlador.
		 */

		public static function manejarRequerimiento(){
			try{

				$accion = PostGet::obtenerPostGet("m_accion");

				if($accion == NULL)
					$accion = "mostrar";

				if($accion == "listarCursos")
					self::listarCursos();
				else if($accion == "mostrar")
					self::mostrarVista();
				else if($accion == "agregarCurso")
					self::agregarCurso();
				else if($accion == "modificarCurso")
					self::modificarCurso();
				else if($accion == "buscarSeccionPorTrayecto")
					self::buscarSeccionPorTrayecto();
				else if($accion == "listarUniCurricular")
					self::listarUniCurricular();
				else if($accion == "obtenerCursosPensum")
					self::obtenerCursosPensum();
				else if($accion == "obtenerDatosDeCurso")
					self::obtenerDatosDeCurso();
				else if($accion == "obtenerEstusEstudiante")
					self::obtenerEstusEstudiante();
				else if($accion == "retirarEstudiante")
					self::retirarEstudiante();
				else if($accion == "eliminarEstudiante")
					self::eliminarEstudiante();
				else if($accion == "obtenerCursosPorEstudiante")
					self::obtenerCursosPorEstudiante();
				else if($accion == "modificarCurEst")
					self::modificarCurEst();
				else if($accion == "retirarCurEstudiante")
					self::retirarCurEstudiante();
				else if($accion == "obtenerCursosDisponiblesParaInscripcionPorEstudiante")
					self::obtenerCursosDisponiblesParaInscripcionPorEstudiante();
				else if($accion == "agregarCurEst")
					self::agregarCurEst();
				else if($accion == "generarTicketInscripcion")
					self::generarTicketInscripcion();
				else
					throw new Exception ("No se pudo resolver la acción $accion");
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Método listarCursos de CursoControlador.
		 *
		 * Recibe de la vista un código de curso a listar.
		 * De estar en null, invoca al método listarCursos (para listarlos todos)
		 * De no ser así, lista el curso perteneciente al código.
		 *
		 * Asigna "cursos" (resultado de la lista) y muestra la vista.
		 */

		public static function listarCursos(){
			try{
				$codigo = PostGet::obtenerPostGet("codigo");
				$codIns = PostGet::obtenerPostGet("codInstituto");
				$codPen = PostGet::obtenerPostGet("codPensum");
				$codPer = PostGet::obtenerPostGet("codPeriodo");
				$patron = PostGet::obtenerPostGet("patron");

				//if($codigo == NULL)
					$r = CursoServicio::listarCursos($codIns,$codPen,$codPer,$patron);
				// else
				// 	$r = CursoServicio::obtenerCursoPorCodigo($codigo);

				Vista::asignarDato("cursos",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Método agregarCurso de CursoControlador.
		 *
		 * Obtiene los datos de un curso a agregar de la vista.
		 * Invoca al servicio con los datos y asigna el resultado a la vista;
		 * luego la muestra.
		 *
		 */

		public static function agregarCurso(){
			try{
				$codPeriodo = PostGet::obtenerPostGet("codPeriodo");
				$codUniCurricular = PostGet::obtenerPostGet("codUniCurricular");
				$codDocente = PostGet::obtenerPostGet("codDocente");
				$seccion = PostGet::obtenerPostGet("seccion");
				$fecInicio = PostGet::obtenerPostGet("fecInicio");
				$fecFinal = PostGet::obtenerPostGet("fecFinal");
				$capacidad = PostGet::obtenerPostGet("capacidad");
				$observaciones = PostGet::obtenerPostGet("observaciones");

				if($codDocente == '')
					$codDocente = NULL;

				if($fecInicio == '')
					$fecInicio = NULL;

				if($fecFinal == '')
					$fecFinal = NULL;

				$r = CursoServicio::insertarCurso($codPeriodo, $codUniCurricular, $codDocente, $seccion, $fecInicio, $fecFinal, $capacidad, $observaciones);


				Vista::asignarDato("codCurso",$r);


				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Método modificarCurso de CursoControlador.
		 *
		 * Obtiene los datos de un curso a modificar desde la vista.
		 * Luego invoca al método modificar del servicio y le pasa los parámetros.
		 *
		 * Muestra la vista.
		 */

		public static function modificarCurso(){
			try{
				$codigo = PostGet::obtenerPostGet("codCurso");
				$codPeriodo = PostGet::obtenerPostGet("codPeriodo");
				$codUniCurricular = PostGet::obtenerPostGet("codUniCurricular");
				$codDocente = PostGet::obtenerPostGet("codDocente");
				$seccion = PostGet::obtenerPostGet("seccion");
				$fecInicio = PostGet::obtenerPostGet("fecInicio");
				$fecFinal = PostGet::obtenerPostGet("fecFinal");
				$capacidad = PostGet::obtenerPostGet("capacidad");
				$observaciones = PostGet::obtenerPostGet("observaciones");

				if($codDocente == '')
					$codDocente = NULL;

				if($fecInicio == '')
					$fecInicio = NULL;

				if($fecFinal == '')
					$fecFinal = NULL;

				$r = CursoServicio::modificarCurso($codigo,$codPeriodo, $codUniCurricular, $codDocente, $seccion, $fecInicio, $fecFinal, $capacidad, $observaciones);


				Vista::asignarDato("mensaje","El curso con código $codigo se ha modificado exitosamente.");


				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Método eliminarCurso de CursoControlador
		 *
		 * Obtiene un código del curso desde la vista e invoca al método eliminar
		 * curso del servicio.
		 *
		 * Luego muestra la vista.
		 */

		public static function eliminarCurso(){
			try{
				$codigo = PostGet::obtenerPostGet("codCurso");

				CursoServicio::eliminarCurso($codigo);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * CUR_ESTUDIANTE
		 */


		/*
		 * Método listarCurEst de CursoControlador.
		 *
		 * Recibe de la vista un código de curso-estudiante a listar.
		 * De estar en null, invoca al método listarCurEst (para listarlos todos)
		 * De no ser así, lista el cur-estudiante perteneciente al código
		 *
		 * Asigna "curEst" (resultado de la lista) y muestra la vista.
		 */

		public static function listarCurEst(){
			try{
				$codigo = PostGet::obtenerPostGet("codCurEst");

				if($codigo == NULL)
					$r = CursoServicio::obtenerCurEst();
				else
					$r = CursoServicio::obtenerCurEstPorCodigo($codigo);

				Vista::asignarDato("curEst",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Método agregarCurEst de CursoControlador.
		 *
		 * Obtiene los datos de un curso-estudiante a agregar.
		 * Se los pasa como parámetro a la función agregarEst del servicio.
		 *
		 * Asigna codCurEst a la vista (resultado de agregar curEstudiante)
		 * Luego la muestra.
		 *
		 */

		public static function agregarCurEst(){
			try{
				$codEstudiante = PostGet::obtenerPostGet("codEstudiante");
				$codCurso = PostGet::obtenerPostGet("codCurso");
				$porAsistencia = PostGet::obtenerPostGet("porAsistencia");
				$nota = PostGet::obtenerPostGet("nota");
				$codEstado = PostGet::obtenerPostGet("codEstado");
				$observaciones = PostGet::obtenerPostGet("observaciones");

				//~ var_dump($_POST);

				$r = CursoServicio::insertarCurEst($codEstudiante, $codCurso, $porAsistencia, $nota, $codEstado, $observaciones);

				if($r == 0){
					Vista::asignarDato("mensaje","El estudiante se encontraba retirado en el curso. Se realizó la inscripción colocando como 'Cursando' al mismo.");
				}
				else{
					Vista::asignarDato("codCurEst",$r);
					Vista::asignarDato("codigo",$codCurso);

					Vista::asignarDato("mensaje","El estudiante se ha inscrito exitosamente en el curso $codCurso");
				}
				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Método modificarCurEst de CursoControlador.
		 *
		 * Obtiene los datos de un curso-estudiante a modificar.
		 * Se los pasa como parámetro a la función modificarEst del servicio.
		 *
		 * Luego muestra la vista.
		 */

		public static function modificarCurEst(){
			try{
				$codigo = PostGet::obtenerPostGet("codCurEst");
				$codEstudiante = PostGet::obtenerPostGet("codEstudiante");
				$codCurso = PostGet::obtenerPostGet("codCurso");
				$porAsistencia = PostGet::obtenerPostGet("porAsistencia");
				$nota = PostGet::obtenerPostGet("nota");
				$codEstado = PostGet::obtenerPostGet("codEstado");
				$observaciones = PostGet::obtenerPostGet("observaciones");

				CursoServicio::modificarCurEst($codigo, $codEstudiante, $codCurso, $porAsistencia, $nota, $codEstado, $observaciones);

				Vista::asignarDato("nombre",PostGet::obtenerPostGet("nombre"));

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Método eliminarCurEst de CursoControlador.
		 *
		 * Obtiene un código de curEstudiante, se lo pasa como parámetro
		 * al método eliminarCurEst de CursoServicio y muestra la vista.
		 */

		public static function eliminarCurEst(){
			try{
				$codigo = PostGet::obtenerPostGet("codCurEst");

				CursoServicio::eliminarCurEst($codigo);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Función estática que invoca al método mostrar de la clase Vista
		 * para ir a una vista parametrizable.
		 *
		 */

		public static function mostrarVista(){
			try{
				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function retirarCurEstudiante(){
			try{
				$codigo = PostGet::obtenerPostGet("codigo");

				$r = CursoServicio::retirarCurEstudiante($codigo);

				if($r != 0)
					Vista::asignarDato("mensaje","Se retiró la Unidad Curricular con éxito");

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function obtenerDatosDeCurso(){
			try{
				$codigo = PostGet::obtenerPostGet("codigo");

				$r = CursoServicio::obtenerDatosDeCurso($codigo);

				Vista::asignarDato("cursoInfoMontar",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function buscarSeccionPorTrayecto(){
			try{
				$cod = PostGet::obtenerPostGet("codTrayecto");

				$r = CursoServicio::listarSeccionPorTrayecto($cod);

				Vista::asignarDato("secciones",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function listarUniCurricular(){
			try{
				$seccion = PostGet::obtenerPostGet("seccion");
				$pensum = PostGet::obtenerPostGet("pensum");
				$trayecto = PostGet::obtenerPostGet("trayecto");
				$periodo = PostGet::obtenerPostGet("periodo");

				$r = CursoServicio::listarUniCurricular($seccion,$pensum,$trayecto,$periodo);

				Vista::asignarDato("uni",$r);
				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function obtenerCursosPensum(){
			try{
				$seccion = PostGet::obtenerPostGet("seccion");
				$trayecto = PostGet::obtenerPostGet("trayecto");
				$periodo = PostGet::obtenerPostGet("periodo");

				$r = CursoServicio::obtenerCursosPensum($seccion,$trayecto,$periodo);

				Vista::asignarDato("cursos",$r);
				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function obtenerEstusEstudiante(){
			try{
				$r = CursoServicio::obtenerEstusEstudiante();

				Vista::asignarDato("estados",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function retirarEstudiante(){
			try{
				$codEstudiante = PostGet::obtenerPostGet("codEstudiante");
				$codCurso = PostGet::obtenerPostGet("codCurso");

				CursoServicio::retirarEstudiante($codEstudiante,$codCurso);

				Vista::asignarDato("mensaje","Se ha retirado el estudiante con éxito.");

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function eliminarEstudiante(){
			try{
				$codEstudiante = PostGet::obtenerPostGet("codEstudiante");
				$codCurso = PostGet::obtenerPostGet("codCurso");

				CursoServicio::eliminarEstudiante($codEstudiante,$codCurso);

				Vista::asignarDato("mensaje","Se ha retirado el estudiante con éxito.");

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function obtenerCursosPorEstudiante(){
			try{
				$codigo = PostGet::obtenerPostGet("codigo");

				$r = CursoServicio::obtenerCursosPorEstudiante($codigo);

				Vista::asignarDato("cursos",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		/*
		 * Función pública y estática que sirve para conocer los cursos
		 * que puede inscribir un estudiante.
		 *
		 * Para esto, se sigue el siguiente algoritmo:
		 *		1) Se buscan todos los códigos de las unidades curriculares que tiene
		 * que ver el estudiante en el pensum. (Devuelve un arreglo con los códigos de las
		 * unidades curriculares)
		 *  	2) Se obtienen todas las unidades curriculares que ha convalidado ese
		 * estudiante en el pensum. (Devuelve un arreglo con los códigos de las
		 * unidades curriculares)
		 *  	3) Se obtienen todas las unidades curriculares que el estudiante
		 * ha aprobado en el pensum. (Devuelve un arreglo con los códigos de las
		 * unidades curriculares)
		 *  	4) Si hay unidades curriculares aprobadas, se restan de la lista de
		 * unidades curriculares disponibles para inscribir (función array_diff)
		 *  	5) Si hay unidades curriculares convalidadas, se restan de la lista
		 * de unidades curriculares disponibles para inscribir (función array_diff)
		 *  	6) Se obtienen las unidades curriculares preladas de ese pensum.
		 *  Se pasa como parámetro la lista de unidades curriculares y Devuelve
		 *  la lista de las unidades curriculares que deben removerse de las disponibles.
		 *  	7) Se obtienen los códigos de unidades curriculares donde el estudiante
		 * se encuentra como 'Cursando' en un curso que imparte la misma.
		 *  	8) Se obtienen los cursos que imparten las u de datsonidades curriculares disponibles
		 *  luego de las restricciones antes mencionadas.
		 * La fórmula general del algoritmo es:
		 *		$listaUniCur = (($listaUniCur - $aprobadas) - $convalidaciones)
		 *		$r (total) = (($listaUniCur - $preladas) - $cursando)
		 *
		 *	Para entender más el comportamiento de este procedimiento,
		 * revisar CursoServicio.php en las funciones que intervienen
		 * en el mismo.
		 */

		public static function obtenerCursosDisponiblesParaInscripcionPorEstudiante(){
			try{
				$estudiante = PostGet::obtenerPostGet("estudiante");
				$instituto = PostGet::obtenerPostGet("instituto");
				$pensum = PostGet::obtenerPostGet("pensum");
				$periodo = PostGet::obtenerPostGet("periodo");

				/* Unidades curriculares que tiene que ver en el pensum */
				$listaUniCur = CursoServicio::obtenerUnidadesCurricularesDelPensumPorEstudiante($estudiante);

				/* Unidades curriculares que ha convalidado */
				$convalidaciones = CursoServicio::obtenerUnidadesCurricularesConvalidadasPorEstudiante($estudiante,$pensum);

				//arreglo
				$aprobadas = CursoServicio::obtenerUnidadesCurricularesAprobadasPorEstudiante($estudiante,$pensum);

				if ($aprobadas != null)
					$listaUniCur = array_diff ($listaUniCur, $aprobadas);
				if ($convalidaciones != null)
					$listaUniCur = array_diff( $listaUniCur, $convalidaciones);

				//arreglo
				$preladas = CursoServicio::obtenerUnidadesCurricularesPreladasPorListaDeUnidadesCurriculares($listaUniCur,$pensum,$instituto);

				//arreglo
				$cursando = CursoServicio::obtenerCursosCursando($estudiante,$pensum);

				//arreglo
				$r = CursoServicio::obtenerCursosDisponiblesParaInscripcionPorEstudiante($estudiante, $aprobadas, $convalidaciones, $preladas, $cursando);

				Vista::asignarDato("cursos",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}

		public static function generarTicketInscripcion(){
			try{
				$estudiante = PostGet::obtenerPostGet("codEstudiante");
				$pensum = PostGet::obtenerPostGet("codPensum");
				$periodo = PostGet::obtenerPostGet("codPeriodo");

				$r = CursoServicio::obtenerTicketInscripcion($estudiante, $pensum, $periodo);

				Vista::asignarDato("ticket",$r);

				Vista::mostrar();
			}
			catch(Exception $e){
				throw $e;
			}
		}


	}
?>
