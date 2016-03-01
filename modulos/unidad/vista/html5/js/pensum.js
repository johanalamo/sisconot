

function  abrirDialogoElimiar(nombreDialogo,titulo,tipoAccion){
	$('.modal').remove();
	//$('#'+nombreDialogo).remove();
	crearDialogo(nombreDialogo,"<center>Eliminar Pensum</center>","",1,tipoAccion,"Aceptar");	
}


function administrarPensum(){
	crearDialogo("preagregarpensum","<center>Agregar Pensum</center>","",1,"validarAgregarPensum()","Agregar Pensum");
	$("<div class='row'><div class='col-md-12'><div id='pensumA'></div></div></div>").appendTo("#preagregarpensum .modal-body");
	$("#pensumA").load("modulos/pensum/vista/html5/js/FormularioPensum.php",function(){activarSelect();});	
	//$('#preagregarpensum').modal('show');						
}

function validarAgregarPensum(){
	if(validarSoloTexto("#nombre",5,60,true))
	{agregarPensum();}
}

function agregarPensum(){	
	var arr = Array ("m_modulo", "pensum",
					 "m_accion", "agregar",
					 "nombre", $("#nombre").val(),
					 "nom_corto", $("#nom_corto").val(), 
					 "observaciones", $("#observaciones").val(),
					 "minCanElectiva", $("#min_cant_elect").val(),
					 "minCreElectiva", $("#min_cre_elect").val(),
					 "minCreObli",$("#min_cre_oblig").val(),
					 "fecha",$("#fecha").val()

					 );
//	console.log(arr);
	ajaxMVC(arr,succAgregarPensum,errorAgregarPensum);
}

function succAgregarPensum(data){
	if (data.estatus>0){		
		pensums=data.pensum; 
		$("#preagregarpensum").modal('hide');		
		mostrarMensaje("El pensum ha sido agregado satisfactoriamente!",1);
		recargarPensum();
	}
}

function errorAgregarPensum(){mostrarMensaje("No pueden agregar pensum revisar log",2);}

function eliminar(codigo){	
		var arr = Array ("m_modulo","pensum",
						 "m_accion","eliminar",
						 "codigo", $("#codigoI").val());			
		ajaxMVC(arr,succEliminarPensum,errorEliminarPensum);

}

function eliminarPensum(codigo){
	abrirDialogoElimiar("dialogoPensum","Eliminar Pensum","eliminar()");
	
	var a=Array("m_modulo","pensum","m_accion","buscarPensum",
					"m_vista","Obtener","codigo",codigo);
	ajaxMVC(a,succObtenerE,error);
	
}

function succEliminarPensum(data){
	if (data.estatus>0){
		mostrarMensaje(data.mensaje,1);
		$("#dialogoPensum").modal('hide');	
		recargarPensum();		
		
	}	

}

function errorEliminarPensum(data){mostrarMensaje("No se puede eliminar un pensum con trayectos activos",2);}

function verPensum(codigo){	
	var arr = Array ("m_modulo","pensum",
	 				 "m_accion","buscarPensum",
	 				 "codigo",codigo);
	ajaxMVC(arr,succBuscarPensum,errorBuscarPensum); 
}

function succBuscarPensum(data){
	if (data.estatus>0){
		$(".modal").remove();
		pensums=data.pensum;
		crearDialogo("verPensum","<center>"+pensums[0]['nombre']+"</center>","<center>Informacion del Pensum</center>",1,"modificar()","")
		$("<div class='row'><div class='col-md-12'><div id='pensumV'></div></div></div>").appendTo("#verPensum .modal-body");
		$("#pensumV").load("modulos/pensum/vista/html5/js/VerPensum.php",function(){montarPensum(pensums);});
		$('#verPensum').modal('show');
	}
}


function errorBuscarPensum(){mostrarMensaje("No se puede el pensum en este momento");}

function activarPensum(){
	$('#nombre').attr('disabled',false);
	$('#nom_corto').attr('disabled',false);
	$('#observaciones').attr('disabled',false); 
	$(".modal .btn-danger").remove();
    $(".modal-footer").append("<button class='btn btn-success' onclick='validarModificar()'>Guardar Pensum</button>");
    $(".modal-footer").append("<button class='btn btn-danger' data-dismiss='modal' type='button'>Cerrar</button>"); 
    $("#BotonModificar").remove();
}	

function validarModificar(){
	if(validarSoloTexto("#nombre",5,60,true) && validarSoloTexto("#nom_corto",2,6,true))
	{modificar();}
}

function modificar(){
	console.log('llamado');
	if (confirm("¿Desea modificar el siguiente pensum?")){

		var arr = Array ("m_modulo", "pensum",
					 "m_accion", "modificar",
					 "codigo", $("#codigo").val(),
					 "nombre", $("#nombre").val(),
					 "nom_corto", $("#nom_corto").val(), 
					 "observaciones", $("#observaciones").val(),
					 "minCanElectiva", $("#min_cant_elect").val(),
					 "minCreElectiva", $("#min_cre_elect").val(),
					 "minCreObli",$("#min_cre_oblig").val(),
					 "fecha",$("#fecha").val()

					 );
		console.log(arr.toString());
/*		var arr = Array ("m_modulo", "pensum",
					 "m_accion", "modificar",
					 "codigo",$("#codigo").val(),
					 "nombre", $("#nombre").val(),
					 "nom_corto", $("#nom_corto").val(), 
					 "observaciones", $("#observaciones").val());*/
		ajaxMVC(arr,succModificar,errorModificar);
	}
	else 
	return false;
}

function succModificar(data){
	//alert('ok')
	if (data.estatus>0){
		$("#verPensum").modal('hide');
		mostrarMensaje(data.mensaje,1);
		recargarPensum();
	}
}

function errorModificar(){mostrarMensaje("Problema al modificar",2);}

function agregarInfPen(codigo){
	var arr = Array ("m_modulo","pensum",
					 "m_accion","buscarPensum",
					 "codigo",codigo);
	ajaxMVC(arr,succInfoPen,errorInfoPen); 

	console.log(arr);
}

function succInfoPen(data){
	console.log(data);
	if (data.estatus>0){
		$(".modal").remove()
		pensums=data.pensum;
		crearDialogo("infoPensum","<center>"+pensums[0]['nombre']+"</center>","<center>Nombre Abreviado del Pensum: "+pensums[0]['nom_corto']+"<center>",1,"modificar()","Modificar Pensum")
		
		$("<div class='row'><div class='col-md-12'><div id='pensumV'></div></div></div>").appendTo("#infoPensum .modal-body");
		$("#pensumV").load("modulos/pensum/vista/html5/js/FormularioPensumEdit.php",function(){
			infoEditPensum(pensums[0]);
		});
		$('#infoPensum').modal('show');
	}
}

function errorInfoPen(){mostrarMensaje("No se pudo agregar el pensum en este momento");}

function infoEditPensum(data){
	console.log(data);
	$("#codigo").val(data["codigo"])
	$("#nombre").val(data["nombre"])
	$("#nom_corto").val(data["nom_corto"]); 
    $("#min_cant_elect").val(data["min_can_electiva"]);
	$("#min_cre_elect").val(data["min_cre_electiva"]);
	$("#min_cre_oblig").val(data["min_cre_obligatoria"]);
	$("#fecha").val(data["fec_creacion"]);
	$("#observaciones").val(data["observaciones"]);
}

function infoTray(pensum){
	cadena="";
	/*var trayectos = pensum['trayectos'];
	if(trayectos[0]['codigo']!=null){
		for (var i=0; i<trayectos.length; i++)		
			{
				var num=i+1;
				var trayecto = trayectos[i];
				var unidades = trayecto['unidades'];
				var unidad1 = unidades[0];
				var cod_trayecto = unidad1['codTrayecto'];			
					var num_unit = unidades.length;
			      cadena+="<div class='panel panel-default' id='idenueva"+num+"'>";
			      	cadena+="<div class='panel-heading' role='tab' id='headerT"+num+"'>";
				  		cadena+="<h4 class='panel-title'>"; 
				  			cadena+="<a data-toggle='collapse' data-parent='#accordion' href='#collapse"+num+"' aria-expanded='true' aria-controls='collapseOne'>";  											
							//=====================================================PANEL=============================================================================
							cadena+="<b><center>Trayecto "+trayecto['numTrayecto']+"</center></b>";
							if (permiso.pensum.insert)
							{
							cadena+="<button class='btn btn-danger pull-right' title='Eliminar Trayecto' onclick='eliminarTrayecto("+trayecto['codPensum']+","+trayecto['numTrayecto']+")'><i class='icon-remove'></i></button>";	
							cadena+="<button class='btn btn-primary pull-right' title='Ver Trayecto' onclick='verTrayecto("+trayecto['codPensum']+","+trayecto['numTrayecto']+")'><i class='icon-eye-open'></i></button>";	
							}							
							
							//=========================================================================================================================================		  				
				  		cadena+="</a>";
				 	 	cadena+="</h4>";
				  	cadena+="</div>";
				  	cadena+="<div id='collapse"+num+"' class='panel-collapse collapse' role='tabpanel' aria-labelledby='headingOne'>";
				  	cadena+="<div class='panel-body'>";		  	
				  	cadena+="<table class='table table-bordered'>";
				  	cadena+="<tr class='titulo'>";
					   				cadena+="<td>NOMBRE DE UNIDAD CURRICULAR</td>";
					   				cadena+="<td>CODIGO DE UNIDAD CURRICULAR</td>";
					   				cadena+="<td>HORAS DE TRABAJO INDEPENDIENTE</td>";
					   				cadena+="<td>HORAS DE TRABAJO ACOMPAÑADO</td>";					   				
					   				cadena+="<td>UNIDADES DE CREDITO</td>";	
					   				cadena+="<td>NOTA APROBATORIA</td>";					   							   				
					   				cadena+="<td>DURACION DE SEMANAS</td>";
					   				cadena+="<td>TIPO</td>";
					   				
					   				if (permiso.pensum.insert)
					   				{
					   					cadena+="<td>VER</td>";
					   				cadena+="<td><button class='btn btn-success' title='Agregar Unidad Curricular' onclick='preAgregarUnidadCurricular("+trayecto['codigo']+","+trayecto['numTrayecto']+","+trayecto['codPensum']+")'><i class='icon-plus'></i></button></td>";
					   				}
					   				
					   				
					   			cadena+="</tr>";

						for (j=0; j<unidades.length;j++)
						{				   			
							var unidad = unidades[j];						
							if (unidad['codigo'] != null)
							{					
								cadena+="<tr class='contenido'>";							
								cadena+="<td>"+unidad['nombre']+"</td>"; 
								cadena+="<td>"+unidad['codUnidad']+"</td>"; 
								cadena+="<td>"+unidad['hti']+"</td>";
								cadena+="<td>"+unidad['hta']+"</td>";								
								cadena+="<td>"+unidad['uniCredito']+"</td>"; 
								cadena+="<td>"+unidad['notMinima']+"/"+unidad['notMaxima']+"</td>"; 								
								cadena+="<td>"+unidad['durSemana']+"</td>";
								cadena+="<td>"+unidad['tipo']+"</td>"; 						   		
							    if (permiso.pensum.insert)
							    {
							    cadena+="<td><button class='btn btn-warning' title='Ver Unidad Curricular' onclick='verUnidadCurricular("+unidad['codigo']+","+trayecto['numTrayecto']+","+trayecto['codPensum']+","+trayecto['codigo']+")'><i class='icon-eye-open'></i></button></td>";
							   	cadena+="<td><button class='btn btn-danger' title='Eliminar Unidad Curricular' onclick='eliminarUnidadCurricular("+unidad['codigo']+")'><i class='icon-remove'></i></button></td>";   
							    }	
							   	
							}
						}
						cadena+="</tr>";
						cadena+="</tr>";
						cadena+="</table>";						
						cadena+="</div>";				
			  			cadena+="</div>";	  			
			  			cadena+="</div>";
			}
		cadena+="</div>";
		$(cadena).appendTo('#accordiontray');		
		if (permiso.pensum.insert){$("<div class='row'><div class='col-md-4' id='botones'><button class='btn btn-success' onclick='preAgregarTrayecto("+pensum['codigo']+")'>Agregar Trayecto</button></div></div>").appendTo("#divtrayecto");}
		$("<div class='col-md-6'><button class='btn btn-danger' onclick=\"window.location.assign('index.php?m_modulo=trayecto&m_accion=verTrayectosPensumPDF&m_vista=verPensumTrays&m_formato=pdf&codigoPensum="+trayecto['codPensum']+"')\"><i class='icon-book'></i> Exportar en PDF</button></div><br><br>").appendTo("#botones");
		$("<input type='text' value="+pensum['codigo']+" hidden='hidden' id='inputPen'>").appendTo("#inputPensum");
	}else{*/
		$("<div class='row'><div class='col-md-4' id='botones'><button class='btn btn-success' onclick='preAgregarTrayecto("+pensum['codigo']+")'>Agregar Trayecto</button></div></div>").appendTo("#divtrayecto");
		$("<input type='text' value="+pensum['codigo']+" hidden='hidden' id='inputPen'>").appendTo("#inputPensum");
		preAgregarTrayecto(pensum['codigo']);
	//}
}

function infoTrayRecargar(pensum){
	cadena="";
	var trayectos = pensum['trayectos'];
	if(trayectos[0]['codigo']!=null){
		for (var i=0; i<trayectos.length; i++)		
			{
				var num=i+1;
				var trayecto = trayectos[i];
				var unidades = trayecto['unidades'];
				var unidad1 = unidades[0];
				var cod_trayecto = unidad1['codTrayecto'];			
					var num_unit = unidades.length;
			      cadena+="<div class='panel panel-default' id='idenueva"+num+"'>";
			      	cadena+="<div class='panel-heading' role='tab' id='headerT"+num+"'>";
				  		cadena+="<h4 class='panel-title'>"; 
				  			cadena+="<a data-toggle='collapse' data-parent='#accordion' href='#collapse"+num+"' aria-expanded='true' aria-controls='collapseOne'>";  											
							//=====================================================PANEL=============================================================================
								cadena+="<b><center>Trayecto "+trayecto['numTrayecto']+"</center></b><button class='btn btn-danger pull-right' title='Eliminar Trayecto' onclick='eliminarTrayecto("+trayecto['codPensum']+","+trayecto['numTrayecto']+")'><i class='icon-remove'></i></button>"+"<button class='btn btn-primary pull-right' title='Ver Trayecto' onclick='verTrayecto("+trayecto['codPensum']+","+trayecto['numTrayecto']+")'><i class='icon-eye-open'></i></button>";	
							//=========================================================================================================================================		  				
				  		cadena+="</a>";
				 	 	cadena+="</h4>";
				  	cadena+="</div>";
				  	cadena+="<div id='collapse"+num+"' class='panel-collapse collapse' role='tabpanel' aria-labelledby='headingOne'>";
				  	cadena+="<div class='panel-body'>";		  	
				  	cadena+="<table class='table table-bordered'>";
				  	cadena+="<tr class='titulo'>";
					   			
					   				cadena+="<td>NOMBRE DE UNIDAD CURRICULAR</td>";
						   				cadena+="<td>CODIGO DE UNIDAD CURRICULAR</td>";
						   				cadena+="<td>HORAS DE TRABAJO INDEPENDIENTE</td>";
						   				cadena+="<td>HORAS DE TRABAJO ACOMPAÑADO</td>";					   				
						   				cadena+="<td>UNIDADES DE CREDITO</td>";	
						   				cadena+="<td>NOTA APROBATORIA</td>";					   							   				
						   				cadena+="<td>DURACION DE SEMANAS</td>";
						   				cadena+="<td>TIPO</td>";
						   				cadena+="<td>VER</td>";
					   				cadena+="<td><button class='btn btn-success' title='Agregar Unidad Curricular' onclick='preAgregarUnidadCurricular("+trayecto['codigo']+","+trayecto['numTrayecto']+","+trayecto['codPensum']+")'><i class='icon-plus'></i></button></td>";
					   			cadena+="</tr>";

						for (j=0; j<unidades.length;j++)
						{				   			
							var unidad = unidades[j];						
							if (unidad['codigo'] != null)
							{					
								cadena+="<tr class='contenido'>";
								
								cadena+="<td>"+unidad['nombre']+"</td>"; 
									cadena+="<td>"+unidad['codUnidad']+"</td>"; 
									cadena+="<td>"+unidad['hti']+"</td>";
									cadena+="<td>"+unidad['hta']+"</td>";								
									cadena+="<td>"+unidad['uniCredito']+"</td>"; 
									cadena+="<td>"+unidad['notMinima']+"/"+unidad['notMaxima']+"</td>"; 								
									cadena+="<td>"+unidad['durSemana']+"</td>";
									cadena+="<td>"+unidad['tipo']+"</td>"; 								   		
							   	cadena+="<td><button class='btn btn-warning' title='Ver Unidad Curricular' onclick='verUnidadCurricular("+unidad['codigo']+","+trayecto['numTrayecto']+","+trayecto['codPensum']+","+trayecto['codigo']+")'><i class='icon-eye-open'></i></button></td>";
							   	cadena+="<td><button class='btn btn-danger' title='Eliminar Unidad Curricular' onclick='eliminarUnidadCurricular("+unidad['codigo']+")'><i class='icon-remove'></i></button></td>";   
							}
						}
						cadena+="</tr>";
						cadena+="</tr>";
						cadena+="</table>";						
						cadena+="</div>";				
			  			cadena+="</div>";	  			
			  			cadena+="</div>";
			}
		cadena+="</div>";
		$(cadena).appendTo('#accordiontray2');	
		$("<div class='row'><div class='col-md-4' id='botones'><button class='btn btn-success' onclick='preAgregarTrayecto("+pensum['codigo']+")'>Agregar Trayecto</button></div></div>").appendTo("#divtrayecto");	
		$("<div class='col-md-6'><button class='btn btn-danger' onclick=\"window.location.assign('index.php?m_modulo=trayecto&m_accion=verTrayectosPensumPDF&m_vista=verPensumTrays&m_formato=pdf&codigoPensum="+trayecto['codPensum']+"')\"><i class='icon-book'></i> Exportar en PDF</button></div><br><br>").appendTo("#botones");
		$("<input type='text' value="+pensum['codigo']+" hidden='hidden' id='inputPen'>").appendTo("#inputPensum");
	}else{
		$("<div class='row'><div class='col-md-4' id='botones'><button class='btn btn-success' onclick='preAgregarTrayecto("+pensum['codigo']+")'>Agregar Trayecto</button></div></div>").appendTo("#divtrayecto");
		$("<input type='text' value="+pensum['codigo']+" hidden='hidden' id='inputPen'>").appendTo("#inputPensum");
		preAgregarTrayecto(pensum['codigo']);
	}
}

function buscarListar(patron){
	var arr = Array("m_modulo"	,	"pensum",
					"m_accion"	,	"listar",
					"patron"	,	patron);
	ajaxMVC(arr,successListarAjax,errorListarAjax);
}

function successListarAjax(data){
	if(data.estatus > 0){
		recargar(data.pensum);
	}
}

function errorListarAjax(data){}

function recargarPensum(){
	var arr = Array ("m_modulo", "pensum",
				     "m_accion", "listar");
	ajaxMVC(arr,actualizarLista,errorRecargarPensum);
}

function errorRecargarPensum(data){mostrarMensaje("Error al recargar la pagina",2);}

function actualizarLista(data){
	console.log(data);
	if(data.estatus>0){
		$('#table').remove();
		$('#table_wrapper').remove();

		cadena="<table class='table table-advance' id='table'>";
		cadena+="<thead>";	
			cadena+="<tr>";
				cadena+="<th>N°</>";
                cadena+="<th>Nombre Pesum</th>";
                cadena+="<th>Nombre Corto</th>";		            
                cadena+="<th>Modificar</th>";
                cadena+="<th>Eliminar</th>";			 
	        cadena+="</tr>";
		cadena+="</thead>";	
		cadena+="<tbody>";
		for (i=0;i<data.pensum.length;i++){
		/*	cadena+="<tr>";
			cadena+=" <td style='text-align:left;'>"+data.pensum[i]['nombre']+"</td>";
			cadena+=" <td>"+data.pensum[i]['nom_corto']+"</td>";
			if (data.pensum[i]['direccion']=="")
				cadena+="<td>No asignada</td>";
			else
				cadena+="<td>"+data.pensum[i]['direccion']+"</td>";
			cadena+="<td>";
			
			cadena+="<button type='button' onClick='modificarInstituto("+data.pensum[i]['codigo']+")' data-toggle='modal' data-target='#dialogoInstituto' title='Modificar Instituto'>";
			cadena+="<i class='icon-pencil'></i>"
			cadena+="</button>";
			
			cadena+="</td>";
			cadena+="<td>"
		
			cadena+="<button type='button' onClick='eliminarInstituto("+data.pensum[i]['codigo']+")' data-toggle='modal' data-target='#dialogoInstituto' title='Eliminar Instituto'>"
			cadena+="<i class='icon-trash'></i>"
			cadena+="</button>";
		
			cadena+="</td>";
			cadena+="</tr>"; */
			cadena+="<tr >";				
				cadena+="<td><a href='#' onmouseover='verDetalle("+data.pensum[i]['codigo']+")' >"+i+"</a></td>";
				cadena+="<td><a href='#'  onmouseover='verDetalle("+data.pensum[i]['codigo']+")'>"+data.pensum[i]['nombre']+"</a></td>";
				cadena+="<td><a href='#'  onmouseover='verDetalle("+data.pensum[i]['codigo']+")'>"+data.pensum[i]['nom_corto']+"</a></td>";
				cadena+="<td>";
				cadena+="<button class='btn btn-info' title='Informacion del Pensum' onclick='agregarInfPen("+data.pensum[i]['codigo']+")'>";
				cadena+="<i class='icon-pencil'></i>";
				cadena+="</button>";
				cadena+="</td>";	
				cadena+="<td>";
				cadena+="<button class='btn btn-danger' title='Eliminar Pensum' onclick='eliminarPensum("+data.pensum[i]['codigo']+");' data-toggle='modal' data-target='#dialogoPensum' title='Eliminar Instituto' >";
						cadena+="<i class='icon-remove'></i>";
					cadena+="</button>";
				cadena+="</td>";
			cadena+="</tr>";

		
		}
		cadena+="</table>";
		cadena+="<tbody>";
		$(cadena).appendTo("#listarI");

	//	alert('hola');
		$('#table').DataTable();
	}
	else 
		mostrarMensaje(data.mensaje,2);
}


/*
consulta todo los detalles
*/
function consultarDetallePen(data) {
//	console.log(data)
	if (data.estatus>0){
		
		pensum=data.pensum[0];
	//	console.log(pensum)
		cadena="";
		
		cadena+="<div id='detallePen' class='third'>";
		cadena+="<table id='pesum' class='table table-bordered table-striped' style='clear: both'><tbody>";
		cadena+="<tr><td style='width: 35%;''>Codigo:</td><td style='width: 65%;'><a href='#'' >"+pensum[0]+"</a></td></tr>";
		cadena+="<tr><td>Nombre:</td><td>";
		cadena+="<a href='#'' >"+pensum[1]+"</a></td></tr>";
		cadena+="<tr><td>Nombre Corto:</td><td>";
		cadena+="<a href='#'' >"+pensum[2]+"</a></td></tr>";		
		cadena+="<tr><td>Observaciones:</td><td>";
		cadena+="<a href='#'' >"+pensum[3]+"</a></td></tr>";
		cadena+="<tr><td>Minima cantidad electiva:</td><td>";
		cadena+="<a href='#'' >"+pensum[4]+"</a></td></tr>";	
		cadena+="<tr><td>Minima credito electiva:</td><td>";
		cadena+="<a href='#'' >"+pensum[5]+"</a></td></tr>";	
		cadena+="<tr><td>Minima credito obligatorio:</td><td>";
		cadena+="<a href='#'' >"+pensum[6]+"</a></td></tr>";
		cadena+="<tr><td>Fecha de Creación:</td><td>";
		cadena+="<a href='#'' >"+pensum[7]+"</a></td></tr>";	
		cadena+="</tbody></table></div>";
	//	$("#detallePen").html(cadena);
	//	alert(cadena);
		//$(cadena).appendTo('#detallePen');
		$("div.third").replaceWith(cadena);
	}
}

/*ver pensum consulta pensum simple*/
function verDetalle(codigo){	
	var arr = Array ("m_modulo","pensum",
	 				 "m_accion","buscarPensum",
	 				 "codigo",codigo);
	ajaxMVC(arr,consultarDetallePen,errorBuscarPensum); 
}

function succObtenerE(data){
	if(data.estatus>0){
		$("<h3> Esta seguro que quiere eliminar el Pensum ?</h3>").appendTo(".modal-body");
		cadena="<input type='hidden' value='"+data.pensum[0]['codigo']+"' class='form-control' placeholder='codigo Pensum' id='codigoI'>";
		$(cadena).appendTo(".modal-body");
		
		$("<br>").appendTo(".modal-body");
		cadena= "<h4>Codigo : "+data.pensum[0]['codigo']+"</h4>";
		$(cadena).appendTo(".modal-body");
		cadena= "<h4>Nombre: "+data.pensum[0]['nombre']+"</h4>";
		$(cadena).appendTo(".modal-body");
		cadena= "<h4>Nombre Corto : "+data.pensum[0]['nom_corto']+"</h4>";
		$(cadena).appendTo(".modal-body");
		
	}
	else 
		mostrarMensaje(data.mensaje,2);
}

function error(data){
		mostrarMensaje("error error: " + data.responseText,2);
}