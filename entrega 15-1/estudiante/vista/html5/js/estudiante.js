$(document).ready(function() {
	verInstitutoE();
	/*verPNFE();
	verEstadoE();*/
} );



function agregarEstudiante(){
	var arr = Array("m_modulo"	,	"estudiante",
					"m_accion"	,	"agregar",	
					"codRusnies", $("#cod_rusnies").val(),
					"insEstudiante", $("#ins_estudiante").val(),
					"penEstudiante", $("#pen_estudiante").val(),
					"numCarnet", $("#num_carnet").val(),
					"expediente", $("#expediente").val(),
					"estEstudiante", $("#est_estudiante").val(),
					"fecIniEstudiante", $("#fec_ini_estudiante").val(),
					"condicion", $("#condicion").val(),
					"obsEstudiante", $("#obs_estudiante").val());	

/*	if($('input:radio[name=cod_persona]:checked').val()==null)
		mostrarMensaje("Debe de seleccionar una persona.",2);
	else*/
		ajaxMVC(arr,succAgregarEstudiante,error);

}

function succAgregarEstudiante(){
	mostrarMensaje(data.mensaje, 1);
}


function verInstitutoE(){

	var arr = Array("m_modulo"	,	"estudiante",
					"m_accion"	,	"listar"
					);
		
	ajaxMVC(arr,montarSelectInstitutoE,error);
}

function montarSelectInstitutoE(data){
	console.log(data);
	var cadena = "";
	cadena += "<select  class='selectpicker' name='ins_estudiante' id='ins_estudiante' title='institutos' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	for(var x=0; x<data.instituto.length;x++)
	{
	 	if(data.instituto[x]['codigo']!=11)
	 		cadena += '<option value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';
	 	else
	 		cadena += '<option selected="selected" value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';
	}
	cadena+="</select>";

	$(cadena).appendTo('.ins_estudiante');
	activarSelect();					
}

function verPNFE(){

	var arr = Array("m_modulo"	,	"estudiante",
					"m_accion"	,	"listar"
														
					);
		
	ajaxMVC(arr,montarSelectPNFE,error);
}

function montarSelectPNFE(data){

	var cadena = "";
	cadena += "<select  class='selectpicker' id='selectPNF' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.pnf.length;x++)
	{
		cadena += '<option value="'+data.pnf[x]["codigo"]+'">'+data.pnf[x]["nom_corto"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectPensum');
	activarSelect();					
}

function verEstadoE(){

	var arr = Array("m_modulo"	,	"estudiante",
					"m_accion"	,	"listarEstado"				
					);		
	ajaxMVC(arr,montarSelectEstadoE,error);
}

function montarSelectEstadoE(data){

	var cadena = "";
	cadena += "<select  class='selectpicker' id='selectEstado' title='estado' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.estado.length;x++)
	{		
		cadena += '<option value="'+data.estado[x]["codigo"]+'">'+data.estado[x]["nombre"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectEstado');
	activarSelect();					
}

function verPersonaEstudiante(){

	var arr = Array("m_modulo"	,	"estudiante",
					"m_accion"	,	"listarPersonaEstudiante"				
					);		
	ajaxMVC(arr,montarPersonaEstudiante,error);
}

function montarPersonaEstudiante(){

	cadena="";
	cadena+'<tbody id="listarPersonaEstudiante">';
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

function borrarEstudiante(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					/*"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),*/
					"cod_estudiante",  $("#cod_estudiante").val()									
					);
		
	ajaxMVC(arr,succMontarEliminarEstudiante,error);

}

function succMontarEliminarEstudiante (){

	if(data.estatus>0)
		montarEliminarEstudiante(data);
	else
		mostrarMensaje(data.mensaje,4);
}

function montarEliminarEstudiante (data){
	
}


function error(data){	
	console.log(data);
	mostrarMensaje("Error de comunicación con el servidor.",2);
}