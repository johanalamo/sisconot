
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

Nombre: estudiante.js
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

	verEmpleado();

} );

function verEmpleado (){


	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"codPersona",	getVarsUrl().persona
					);

	ajaxMVC(arr,montarEmpleado,error);

}

function montarEmpleado(data){
	console.log(data);
	var acu=0;
	cadena="";
	cadena+='<tbody id="listarEmpleado">';
	if(data.empleado!=null){
		for(var x=0; x<data.empleado.length; x++)
		{
			acu=x+1;
			cadena+='<tr onclick="modificarEmpleado('+data.empleado[x]['codigo']+');"  id="'+data.empleado[x]['codigo']+'">';
			cadena+='<a href="#"><td>'+acu+'</td>';
			cadena+='<td>'+data.empleado[x]['codigo']+'</td>';
			cadena+='<td>'+data.empleado[x]['fec_inicios']+'</td>';
			if(data.empleado[x]['fec_fin'])
				cadena+='<td>'+data.empleado[x]['fec_fin']+'</td>';
			else
				cadena+='<td>-</td>';
			cadena+='<td>'+data.empleado[x]['nombre']+'</td>';
			cadena+='<td>'+data.empleado[x]['nom_instituto']+'</td>';
			cadena+='<td>'+data.empleado[x]['nom_pensum']+'</td>';	
			if(data.empleado[x]['es_jef_pensum'])							 
				cadena+='<td tile="Jefe de pensum" >SI</td>';
			else
				cadena+='<td tile="Jefe de pensum" >NO</td>';
			
			if(data.empleado[x]['es_jef_con_estudio'])
				cadena+='<td title="Jefe de Control de Estudio">SI</td>';
			else
				cadena+='<td title="Jefe de Control de Estudio">NO</td>';
			
			if(data.empleado[x]['es_ministerio'])
				cadena+='<td title="Personal del Ministerio">SI</td>';
			else
				cadena+='<td title="Personal del Ministerio">NO</td>';
			
			if(data.empleado[x]['es_docente'])
				cadena+='<td id="Docente" title="Docente">SI</td>';
			else
				cadena+='<td id="Docente" title="Docente">NO</td>';

			if(data.empleado[x]['observaciones'])
				cadena+='<td id="Observaciones">'+data.empleado[x]['observaciones']+'</td>';
			else
				cadena+='<td> - </td> ';
			cadena+='</a></tr>';
		}
	}
	cadena+="</tbody>";

	$("#listarEmpleado").remove();
	$(cadena).appendTo('#tablaEmpleado');
}
/**
* Funcion Java Script que permite guardar los datos de a un empleado
* para que luego sean almacenados en la base de datos. Los Datos son enviados
* por ajax.
*/


function preGuardarEmpleado(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"codPersona",	getVarsUrl().persona
					);

	ajaxMVC(arr,compararDatosEmpleados,error);

}

function compararDatosEmpleados(data){

	var bool= true;
	var boolAux=false;
	var acu=0;
	var mensaje="";
	var i=0;		

	if(data.empleado){
		for(var x=0; x<data.empleado.length; x++){
			acu=x+1;
			if((data.empleado[x]['cod_persona'] == data.codPersona 
				&& data.empleado[x]['cod_instituto'] == $("#empleado  #selectInstitutos #selectInstituto").val()
				&& data.empleado[x]['cod_pensum'] == $("#empleado  #selPensumEm #selectPNF").val()
				&& data.empleado[x]['fec_inicios'] == $("#fec_ini_empleado").val() )	
				&& (data.empleado[x]['codigo'] != $("#cod_empleado").val())		
			){		
					mensaje+="Ya esta modificacion se realizo anteriormente. Si desea afectuarla puede";
					mensaje+=" eliminar la informacion que se encuentra en la fila N° "+acu+"."; 		
				mostrarMensaje(mensaje,2);	
				bool=false;
				break;						
			}
			else if( data.empleado[x]['es_jef_con_estudio'] == $('#es_jef_con_estudio').prop('checked')
					&& data.empleado[x]['es_ministerio'] == $('#es_ministerio').prop('checked')
					&& data.empleado[x]['es_jef_pensum'] == $('#es_jef_pensum').prop('checked')
					&& data.empleado[x]['es_docente'] == $('#Docente').prop('checked')
					&& data.empleado[x]['cod_estado'] == $("#empleado  #selectEstado").val()
					&& (data.empleado[x]['codigo'] == $("#cod_empleado").val())
					&& data.empleado[x]['fec_inicios'] == $("#fec_ini_empleado").val()){
				bool=true;
				break;				
			}
			
			else if(data.empleado[x]['fec_final']==null 
						&& data.empleado[x]['fec_inicios'] == $("#fec_ini_empleado").val()
						&& data.empleado[x]['cod_estado'] != $("#empleado  #selectEstado").val()
						&& data.empleado[x]['codigo'] == $("#cod_empleado").val()){
				bool=true;
				i=x;

				if(data.empleado[x]['es_jef_con_estudio'] != $('#es_jef_con_estudio').prop('checked')
						|| data.empleado[x]['es_ministerio'] != $('#es_ministerio').prop('checked')
						|| data.empleado[x]['es_jef_pensum'] != $('#es_jef_pensum').prop('checked')
						|| data.empleado[x]['es_docente'] != $('#Docente').prop('checked')
						|| data.empleado[x]['cod_instituto'] != $("#empleado  #selectInstitutos #selectInstituto").val()
						|| data.empleado[x]['cod_pensum'] != $("#empleado  #selPensumEm #selectPNF").val()
						|| data.empleado[x]['fec_inicios'] != $("#fec_ini_empleado").val()){
					bool=false;
					boolAux=true; 

				}
				break;	
			}
			else if((  
					   data.empleado[x]['es_jef_con_estudio'] != $('#es_jef_con_estudio').prop('checked')
					|| data.empleado[x]['es_ministerio'] != $('#es_ministerio').prop('checked')
					|| data.empleado[x]['es_jef_pensum'] != $('#es_jef_pensum').prop('checked')
					|| data.empleado[x]['es_docente'] != $('#Docente').prop('checked')
					)
					&& (data.empleado[x]['codigo'] == $("#cod_empleado").val())
					&& data.empleado[x]['fec_inicios'] == $("#fec_ini_empleado").val()){				
				bool=false;
				break;
			}
			else if(data.empleado[x]['fec_inicios'] == $("#fec_ini_empleado").val()){
				mensaje+="Ya esta modificacion se realizo anteriormente. Si desea afectuarla puede";
				mensaje+=" eliminar la informacion que se encuentra en la fila N° "+acu+" o puede esperar hasta"; 
				mensaje+=" el dia siguiente.";	
				mostrarMensaje(mensaje,2);	
				bool=false;	
				break;			
			}
			else 
				bool=false;

		}
		//setTimeout(function(){verEmpleado ();}, 300);
	}
	alert(bool);
	if(boolAux)
		preDobleGuardar(bool,boolAux,data.empleado[i]);
	else
		preDobleGuardar(bool);

	verEmpleado ();
}


function preDobleGuardar(bool=null,boolAux=null,data=null){

	if(boolAux){

		guardarEmpleadoAux(data);
	}

	if(bool)
		guardarEmpleado($("#cod_empleado").val(),3);
	else if(boolAux)
		guardarEmpleado(null,false);
	else
		guardarEmpleado(null,true);

}

function guardarEmpleadoAux(data){
	
	var fecha='';
	if($("#fec_fin_empleado").val())
		fecha=$("#fec_fin_empleado").val();
	else
		fecha=fecActual();

	alert("jpipo"+fecha);
	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"agregar",	
					"codPersona",  data['cod_persona'],
					"codEstado", $("#empleado  #selectEstado").val(),
					"codEmpleado",  data['codigo'],
					"codInstituto", data['cod_instituto'],
					"codPensum", data['cod_pensum'],
					"fecInicio", data['fec_inicios'],///'7/2/2015',//fecActual(),
					"fecFin", fecha,///'7/2/2015',//fecActual(),
					"observaciones", $("#obs_empleado").val(),
					"es_jef_con_estudio",data['es_jef_con_estudio'],
					"es_ministerio",	data['es_ministerio'],
					"es_jef_pensum",	data['es_jef_pensum'],
					"Docente",			data['es_docente']
				);

	ajaxMVC(arr,succAgregarEmpleado,error);

}

function guardarEmpleado(codigo,bool=null){
	var fec_ini=$("#fec_ini_empleado").val();
	var fec_fin=null;
	if(bool==true){

		fec_fin=$("#fec_fin_empleado").val();

	}
	else if(bool==false){
		fec_fin=null;
		fec_ini=$("#fec_fin_empleado").val();
	}
	else{
		if($("#fec_fin_empleado").val())
			fec_fin=$("#fec_fin_empleado").val();
		else
			fec_fin=fecActual();
	}

	alert(fec_fin);
	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"agregar",	
					"codPersona",  $("#codigoPersona").val(),
					"codEstado", $("#empleado #selEstadoEm #selectEstado").val(),
					"codEmpleado",  codigo,
					"codInstituto", $("#empleado  #selectInstitutos #selectInstituto").val(),
					"codPensum", $("#empleado  #selPensumEm #selectPNF").val(),
					"fecInicio", fec_ini,///'7/2/2015',//fecActual(),
					"fecFin", fec_fin,///'7/2/2015',//fecActual(),
					"observaciones", $("#obs_empleado").val(),
					"es_jef_con_estudio",$('#es_jef_con_estudio').prop('checked'),
					"es_ministerio",	$('#es_ministerio').prop('checked'),
					"es_jef_pensum",	$('#es_jef_pensum').prop('checked'),
					"Docente",			$('#Docente').prop('checked')
				);
	
	//alert($("#codigoPersona").val()+"<<<"+$("#empleado #selEstadoEm #selectEstado").val()+"<<<"+$("#empleado  #selectInstitutos #selectInstituto").val()+"<<"+$("#empleado  #selPensumEm #selectPNF").val()+"<<"+$("#obs_empleado").val()+"<<<");
	ajaxMVC(arr,succAgregarEmpleado,error);
	
}

function succAgregarEmpleado(data){

	if(data.estatus>0)
		mostrarMensaje(data.mensaje,1);
	else
		mostrarMensaje(data.mensaje,2);

}

/**
* Funcion Java Script que permite listar Todos los institutos
* para que luego sea mostado en un select. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarSelectInstituto().
*/
function verInstitutoEm(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"tipo_persona",	"empleado",
					"campo",		$("#campo").val()
					);
		
	ajaxMVC(arr,montarSelectInstituto,error);
}

function verInstitutoEm2(){
	alert($("#empleado #selectInstituto").val());
	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado2").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#empleado #selectInstituto").val(),
					"tipo_persona",	"empleado",
					"campo",		$("#campo").val(),
					"empleado2"	,	true
					);
	ajaxMVC(arr,montarSelectInstituto,error);
}



/**
* Funcion Java Script que permite mostrar un select con
* los institutos y es concatenado a un  div en la vista HTML
*/
function montarSelectInstitutoE(data){
	console.log(data);
	var cadena = "";
	cadena += "<select  class='selectpicker' name='ins_empleado' id='ins_empleado' title='institutos' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	for(var x=0; x<data.instituto.length;x++)
	{
	 	if(data.instituto[x]['codigo']!=11)
	 		cadena += '<option value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';
	 	else
	 		cadena += '<option selected="selected" value="'+data.instituto[x]["codigo"]+'">'+data.instituto[x]["nom_corto"]+'</option>';
	}
	cadena+="</select>";

	$(cadena).appendTo('.ins_empleado');
	activarSelect();					
}


/**
* Funcion Java Script que permite listar Todos los PNF
* para que luego sea mostado en un select. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarSelectPNF().
*/
function verPNFEm(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"tipo_persona",	"empleado",
					"campo",		$("#campo").val()											
					);
		
	ajaxMVC(arr,montarSelectPNF,error);
}

function verPNFEm2(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#empleado #selectInstituto").val(),
					"tipo_persona",	"empleado",
					"campo",		$("#campo").val(),
					"empleado2"	,	true										
					);
		
	ajaxMVC(arr,montarSelectPNF,error);
}




/**
* Funcion Java Script que permite mostrar un select con
* los PNF y es concatenado a un  div en la vista HTML
*//*
function montarSelectPNFE(data){

	var cadena = "";
	cadena += "<select  class='selectpicker' id='selectPNF' title='pensum' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.pnf.length;x++)
	{
		cadena += '<option value="'+data.pnf[x]["codigo"]+'">'+data.pnf[x]["nom_corto"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectPensumEm');
	activarSelect();					
}
*/
/**
* Funcion Java Script que permite listar Todos los estados que posee un actor
* para que luego sea mostado en un select. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion mmontarSelectEstado().
*/
function verEstadoEm(){
	
	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#selectInstituto").val(),
					"tipo_persona",	"empleado",
					"campo",		$("#campo").val()	
					);		
	ajaxMVC(arr,montarSelectEstado,error);
}

function verEstadoEm2(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"estado"	,	$("#selectEstado2").val(),
					"pnf"		,	$("#selectPNF").val(),
					"instituto"	,	$("#empleado #selectInstituto").val(),
					"tipo_persona",	"empleado",
					"campo",		$("#campo").val(),
					"empleado2"	,	true
					);		
	ajaxMVC(arr,montarSelectEstado,error);
}
/**
* Funcion Java Script que permite mostrar un select con
* los estados y es concatenado a un  div en la vista HTML
*//*
function montarSelectEstadoEm(data){

	var cadena = "";
	cadena += "<select  class='selectpicker' id='selectEstadoEm' title='Estado' data-live-search='true' data-size='auto' data-max-options='12' >"; 
	cadena += "<option value='seleccionar'>Seleccionar</option>";
	for(var x=0; x<data.estado.length;x++)
	{		
		cadena += '<option value="'+data.estado[x]["codigo"]+'">'+data.estado[x]["nombre"]+'</option>';
	}
	cadena +="</select>";

	$(cadena).appendTo('.selectEstadoEm');
	activarSelect();					
}*/


/** 
* Funcion Java Script que permite listar Todas las personas de tipo empleado
* para que luego sean mostradas. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarPersona().
*//*
function verPersonaEmpleado(){

	var arr = Array("m_modulo"	,	"persona",
					"m_accion"	,	"listar",
					"tipo_persona", $("tipo_persona").val()				
					);		
	ajaxMVC(arr,montarPersonaEmpleado,error);
}*


/**
* Funcion Java Script que permite listar Todos los estudiantes
* para que luego sean mostradas. los datos son enviados
* por ajax para que se haga la consulta a la base de datos y mostrar 
* los resultados en la funcion montarPersona().
*/
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

/**
* Funcion Java Script que permite listar a un empleado en el HTML para
* que lugo se modifique su informacionde la base de datos. Los Datos son enviados
* por ajax.
*/

function modificarEmpleado(cod_empleado=null,cod_persona=null){
	
	if(!cod_persona && $("#cod_persona").val())
		cod_persona=$("#cod_persona").val();

	if(!cod_empleado && $("#cod_empleado").val())
		cod_empleado=$("#cod_empleado").val();


	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"listar",
					"codPersona",   cod_persona,
					"codEmpleado",  cod_empleado									
					);
		
	ajaxMVC(arr,succMontarModificarEmpleado,error);

}

/**
 * esta funcion JavaScript permite signar los datos obtenido en la
 * consuta  la base de datos y colocarlos en la vista HTML
 * de esta manera el usuario podra modificar los datos de la empleado
 */
function succMontarModificarEmpleado (data){
//alert(data.empleado[0]['cod_estado']);
	
	console.log(data.empleado);
	$("#cod_empleado").val(data.empleado[0]['codigo']);
	$("#cod_persona").val(data.empleado[0]['cod_persona']);
	$("#empleado  #selectEstado2").val(data.empleado[0]['cod_estado']);
	$("#empleado  #selectEstado2").selectpicker('refresh');
	$("#empleado #selectInstituto").val(data.empleado[0]['cod_instituto']);	
	
	setTimeout(function(){ 
$('#empleado #selectInstituto').selectpicker('refresh');
		$("#empleado #selectPNF").val(data.empleado[0]['cod_pensum']);
		$('#empleado #selectPNF').selectpicker('refresh');  
	}, 300);
	$("#fec_ini_empleado").val(data.empleado[0]['fec_inicios']);
	if(data.empleado[0]['fec_final'])
		$("#fec_fin_empleado").val(data.empleado[0]['fec_final']);
	else 
		$("#fec_fin_empleado").val(fecActual());
	$("#obs_empleado").val(data.empleado[0]['observaciones']);	
	$("#es_ministerio").prop( "checked",data.empleado[0]['es_ministerio']);
	$("#es_jef_pensum").prop( "checked",data.empleado[0]['es_jef_pensum']);
	$("#es_jef_con_estudio").prop( "checked",data.empleado[0]['es_jef_con_estudio']);
	$("#Docente").prop( "checked",data.empleado[0]['es_docente']);
	//alert(data.empleado[0]['cod_estado']);
}

function NuevoEmpleado (){
//alert(data.empleado[0]['cod_estado']);
	

	$("#cod_empleado").val("");
	//$("#cod_persona").val("");
	$("#empleado #selectPNF").val("seleccionar");
	$('#empleado #selectPNF').selectpicker('refresh');
	$("#empleado #selEstadoEm #selectEstado2").val("seleccionar");
	$("#empleado #selEstadoEm #selectEstado2").selectpicker('refresh');
	$("#empleado #selectInstituto").val("seleccionar");	
	$('#empleado #selectInstituto').selectpicker('refresh');
	$("#fec_ini_empleado").val(fecActual());
	$("#fec_fin_empleado").val("");
	$("#obs_empleado").val("");	
	$("#es_ministerio").prop( "checked",false);
	$("#es_jef_pensum").prop( "checked",false);
	$("#es_jef_con_estudio").prop( "checked",false);
	$("#Docente").prop( "checked",false);
	//alert(data.empleado[0]['cod_estado']);
}

/**
* Funcion Java Script que permite borrar a un  estudiante
* de la base de datos. Los Datos son enviados
* por ajax.
*/
function borrarEmpleado(){

	var arr = Array("m_modulo"	,	"empleado",
					"m_accion"	,	"eliminar",
					"codEmpleado",  $("#cod_empleado").val()									
					);
		
	ajaxMVC(arr,succMontarEliminarEmpleado,error);

}

function succMontarEliminarEmpleado (data){

	if(data.estatus>0){
		mostrarMensaje(data.mensaje,1);
		setTimeout(function(){verEmpleado ();}, 300);
	}
	else
		mostrarMensaje(data.mensaje,2);
}


function error(data){	
	console.log(data);
	mostrarMensaje("Error de comunicación con el servidor.",2);
}
