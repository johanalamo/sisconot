$(document).ready(function() {
    $('div.estudiante').fadeIn(700);				
	$('div.empleado').hide();
});

$(function()
{	
	$("a.estudiante").click(function()
	{				
		$('div.estudiante').fadeIn(700);				
		$('div.empleado').hide();							
	});

	$("a.empleado").click(function()
	{				
		$('div.empleado').fadeIn(700);				
		$('div.estudiante').hide();							
	});
});

$(document).ready(function() {
	verInstituto();
	verPNF();
	verEstado();
	verPersona();

} );

function nuevoPersonaEstudiante (){	
	window.location.href = 'index.php?m_modulo=persona&m_vista=Agregar&m_formato=html5'; 
}

function nuevoPersonaEmpleado (){	
	window.location.href = 'index.php?m_modulo=persona&m_vista=Agregar&m_formato=html5'; 
}


function verInstituto(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()
					);
		
	ajaxMVC(arr,montarSelectInstituto,error);
}

function montarSelectInstituto(data){
	var cadena = "";
	cadena += "<select onchange='verPersona();' class='selectpicker' id='selectInstituto' title='institutos' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.instituto.length;x++)
	{
	 	if(data.instituto[x]['codigo']!=11)
	 		cadena += '<option value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';
	 	else
	 		cadena += '<option selected="selected" value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectInstituto');
	activarSelect();					
}

function verPNF(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()									
					);
		
	ajaxMVC(arr,montarSelectPNF,error);
}

function montarSelectPNF(data){

	var cadena = "";
	cadena += "<select onchange='verPersona();' class='selectpicker' id='selectPNF' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.pnf.length;x++)
	{
		cadena += '<option value="'+data.pnf[x]["codigo"]+'">'+data.pnf[x]["nom_corto"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectPensum');
	activarSelect();					
}

function verEstado(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()					
					);		
	ajaxMVC(arr,montarSelectEstado,error);
}

function montarSelectEstado(data){

	var cadena = "";
	cadena += "<select onchange='verPersona();' class='selectpicker' id='selectEstado' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.estado.length;x++)
	{		
		cadena += '<option value="'+data.estado[x]["codigo"]+'">'+data.estado[x]["nombre"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectEstado');
	activarSelect();					
}

function verPersona(){
	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val()
					);
		
	ajaxMVC(arr,montarPersona,error);
}

function verPersonaEmpleado(){
	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"tipo_persona",	"empleado"
					);
		
	ajaxMVC(arr,montarPersona,error);
}

function verPersonaEstudiante(){
	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"tipo_persona",	"estudiante"
					);
		
	ajaxMVC(arr,montarPersona,error);
}
function montarPersona(data){
	
	
	cadena="";
	cadena+'<tbody id="listarPersona">';
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
		cadena+="<td><input id='cod_persona' type='radio' name='cod_persona' value='"+data.persona[x]['codigo']+"'>"+data.persona[x]['codigo']+"</td>";
		cadena+="<td>"+data.persona[x]['cedula']+"</td>";
		cadena+="<td>"+data.persona[x]['apellido1']+" "+nombre+"</td>";
		cadena+="<td>"+data.persona[x]['nombre1']+" "+apellido+"</td>";
		cadena+="<td>"+data.persona[x]['cor_personal']+"</td>";
	}
	cadena+"</tbody>";

	$("#listarPersona").remove();
	$(cadena).appendTo('#primeraTabla');	

}

function modificarPersona(){
	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"modificar",	
					"codPersona", $('input:radio[name=cod_persona]:checked').val());	

/*	if($('input:radio[name=cod_persona]:checked').val()==null)
		mostrarMensaje("Debe de seleccionar una persona.",2);
	else*/
		ajaxMVC(arr,montarModificarPersona,error);

}

function succMontarModificarPersona(data)
{

	if(data.estatus>0)
		montarModificarPersona(data);
	else
		mostrarMensaje(data.mensaje,4);
}

function montarModificarPersona(data){

	alert("hola");
	//document.location.href = "index.php?m_modulo=persona&m_formato=html5&m_accion=listar&m_vista=Agregar";
	
}



function guardarPersona(){
	var arr = Array("m_modulo"	,	"persona",
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
					"nacionalidad",	$('#nacionalidad').val()


					);
		
	ajaxMVC(arr,succAgregarPersona,error);
}

function borrarPersona(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					/*"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),*/
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

function succAgregarPersona(data){
	mostrarMensaje(data.mensaje, 1);
	
}


function error(data){	
	console.log(data);
	mostrarMensaje("Error de comunicación con el servidor.",2);
}