
/*
 * * * * * * * * * * LICENCIA * * * * * * * * * * * * * * * * * * * * *

Copyright(C) 2015
pensum Universtiario de Tecnología Dr. Federico Rivero Palacio

Este programa es Software Libre y usted puede redistribuirlo y/o modificarlo
bajo los términos de la versión 3.0 de la Licencia Pública General (GPLv3)
publicada por la Free Software Foundation (FSF), es distribuido sin ninguna
garantía. Usted debe haber recibido una copia de la GPLv3 junto con este
programa, sino, puede encontrarlo en la página web de la FSF, 
específicamente en la dirección http://www.gnu.org/licenses/gpl-3.0.html

 * * * * * * * * * * ARCHIVO * * * * * * * * * * * * * * * * * * * * *

Nombre: persona.js
Diseñador:Jean Pierre Sosa.
Programador:Jean Pierre Sosa.
Fecha:10-1-16
Descripción:  
	Este es el javascript del módulo error, encargado de todas las 
	llamadas AJAX, objetos DOM y validaciones de dicho módulo. 

 * * * * * * * * Cambios/Mejoras/Correcciones/Revisiones * * * * * * * *
Diseñador - Programador /   Fecha   / Descripción del cambio
   

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/



$(document).ready(function() {


	$('div.infoPersona').fadeIn(700);
    $('div.estudiantes').hide();				
	$('div.empleados').hide();

	
});

$(function()
{	
	$("a.infoPersona").click(function()
	{				
		$('div.infoPersona').fadeIn(700);
	    $('div.estudiantes').hide();				
		$('div.empleados').hide();
						
	});

	$("a.estudiantes").click(function()
	{				
		$('div.estudiantes').fadeIn(700);
	    $('div.infoPersona').hide();				
		$('div.empleados').hide();
						
	});

	$("a.empleados").click(function()
	{				
		$('div.empleados').fadeIn(700);				
		$('div.estudiantes').hide();	
		$('div.infoPersona').hide();						
	});
});

$(document).ready(function() {
	verInstituto();
	verPNF();
	verEstado();
	verPersona();
	tabsBloqueados();
	removerEsEm();
	mostrarInformaion();
	//bloquearCampos();

} );

function getVarsUrl(){
    var url= location.search.replace("?", "");
    var arrUrl = url.split("&");
    var urlObj={};   
    for(var i=0; i<arrUrl.length; i++){
        var x= arrUrl[i].split("=");
        urlObj[x[0]]=x[1]
    }
    return urlObj;
}


function nuevoPersonaEstudiante (){	
	window.location.href = 'index.php?m_modulo=persona&m_vista=Principal&m_formato=html5'; 
}

function nuevoPersonaEmpleado (){	
	window.location.href = 'index.php?m_modulo=persona&m_vista=Agregar&m_formato=html5'; 
}
function foto(data){

	$("#foto").on("change", function(){

	    /* Limpiar vista previa */

	    $("#vista-previa").html('');

	    var archivos = document.getElementById('foto').files;

	    var navegador = window.URL || window.webkitURL;

	    /* Recorrer los archivos */
	    $("#imagen").remove();
	    for(x=0; x<archivos.length; x++)
	    {   	
	   		var objeto_url = navegador.createObjectURL(archivos[x]);
		}
		var cadena ="";
		cadena+="<div id='imagen'>";
		cadena+="<img src="+objeto_url+" width='200' height='200'>";
		cadena+="</div>";
		
		$("#superImagen").append(cadena);

	});
	
}
/**
* Funcion Java Script que permite listar Todos los institutos
* para que luego sea mostado en un select. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarSelectInstituto().
*/
function verInstituto(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()
					);
		
	ajaxMVC(arr,montarSelectInstituto,error);
}

/**
* Funcion Java Script que permite mostrar un select con
* los institutos y es concatenado a un  div en la vista HTML
*/

function montarSelectInstituto(data){
	var cadena = "";

	$("#selectIns").remove();	

	cadena+="<div id='selectIns'> institutos ";
	if(data.tipo_persona=='estudiante')
		cadena += "<select onchange='verPersonaEstudiante();' class='selectpicker' id='selectInstituto' title='institutos' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	else if(data.tipo_persona=='empleado')
		cadena += "<select onchange='verPersonaEmpleado();' class='selectpicker' id='selectInstituto' title='institutos' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	else
		cadena += "<select onchange='verPersona(); verPNF();' class='selectpicker' id='selectInstituto' title='institutos' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar' >Seleccionar</option>";
	for(var x=0; x<data.instituto.length;x++)
	{
	 	if(data.instituto[x]['codigo']!=11)
	 		cadena += '<option value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';
	 	/*else
	 		cadena += '<option selected="selected" value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';*/
	}
	cadena +="</select>";
	$(cadena).appendTo('#selectInstitutos');
	$(cadena).appendTo('.selectInstituto');
	activarSelect();	

}

/**
* Funcion Java Script que permite listar Todos los PNF
* para que luego sea mostado en un select. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarSelectPNF().
*/
function verPNF(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()								
					);
		
	ajaxMVC(arr,montarSelectPNF,error);
}


/**
* Funcion Java Script que permite mostrar un select con
* los PNF y es concatenado a un  div en la vista HTML
*/
function montarSelectPNF(data){

	var cadena = "";
	$("#selectPensuma").remove();	

	cadena+="<div id='selectPensuma'> Pensum ";
	if(data.tipo_persona=='estudiante')
		cadena += "<select onchange='verPersonaEstudiante();' class='selectpicker' id='selectPNF' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	else if(data.tipo_persona=='empleado')
		cadena += "<select onchange='verPersonaEmpleado();' class='selectpicker' id='selectPNF' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	else
		cadena += "<select onchange='verPersona();' class='selectpicker' id='selectPNF' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	if(data.pnf){
		for(var x=0; x<data.pnf.length;x++)
		{	
			cadena += '<option value="'+data.pnf[x]["codigo"]+'">'+data.pnf[x][1]+'</option>';
		}
	}
	
	cadena +="</select>";

	$(cadena).appendTo('.selectPensum');
	activarSelect();					
}

/**
* Funcion Java Script que permite listar Todos los estados que posee un actor
* para que luego sea mostado en un select. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion mmontarSelectEstado().
*/

function verEstado(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()				
					);		
	ajaxMVC(arr,montarSelectEstado,error);
}

/**
* Funcion Java Script que permite mostrar un select con
* los estados y es concatenado a un  div en la vista HTML
*/
function montarSelectEstado(data){

	var cadena = "";
	$("#selectEstados").remove();$("#selectEstados").remove();	
	cadena+="<div id='selectEstados'> Estado ";
	if(data.tipo_persona=='estudiante')
		cadena += "<select onchange='verPersonaEstudiante();' name='selectEstado' id='selectEstado' class='selectpicker'  title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	else if(data.tipo_persona=='empleado')
		cadena += "<select onchange='verPersonaEmpleado();' name='selectEstado' class='selectpicker' id='selectEstado' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	else
		cadena += "<select onchange='verPersona();' name='selectEstado' class='selectpicker' id='selectEstado' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.estado.length;x++)
	{
		cadena += '<option value="'+data.estado[x]["codigo"]+'">'+data.estado[x]["nombre"]+'</option>';
	}
	cadena +="</select></div>";

	$(cadena).appendTo('.selectEstado');
	activarSelect();	
				
}

/**
* Funcion Java Script que permite listar Todas las personas
* para que luego sean mostradas. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarPersona().
*/
function verPersona(){
	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()
					);
		
	ajaxMVC(arr,montarPersona,error);
}

function buscarPorCampo(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"campo"		,	$("#campo").val()
					);
	ajaxMVC(arr,montarPersona,error);
}

function guardarFoto(){
	//var data = new FormData();

}

function succFoto(data){
//	alert("foto");
}

/**
* Funcion Java Script que permite listar Todos los empleado
* para que luego sean mostradas. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarPersona().
*/
function verPersonaEmpleado(){
	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"tipo_persona",	"empleado"
					);
		
	ajaxMVC(arr,montarPersona,error);
}



/**
* Funcion Java Script que permite listar Todos los estudiantes
* para que luego sean mostradas. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarPersona().
*/
function verPersonaEstudiante(){
	var arr = Array("m_modulo"	,	"estudiante",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"tipo_persona",	"estudiante"
					);
	
	ajaxMVC(arr,montarPersona,error);
}

/**
* Funcion Java Script que permite mostrar una tabla con
* las personas y es concatenado a una tabla en la vista HTML
*/
function montarPersona(data){	
	
	cadena="";
	cadena+='<tbody id="listarPersona">';

	if(data.persona!=null){
		for(var x=0; x<data.persona.length; x++)
		{
			if(data.persona[x]['apellido2']!=null)
				var nombre=data.persona[x]['apellido2'];
			else
				var nombre="";

			if(data.persona[x]['nombre2']!=null)
				var apellido=data.persona[x]['nombre2'];
			else
				var apellido="";
			cadena+="<tr>";
			cadena+="<td><input id='cod_persona' type='radio' name='cod_persona' value='"+data.persona[x]['cod_persona']+"'>"+data.persona[x]['cod_persona']+"</td>";
			cadena+="<td>"+data.persona[x]['cedula']+"</td>";
			cadena+="<td>"+data.persona[x]['apellido1']+" "+nombre+"</td>";
			cadena+="<td>"+data.persona[x]['nombre1']+" "+apellido+"</td>";
			cadena+="<td>"+data.persona[x]['cor_personal']+"</td>";
			cadena+="</tr>";
		}
	}
	cadena+="</tbody>";

	$("#listarPersona").remove();
	$(cadena).appendTo('#primeraTabla');

}

/**
* Funcion Java Script que permite modificar la informacion
* de una persona de la base de datos. Los Datos son enviados
* por ajax.
*//*
function modificarPersonas(){
	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"modificar",
					"codPersona", $('input:radio[name=cod_persona]:checked').val()
					);	

		ajaxMVC(arr,succMontarModificarPerson,error);

}

function succMontarModificarPerson(data)
{
	alert("lol");
	/*if(data.estatus>0)
		montarModificarPersona(data);
	else
		mostrarMensaje(data.mensaje,4);
}

function montarModificarPersona(data){

	alert("hola");
	//document.location.href = "index.php?m_modulo=persona&m_formato=html5&m_accion=listar&m_vista=Agregar";
	
}
*/
/**
* Funcion Java Script que permite guardar los datos de a una persona
* para que luego sean guaradosde la base de datos. Los Datos son enviados
* por ajax.
*/

function guardarPersona(){

//	var data = new FormData();
	var a="archivo";
	var b="";
	jQuery.each(jQuery('#foto')[0].files, function(i, file) {
	   // data.append('file-'+i, file);
	   a='archivo';
	   b=file;
	});
	
	var arr= Array( "m_modulo"	,	"persona",
					"m_accion"	,	"agregar",
					"m_modulo"	,	"persona",
					"m_accion"	,	"agregar",
					"cedPersona",	$("#ced_persona").val(),
					"rifPersona",	$("#rif_persona").val(),
					"nombre1"	,	$("#nombre1").val(),
					"nombre2"	,	$("#nombre2").val(),
					"apellido1"	,	$("#apellido1").val(),
					"apellido2"	,	$("#apellido2").val(),
					"telefono1"	,	$("#telefono1").val(),
					"telefono2"	,	$("#telefono2").val(),
					"corPersonal"	,	$("#cor_personal").val(),
					"corInstitucional"	,	$("#cor_institucional").val(),
					"discapacidad"	,	$("#discapacidad").val(),
					"direccion"	,	$("#direccion").val(),
					"obsPersona"	,	$("#obs_persona").val(),
					"sexo"		,	$('#sexo').val(),
					"tipSangre" ,	$('#tip_sangre').val(),
					"hijo"		,	$('#hijo').val(),
					"estCivil"	,	$('#est_civil').val(),
					"nacionalidad",	$('#nacionalidad').val(),
					"fecNacimiento",$('#fec_nac').val(),
					"codigo",		$('#cod_persona').val(),
					"estado",		$('#estado').val(),
					a 		,		b
				);
					
	ajaxMVC(arr,succAgregarPersona,error);
	//ajaxMVC(arr,succAgregarPersona,error);
}

/**
* Funcion Java Script que permite listar a una persona en el HTML para
* que lugo se modifique su informacionde la base de datos. Los Datos son enviados
* por ajax.
*/
function modificarPersona(){
	var codigo=null;
	if(getVarsUrl().persona)
		codigo=getVarsUrl().persona;
	else
		codigo=$('input:radio[name=cod_persona]:checked').val();

	window.location.href = 'index.php?m_modulo=persona&m_vista=Principal&m_formato=html5&persona='+codigo+'&accion=M';
}

function mostrarPersona(){

	var codigo=null;
	if(getVarsUrl().persona)
		codigo=getVarsUrl().persona;
	else
		codigo=$('input:radio[name=cod_persona]:checked').val();
	
	window.location.href = 'index.php?m_modulo=persona&m_vista=Principal&m_formato=html5&persona='+codigo+'&accion=V';
}

function bloquearCampos(ver=null){	
		
	bloquearCamposEstudiante();
			
		
}




function mostrarInformaion(){
	if(getVarsUrl().persona){
		var arr = Array("m_modulo"	,"persona",
					"m_accion"	,	"modificar",					
					"codPersona",  getVarsUrl().persona								
					);

		if(getVarsUrl().accion=='M'){			
			$("#editar_estudiante").remove();
			$("#editar_empleado").remove();

		}
		else if(getVarsUrl().accion=='V'){
			$("#md_estudiante").remove();
			$("#md_empleado").remove();
			$("#borrar_estudiante").remove();
			$("#borrar_empleado").remove();
		}
		else {
			$("#md_estudiante").remove();
			$("#md_empleado").remove();
			$("#borrar_estudiante").remove();
			$("#borrar_empleado").remove();
			$("#editar_estudiante").remove();
			$("#editar_empleado").remove();
			$("#nuevo_estudiante").remove();
			$("#nuevo_empleado").remove();
			$("#nv_empleado").remove();
			$("#nv_estudiante").remove();
		}

		ajaxMVC(arr,succMontarModificarPersona,error);
	}
	
	
}

function mostrarInformaion2(){
	if(getVarsUrl().persona){
		var arr = Array("m_modulo"	,"persona",
					"m_accion"	,	"modificar",					
					"codPersona",  getVarsUrl().persona								
					);		

		ajaxMVC(arr,succMontarModificarPersona2,error);
	}
	
	
}

function succMontarModificarPersona2(data){
	setTimeout(function(){ succMontarModificarEmpleado(data); }, 300);
}
/**
 * esta funcion JavaScript permite signar los datos obtenido en la
 * consuta  la base de datos y colocarlos en la vista HTML
 * de esta manera el usuario podra modificar los datos de la persona
 */
/*
function succMontarModificarPersona (data){
	console.log(data);
	window.location.href = 'index.php?m_modulo=persona&m_vista=Agregar&m_formato=html5&persona='+data.persona[0]['cod_persona'];
		
	//ajaxMVC(arr,succMontarModificarPersona2,error);
	
}*/


function succMontarModificarPersona(data){
	
	verEstadoEs();
	tabsActivos(); 
	//$("#estudiante").show();
		
	$("#ced_persona").val(data.persona[0]['cedula']);
	$("#rif_persona").val(data.persona[0]['rif']);
	$("#nombre1").val(data.persona[0]['nombre1']);
	$("#nombre2").val(data.persona[0]['nombre2']);
	$("#apellido1").val(data.persona[0]['apellido1']);
	$("#apellido2").val(data.persona[0]['apellido2']);
	$("#telefono1").val(data.persona[0]['telefono1']);
	$("#telefono2").val(data.persona[0]['telefono2']);
	$("#cor_personal").val(data.persona[0]['cor_personal']);
	$("#cor_institucional").val(data.persona[0]['cor_institucional']);
	$("#discapacidad").val(data.persona[0]['discapacidad']);
	$("#direccion").val(data.persona[0]['direccion']);
	$("#obs_persona").val(data.persona[0]['observaciones']);
	$('#sexo').val(data.persona[0]['sexo']);
	$('#tip_sangre').val(data.persona[0]['tip_sangre']);
	$('#hijo').val(data.persona[0]['hijos']);
	$('#est_civil').val(data.persona[0]['est_civil']);
	$('#nacionalidad').val(data.persona[0]['nacionalidad']);
	$('#fecNacimiento').val(data.persona[0]['fec_nacimiento']);
	$('#cod_persona').val(data.persona[0]['codigo']);
	$('#codigoPersona').val(data.persona[0]['codigo']);
	if(data.foto){
		$("#imagen").remove();
		var cadena ="";
		cadena+="<div id='imagen'>";
		cadena+="<img src="+data.foto+" width='200' height='200'>";
		cadena+="</div>";
		
		$("#superImagen").append(cadena);
	}
	if(data.empleado)
		setTimeout(function(){ succMontarModificarEmpleado(data); }, 400);
	if(data.estudiante)
		setTimeout(function(){ succMontarModificarEstudiante(data); }, 400);
	
		 
				


	

}

/**
* Funcion Java Script que permite borrar a una persona
* de la base de datos. Los Datos son enviados
* por ajax.
*/
function borrarPersona(){ //activoo controlador.

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"eliminar",
					"cod_persona",  $("#cod_persona").val()									
					);
		
	ajaxMVC(arr,succMontarEliminarPersona,error);

}

function succMontarEliminarPersona (data){

	if(data.estatus>0)
		montarEliminarPersona(data);
	else
		mostrarMensaje(data.mensaje,4);

}

function montarEliminarPersona(data){

	
}

function fecActual(){
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = dd+'/'+mm+'/'+yyyy;
	return today;
}

function succAgregarPersona(data){
	//aqui se agrega el codigo de persona en el hiden
	console.log(data);
alert(data.mensaje);
	//alert(data.codPersona);

	if(data.estatus>0)
		mostrarMensaje(data.mensaje, 1);
	else
		mostrarMensaje(data.mensaje, 2);

	$('#cod_persona').val(data.codPersona);
	$('#codigoPersona').val(data.codPersona);
	if(data.codPersona){
		tabsActivos(); 
		//AgregarEsEm();
		//$('div.estudiante').fadeIn(700);				
		$('div.empleado').hide();
		$('#fec_ini_estudiante').val(fecActual());
		
		if(data.foto){
			alert(data.foto);
			$("#imagen").remove();
			var cadena ="";
			cadena+="<div id='imagen'>";
			cadena+="<img src="+data.foto+" width='200' height='200'>";
			cadena+="</div>";
			
			$("#superImagen").append(cadena);
		}

	}

}


function tabsBloqueados(){
	/*var cadena="";
		cadena+='<div id="tab">';
		cadena+='<ul class="uk-tab" data-uk-tab>';
		cadena+='<li class="uk-disabled"><a class="estudiante" onclick="verEstadoEs();">Estudiante</a></li>';
		cadena+='<li class="uk-disabled"><a class="empleado" onclick="verEstadoEm();">Empleado</a></li>';			    
		cadena+='<li class="uk-disabled"><a  >Bloqueado</a></li>';
		cadena+='</ul>';
		cadena+='</div>';
	$("#tab").remove();
	$(cadena).appendTo('#tabs');*/
	$("#tabsBloqueado").hide();
	$("#tabsActivo").hide();
	


}

function tabsActivos(){
	/*var cadena="";
	alert($("#cod_persona").val());
	if($("#cod_persona").val()){
		
		cadena+='<div id="tab">';
		cadena+='<ul class="uk-tab" data-uk-tab>';
		cadena+='<li class="uk-active"><a href="" class="estudiante" onclick="verEstadoEs();">Estudiante</a></li>';
		cadena+='<li><a href="" class="empleado" onclick="verEstadoEm();">Empleado</a></li>';			    
		cadena+='<li class="uk-disabled"><a  >Bloqueado</a></li>';
		cadena+='</ul>';
		cadena+='</div>';
		$("#tab").remove();
		$(cadena).appendTo('#tabs');

	}
	else{
		tabsBloqueados();
	}*/
	$("#tabsBloqueado").hide();
	$("#tabsActivo").show();
}
/*
function AgregarEsEm(){
	
	if($("#cod_persona").val()){
		
		$("#estudiante").show();
		$("#empleado").show();
		//$('.estudiante_empleado_agregar').load('modulos/persona/vista/html5/js/EstudianteEmpleadoTabs.html');

	}
	else{
		removerEsEm();
		tabsBloqueados()
	}
}
*/
function removerEsEm(){
	
	$("#estudiante").hide();
	$("#empleado").hide();
	
}

function exportarPDF(data){
	console.log(data);
	var arr = Array("m_modulo"	,"persona",
					"m_accion"	,	"modificar",					
					"codPersona",  getVarsUrl().persona								
					);


}

/**
* Funcion Java Script que permite mostrar un mensaje de error.
*/
function error(data){	
	console.log(data);
	mostrarMensaje("Error de comunicación con el servidor.",2);
}