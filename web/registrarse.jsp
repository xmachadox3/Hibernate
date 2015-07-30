<%-- 
    Document   : registrarse
    Created on : 23/07/2015, 01:24:37 PM
    Author     : Jesús Machado
--%>

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
            <br><br><br>  
            <div class="row">
                <div class="col-md-offset-3 col-lg-6">
                    <h4 class="text-center">Propietario</h4>
                    <form action="RegistrarPropietario" method="post" >
        		<div class="form-group">
                            <label>Cedula</label>
                            <input type="text" class="form-control" placeholder="Cedula" name="cedula" required>
  			</div>
  			<div class="form-group">
                            <label>Nombre</label>
                            <input type="text" class="form-control" placeholder="Nombre" name="nombre" required>
  			</div>
  			<div class="form-group">
                            <label>Apellido</label>
                            <input type="text" class="form-control" placeholder="Apellido" name="apellido" required>
  			</div>
  			<div class="form-group">
                            <label>Login del Usuario</label>
                            <input type="text" class="form-control" placeholder="Login" name="login" required>
  			</div>
  			<div class="form-group">
                            <label>Clave del Usuario</label>
                            <input type="password" class="form-control" placeholder="Clave" name="clave" required>
  			</div>
  			<div class="form-group">
                            <label>Numero de Cuenta</label>
                            <input type="text" class="form-control" placeholder="Numero de Cuenta" name="ncuenta" required>
  			</div>
                        <div class="form-group">
                            <label>Telefono</label>
                            <input type="text" class="form-control" placeholder="Telefono" name="telefono" required>
  			</div>
  			<div class="text-center">  					
                            <button type="reset" class="btn btn-warning">Limpiar Campos</button>
                            <button type="submit" class="btn btn-default" name="registerPropietario" value="registerPropietario">Aceptar</button>
  			</div>
                    </form>
                </div>
            </div>
        </div> <!-- /container -->
    </body>
</html>