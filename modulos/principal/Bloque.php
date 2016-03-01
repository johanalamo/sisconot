<?php

if($modulo == 'curso'){
	require_once 'modulos/curso/CursoControlador.php';
	CursoControlador::manejarRequerimiento();
}
else if($modulo == 'empleado'){
	require_once 'modulos/empleado/EmpleadoControlador.php';
	EmpleadoControlador::manejarRequerimiento();
}
else if($modulo == 'error'){
	require_once 'modulos/error/ErrorControlador.php';
	ErrorControlador::manejarRequerimiento();
}
else if($modulo == 'estudiante'){
	require_once 'modulos/estudiante/EstudianteControlador.php';
	EstudianteControlador::manejarRequerimiento();
}
else if($modulo == 'instituto'){
	require_once 'modulos/instituto/InstitutoControlador.php';
	InstitutoControlador::manejarRequerimiento();
}
else if($modulo == 'login'){
	require_once 'modulos/login/LoginControlador.php';
	LoginControlador::manejarRequerimiento();
}
else if($modulo == 'pensum'){
	require_once 'modulos/pensum/PensumControlador.php';
	PensumControlador::manejarRequerimiento();
}
else if($modulo == 'periodo'){
	require_once 'modulos/periodo/PeriodoControlador.php';
	PeriodoControlador::manejarRequerimiento();
}
else if($modulo == 'persona'){
	require_once 'modulos/persona/PersonaControlador.php';
	PersonaControlador::manejarRequerimiento();
}
else if($modulo == 'prelacion'){
	require_once 'modulos/prelacion/PrelacionControlador.php';
	PrelacionControlador::manejarRequerimiento();
}
else if($modulo == 'principal'){
	require_once 'modulos/principal/PrincipalControlador.php';
	PrincipalControlador::manejarRequerimiento();
}
else if($modulo == 'trayecto'){
	require_once 'modulos/trayecto/TrayectoControlador.php';
	TrayectoControlador::manejarRequerimiento();
}
else if($modulo == 'unidad'){
	require_once 'modulos/unidad/UnidadCurricularControlador.php';
	UnidadControlador::manejarRequerimiento();
}
else if($modulo == 'usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMO'){
	require_once 'modulos/usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMO/Usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMOControlador.php';
	Usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMOControlador::manejarRequerimiento();
}
else
	throw new Exception ('(PrincipalControlador) Módulo inválido: $modulo')
?>
