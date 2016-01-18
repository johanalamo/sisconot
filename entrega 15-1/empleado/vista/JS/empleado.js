//falta colocar atributos en la funcion agregar empleado

function agregarEmpleado(){
	var arr = Array("m_modulo"	,	"estudiante",
					"m_accion"	,	"agregar",	
					"estEmpleado", $("#est_empleado").val(),
					"insEmpleado", $("#ins_empleado").val(),
					"penEmpleado", $("#pen_empleado").val(),
					"fecIniEstudiante", $("#fec_ini_empleado").val(),
					"obsEmpleado", $("#obs_empleado").val());	

/*	if($('input:radio[name=cod_persona]:checked').val()==null)
		mostrarMensaje("Debe de seleccionar una persona.",2);
	else*/
		ajaxMVC(arr,succAgregarEmpleado,error);

}

function succAgregarEmpleado(){
	mostrarMensaje(data.mensaje, 1);
}

function verEstadoEm(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listarEstado"				
					);		
	ajaxMVC(arr,montarSelectEstadoEm,error);
}

function montarSelectEstadoEm(data){

	var cadena = "";
	cadena += "<select  class='selectpicker' id='selectEstado' title='Estado' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.estado.length;x++)
	{		
		cadena += '<option value="'+data.estado[x]["codigo"]+'">'+data.estado[x]["nombre"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectEstado');
	activarSelect();					
}


function verPersonaEmpleado(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listarPersonaEmpleado"				
					);		
	ajaxMVC(arr,montarPersonaEmpleado,error);
}

function montarPersonaEmpleado(){

	cadena="";
	cadena+'<tbody id="listarPersonaEmpleado">';
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



function borrarEmpleado(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					/*"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),*/
					"cod_empleado",  $("#cod_empleado").val()									
					);
		
	ajaxMVC(arr,succMontarEliminarEmpleado,error);

}

function succMontarEliminarEmpleado (){

	if(data.estatus>0)
		montarEliminarEmpleado(data);
	else
		mostrarMensaje(data.mensaje,4);
}

function montarEliminarEmpleado (data){
	
}


function error(data){	
	console.log(data);
	mostrarMensaje("Error de comunicación con el servidor.",2);
}