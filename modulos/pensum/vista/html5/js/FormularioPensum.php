<form class="form-horizontal"  enctype="multipart/form-data" id="formpen">	
	<div class="container-fluid">		
		<div class="row-fluid">
				<div class="col-md-10 col-md-offset-1">		
					<div class="input-group">									
							<span class="input-group-addon">Nombre Completo:</span>
							<input type='text' name='nombre' onkeyup='validarSoloTexto("#nombre",5,60,true)' id='nombre' maxlength='50' class='form-control'  placeholder='Nombre'>
						</div>
					</div>
		</div><br><br>
		<div class="row-fluid">
				<div class="col-md-10 col-md-offset-1">		
					<div class="input-group">									
							<span class="input-group-addon">Nombre Corto:</span>
							<input type='text' name='nom_corto' onkeyup='validarSoloTexto("#nom_corto",2,20,true)' id='nom_corto' maxlength='25' class='form-control'  placeholder='Nombre Corto'>
						</div>
					</div>
		</div><br><br>

		<div class="row-fluid">
				<div class="col-md-10 col-md-offset-1">		
					<div class="input-group">									
							<span class="input-group-addon">Minima cantidad electiva:</span>
							<input type='text' name='min_cant_elect' onkeyup="validarSoloNumeros('#min_cant_elect',1,2,true)"  maxlength='2' id='min_cant_elect'  class='form-control'  placeholder='Min cantidad electiva'>
						</div>
					</div>
		</div><br><br>
		<div class="row-fluid">
				<div class="col-md-10 col-md-offset-1">		
					<div class="input-group">									
							<span class="input-group-addon">Minima credito electiva:</span>
							<input type='text' name='min_cre_elect' onkeyup="validarSoloNumeros('#min_cre_elect',1,2,true)"  maxlength='2' id='min_cre_elect' class='form-control'  placeholder='Min credito obligatorio'>
						</div>
					</div>
		</div><br><br>
		<div class="row-fluid">
				<div class="col-md-10 col-md-offset-1">		
					<div class="input-group">									
							<span class="input-group-addon">Minima credito obligatorio:</span>
							<input type='text' name='min_cre_oblig'  onkeyup="validarSoloNumeros('#min_cre_oblig',1,3,true)"  maxlength='3' id='min_cre_oblig' class='form-control'  placeholder='Min credito obligatorio'>
						</div>
					</div>
		</div><br><br>
		<div class="row-fluid">
				<div class="col-md-10 col-md-offset-1">		
					<div class="input-group">									
							<span class="input-group-addon">Fecha:</span>
							<input type='text' name='fecha' id='fecha' maxlength='25' class='form-control'  placeholder='Fecha'>
						</div>
					</div>
		</div><br><br>
		<div class="row-fluid">
				<div class="col-md-10 col-md-offset-1">		
					<div class="input-group">									
							<span class="input-group-addon">Observaciones:</span>
						<!--	<input type='text' name='observaciones' id='observaciones' maxlength='200' class='form-control'  placeholder='Observaciones'> -->
							​<textarea id="observaciones" rows="3" cols="60" name='observaciones' id='observaciones' maxlength='200' class='form-control'  placeholder='Observaciones'></textarea>
						</div>
					</div>
		</div><br><br>
	</div>		
</form>	
