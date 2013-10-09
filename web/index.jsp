<%-- 
    Document   : index
    Created on : 08/10/2013, 02:10:15 PM
    Author     : RMUNAYCO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Object omensaje= request.getAttribute("mensaje");  
   Object odatos= request.getAttribute("datos");  
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta de Tributos</title>
        <link href="css/estilos.css" rel="stylesheet" type="text/css">
		<script languaje="JavaScript" src="js/js.js"> </script>
		<script languaje="JavaScript" type="text/javascript">
var gCount = 0;
var contPag = 0;
function goRefresh() {
 document.mainForm.codigo.value = "";
 if(gCount == 0){
 document.mainForm.imagen.src="imagen/catcha1.jpg";
 gCount = gCount + 1;
 }else{
  gCount=0;
  document.mainForm.imagen.src="imagen/catcha.jpg";
 }
}


function format(type) {
 var form = document.mainForm;
 if(type == 0) {
   document.getElementById('s1').style.visibility = 'visible'; 
   document.getElementById('s2').style.visibility = 'hidden';
   document.getElementById('s3').style.visibility = 'hidden';
   form.search1.maxLength = 11;
   form.search1.onkeypress = function(e) {
   if (!e) e=window.event;
   key = e.keyCode? e.keyCode : e.which>0?e.which:e.keyCode;
   if (key == 8 || key==9) return true;
   pattern =/[0-9]/;
   te = String.fromCharCode(key);
   return pattern.test(te);     
  }  
  form.search1.focus();
  form.search1.value = "";
  
 }
 if(type == 1) {
   document.getElementById('s2').style.visibility = 'visible'; 
   document.getElementById('s1').style.visibility = 'hidden';
   document.getElementById('s3').style.visibility = 'hidden';
   form.search2.maxLength = 16; 
   form.search2.onkeypress = function(e) {return true;}   
   form.search2.focus();
   form.search2.value = "";
 }
 
 if(type == 2) {
   document.getElementById('s3').style.visibility = 'visible'; 
   document.getElementById('s1').style.visibility = 'hidden';
   document.getElementById('s2').style.visibility = 'hidden';
   form.search3.maxLength = 100;
   form.search3.onkeypress = function(e) {return true;}   
   form.search3.focus();
   form.search3.value = "" ;
 }
 

}

function verificaDocumento()
 {
   var form = document.mainForm;
   var   tipdoc = form.tipdoc.value;
   var    numdoc =form.search2.value;  
   if (tipdoc=="1")
    {
      if (numdoc.length!=8 )
       {
          alert("El número de documento es INCONSISTENTE");		  
          return false;
       }
	   else{
	      if ( !esnumero(numdoc) )
          {
             alert("El número de documento de identidad es INCONSISTENTE");		  
             return false;
          }
	   }   	   
    }	
	return true; 
  }
  

function evalSearch() {
 var form = document.mainForm;
 if(form.tQuery[0].checked) {
  form.nroRuc.value = form.search1.value;
  form.accion.value = "consPorRuc";
  if(!esrucok(form.nroRuc.value)){
    alert('ingrese numero de RUC valido');form.search1.focus();return;
  }
 }
 else {
   if(form.tQuery[2].checked) {
     form.accion.value = "consPorRazonSoc";
     form.razSoc.value = form.search3.value;
     if(!longitudmayor(trim(form.razSoc.value),4) || (trim(form.razSoc.value).substring(0,1)=='*')){
       alert('La Razón social no es válida');form.search3.focus();return;
     }
	 if ( validar(form.search3.value)==false){
	    alert('Sólo puede ingresar letras y/o números');form.search3.focus();return;
	 }	
   
   }else {//Tipo y nro del documento
     form.nrodoc.value = form.search2.value;
     form.accion.value = "consPorTipdoc";
     if(!longitudmayor(trim(form.nrodoc.value),4) || (trim(form.nrodoc.value).substring(0,1)=='*')){
       alert('El Nro del documento no es válido');form.search2.focus();return;
     } 
	  if (verificaDocumento()==false) return; 
	  if ( validar2(form.search2.value)==false){
	    alert('Sólo puede ingresar letras  y/o números ');form.search2.focus();return;
	  }	
   } 
   
 }
 if(form.contexto.value == 'ti-it'){
   if(trim(form.codigo.value).length < 4) {
     alert('Por favor ingrese código de imagen');form.codigo.focus();return;
   }
  }
 form.submit();
}
function   validar(texto) {
             x = true;
			 //if (!/^([A-Za-z\s])*$/.test(texto)){ 
            if (!/^([A-Za-z0-9\s\361\321@\\&\\Ü\\ü\\-\\.\\,])*$/.test(texto)){               
                x = false;
             }
            return x; 
}
function   validar2(texto) {
             x = true;			 
            if (!/^([A-Za-z0-9\\-\\.\\_])*$/.test(texto)){               
                x = false;
             }
            return x; 
}

function getContPag(){
return -contPag;
}
function incContPag(){
contPag=contPag+1;
}
function resetContPag(){
contPag=0;
}
</script>
        <style type="text/css">
<!--
.Estilo1 {color: #990000}
.Estilo2 {font-size: 14px}
-->
        </style>
</head>
    <body bgcolor="#BBBAAA" onLoad="JavaScript:format(0)" style="">
    
<form target="mainFrame" method="post" name="mainForm" action="encontrar">

   <table class="form-table" cellspacing="2" cellpadding="3" width="100%" border="0">
    <tbody>
     <tr>
      <td>
       <table cellspacing="2" cellpadding="3" width="100%" border="0">
        <tbody>
         <tr>
          <td height="181" align="center" bgcolor="#aaaacc"><p><img src="imagen/Sunat-Logo.gif" width="312" height="76"></p>
            
         </tr>
        </tbody>
       </table>
     <input type="hidden" name="accion" value="">
     <input type="hidden" name="razSoc" value="">
     <input type="hidden" name="nroRuc" value="">
	 <input type="hidden" name="nrodoc" value="">
       <table cellspacing="0" cellpadding="0" width="100%" border="0">
       <tbody>
            
       <input type="hidden" name="contexto" value="ti-it"> 
       <tr>
         <td width="2%"><input type="radio" name="tQuery" onClick="format(0)" checked=""></td>
         <td class="bgn" width="20%">Ingrese su número de RUC</td>    
		 
		 <td align="left" colspan="1" width="30%">
		 <div id="s1" style="visibility: visible;">
		 <input class="form-text" name="search1" size="11" maxlength="11">
		 </div>
		 </td>  
		

		<!-- <td align="left" rowspan="1" width="180"></td>    -->  
         <td class="bgn" rowspan="1" width="20%" valign="middle">Ingrese el código que se muestra en la imagen:</td>
         <td align="left" rowspan="1" width="13%"><img src="imagen/catcha.jpg" name="imagen" width="96" height="48"></td>
         <td align="left" rowspan="1" width="10%" valign="center"><input style="text-transform:uppercase;" type="text" name="codigo" maxlength="4" size="4" onChange="this.value=this.value.toUpperCase();"></td>
         <td rowspan="1" width="5%"><input class="form-button" type="button" value="Buscar" onClick="evalSearch();"></td>
       </tr>
	   <tr>
           <td><input type="radio" name="tQuery" onClick="format(1)"></td>
           <td class="bgn">Ingrese su tipo y número de documento de identidad 
           <select size="1" name="tipdoc">				
					 <option value="1">Documento Nacional de Identidad </option>
					 
					 
			</select> 
			</td>
			 
			<td align="left" colspan="1">
			<div id="s2" style="visibility: hidden;">
			<input class="form-text" name="search2" size="16">
			</div>
			</td> 
			 
				    
		  </tr> 
	   
       <tr>
       
         
		  
		 <td align="left" colspan="4">
		 <div id="s3" style="visibility: hidden;">
		 <input class="form-text" name="search3" size="30">
		 </div>
		  </td> 
		
		 
       </tr>
	   
                                           
         </tbody>
        </table>
       </td>
     </tr>
     </tbody>
  </table>
   <table width="969" border="0">
     <tr>
             <td width="548" class="beta-neg-alert">
           <% if(omensaje != null){%>
          <%= omensaje.toString()   %>
       <% } %>
       </td>
     </tr>
   </table>
   <p>&nbsp;</p>
   <%  if(odatos != null){
      java.util.ArrayList mostrar= (java.util.ArrayList)odatos;
      String snombre= mostrar.get(0).toString();
      java.util.Vector wdeudas= (java.util.Vector)mostrar.get(1);
   %>
   <p class="gamma-pos-alert Estilo1">Persona Con Deuda Pendiente al Estado: <%= snombre %> </p>
  <%   for(Object mdebe : wdeudas){
      String[] zdato = (String[])mdebe;
  %>
   <table width="453" border="0" align="center">
     <tr>
       <th width="173" class="T0" scope="row"><div align="left">Tributo:</div></th>
       <td width="270" class="bgn-required"><%= zdato[1] %></td>
     </tr>
     <tr>
       <th class="T0" scope="row"><div align="left">RUC:</div></th>
       <td class="bgn-required"><%= zdato[0] %></td>
     </tr>
     <tr>
       <th class="T0" scope="row"><div align="left">Periodo Tributario: </div></th>
       <td class="bgn-required"><%= zdato[2] %></td>
     </tr>
     <tr>
       <th class="T0" scope="row"><div align="left">Resolucion:</div></th>
       <td class="bgn-required"><%= zdato[3] %></td>
     </tr>
     <tr>
       <th class="T0" scope="row"><div align="left">Codigo Tributo: </div></th>
       <td class="bgn-required"><%= zdato[4] %></td>
     </tr>
     <tr>
       <th class="T0" scope="row"><div align="left">Deuda a pagar: </div></th>
       <td class="bgn-required"><%= zdato[5] %></td>
     </tr>
   </table>
   <p>&nbsp;   </p>
   <%  }  %>
   <p>
     <% }  %>
    </p>
   <p>&nbsp;</p>
</form>

    </body>
</html>
