// ver detalle de la unidad curricular

function verDetalle(codigo){	
	var arr = Array ("m_modulo","unidad",
	 				 "m_accion","buscarCodigoUnidadCurricular",
	 				 "codigo",codigo);
	ajaxMVC(arr,consultarDetalleUni,errorBuscarUni); 
}


function errorBuscarUni(){mostrarMensaje("No se puede la unidad curricular en este momento",2);}


/*
consulta todo los detalles
*/

// ver los detalles
function consultarDetalleUni(data) {
//	console.log(data)
	if (data.estatus>0){
		
		unidad=data.unidad[0];
	//	console.log(unidad);
		cadena="";
		
		cadena+="<div id='detallePen' class='third'>";
		cadena+="<table id='pesum' class='table table-bordered table-striped' style='clear: both'><tbody>";
		cadena+="<tr><td style='width: 35%;''>Código:</td><td style='width: 65%;'><a href='#'' >"+unidad[0]+"</a></td></tr>";
		cadena+="<tr><td>Código de Ministerio:</td><td>";
		cadena+="<a href='#'' >"+unidad[1]+"</a></td></tr>";
		cadena+="<tr><td>Nombre:</td><td>";
		cadena+="<a href='#'' >"+unidad[2]+"</a></td></tr>";		
		cadena+="<tr><td>Horas de Trabajo Acompañadas (HTA):</td><td>";
		cadena+="<a href='#'' >"+unidad[3]+"</a></td></tr>";
		cadena+="<tr><td>Horas de Trabajo Independiente (HTI):</td><td>";
		cadena+="<a href='#'' >"+unidad[4]+"</a></td></tr>";	
		cadena+="<tr><td>Unidades de Crédito:</td><td>";
		cadena+="<a href='#'' >"+unidad[5]+"</a></td></tr>";	
		cadena+="<tr><td>Duración de Semanas:</td><td>";
		cadena+="<a href='#'' >"+unidad[6]+"</a></td></tr>";
		cadena+="<tr><td>Nota Mínima Aprobatoria:</td><td>";
		cadena+="<a href='#'' >"+unidad[7]+"</a></td></tr>";	
		cadena+="<tr><td>Nota Máxima:</td><td>";
		cadena+="<a href='#'' >"+unidad[8]+"</a></td></tr>";
		cadena+="<tr><td>Descripción:</td><td>";
		cadena+="<a href='#'' >"+unidad[9]+"</a></td></tr>";
		cadena+="<tr><td>Observación:</td><td>";
		cadena+="<a href='#'' >"+unidad[10]+"</a></td></tr>";
		cadena+="<tr><td>Contenido:</td><td>";
		cadena+="<a href='#'' >"+unidad[11]+"</a></td></tr>";
		cadena+="</tbody></table></div>";
	//	$("#detallePen").html(cadena);
	//	alert(cadena);
		//$(cadena).appendTo('#detallePen');
		$("div.third").replaceWith(cadena);
	}
}


function verCoincidencia(){
	
	var arr = Array ("m_modulo","unidad",
	 				 "m_accion","buscarUniPorCoincidencia",
	 				 "patron",$("#codigoMinisterio").val());

	ajaxMVC(arr,verConsultarPatronUni,errorBuscarPatron); 
}


function errorBuscarPatron(){mostrarMensaje("No Puede mostar Coincidencias unidad curricular en este momento",2);}

function verConsultarPatronUni(data){
	var cadena="";
	
	var unidades = data["unidades"];
	
	if (data["unidades"] != null){
		cadena+=" <div class='trow' style='width:auto; height:200px; overflow:auto;'>";		                			
		cadena+="<table class='table table-hover mbn'><thead><tr class='active'><th># Código</th> <th>Código Ministerio</th><th>Nombre</th><th>Descripción</th></tr></thead>";
	    cadena+="<tbody> ";
	    for (var i = 0; i < unidades.length ; i++) {	    	
	    	 cadena+="  <tr class='active' href='#' onclick='verDetalleYCampos( "+ unidades[i][0]+ ")'><th># "+ unidades[i][0]+ "</th> <th>"+ unidades[i][1]+ "</th> <th>"+ unidades[i][2]+ "</th> <th>"+ unidades[i][3]+ "</th> </tr>";
	    };
	    cadena+=""
	    cadena+="</tbody></table></div>";
		$("div.trow").replaceWith(cadena);

	//console.log(data["unidades"].length)
	}//else{
		///cadena=" Hola mundo";

		//$("div.trow").replaceWith(cadena);
	//}
}

function verDetalleYCampos(codigo){
	verDetalle(codigo);
	llenarCamposForm(codigo);
}

function llenarCamposForm(codigo){
	var arr = Array ("m_modulo","unidad",
	 				 "m_accion","buscarCodigoUnidadCurricular",
	 				 "codigo",codigo);
	ajaxMVC(arr,setCampos,errorBuscarUni); 
}

function setCampos(data){
	//console.log('unidad');
	unidad=data.unidad[0];
//		console.log(unidad);
	$("#codigo").val(unidad["codigo"]);
	$("#codigoMinisterio").val(unidad["cod_uni_ministerio"]);
	$("#nombre").val(unidad["nombre"]);
	$("#unidadCredito").val(unidad["uni_credito"]);
	$("#descripcion").val(unidad["descripcion"]);
	$("#hta").val(unidad["hta"]);
	$("#hti").val(unidad["hti"]);
	$("#semanas").val(unidad["dur_semanas"]);
	$("#notaMin").val(unidad["not_min_aprobatoria"]);
	$("#notMaxima").val(unidad["not_maxima"]);
	$("#contenido").val(unidad["contenido"]);
	$("#observacion").val(unidad["observacion"]);
	
}

function setClear(){
	//console.log('unidad');	
//		console.log(unidad);
	$("#codigo").val('');
	$("#codigoMinisterio").val('');
	$("#nombre").val('');
	$("#unidadCredito").val('');
	$("#descripcion").val('');
	$("#hta").val('');
	$("#hti").val('');
	$("#semanas").val('');
	$("#notaMin").val('');
	$("#notMaxima").val('');
	$("#contenido").val('');
	$("#observacion").val('');	
}

function agregarModificar(){
	if (validarFrom()){
		if ($("#codigo").val() != ''){
			var arr = Array (
			"m_modulo","unidad",
			"m_accion","preAgregModif",
			"codigo",$("#codigo").val(),
			"codMinisterio",$("#codigoMinisterio").val(),
			"nombre",$("#nombre").val(),
			"unidadesCredito",$("#unidadCredito").val(),
			"descripcion",$("#descripcion").val(),
			"hta",$("#hta").val(),
			"hti",$("#hti").val(),
			"duracionSemanas",$("#semanas").val(),
			"notaMinima",$("#notaMin").val(),
			"notaMaxima",$("#notMaxima").val(),
			"contenido",$("#contenido").val(),
			"observacion",$("#observacion").val()
			);	 
		console.log(arr.toString())
	 	}else{
	 		var arr = Array (
		    "m_modulo","unidad",
		    "m_accion","preAgregModif",
			"codMinisterio",$("#codigoMinisterio").val(),
			"nombre",$("#nombre").val(),
			"unidadesCredito",$("#unidadCredito").val(),
			"descripcion",$("#descripcion").val(),
			"hta",$("#hta").val(),
			"hti",$("#hti").val(),
			"duracionSemanas",$("#semanas").val(),
			"notaMinima",$("#notaMin").val(),
			"notaMaxima",$("#notMaxima").val(),
			"contenido",$("#contenido").val(),
			"observacion",$("#observacion").val()
			);	
		console.log(arr.toString()) 
	 	}
		
		ajaxMVC(arr,succAgregarModifUnidad,errorAgregarModifUnidad);
		
	}else{
		errorCamposInvalidos();
	}

}

function validarFrom(){
	var result = true;


	return result;
}
// mensaje de agregar o modificar exito
function succAgregarModifUnidad(data){
	console.log(data)
	if (data.estatus>0){
		//mostrarMensaje("No se puede realizar operacion fallo del servicio", 3);
		mostrarMensaje("El pensum ha sido agregado satisfactoriamente!",1);	
	//	mostrarMensaje("El pensum ha sido agregado satisfactoriamente!",1);
		//alert()		
	}
}

function errorAgregarModifUnidad(){
	mostrarMensaje("No se puede realizar operacion fallo del servicio", 3);
}

function errorCamposInvalidos(){mostrarMensaje("No se puede hacer el cambio Campos Invalidos",2);}

// redireciona el boton de edit a el formulario de agregar
function redirectEdit(codigo){
	  window.location="index.php?m_modulo=unidad&m_formato=html5&m_accion=preAgregarModif&m_vista=Agregar&codigo="+codigo;
}


/*Eliminar unidada*/
function  abrirDialogoElimiar(nombreDialogo,titulo,tipoAccion){
	$('.modal').remove();
	//$('#'+nombreDialogo).remove();
	crearDialogo(nombreDialogo,"<center>Eliminar Unidad</center>","",1,tipoAccion,"Aceptar");	
}


function eliminar(codigo){	
		var arr = Array ("m_modulo","unidad",
						 "m_accion","eliminarUnidadCurricular",
						 "codigo", $("#codigoI").val());			
		//console.log(arr.toString());
		ajaxMVC(arr,succEliminarUnidad,errorEliminarUnidad);

}

function eliminarUnidad(codigo){
	abrirDialogoElimiar("dialogoUnidad","Eliminar Pensum","eliminar()");

	var arr = Array ("m_modulo","unidad",
	 				 "m_accion","buscarCodigoUnidadCurricular",
	 				 "codigo",codigo);

	ajaxMVC(arr,succObtenerU,error);
	
}

function succEliminarUnidad(data){
	if (data.estatus>0){
		mostrarMensaje(data.mensaje,1);
		$("#dialogoUnidad").modal('hide');	
		recargarUnidad();		
		
	}	

}

function succObtenerU(data){
	if(data.estatus>0){
		console.log(data);
		$("<h3> Esta seguro que quiere eliminar el Unidad ?</h3>").appendTo(".modal-body");
		cadena="<input type='hidden' value='"+data.unidad[0]['codigo']+"' class='form-control' placeholder='codigo Pensum' id='codigoI'>";
		$(cadena).appendTo(".modal-body");
		
		$("<br>").appendTo(".modal-body");
		cadena= "<h4>Código : "+data.unidad[0]['codigo']+"</h4>";
		$(cadena).appendTo(".modal-body");
		cadena= "<h4>Nombre: "+data.unidad[0]['nombre']+"</h4>";
		$(cadena).appendTo(".modal-body");
		cadena= "<h4>Descripción : "+data.unidad[0]['descripcion']+"</h4>";
		$(cadena).appendTo(".modal-body");
		
	}
	else 
		mostrarMensaje(data.mensaje,2);
}

function errorEliminarUnidad(data){mostrarMensaje("No se puede eliminar un unidad activos",2);}


// recargar listar

function recargarUnidad(){
	var arr = Array ("m_modulo", "unidad",
				     "m_accion", "listarUnidades");
	ajaxMVC(arr,actualizarLista,errorRecargar);
}

function errorRecargar(data){mostrarMensaje("Error al recargar la pagina",2);}


function actualizarLista(data){
	console.log(data);
	if(data.estatus>0){
		$('#table').remove();
		$('#table_wrapper').remove();

		cadena="<table class='table table-advance' id='table'>";
		cadena+="<thead>";
	    cadena+="<tr>";
    	cadena+="<th>N° Código</th>";
        cadena+="<th>Nombre Unidad Curricular</th>";
        cadena+="<th>Descripcion</th>";
        cadena+="<th>Modificar</th>";
	    cadena+="<th>Eliminar</th>";
	    cadena+="</tr></thead>";
		cadena+="<tbody>";
		for (i=0;i<data.unidades.length;i++){
			cadena+="<tr >";
				cadena+="<td><a href='#' onmouseover='verDetalle("+data.unidades[i]["codigo"]+")'>"+data.unidades[i]["codigo"]+"</a></td>";
				cadena+="<td><a href='#' onmouseover='verDetalle("+data.unidades[i]["codigo"]+")'>"+data.unidades[i]["nombre"]+" ("+data.unidades[i]["cod_uni_ministerio"]+")</a></td>";
				cadena+="<td><a href='#' onmouseover='verDetalle("+data.unidades[i]["codigo"]+")'>"+data.unidades[i]["descripcion"]+"</a></td>";
				cadena+="<td>";
				cadena+="<button class='btn btn-info' title='Modificar la Unidada Curricular' onclick='redirectEdit("+data.unidades[i]["codigo"]+")'>";
				cadena+="<i class='icon-pencil'></i>";
				cadena+="</button>";
				cadena+="</td>";
				cadena+="<td>";
				cadena+="<button class='btn btn-danger' title='Eliminar Pensum' onclick='eliminarUnidad("+data.unidades[i]["codigo"]+")' data-toggle='modal' data-target='#dialogoUnidad' title='Eliminar Unidad'>";
				cadena+="<i class='icon-remove'></i>";
				cadena+="</button>";
				cadena+="</td>";
			cadena+="</tr>";
		}
		cadena+="</tbody></table>";

		$(cadena).appendTo("#listarI");

	console.log(cadena);
		$('#table').DataTable();
	}
	else 
		mostrarMensaje(data.mensaje,2);
}












/*

function preAgregarUnidadCurricular(codTray,numTrayecto,codPensum){
	$("#modalAgregarUnidadCurricular .modal-body").remove();
	$("#verUnidadCurricular .modal-body").remove();
	crearDialogo("modalAgregarUnidadCurricular","<center><h3>Agregar Unidad Curricular</h3></center>","<center></center>",1,"validarAgregarUnidadCurricular()","Agregar");
	$("#modalAgregarUnidadCurricular .modal-body").load("modulos/pensum/vista/html5/js/formularioUnidadCurricular.php",function(){buscarTipoUnidadCurricular(codTray);buscarPrelacion(numTrayecto,codPensum);});
	$("#modalAgregarUnidadCurricular").modal("show");
}

function buscarPrelacion(numTrayecto,codPensum){
	if(numTrayecto>0){
		numTrayecto=numTrayecto-1;
		var arr = Array("m_modulo","unidad",
						"m_accion","listarPrelacion",
						"numtray",numTrayecto,
						"codigo",codPensum);
		ajaxMVC(arr,cargarUnidadCurricular,errorListarPrelacion);		
	}
}

function errorListarPrelacion(){mostrarMensaje("No pueden cargar las unidades para relacionar en este momento",2);}

function cargarUnidadCurricular(data){
	unidadCurricular=data.pensum;
	if (unidadCurricular!=null){
		$("#divCheckUC").hide();
		$("#tituloUnidadCurricular").append("<center><label class='checkbox-inline'><input type='checkbox' name='checkUnidadCurricular' id='checkUnidadCurricular' onchange='checkUC()'>Materias requeridas para cursar esta Unidad Curricular:</label></center><br><br>");
		for (var i=0;i<unidadCurricular.length;i++){
			$("#divCheckUC").append("<input type='checkbox' id='check"+i+"' value="+unidadCurricular[i]['codigo']+">"+unidadCurricular[i]['nombre']+"<br>");
		}	
		$("#numArrUC").val(i);
	}
}

function buscarTipoUnidadCurricular(codTray){
	$("#codTray").val(codTray);
	var arr =Array("m_modulo","unidad",
					"m_accion","buscarCodigoUnidadCurricular");
    ajaxMVC(arr,montarTipoUnidadCurricular,errorListarAjax);    
}

function montarTipoUnidadCurricular(data){	
	tipoUnidadCurricular=data.pensum;
	$("#selectTipoUnidad").append("<div class='input-group'><span class='input-group-addon'>Tipo de Unidad Curricular:</span><select class='form-control selectpicker' id='tipoUnidadCurricular' class='selectpicker' data-live-search='true'></select></div>");
	for (var i=0;i<tipoUnidadCurricular.length;i++){
		$("#tipoUnidadCurricular").append("<option value="+tipoUnidadCurricular[i]['codigo']+">"+tipoUnidadCurricular[i]['nombre']+"</option>");
	}
	activarSelect();
}

function checkUC(){
	if($('#checkUnidadCurricular').is(':checked')){
		$("#divCheckUC").show();
	}else{$("#divCheckUC").hide();}
}

function validarAgregarUnidadCurricular(){
	if(validarRangos('#nombreUC',2,100,true)&&
		validarRangos('#codMinisterio',2,30,true)&&
		validarSoloNumeros('#hti',1,2,true)&&
		validarSoloNumeros('#hta',1,2,true)&&
		validarSoloNumeros('#unidadesCredito',1,2,true)&&
		validarSoloNumeros('#duracionSemanas',1,3,true)&&
		validarSoloNumeros('#notaMinima',1,2,true)&&
		validarSoloNumeros('#notaMaxima',1,2,true)&&
		validarMayorMenor('#notaMaxima','#notaMinima'))
	{	
		agregarUnidadCurricular();}
}

function validarMayorMenor(mayor, menor){
	$(".popover").hide();	
	if($(mayor).val() <= $(menor).val()){
		detonarAdvertencia(menor,"La nota minima no puede ser mayor a la nota maxima");
		return false;
	}
	return true;
}

function agregarUnidadCurricular(){
	var arr = Array("m_modulo","unidad",
					"m_accion","agregarUnidadCurricular",					
					"nombreUC",$("#nombreUC").val(),
					"codMinisterio",$("#codMinisterio").val(),
					"codTrayecto",$("#codTray").val(),
					"tipoUnidadCurricular",$("#tipoUnidadCurricular").val()[0],
					"hta",$("#hta").val(),
					"hti",$("#hti").val(),
					"unidadesCredito",$("#unidadesCredito").val(),
					"duracionSemanas",$("#duracionSemanas").val(),
					"notaMinima",$("#notaMinima").val(),
					"notaMaxima",$("#notaMaxima").val());
	ajaxMVC(arr,succAgregarUC,errorAgregarUC);
}

function succAgregarUC(data){
	var arrUC = new Array();
	if($("#numArrUC").val()!=0 && $("#numArrUC").val()!=null){
		for (var i=0;i<$("#numArrUC").val();i++){
			if($("#check"+i).is(":checked")){
				arrUC[i]=$("#check"+i).val();
				var arr = Array("m_modulo","unidad",
						"m_accion","agregarPrelacion",
						"unidadCurricularPrelada",arrUC[i]);
				ajaxMVC(arr,succAgregarPrelacion,errorAgregarPrelacion);
			}
		}
	}
	$("#modalAgregarUnidadCurricular").modal('hide');
	mostrarMensaje("Unidad Curricular agregada con exito",1);
	recargarUnidadCurricular();
}
function errorAgregarUC(){mostrarMensaje("No pueden existir 2 unidades curriculares con el mismo nombre o codigo",2);}

function errorAgregarPrelacion(){mostrarMensaje("No se pudo agregar las materias necesarias para la unidad curricular",2);}

function succAgregarPrelacion(data){}

function recargarUnidadCurricular(){
	var arr = Array("m_modulo", "pensum",
					"m_accion", "buscarTrayPen",
					"codigo", $("#inputPen").val());
	ajaxMVC(arr,succRecargarUnidadCurricular,errorRecargarUnidadCurricular);	
}

function succRecargarUnidadCurricular(data){
	if (data.estatus>0){	
		pensums=data.pensum;						
		$("#infoPensum .modal").remove();									
		crearDialogo("infoPensum2","<center>"+pensums['nombre']+"</center>","<center>Nombre Abreviado del Pensum: "+pensums['nombreCorto']+"<center>","","","");
		$("<div class='row'><div class='col-md-12'><div id='pensumV'></div></div></div>").appendTo("#infoPensum2 .modal-body");
		$("#pensumV").load("modulos/pensum/vista/html5/js/InformacionP.php",function(){infoTrayRecargar(pensums);});	
		$("#infoPensum").modal("show");		
	}
}

function errorRecargarUnidadCurricular(){mostrarMensaje("No se puede recargar el listado por el momento",2);}

function eliminarUnidadCurricular(codigo){	
	if (confirm("¿Desea eliminar la siguiente unidad curricular?")){
		var arr = Array ("m_modulo","unidad",
						 "m_accion","eliminarUnidadCurricular",
						 "codigo", codigo);			
		ajaxMVC(arr,succEliminarUC,errorEliminarUC);			
	}
	else
	return false;
}
function succEliminarUC(data){	
	if (data.estatus>0){
		mostrarMensaje("Unidad curricular eliminada con exito",1);
		$("#VentanaFormularioTrayecto").modal('hide'); 
		recargarUnidadCurricular();		
	}
}

function errorEliminarUC(){mostrarMensaje("No se puede eliminar unidades curricular que estan siendo usadas en el sistema",2);}

function eliminarUnidadesPorTrayecto(codigotrayecto){
	if (confirm("¿Para eliminar el siguiente trayecto debe eliminar todas las unidades curriculares de este,¿Está seguro?")){
			var arr = Array ("m_modulo","pensum",
							 "m_accion","eliminarUnidadesPorTrayecto",
							 "codigo", codigotrayecto);			
			ajaxMVC(arr,succEliminarUnidadesPorTrayecto,errorEliminarUnidadesPorTrayecto);
		}
	else
	return false;	
}

function succEliminarUnidadesPorTrayecto(){mostrarMensaje("unidades Curricular Eliminadas",1);}

function errorEliminarUnidadesPorTrayecto(){mostrarMensaje("No se puede eliminar unidades curricular que estan siendo usadas en el sistema",2);}

function verUnidadCurricular(codigo,numTrayecto,codPensum,codTray){
	$("#modalAgregarUnidadCurricular .modal-body").remove();
	$("#verUnidadCurricular .modal-body").remove();
	crearDialogo("verUnidadCurricular","<center><h2>Unidad Curricular</h2></center>","",1,"validarmodificarUnidadCurricular()","Modificar");		
	$("#verUnidadCurricular .modal-body").load("modulos/pensum/vista/html5/js/formularioUnidadCurricular.php",function(){ajaxVerUnidadCurricular(codigo);buscarCheckUnidadCurricular(numTrayecto,codPensum,codigo);$('#verUnidadCurricular').modal('show');});
}

function ajaxVerUnidadCurricular(codigo){
	var arr = Array ("m_modulo","unidad",
		 			 "m_accion","verUnidadCurricular",
		 			 "codigo",codigo);
	ajaxMVC(arr,montarUnidadCurricular,errorVerUnidadCurricular);
}

function errorVerUnidadCurricular(data){mostrarMensaje("No se puede ver la unidad curricular en este momento",2);}

function montarUnidadCurricular(data){
	if (data.estatus>0){
		pensums=data.pensum;
		$("#selectTipoUnidad").append("<span class='input-group-addon' id='tituloinput'>Tipo de Unidad Curricular:</span><input type='text' id='tipoUnidadCurricular' class='form-control' value=''>");
		$("#botonModificarUnidadCurricular").append("<center><button id='botonModif' class='btn btn-warning' onclick='preModificarUnidadCurricular()'>Modificar Unidad Curricular</button></center>");
		$("#nombreUC,#codMinisterio,#tipoUnidadCurricular,#hta,#hti,#unidadesCredito,#duracionSemanas,#notaMinima,#notaMaxima").attr('disabled',true);
		$("#codUni").val(pensums[0]['cod_unidad']);
		$("#codTray").val(pensums[0]['cod_trayecto']);
		$("#nombreUC").val(pensums[0]['nombre_unidad']);
		$("#codMinisterio").val(pensums[0]['cod_uni_ministerio']);
		$("#tipoUnidadCurricular").val(pensums[0]['nombre_tipo']);
		$("#hta").val(pensums[0]['hta']);
		$("#hti").val(pensums[0]['hti']);
		$("#unidadesCredito").val(pensums[0]['uni_credito']);
		$("#duracionSemanas").val(pensums[0]['dur_semanas']);
		$("#notaMinima").val(pensums[0]['not_min_aprobatoria']);
		$("#notaMaxima").val(pensums[0]['not_maxima']);
		$("#tituloUnidadCurricular").hide();
		$("#divCheckUC").hide();
	}
}

function buscarCheckUnidadCurricular(numTrayecto,codPensum,codigo){
	if(numTrayecto>0){
		numTrayecto=numTrayecto-1;
		var arr = Array("m_modulo","unidad",
						"m_accion","listarPrelacion",
						"numtray",numTrayecto,
						"codigo",codPensum);
		ajaxMVC(arr,cargarCheckModificarUnidadCurricular,errorCargarCheckUnidadCurricular);
	}
}

function errorCargarCheckUnidadCurricular(){mostrarMensaje("No se pueden cargar unidades para relacionar en este momento",2);}

function cargarCheckModificarUnidadCurricular(data){
	unidadCurricular=data.pensum;
	if (unidadCurricular!=null){
		$("#divCheckUC").hide();
		$("#tituloUnidadCurricular").append("<center><label class='checkbox-inline'><input type='checkbox' name='checkUnidadCurricular' id='checkUnidadCurricular' onchange='checkUC()'>Materias requeridas para cursar esta Unidad Curricular:</label></center><br><br>");
		for (var i=0;i<unidadCurricular.length;i++){
			$("#divCheckUC").append("<input type='checkbox' id='check"+i+"' value="+unidadCurricular[i]['codigo']+">"+unidadCurricular[i]['nombre']+"<br>");
			$("#divCheckUC").append("<input type='hidden' id='status"+i+"' value='0'><br>");
		}	
		$("#numArrUC").val(i);
		ajaxCheckModificarUnidadCirrucular();
	}
}

function ajaxCheckModificarUnidadCirrucular(){
	var arr = Array("m_modulo","unidad",
					"m_accion","buscarPrelacionUnidadCurricular",
					"codigo",$("#codUni").val());
	ajaxMVC(arr,actCheckModificarUnidadCirrucular,errorCargarCheckUnidadCurricular);
}

function actCheckModificarUnidadCirrucular(data){
	if (data.estatus>0){
		prelacion=data.pensum;
		for (var i=0; i<prelacion.length;i++){
			for (var j=0; j<$("#numArrUC").val(); j++){
				if (prelacion[i]['cod_uni_cur_prelada']==$("#check"+j).val()){
					$("#check"+j).prop("checked",true);
					$("#status"+j).val(1);
				}
			}
		}
	}
}

function preModificarUnidadCurricular(){	
	$("#botonModif").remove();	
	var arr = Array("m_modulo","unidad",
					"m_accion","buscarCodigoUnidadCurricular");
    ajaxMVC(arr,montarPreModificarUnidadCurricular,errorPreModificarUnidadCurricular);	
}

function montarPreModificarUnidadCurricular(data){
	$("#nombreUC,#codMinisterio,#tipoUnidadCurricular,#hta,#hti,#unidadesCredito,#duracionSemanas,#notaMinima,#notaMaxima").attr('disabled',false);
	$("#tituloinput").remove();
	$("#tipoUnidadCurricular").remove();
	$("#tituloUnidadCurricular").show();
	$("#checkUnidadCurricular").attr("checked",true);
	$("#divCheckUC").show();
	tipoUnidadCurricular=data.pensum;
	$("#selectTipoUnidad").append("<div class='input-group'><span class='input-group-addon'>Tipo de Unidad Curricular:</span><select class='form-control selectpicker' id='tipoUnidadCurricular' class='selectpicker' data-live-search='true'></select></div>");
	for (var i=0;i<tipoUnidadCurricular.length;i++){
		$("#tipoUnidadCurricular").append("<option value="+tipoUnidadCurricular[i]['codigo']+">"+tipoUnidadCurricular[i]['nombre']+"</option>");
	}
	activarSelect();
}

function errorPreModificarUnidadCurricular(){mostrarMensaje("No se puede modificar la unidad en este momento",2);}

function validarmodificarUnidadCurricular(){
	if(validarSoloTexto('#nombreUC',2,100,true)&&
		validarRangos('#codMinisterio',2,30,true)&&
		validarSoloNumeros('#hti',1,2,true)&&
		validarSoloNumeros('#hta',1,2,true)&&
		validarSoloNumeros('#unidadesCredito',1,2,true)&&
		validarSoloNumeros('#duracionSemanas',1,3,true)&&
		validarSoloNumeros('#notaMinima',1,2,true)&&
		validarSoloNumeros('#notaMaxima',1,2,true)&&
		validarMayorMenor('#notaMaxima','#notaMinima'))
	{modificarUnidadCurricular();}
}
function modificarUnidadCurricular(){	
	if (confirm("¿Desea modificar esta unidad curricular?")){
		var arr = Array ("m_modulo","unidad",
						 "m_accion","modificarUnidadCurricular",
						 "codigo", $("#codUni").val(),
						 "codMinisterio", $("#codMinisterio").val(),
						 "codTrayecto",$("#codTray").val(),
						 "nombreUC",$("#nombreUC").val(),							 
						 "tipoUnidadCurricular",$("#tipoUnidadCurricular").val()[0],
						 "hta",$("#hta").val(),
						 "hti",$("#hti").val(),
						 "unidadesCredito",$("#unidadesCredito").val(),
						 "duracionSemanas",$("#duracionSemanas").val(),
						 "notaMinima",$("#notaMinima").val(),
						 "notaMaxima",$("#notaMaxima").val());			
		ajaxMVC(arr,modificarPrelacionUnidadCurricular,errorModificarUnidadCurricular);					
	}
	else
	return false;
}

function modificarPrelacionUnidadCurricular(data){
	if (data.estatus>0){
		mostrarMensaje("Trayecto modificado a este pensum satisfactoriamente",1);
		$("#verUnidadCurricular").modal('hide');
		for (var i=0; i<$("#numArrUC").val(); i++){
			if($("#status"+i).val()==1 && !$("#check"+i).is(':checked')){
				var arr = Array("m_modulo","unidad",
								"m_accion","eliminarPrelacion",
								"codigoUnidad",$("#codUni").val(),
								"codigoPrelada",$("#check"+i).val());
    			ajaxMVC(arr,succEliminarPrelacion,errorModificarUnidadCurricular);
			}
			if($("#status"+i).val()==0 && $("#check"+i).is(':checked')){
				var arr = Array("m_modulo","unidad",
								"m_accion","agregarPrelacionModificar",
								"codigoUnidad",$("#codUni").val(),
								"codigoPrelada",$("#check"+i).val());
    			ajaxMVC(arr,succAgregarPrelacionModificar,errorModificarUnidadCurricular);
			}
		}
		recargarUnidadCurricular();
	}
}
function succEliminarPrelacion(data){}
function succAgregarPrelacionModificar(data){}

function errorModificarUnidadCurricular(){mostrarMensaje("No se ha podido modificar esta unidad curricular",2);}

function errorListarAjax(){mostrarMensaje("Ha ocurrido un eror en la conexion a base de datos",2);}

*/