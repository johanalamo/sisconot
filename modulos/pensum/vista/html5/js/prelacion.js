function err(data){
	alert("err");
	console.log(data);
}

function errorSelect(data){
mostrarMensaje("Error Cargando Select consultar LOG",2);
console.log(data);}



function cargarPensums(){

	var arr = Array("m_modulo"		,	"pensum",
					"m_accion"		,	"buscarPorInstituto",
					"codigo" 		, 	$("#selInst").val()[0]);

	ajaxMVC(arr,succCargarPensums,errorSelect);
}

function cargarInstitutos(){
	var arr = Array("m_modulo"		,		"instituto",
					"m_accion"		,		"listar");

	ajaxMVC(arr,succCargarInstitutos,err);
}

function cargarUnidadCurricular(){
		var arr = Array("m_modulo"		,		"unidad",
					"m_accion"		,		"listarUnidades");

	ajaxMVC(arr,ssccCargaUnidadesC,err);
}

function ssccCargaUnidadesC(data){

	var ins = data.unidades;
	var cad = "";

	cad += "<select class='selectpicker' id='selUnidad' onchange='obtenerCodigo(1)' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Unidad Curricular'>";

	if(ins){
		for(var i = 0; i < ins.length; i++){
			cad += "<option value="+ins[i][0]+">"+ins[i][2]+"</option>";
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

	var cad = "";

	cad += "<select class='selectpicker' id='selUnidadP' onchange='obtenerCodigo(2)' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Unidad Curricular Prelada'>";

	if(ins){
		for(var i = 0; i < ins.length; i++){
			cad += "<option value="+ins[i][0]+">"+ins[i][2]+"</option>";
		}
		cad += "</select>";
	}
	else{
		cad += "<option></option>";
	}

	$("#selUnidadP").selectpicker("destroy");
	$("#divUniP").append(cad);
	$("#selUnidadP").selectpicker();
}

function obtenerCodigo(selUnidad){
	console.log(selUnidad)
	if (selUnidad == 1){
		$("#codigoUnidadC").val($("#selUnidad").val());
	}else{
		$("#codigoUnidadCP").val($("#selUnidadP").val());
	}
	//alert("#"+selUnidad) ;
}

function succCargarInstitutos(data){
	console.log(data);
	var ins = data.institutos;
	var cad = "";

	cad += "<select class='selectpicker' id='selInst' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Instituto'>";

	if(ins){
		for(var i = 0; i < ins.length; i++){
			cad += "<option value="+ins[i][0]+">"+ins[i]['nombre']+"</option>";
		}
		cad += "</select>";
	}
	else{
		cad += "<option></option>";
	}
	console.log(cad)
	$("#selInst").selectpicker("destroy");
	$("#divInst").append(cad);
	$("#selInst").selectpicker();
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
	   }else{
	   	alert('No posee codigo Pensum en url');
	   }
}

