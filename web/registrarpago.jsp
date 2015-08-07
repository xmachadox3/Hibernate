<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>BDOO Jesus Machado</title>  
    	<link rel="stylesheet" href="source/css/bootstrap.min.css">		
        <script src="source/js/jquery.min.js"></script>
        <script src="source/js/bootstrap.min.js"></script>	
        <link id="bsdp-css" href="source/css/bootstrap-datepicker3.css" rel="stylesheet">
        <script src="source/js/bootstrap-datepicker.js"></script>
	<script src="source/js/bootstrap-datepicker.es.min.js" charset="UTF-8"></script>
    </head>
    <body>
        <div class="container">
            <div class="header clearfix">
                <nav class="navbar navbar-inverse navbar-fixed-top">
                    <div class="container">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                                <span class="sr-only">Toggle navigation</span>
            			<span class="icon-bar"></span>
            			<span class="icon-bar"></span>
            			<span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="index.jsp">Casa de Playas</a>
                        </div>
                        <div id="navbar" class="navbar-collapse collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="registrarse.jsp">
                                        Registrarse
                                    </a>
                                </li>
                                <%if(session.getAttribute("session") == null){%>
                                <li>
                                    <a href="registrarpago.jsp">Procesar Pago</a>  
                                </li>
                                <%}%>
                            </ul>
                            <%
                                boolean estado = false;
                                if(session.getAttribute("session") != null){
                                    String Usuario = (String) session.getAttribute("session");
                                    estado = true;
                            %>
                            <ul class="navbar-right">
                                <li style="color: #ddd; margin-top: 5px; list-style: none;">
                                    <div style="display: inline-block; font-weight: bold; margin-top: 10px;">
                                        <%= Usuario %>
                                    </div>
                                    <div style="display: inline-block; margin-top: 5px; margin-left: 10px;">
                                        <form method="post" action="DestruirSession">
                                            <button type="submit" class="btn btn-sm btn-warning" name="cerrarSession" value="cerrarSession">
                                                Cerrar Sesión
                                            </button>
                                        </form>
                                    </div>
                                </li>
                            </ul>   
                            <%}
                             else {%>
                            <form class="navbar-form navbar-right" method="post" action="Login" >
                                <div class="form-group">
                                    <input type="text" placeholder="Login" class="form-control" name ="login">
                                </div>
                                <div class="form-group">
                                    <input type="password" placeholder="Clave" class="form-control" name= "password">
                                </div>
                                <button type="submit" class="btn btn-success" name="loginuser" value="loginuser">Loguearse</button>
                            </form>
                            <%}%>
                        </div>
                    </div>
                </nav>
            </div> <!-- Header -->
            <div class="clearfix"></div>
            <br><br><br>
           <h3 class="text-muted">Alquiler de Casas</h3>
      	
      	<%if(session.getAttribute("session") == null){ %>
      	<form class="form-horizontal" action="RegistrarPago" method="post">
  			<div class="form-group">
    			<label class="col-sm-2 control-label">Codigo Reserva</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" name="codigoreserva">
    			</div>
  			</div>
  			<div class="form-group">
    			<label  class="col-sm-2 control-label">Login Usuario</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" name="loginusuario" >
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="inputPassword3" class="col-sm-2 control-label">Clave</label>
    			<div class="col-sm-10">
      				<input type="password" class="form-control" name="clave">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="inputPassword3" class="col-sm-2 control-label">Telefono</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" name="telefono">
    			</div>
  			</div> 
  			<div class="form-group">
    			<label for="inputPassword3" class="col-sm-2 control-label">Numero de Deposito</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" name="ndeposito">
    			</div>
  			</div>  			
  			<div class="form-group">
    			<div class="col-sm-offset-2 col-sm-10">
      				<button type="submit" class="btn btn-default">Aceptar</button>
    			</div>
  			</div>
		</form>
      	<% }%>                     
        </div>
    </body>
</html>
