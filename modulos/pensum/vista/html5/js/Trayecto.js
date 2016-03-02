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
		cadena+="<tr><td style='width: 35%;''>Codigo:</td><td style='width: 65%;'><a href='#'' >"+unidad[0]+"</a></td></tr>";
		cadena+="<tr><td>Codigo de Ministerio:</td><td>";
		cadena+="<a href='#'' >"+unidad[1]+"</a></td></tr>";
		cadena+="<tr><td>Nombre:</td><td>";
		cadena+="<a href='#'' >"+unidad[2]+"</a></td></tr>";		
		cadena+="<tr><td>Horas de Trabajo Acompañadas (HTA):</td><td>";
		cadena+="<a href='#'' >"+unidad[3]+"</a></td></tr>";
		cadena+="<tr><td>Horas de Trabajo Independiente (HTI):</td><td>";
		cadena+="<a href='#'' >"+unidad[4]+"</a></td></tr>";	
		cadena+="<tr><td>Unidades de Credito:</td><td>";
		cadena+="<a href='#'' >"+unidad[5]+"</a></td></tr>";	
		cadena+="<tr><td>Duracion de Semanas:</td><td>";
		cadena+="<a href='#'' >"+unidad[6]+"</a></td></tr>";
		cadena+="<tr><td>Nota Minima Aprobatoria:</td><td>";
		cadena+="<a href='#'' >"+unidad[7]+"</a></td></tr>";	
		cadena+="<tr><td>Nota Maxima:</td><td>";
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
		cadena+="<table class='table table-hover mbn'><thead><tr class='active'><th># Codigo</th> <th>Codigo Ministerio</th><th>Nombre</th><th>Descripción</th></tr></thead>";
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
	if (data.estatus>0){
		mostrarMensaje("El pensum ha sido agregado satisfactoriamente!",1);	
		setClear();
	}
}

function errorAgregarModifUnidad(){
	mostrarMensaje("No se puede realizar operacion fallo del servicio", 3);
}

function errorCamposInvalidos(){mostrarMensaje("No se puede hacer el cambio Campos Invalidos",2);}

// redireciona el boton de edit a el formulario de agregar
function redirectEdit(codigo){
	  window.location="http://localhost:8085/sisconot-desarrollo/index.php?m_modulo=unidad&m_formato=html5&m_accion=preAgregarModif&m_vista=Agregar&codigo="+codigo;
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
		cadena= "<h4>Codigo : "+data.unidad[0]['codigo']+"</h4>";
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
    	cadena+="<th>N° Codigo</th>";
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

function ObtenerIDPensum(){
	var loc = document.location.href;	
	var getString = loc.search("codigoPensum");	
	 if (getString != -1){
       	 getString+=13;
	     var a = loc.substring(getString,getString+25);
	     console.log(a);
	   }else{
	   	alert('No posee codigo Pensum en url');
	   }
}





