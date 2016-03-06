
function cargarUnidadCurricular(){
		var arr = Array("m_modulo"		,		"unidad",
					"m_accion"		,		"buscarUniCurricularPorPensum",
					"codigo" 		, 	$("#codigoPensum").val()
					);

	ajaxMVC(arr,ssccCargaUnidadesC,err);
}



function ObtenerIDPensum(){
	
	var loc = document.location.href;	
	var getString = loc.search("codigoPensum");	
	 if (getString != -1){
       	 getString+=13;
	     var a = loc.substring(getString,getString+25);
	//     console.log(a);
	     $("#codigoPensum").val(a);
	//     alert( $("#codigoPensum").val());
			return true;
	   }else{
	   	alert('No posee codigo Pensum en url');
	   		return false;
	   }
}



function ssccCargaUnidadesC(data){

	console.log(data)
	var ins = data.pensum;
	var cad = "";

	cad += "<select class='selectpicker' id='selUnidad' onchange='obtenerCodigo()' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Unidad Curricular'>";

	if(ins){
		for(var i = 0; i < ins.length; i++){
			cad += "<option value="+ins[i]["cod_uni_curricular"]+">"+ins[i]["nombre"]+"</option>";
		}
		cad += "</select>";
	}
	else{
		cad += "<option></option>";
	}

	$("#selUnidad").selectpicker("destroy");
	$("#divUni").append(cad);
	$("#selUnidad").selectpicker();

	console.log(data);	
}


function err(data){
	alert("err");
	console.log(data);
}

function obtenerCodigo(selUnidad){
		$("#codigoUni").val($("#selUnidad").val());	
	//alert("#"+selUnidad) ;
}