function comprueba_extension(formulario, archivo, boton,boton2) 
    { 
	   extensiones_permitidas = new Array(".png", ".jpg",".gif"); 
	   error = ""; 
	   if (!archivo) 
	   { 
	      //Si no tengo archivo, es que no se ha seleccionado un archivo en el formulario 
	      error = "No has seleccionado ningun archivo"; 
	   }
	   else
	   { 
	      //recupero la extensión de este nombre de archivo 
	      extension = (archivo.substring(archivo.lastIndexOf("."))).toLowerCase(); 
	     
	      //compruebo si la extensión está entre las permitidas 
	      permitida = false; 
	      for (var i = 0; i < extensiones_permitidas.length; i++) 
	      { 
	         if (extensiones_permitidas[i] == extension) 
	         { 
		         permitida = true; 		        
		         break; 
	         } 
	      } 
	  

	      if (!permitida) 
	      { 
	         error = "Comprueba la extension de los archivos a subir. \n Solo se pueden subir archivos con extensiones: " + extensiones_permitidas.join(); 
	      }
	      else
	      {         
	         
	          var f = document.getElementById("formulario");
			  f.enviar.value = boton;
			  f.enviar2.value= boton2;
			  
			  f.submit();
	     	         		
	          return 1; 
	      } 
	   } 


	   //si estoy aqui es que no se ha podido submitir 
	   alert (error); 
	   return 0; 
	}
