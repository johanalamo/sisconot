window.onload=function montarPersona(data){

		var persona=data.personas;

		cadena = '';

		cosole.log(data);

		/*
		 * El primer for sirve para recorrer los estados que fueron filtrados
		 * por el usuario este es el primer for ---> for(var x=0;x<estado.length; x++)
		 * 
		 * el segundo for sirve para recorrer todos los resportes que 
		 * estan alamacenados en la base de datos.
		 */ 
		 
			for(var i = 0; i < persona.length; i++)
			{
				/*
				 * si el estado del error tiene el mismo estado que el usuario filtro
				 * para mostrar los errores, entonces se van a mostrar,
				 * pero de lo contrario si los errores son diferentes entonces no
				 * se va a mostrar ningun reporte 
				 */
				 
				
				alert(persona[i]);
			}
	

		cadena += '</table>';

		// Se adhieren los reportes de error obtenidos a la ventana modal.
		$(cadena).appendTo('#verPersona');
	
}