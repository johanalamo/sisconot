$( document ).ready(function() {
	verInstitutos();
	verPensum();
	verPeriodo ();
	activarCal();
	borrarCamposElectiva();
});

function borrarCamposElectiva(){

}

function borrarElectiva(){

}

function modificarElectiva(){

}

function verInstitutos(){

	var arr=Array("m_modulo"	,		"instituto",
				  "m_accion"	,		"listar"
				);
	ajaxMVC(arr,succInstituto,errAjax);

}

function succInstituto(data){

	var cad ='';
	$("#IdSelectInstituto").remove();

	cad="<div id='IdSelectInstituto'> Instituto";
	cad+= "<select onchange='verPensum();' class='selectpicker' id='SelectInstituto' title='tipo unidad curricular' data-live-search='true' data-size='auto' data-max-options='12' >";
	cad+= "<option value='-1' >Seleccionar</option>";
	if(data.institutos){
		for(var x=0; x<data.institutos.length;x++){
			cad+= "<option value='"+data.institutos[x]['codigo']+"' >"+data.institutos[x]['nom_corto']+"</option>";
		}
	}
	cad+="</select>";
	cad+="</div>";
	$(cad).appendTo('#institutos');
	activarSelect();
}

function verPensum(){

	var arr=Array("m_modulo"	,		"pensum",
				  "m_accion"	,		"buscarPorInstituto",
				  "codigo"		,		$("#SelectInstituto").val()
				);
	ajaxMVC(arr,succPensum,errAjax);

}

function succPensum(data){

	var cad ='';
	$("#IdSelectPensum").remove();

	cad="<div id='IdSelectPensum'> Pensum";
	cad+= "<select class='selectpicker' onchange='verPeriodo();' id='SelectPensum' title='tipo unidad curricular' data-live-search='true' data-size='auto' data-max-options='12' >";
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

}


function verPeriodo (){

	var arr=Array("m_modulo"	,	"periodo",
				  "m_accion"	,	"periodoInsPenEstado",
				  "instituto"	,	$("#SelectInstituto").val(),
				  "pensum"		,	$("#SelectPensum").val(),
				  "estado"		,	'A'
				);
	ajaxMVC(arr,succPerido,errAjax);
}

function succPerido(data){

	var cad ='';
	$("#IdSelectPeriodo").remove();

	cad="<div id='IdSelectPeriodo'> Periodo";
	cad+= "<select class='selectpicker' id='SelectPeriodo' title='tipo unidad curricular' data-live-search='true' data-size='auto' data-max-options='12' >";
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


