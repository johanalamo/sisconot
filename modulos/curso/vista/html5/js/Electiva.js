$( document ).ready(function() {
	activarCal();
	setSelects();
});

function setSelects (){
	var arr = Array("m_modulo","persona");

	ajaxMVC(arr,succSetSelects,errAjax);
}

function succSetSelects(data){
	//alert(data.datos[0].toSource());
	//alert(data.datos[0]['est_pensum']);
	var pensum=data.datos[0]['emp_pensum'];
	var jc= data.datos[0]['es_jef_con_estudio'];
	var instituto=data.datos[0]['emp_inst'];


	verInstitutos(instituto);
	
	verPensuma(pensum,jc,instituto);

	verPeriodo(instituto,jc,pensum);

	if(!jc)
		listarElectivas();

	borrarCamposElectiva(jc);
}

function borrarCamposElectiva(jc){

	if(jc){
		$("#SelectPensum").val("-1");
		verPeriodo();			
		$("#SelectPeriodo").val("-1");	
	}
	else
		$("#SelectPeriodo").val("-1");

	$("#seccion").val("");
	$("#capacidad").val("");
	$("#docentes").val("");
	$("#docente").val("");
	$("#unidadCurricular").val("");
	$("#uniCurricular").val("");
	$("#fecInicio").val("");
	$("#fecFin").val("");
	$("#observacion").val("");
	$("#codigo").val("");
	if(!jc)
		$(".selectpicker").selectpicker("refresh");
}

function borrarElectiva(){

}

function modificarElectiva(){

}

function verInstitutos(codigo){

	if(!codigo)
		codigo=-1;

	var arr=Array("m_modulo"	,		"instituto",
				  "m_accion"	,		"obtener",
				  "codigo"		,		codigo
				);
	ajaxMVC(arr,succInstituto,errAjax);

}

function succInstituto(data){

	var cad ='';
	$("#IdSelectInstituto").remove();

	cad="<div id='IdSelectInstituto'> Instituto";
	cad+= "<select  class='selectpicker' id='SelectInstituto' title='tipo unidad curricular' data-live-search='true' data-size='auto' data-max-options='12' disabled>";
	cad+= "<option value='-1' >Seleccionar</option>";
	if(data.instituto){
		for(var x=0; x<data.instituto.length;x++){
			cad+= "<option value='"+data.instituto[x]['codigo']+"' >"+data.instituto[x]['nom_corto']+"</option>";
		}
	}
	cad+="</select>";
	cad+="</div>";
	$(cad).appendTo('#institutos');
	activarSelect();
	$("#SelectInstituto").val(data.datos[0]['emp_inst']);
	$("#SelectInstituto").selectpicker("refresh");
}

function verPensuma(codigo,jc,instituto){

	if(!codigo)
		codigo=-1;
	if(jc){
		var accion="buscarPorInstituto";
		codigo=instituto;
	}
	else{
		var accion ="buscarPensum";
	}

	var arr=Array("m_modulo"	,		"pensum",
				  "m_accion"	,		accion,
				  "codigo"		,		codigo
				);
	ajaxMVC(arr,succPensum,errAjax);

}

function succPensum(data){

	var pensum=data.datos[0]['emp_pensum'];
	var jc= data.datos[0]['es_jef_con_estudio'];
	var instituto=data.datos[0]['emp_inst'];
	var cad ='';

	$("#IdSelectPensum").remove();

	cad="<div id='IdSelectPensum'> Pensum";
	if(data.datos[0]['es_jef_con_estudio'])
		cad+= "<select class='selectpicker' onchange='verPeriodo("+instituto+","+jc+","+pensum+");' id='SelectPensum' title='tipo unidad curricular' data-live-search='true' data-size='auto' data-max-options='12' >";
	else
		cad+= "<select class='selectpicker'  id='SelectPensum' title='tipo unidad curricular' data-live-search='true' data-size='auto' data-max-options='12' disabled>";

	cad+= "<option value='-1' >Seleccionar</option>";
	if(data.pensum){

		for(var x=0; x<data.pensum.length;x++){
			cad+= "<option value='"+data.pensum[x]['codigo']+"' >"+data.pensum[x][2]+"</option>";
		}
	}

	cad+="</select>";
	cad+="</div>";
	$(cad).appendTo('#pensuma');
	activarSelect();
	if(!data.datos[0]['es_jef_con_estudio']){
		$("#SelectPensum").val(data.datos[0]['emp_pensum']);
		$("#SelectPensum").selectpicker("refresh");
	}	

}


function verPeriodo (instituto,jc,pensum){

	if(jc)
		pensum=$("#SelectPensum").val();

	var arr=Array("m_modulo"	,	"periodo",
				  "m_accion"	,	"periodoInsPenEstado",
				  "instituto"	,	instituto,
				  "pensum"		,	pensum,
				  "estado"		,	'A'
				);
	ajaxMVC(arr,succPerido,errAjax);
}

function succPerido(data){

	var cad ='';
	$("#IdSelectPeriodo").remove();

	cad="<div id='IdSelectPeriodo'> Periodo";
	cad+= "<select class='selectpicker' id='SelectPeriodo' onchange='listarElectivas();' title='tipo unidad curricular' data-live-search='true' data-size='auto' data-max-options='12' >";
	cad+= "<option value='-1' >Seleccionar</option>";
	if(data.periodo){
		for(var x=0; x<data.periodo.length;x++){
			cad+= "<option value='"+data.periodo[x]['codigo']+"' >"+data.periodo[x]['nombre']+"</option>";
		}
	}
	cad+="</select>";
	cad+="</div>";
	$(cad).appendTo('#periodo');
	activarSelect();
}

function autoCompletarUniCurricularPensum(){

	$(".uniCurricular").autocomplete({
			delay: 200,  //milisegundos
			minLength: 1,
			source: function( request, response ) {

				var a=Array("m_modulo"		,		"unidad",
							"m_accion"		,		"uniCurPensum",
							"patron"		,		request.term,
							"pensum"		,		$("#SelectPensum").val(),
							"tipo"			,		"E"
							);

				ajaxMVC(a,function(data){
							return response(data);
						  },
						  function(data){
							return response([{"label": "Error de conexión", "value": {"nombreCorto":""}}]);

						   }
						);

			},
			select: function (event, ui){
				if(ui.item.value == "null"){
					$(this).val("");
					event.preventDefault();
					$("#doc"+$(this).attr("id")).val("");
					$("#uniCurricular").val('');
					$("#detallePen").remove();

				}
				else{
					$(this).val(ui.item.label);
					event.preventDefault();
					var codigo =ui.item.value;
					verDetalle(codigo);
					$("#uniCurricular").val(codigo);
				}


			},
			focus: function (event, ui){
				if(ui.item.value == "null"){
					$(this).val("");
					event.preventDefault();
					$("#uniCurricular").val('');
					$("#detallePen").remove();

				}
				else{
					$(this).val(ui.item.label);
					event.preventDefault();
					var codigo =ui.item.value;
					$("#uniCurricular").val(codigo);
					verDetalle(codigo);
				}
			}
	});
}

function guardarElectiva(){

	var arr=Array("m_modulo"	,	"curso",
				  "m_accion"	,	"guardarElectiva",
				  "periodo"		,	$("#SelectPeriodo").val(),
				  "seccion"		,	$("#seccion").val(), 
				  "capacidad"	,	$("#capacidad").val(),
				  "docente"		,	$("#docente").val(),
				  "uniCurricular",	$("#uniCurricular").val(),
				  "fecInicio"	,	$("#fecInicio").val(),
				  "fecFin"		,	$("#fecFin").val(),
				  "observacion"	,	$("#observacion").val(),
				  "codigo"		,	$("#codigo").val()
				);
	ajaxMVC(arr,succGuardarElectiva,errAjax);

}

function succGuardarElectiva(data){

	if(data.estatus>0){
		mostrarMensaje(data.mensaje,1);
		listarElectivas();
	}
	else
		mostrarMensaje(data.mensaje,2);
}

function listarElectivas(){
	var arr=Array("m_modulo"	,		"curso",
				  "m_accion"	,		"listarCurElectivas",
				  "pensum"		,		$("#SelectPensum").val(),
				  "periodo"		,		$("#SelectPeriodo").val()
				);
	ajaxMVC(arr,succListarElectivas,errAjax);
}

function succListarElectivas(data){

	$("#listarElectiva").remove();
	var cad="";
	cad="<tbody id='listarElectiva' >";
	if(data.electivas){
		for(var x=0; x<data.electivas.length;x++){
			var dat=data.electivas[x];

			cad+="	<tr onclick='buscarElectiva("+dat['codigo']+");'>";
			cad+="	  <td>"+(x+1)+"</td>";
			cad+="	  <td>"+dat['codigo']+"</td>";
			cad+="	  <td>"+dat['nombre']+"</td>";
			cad+="	  <td>"+dat['capacidad']+"</td>";
			cad+="	  <td>"+dat['nom_persona']+"</td>";
			cad+="	  <td>"+dat['fec_inicio']+"</td>";
			cad+="	  <td>"+dat['fec_final']+"</td>";
			cad+="	  <td>"+dat['observaciones']+"</td>";
			cad+="	</tr>";       		
		}
	}
	cad+="</tbody>";
	$(cad).appendTo('#tablaElectiva');
}

function buscarElectiva(codigo){

	var arr=Array("m_modulo"	,		"curso",
				  "m_accion"	,		"buscarCurElectiva",
				  "codigo"		,		codigo
				);
	ajaxMVC(arr,succbuscarElectiva,errAjax);
}

function succbuscarElectiva(data){

	var jc= data.datos[0]['es_jef_con_estudio'];
	var dat=data.electiva[0];

	if(jc){
		$("#SelectPensum").val(dat['cod_pensum']);
		setTimeout(function() {
			verPeriodo($("#SelectInstituto").val(),jc,$("#SelectPensum").val());
		}, 200);
		setTimeout(function() {
			
			$("#SelectPeriodo").val(dat['cod_periodo']);
			$(".selectpicker").selectpicker("refresh");
		}, 350);
		
	}
	else
		$("#SelectPeriodo").val(dat['cod_periodo']);

	$("#seccion").val(dat['seccion']);
	$("#capacidad").val(dat['capacidad']);
	$("#docentes").val(dat['nom_persona']);
	$("#docente").val(dat['cod_docente']);
	$("#unidadCurricular").val(dat['nombre']);
	$("#uniCurricular").val(dat['cod_uni_curricular']);
	$("#fecInicio").val(dat['fec_inicio']);
	$("#fecFin").val(dat['fec_final']);
	$("#observacion").val(dat['observaciones']);
	$("#codigo").val(dat['codigo']);
	if(!jc)
		$(".selectpicker").selectpicker("refresh");
}

function autocompletarDocentes(){

	$(".docentes").autocomplete({
			delay: 200,  //milisegundos
			minLength: 1,
			source: function( request, response ) {
				var a=Array("m_modulo"		,		"empleado",
							"m_accion"		,		"auto",
							"patron"		,		request.term,
							"instituto"		,		$("#SelectInstituto").val(),
							"pensum"		,		$("#SelectPensum").val(),
							"completo"		, 		true
							);

				ajaxMVC(a,function(data){
					console.log(data);
							return response(data);
						  },
						  function(data){
							return response([{"label": "Error de conexión", "value": {"nombreCorto":""}}]);

						   }
						);

			},
			select: function (event, ui){
				if(ui.item.value == "null"){
					$(this).val("");
					event.preventDefault();
					$("#docente").val("");
				}
				else{
					$(this).val(ui.item.label);
					event.preventDefault();
					$("#docente").val(ui.item.value);
					
				}

			},
			focus: function (event, ui){
				if(ui.item.value == "null"){
					$(this).val("");
					event.preventDefault();
					$("#docente").val("");
				}
				else{
					$(this).val(ui.item.label);
					event.preventDefault();
					$("#docente").val(ui.item.value);
				}
			}
	});
}



