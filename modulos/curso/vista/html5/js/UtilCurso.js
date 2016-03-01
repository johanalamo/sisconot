
function succ(data){
	alert("succ");
	console.log(data);
}

function err(data){
	alert("err");
	console.log(data);
}

function cargarInstitutos(){
	var arr = Array("m_modulo"		,		"instituto",
					"m_accion"		,		"listar");

	ajaxMVC(arr,succCargarInstitutos,err);
}

function succCargarInstitutos(data){
	var ins = data.institutos;
	var cad = "";

	cad += "<select class='selectpicker' id='selInst' onchange='cargarPensums()' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Instituto'>";

	if(ins){
		for(var i = 0; i < ins.length; i++){
			cad += "<option value="+ins[i][0]+">"+ins[i]['nombre']+"</option>";
		}
		cad += "</select>";
	}
	else{
		cad += "<option></option>";
	}

	$("#selInst").selectpicker("destroy");
	$("#divInst").append(cad);
	$("#selInst").selectpicker();
}

function cargarPensums(){

	var arr = Array("m_modulo"		,	"pensum",
					"m_accion"		,	"buscarPorInstituto",
					"codigo" 		, 	$("#selInst").val()[0]);

	ajaxMVC(arr,succCargarPensums,err);
}

function succCargarPensums(data){
	var pen = data.pensum;
	var cad = "";

	cad += "<select class='selectpicker' id='selPen' onchange='cargarPeriodos()' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Pensum'>";

	if(pen){

		for(var i = 0; i < pen.length; i++){
			cad += "<option value="+pen[i][0]+">"+pen[i][1]+"</option>";
		}

	}
	else{
		mostrarMensaje("No hay pensums para este instituto.",3);
	}
	cad += "</select>";

	$("#selPen").selectpicker('destroy');
	$("#divPen").append(cad);
	$("#selPen").selectpicker();

	$("#selPer").selectpicker('destroy');
	if($("#divEstudiante").length > 0)
		$("#divPer").append("<select class='selectpicker' id='selPer' onchange='cargarEstudiantes()' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Periodo'></select>");
	else {
		$("#divPer").append("<select class='selectpicker' id='selPer'  data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Periodo'></select>");
	}

	$("#selPer").selectpicker();
}

function cargarPeriodos(){
	var arr = Array("m_modulo"		,		"periodo",
					"m_accion"		,		"listarPeriodos",
					"codPensum"		,		$("#selPen").val()[0]);

	ajaxMVC(arr,succCargarPeriodos,err);
}

function succCargarPeriodos(data){

	var per = data.periodos;
	var cad = "";

	if($("#divEstudiante").length > 0){
		cad += "<select class='selectpicker' id='selPer' onchange='cargarEstudiantes()' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Periodo'>";
	}
	else {
		cad += "<select class='selectpicker' id='selPer' onchange='cargarTrayectos()' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Periodo'>";
	}
	if(per){
		for(var i = 0; i < per.length; i++){
			cad += "<option value="+per[i][0]+">"+per[i][1]+"</option>";
		}
	}
	else{
		cad += "<option></option>";
		mostrarMensaje("No hay periodos abiertos para este pensum.",2);
	}

	cad += "</select>";

	$("#selPer").selectpicker('destroy');
	$("#divPer").append(cad);
	$("#selPer").selectpicker();
}

function cargarTrayectos(){
	var arr = Array("m_modulo"		,		"pensum",
					"m_accion"		,		"buscarPorTrayecto",
					"codigo"		,		$("#selPen").val()[0]);

	ajaxMVC(arr,succCargarTrayectos,err);
}

function succCargarTrayectos(data){
	console.log(data);
	var tra = data.pensum;
	var cad = "";

	if(tra){
		for(var i = 0; i < tra.length; i++){
			cad += "<option value="+tra[i]['codigo']+">Trayecto "+tra[i]['num_trayecto']+"</option>";
		}
	}
	else{
		cad += "<option>"+data.mensaje+"</option>";
	}


	$("#selTra").append(cad).selectpicker('refresh');;
	//$("#divTra").show();
}

function cargarSeccion(){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"buscarSeccionPorTrayecto",
					"codTrayecto"	,		$("#selTra").val()[0]);

	ajaxMVC(arr,succCargarSeccion,err);
}

function succCargarSeccion(data){
	var sec = data.secciones;
	var cad = "";

	if(sec){
		for(var i = 0; i < sec.length; i++){
			cad += "<option value="+sec[i][0]+">Sección "+sec[i][0]+"</option>";
		}
	}
	else{
		cad += "<option>"+data.mensaje+"</option>";
	}


	$("#selSec").append(cad).selectpicker('refresh');;
	//$("#divSec").show();
}

function cargarUni(){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"listarUniCurricular",
					"seccion"		,		$("#selSec").val()[0],
					"pensum"		,		$("#selPen").val()[0],
					"trayecto"		,		$("#selTra").val()[0],
					"periodo"		,		$("#selPer").val()[0]);

	ajaxMVC(arr,succCargarUni,err);
}

function succCargarUni(data){
	var uni = data.uni;
	var cad = "";

	if(uni){
		for(var i = 0; i < uni.length; i++){
			cad += "<option value="+uni[i]['codigo']+">"+uni[i]['nombre']+"</option>";
		}
	}
	else{
		cad += "<option></option>";
	}


	$("#selUni").append(cad).selectpicker('refresh');
}


function listarCursos(){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"listarCursos",
					"codInstituto"	,		$("#selInst").val()[0],
					"codPensum"		,		$("#selPen").val()[0],
					"codPeriodo"	,		$("#selPer").val()[0],
					"patron"		,		$("#patron").val());

	ajaxMVC(arr,succListarCursos,err)
}

function succListarCursos(data){
	console.log(data);
	var cur = data.cursos;
	var cad = "";

	if(cur){
		cad += "<table id='table-lis' class='table table-striped table-bordered table-hover table-condensed table-responsive'>";

		cad += "<th style='text-align:center'>Más opciones</th>";
		cad += "<th style='text-align:center'>Código del Curso</th>";
		cad += "<th style='text-align:center'>Trayecto</th>";
		cad += "<th style='text-align:center'>Sección</th>";
		cad += "<th style='text-align:center'>Unidad Curricular</th>";
		cad += "<th style='text-align:center'>Docente</th>";
		cad += "<th style='text-align:center'>Cantidad de Estudiantes</th>";
		cad += "<th style='text-align:center'>Capacidad de Estudiantes</th>";
		cad += "<th style='text-align:center'>Fecha de Inicio</th>";
		cad += "<th style='text-align:center'>Fecha de Fin</th>";

		var cont = 0;
		var tope = cur.length;
		var it = 0;

		while(cont < tope){
			var tra = cur[cont][1];

			if(it != tra){
				it = tra;
				cad += "<tr>";
				cad+="<th style='text-align:center' colspan='10'>Trayecto "+cur[cont][1]+"</th>";
				cad += "</tr>";
			}

			cad += "<tr>";
			cad += "<td style='text-align:center'><input type='checkbox' onchange='actualizarCheck("+cont+")' id='checkbox"+cont+"'><input type='text' hidden id='hid"+cont+"' value='"+cur[cont][0]+"'></td>"
			for(var i = 0; i < 9; i++){
				if(cur[cont][i] != null)
					cad += "<td style='text-align:center' id='c"+i+cont+"'>"+cur[cont][i]+"</td>";
				else
					cad += "<td style='text-align:center'>No asignado</td>";
			}
			cad += "</tr>";

			cont++;
		}

		cad += "</table>";
	}
	else{
		mostrarMensaje("No hay elementos que coincidan con los criterios de búsqueda",2);
	}

	$("#table-lis").remove();
	$("#divLis").append(cad);
	//$("#divLis").show();
	verificarChecks();
}

function mostrarPatron(){
	$("#divPat").show();
	$("#divBut").show();
}

var cantCheck = 0;

function actualizarCheck(el){

	if($("#checkbox"+el).is(':checked'))
		cantCheck++;
	else
		cantCheck--;

	if(cantCheck == 0)
		ocultarPanel();
	else
		mostrarPanel();
}

function mostrarPanel(){
	if($("#panelB").is(":hidden"))
		$("#panelB").show();
}

function ocultarPanel(){
	if($("#panelB").is(":visible"))
		$("#panelB").hide();
}

function verificarChecks(el){
	var len = $('#table-lis >tbody >tr').length;

	var sec = '';
	for(var i = 0; i < len; i++){
		if($("#checkbox"+i).is(":checked"))
			if(el == 'mod'){
				if($("#c2"+i).html() != sec){
					window.open('index.php?m_modulo=curso&m_accion=mostrar&m_vista=CrearModificarCurso&m_formato=html5&codigo='+$("#hid"+i).val(),'_blank');
					sec = $("#c2"+i).html();
				}
			}
			else if(el == 'le') {
				window.open('index.php?m_modulo=curso&m_accion=mostrar&m_vista=ListarEstudiantes&m_formato=html5&codigo='+$("#hid"+i).val(),'_blank');
			}
			else if(el == 'cn'){
				window.open('index.php?m_modulo=curso&m_accion=mostrar&m_vista=CargarNotas&m_formato=html5&codigo='+$("#hid"+i).val(),'_blank');
			}
			else if(el == 'ri'){
				window.open('index.php?m_modulo=curso&m_accion=mostrar&m_vista=InscribirRetirarEstudiante&m_formato=html5&codigo='+$("#hid"+i).val(),'_blank');
			}
			else if(el == "ret"){
				retirarEstudiante($("#hid"+i).val(),$("#selUni").val()[0]);
			}
			else if(el == "elim"){
				eliminarEstudiante($("#hid"+i).val(),$("#selUni").val()[0]);
			}
	}
}

function retirarEstudiante(codigo, uni){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"retirarEstudiante",
					"codEstudiante"	,		codigo,
					"codCurso"		,		uni);

	ajaxMVC(arr, succRetirarEstudiante, err);
}

function succRetirarEstudiante(data){
	console.log(data);
	mostrarMensaje("Se ha realizado un retiro exitoso.",1);
	listarEstudiantes(succListarEstudiantes,$('#selUni').val()[0]);
}

function eliminarEstudiante(codigo, uni){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"eliminarEstudiante",
					"codEstudiante"	,		codigo,
					"codCurso"		,		uni);

	ajaxMVC(arr, succEliminarEstudiante, err);
}

function succEliminarEstudiante(data){
	mostrarMensaje("Se ha eliminado al estudiante de la lista.",1);
	listarEstudiantes(succListarEstudiantes,$('#selUni').val()[0]);
}


function cargarCursosPensum(){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"obtenerCursosPensum",
					"seccion"		,		$("#sec").val(),
					"trayecto"		,		$("#selTra").val()[0],
					"periodo"		,		$("#selPer").val()[0]);

	ajaxMVC(arr,succCargarCursosPensum,err);
}

function succCargarCursosPensum(data){
	var cur = data.cursos;
	var cad = "";

	if(cur){
		cad += "<table id='tableCur' class='table table-striped table-bordered table-hover table-condensed table-responsive'>";

		cad += "<th style='text-align:center'>Cursos Activos</th>";
		cad += "<th style='text-align:center'>Unidad Curricular</th>";
		cad += "<th style='text-align:center'>Capacidad</th>";
		cad += "<th style='text-align:center'>Docente</th>";
		cad += "<th style='text-align:center'>Fecha de Inicio</th>";
		cad += "<th style='text-align:center'>Fecha de Fin</th>";
		cad += "<th style='text-align:center'>Observaciones</th>";

		for(var i = 0; i < cur.length; i++){
			cad += "<tr>";

			if(cur[i]['codcurso'] != null)
				cad += "<td style='text-align:center'><span class='label label-success'>Activo</span></td>";
			else {
				cad += "<td style='text-align:center'><span class='label label-danger'>Inactivo</span></td>";
			}

			cad += "<td style='text-align:center'>"+cur[i]['nombre']+"</td>";

			if(cur[i]['capacidad'] == null)
				cad += "<td style='text-align:center'><input type='text' id='capacidad'></td>";
			else
				cad += "<td style='text-align:center'><input type='text' id='capacidad' value='"+cur[i]['capacidad']+"'></td>";


			if(cur[i]['nombredocente'] == null)
				cad += "<td style='text-align:center'><input type='text' id='nombredocente'></td>";
			else
				cad += "<td style='text-align:center'><input type='text' id='nombredocente' value='"+cur[i]['nombredocente']+"'></td>";


			if(cur[i]['fec_inicio'] == null)
				cad += "<td style='text-align:center'><input type='text' id='fecini'></td>";
			else
				cad += "<td style='text-align:center'><input type='text' id='fecini' value='"+cur[i]['fec_inicio']+"'></td>";

			if(cur[i]['fec_final'] == null)
				cad += "<td style='text-align:center'><input type='text' id='fecfin'></td>";
			else
				cad += "<td style='text-align:center'><input type='text' id='fecfin' value='"+cur[i]['fec_final']+"'></td>";

			if(cur[i]['observaciones'] == null)
				cad += "<td style='text-align:center'><input type='text' id='observaciones'></td>";
			else
				cad += "<td style='text-align:center'><input type='text' id='observaciones' value='"+cur[i]['observaciones']+"'></td>";

			cad += "</tr>";
		}

		cad += "</table>";
	}
	else{
		cad += "<option>"+data.mensaje+"</option>";
	}

	$("#tableCur").remove();
	$("#divTable").append(cad);
}

function listarEstudiantes(funsucc,cod){
	var arr = Array("m_modulo"		,		"estudiante",
					"m_accion"		,		"listarEstudiantesPorCurso",
					"codigo"		,		cod);


	ajaxMVC(arr,funsucc,err);

}

function succListarEstudiantes(data){
	var est = data.estudiante;
	var cad = "";
	if(est){
		var estB = ($("#selEst").length > 0);

		cad += "<table id='table-lis' class='table table-striped table-bordered table-hover table-condensed table-responsive'>";

		if(estB)
			cad += "<th style='text-align:center'></th>";

		cad += "<th style='text-align:center'>#</th>";
		cad += "<th style='text-align:center'>Cédula</th>";
		cad += "<th style='text-align:center'>Apellido</th>";
		cad += "<th style='text-align:center'>Nombre</th>";
		cad += "<th style='text-align:center'>Correo</th>";
		cad += "<th style='text-align:center'>Nota</th>";
		cad += "<th style='text-align:center'>% Asistencia</th>";
		cad += "<th style='text-align:center'>Estado</th>";

		var prom = 0;

		for(var i = 0; i < est.length; i++){
			cad += "<tr>";

			if(estB)
				cad += "<td style='text-align:center'><input type='checkbox' id='checkbox"+i+"'><input type='hidden' id='hid"+i+"' value='"+est[i]['codigo']+"'></input></td>";

			cad += "<td style='text-align:center'>"+(i+1)+"</td>";

			cad += "<td style='text-align:center'>"+est[i]['cedula']+"</td>";

			cad += "<td style='text-align:center'>"+est[i]['apellido1']+"</td>";

			cad += "<td style='text-align:center'>"+est[i]['nombre1']+"</td>";

			if(est[i]['cor_personal'] == null)
				cad += "<td style='text-align:center'>No asignado</td>";
			else
				cad += "<td style='text-align:center'>"+est[i]['cor_personal']+"</td>";

			if(est[i]['nota'] == null)
				cad += "<td style='text-align:center'>No asignado</td>";
			else{
				cad += "<td style='text-align:center'>"+est[i]['nota']+"</td>";
				prom += est[i]['nota'];
			}

			if(est[i]['por_asistencia'] == null)
				cad += "<td style='text-align:center'>No asignado</td>";
			else
				cad += "<td style='text-align:center'>"+est[i]['por_asistencia']+"</td>";

			if(est[i]['nombre'] == null)
				cad += "<td style='text-align:center'>No asignado</td>";
			else
				cad += "<td style='text-align:center'>"+est[i]['nombre']+"</td>";

			cad += "</tr>";


		}
		cad += "</table>";

		$("#divButt").show();
		// Cálculos de promedio
	}
	else {
		$("#divButt").hide();
		mostrarMensaje("No hay resultados para los criterios de búsqueda",3);
	}

	$("#table-lis").remove();
	$("#divLis").append(cad);

}
$( document ).ready(function() {
	if($("#selInst").length > 0)
		cargarInstitutos();
	else {
		cargarNotas();
		listarEstudiantes(succListarEstudiantesCargarNotas,obtenerGet('codigo'));
	}
});


if(obtenerGet('codigo') != null && obtenerGet('m_vista') != 'CargarNotas')
	montarSelects();

function obtenerGet(indice){
	var $_GET = {};

	document.location.search.replace(/\??(?:([^=]+)=([^&]*)&?)/g, function () {
	    function decode(s) {
	        return decodeURIComponent(s.split("+").join(" "));
	    }

    	$_GET[decode(arguments[1])] = decode(arguments[2]);
	});

	return ($_GET[indice])?$_GET[indice]:null;
}

function montarSelects(){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"obtenerDatosDeCurso",
					"codigo"		,		obtenerGet('codigo'));

	ajaxMVC(arr,succMontarSelects,err);
}

function cargarNotas(){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"obtenerDatosDeCurso",
					"codigo"		,		obtenerGet('codigo'));

	ajaxMVC(arr,succCargarNotas,err);
}

function montarSelectEstado(data){
	if(data == null){
		var arr = Array("m_modulo"		,		"curso",
						"m_accion"		,		"obtenerEstusEstudiante");

		ajaxMVC(arr,montarSelectEstado,err);
	}
	else {
		var dat = data.estados;
		var cad = "";
		if(dat){
			for(var i = 0; i < dat.length; i++)
				cad += "<option value='"+dat[i]['codigo']+"'>"+dat[i]['nombre']+"</option>";
		}
	}
}

function succCargarNotas(data){
	var dat = data.cursoInfoMontar;

	if(dat){
		$("#inst").html(dat[0]['nombreins']);
		$("#tra").html(dat[0]['numtrayecto']);
		if(dat[0]['nombredocente'] != null)
			$("#doc").html(dat[0]['nombredocente']);
		else {
			$("#doc").html("No asignado");
		}
		$("#pen").html(dat[0]['nombrepen']);
		$("#sec").html(dat[0]['seccion']);

		$("#per").html(dat[0]['nombreperiodo']);
		$("#uni").html(dat[0]['nombreuni']);
	}
}


function succListarEstudiantesCargarNotas(data){
	var est = data.estudiante;
	var cad = "";
	var cad2 = "";
	var edos = data.estados;

	for(var j = 0; j < edos.length; j++){
		cad2 += "<option value='"+edos[j]['codigo']+"'>"+edos[j]['nombre']+"</option>";
	}

	console.log(data);
	if(est){
		cad += "<table id='table-Est' class='table table-striped table-bordered table-hover table-condensed table-responsive'>";

		cad += "<th style='text-align:center'>#</th>";
		cad += "<th style='text-align:center'>Cédula</th>";
		cad += "<th style='text-align:center'>Apellido</th>";
		cad += "<th style='text-align:center'>Nombre</th>";
		cad += "<th style='text-align:center'>Nota</th>";
		cad += "<th style='text-align:center'>% Asistencia</th>";
		cad += "<th style='text-align:center'>Estado</th>";
		cad += "<th style='text-align:center'>Observaciones</th>";

		var prom = 0;

		montarSelectEstado(null);

		cad += "<input type='hidden' id='codigocurso' value='"+est[0]['cod_curso']+"'>";

		for(var i = 0; i < est.length; i++){
			cad += "<tr>";

			cad += "<td style='text-align:center'>"+(i+1)+" <input type='hidden' id='hid"+i+"' value='n'>";
			cad += "<input type='hidden' id='curest"+i+"' value='"+est[i]['cod_curest']+"'></td>";
			cad += "<input type='hidden' id='est"+i+"' value='"+est[i]['codigo']+"'></td>";

			cad += "<td style='text-align:center'>"+est[i]['cedula']+"</td>";

			cad += "<td style='text-align:center'>"+est[i]['apellido1']+"</td>";

			cad += "<td style='text-align:center'>"+est[i]['nombre1']+"</td>";

			cad += "<input type='hidden' id='nom"+i+"' value='"+est[i]['nombre1']+" "+est[i]['apellido1']+"'>";

			if(est[i]['nota'] == null)
				cad += "<td style='text-align:center'><input type='text' onchange='actualizarEstado("+i+")' id='nota"+i+"' size='2' value=''></td>";
			else
				cad += "<td style='text-align:center'><input type='text' onchange='actualizarEstado("+i+")' id='nota"+i+"'  size='2' value='"+est[i]['nota']+"'></td>";

			if(est[i]['por_asistencia'] == null)
				cad += "<td style='text-align:center'><input type='text' onchange='actualizarEstado("+i+")' id='asis"+i+"' size='3' value=''></td>";
			else
				cad += "<td style='text-align:center'><input type='text' onchange='actualizarEstado("+i+")' id='asis"+i+"' size='3' value='"+est[i]['por_asistencia']+"'></td>";

			cad += "<td style='text-align:center'><select class='selectpicker' onchange='actualizarEstado("+i+")' data-live-search='true' data-size='auto' multiple data-max-options='1' id='estado"+i+"'>"+cad2+"</select></td>";

			if(est[i]['observaciones'] == null)
				cad += "<td style='text-align:center'><input type='text' onchange='actualizarEstado("+i+")' id='obser"+i+"' value=''></td>";
			else
				cad += "<td style='text-align:center'><input type='text' onchange='actualizarEstado("+i+")' id='obser"+i+"' value='"+est[i]['observaciones']+"'></td>";

			cad += "</tr>";
		}

		cad += "</table>";

		cad += "<br><br><center><button class='btn btn-dark btn-xs' onclick='guardarNotas()'>Cargar Notas</button></center>";
	}
	else {
		mostrarMensaje("No hay resultados para los criterios de búsqueda",3);
	}

	$("#table-Est").remove();
	$("#tableEst").append(cad);

	for(var i = 0; i < est.length; i++){
		$("#estado"+i).val(est[i]['cod_estado']);
	}

	$(".selectpicker").selectpicker();
}


function actualizarEstado(i){
	$("#hid"+i).val("s");
}

function guardarNotas(i){
	var len = $('#table-Est >tbody >tr').length;

	for(var i = 0; i < len; i++){
		if($("#hid"+i).val() == 's'){
			$("#hid"+i).val("n");
			var arr = Array("m_modulo"		,		"curso",
							"m_accion"		,		"modificarCurEst",
							"codCurEst"		,		$("#curest"+i).val(),
							"codCurso"		,		$("#codigocurso").val(),
							"codEstudiante"	,		$("#est"+i).val(),
							"porAsistencia"	,		$("#asis"+i).val(),
							"codEstado"		,		$("#estado"+i).val()[0],
							"nota"			,		$("#nota"+i).val(),
							"observacion"	,		$("#obser"+i).val(),
							"nombre"		,		$("#nom"+i).val());

			ajaxMVC(arr,succGuardarNotas,err);
		}
	}
}

function succGuardarNotas(data){
	mostrarMensaje("La información del estudiante "+data.nombre+" fue cargada exitosamente.",1);
}

function succMontarSelects(data){
	var dat = data.cursoInfoMontar;

	var i = 1;
	if(dat[0]['cod_instituto'] != null){
		setTimeout(function (){
			$("#selInst").val(dat[0]['cod_instituto']);
			$("#selInst").selectpicker("refresh");
			cargarPensums();
		}, 150);
	}

	if(dat[0]['cod_pensum'] != null){
		setTimeout(function (){
			$("#selPen").val(dat[0]['cod_pensum']);
			cargarPeriodos();
		}, 300);
	}

	if(dat[0]['codigo'] != null){
		setTimeout(function (){
			$("#selPer").val(dat[0]['codigo']);
			cargarTrayectos();
		}, 450);
	}

	if(dat[0]['cod_trayecto'] != null){
		setTimeout(function (){
			$("#selTra").val(dat[0]['cod_trayecto']);
			cargarSeccion();
		}, 600);
	}

	if(dat[0]['seccion'] != null){
		setTimeout(function (){
			$("#selSec").val(dat[0]['seccion']);
			cargarUni();
		}, 750);
	}

	if(dat[0]['cod_uni_curricular'] != null){
		setTimeout(function (){
			$("#selUni").val(dat[0]['cod_uni_curricular']);
		}, 1000);
	}

	setTimeout(function (){
		$(".selectpicker").selectpicker("refresh");

		if($("#divLis").length == 0)
			cargarCursosPensum();
		else
			listarEstudiantes(succListarEstudiantes,$("#selUni").val()[0]);
	}, 1200);

}

function montarSelect(sel,val){
	$(sel).val(val);
	$(sel).selectpicker("refresh");
}

function cargarEstudiantes(){
	var arr = Array("m_modulo"		,		"estudiante",
					"m_accion"		,		"listarEstudiantePeriodo",
					"instituto"		,		$("#selInst").val()[0],
					"pensum"		,		$("#selPen").val()[0],
					"periodo"		,		$("#selPer").val()[0]);

	ajaxMVC(arr,succCargarEstudiantes,err);
}

function succCargarEstudiantes(data){
	var dat = data.estudiantes;
	var cad = "";

	cad += "<select class='selectpicker' id='selEstudiante' onchange='listarUniEstudiante()' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Estudiante'>";

	if(dat){
		for(var i = 0; i < dat.length; i++){
			cad += "<option value='"+dat[i]['codigo']+"'>"+dat[i]['nombrecompleto']+"</option>";
		}
	}

	cad += "</select>";

	$("#selEstudiante").selectpicker("destroy");
	$("#divEstudiante").append(cad);
	$("#selEstudiante").selectpicker();
}

function listarUniEstudiante(){
	var arr = Array("m_modulo"		,		"curso",
					"m_accion"		,		"obtenerCursosPorEstudiante",
					"codigo"		,		$("#selEstudiante").val()[0]);

	ajaxMVC(arr,succListarUniEstudiante,err);
}

function succListarUniEstudiante(data){
	console.log(data);
}
