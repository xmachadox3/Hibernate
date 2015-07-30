<%@page import="com.persistentes.Casaplaya"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.controlador.NewHibernateUtil"%>
<%@page import="org.hibernate.SessionFactory"%>
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
                         </div>
                    </div>
                </nav>
            </div> <!-- Header -->
            <div class="clearfix"></div>
            <br>
            <br>
            <div class="row">
                <div class="col-lg-3">
                    <h2 class="text-center">Registrar Casas de Playa</h2>
                    <form method="post" action="RegistrarCasaPlaya" >
                        <div class="form-group">
                            <input type="text" placeholder="codigo" class="form-control" name ="codigo" required>
            		</div>	
            		<div class="form-group">
                            <input type="text" placeholder="poblacion" class="form-control" name= "poblacion" required>
            		</div>
            		<div class="form-group">
                            <input type="number" placeholder="Numeros de Baños" class="form-control" name= "nbanos" required>
            		</div>
            		<div class="form-group">
                            <input type="number" placeholder="Numeros de Cocinas" class="form-control" name= "ncocinas" required>
            		</div>
            		<div class="form-group">
                            <input type="number" placeholder="Numeros de Comedores" class="form-control" name= "ncomedores" required>
            		</div>
            		<div class="form-group">
                            <input type="number" placeholder="Numeros de Estacionamientos" class="form-control" name= "nestacionamientos" required>
            		</div>
            		<div class="form-group">
                            <input type="number" placeholder="Numeros de Habitaciones" class="form-control" name= "nhabitaciones" required>
            		</div>
            		<div class="form-group" style="display: none">
                            <input type="text"  class="form-control" name= "usuario" value="<%= Usuario%>" required>
            		</div>
                            <button type="submit" class="btn btn-success" name="registrarcasaplaya"  value="registrarcasaplaya">Guardar</button>
          		</form>
      			
      		</div>
                <div class="col-lg-9">
                    <h2 class="text-center">Casas de Playa Registradas</h2> 
                       <table class="table table-hover">
      				<thead>
      				<th>Codigo</th>
      				<th>EstadoActual</th>
      				<th>#-Banos</th>
      				<th>#-Cocinas</th>
      				<th>#-Comedores</th>
      				<th>#-Estacionamientos</th>
                                <th>#-Habitaciones</th>
      				<th>#-Poblacion</th>
      				<th>#-Propietario</th>
                            </thead>
                        <%
                            try{
                                SessionFactory sesion = NewHibernateUtil.getSessionFactory();
                                Session session1;
                                session1 = sesion.openSession();
                                Transaction tx = session1.beginTransaction();
                                
                                String hql = "FROM Casaplaya CP where CP.propietario.persona.login = " + "\'" + Usuario + "\'" ;
                                Query query = session1.createQuery(hql);
                                Iterator<Casaplaya> resultCasaPlaya = query.list().iterator();
      					
      					
      				%>
      				<tbody>
      				<%while(resultCasaPlaya.hasNext()){ 
      					Casaplaya t = resultCasaPlaya.next();
      				%>
      					<tr>
      						<td><%= t.getCodigo() %></td>
      						<td><%= t.getEstadoactual() %></td>
      						<td><%= t.getNbanos() %></td>
      						<td><%= t.getNcocinas() %></td>
      						<td><%= t.getNcomedores() %></td>
      						<td><%= t.getNestacionamientos() %></td>
      						<td><%= t.getNhabitaciones() %></td>
      						<td><%= t.getPoblacion()  %></td>
      						<td><%= t.getPropietario().getPersona().getNombre() %></td>
      					</tr>
      				<%
                                    }      					
      				}catch(Exception e){
      					%><%="Error" %><%
      				}
      				%>
                                </tb>			
                            </table>
                        </div> 
                    <br>
            </div>
            <div class="row">
                <div class="col-lg-3">
                    <h2 class="text-center">Registrar Paquete Casa de Playa</h2>
                    <form method="post" action="RegistrarPaqueteCasaPlaya" >
                        <div class="form-group">
                            <input type="text" placeholder="Codigo de la Casa" class="form-control" name ="codigocasa" required>
            		</div>	
            		<div class="form-group">
              			<input type="text" placeholder="Codigo del Paquete" class="form-control" name= "codigopaquete" required>
            		</div>
            		<div class="form-group">
              			<input type="text" placeholder="Fecha Inicial" class="form-control" name= "finicial" required>
            		</div>
            		<div class="form-group">
              			<input type="text" placeholder="Fecha Final" class="form-control" name= "ffinal" required>
            		</div>
            		
            		<div class="form-group">
              			<input type="text" placeholder="Precio" class="form-control" name= "precio" required>
            		</div>            		
            		<div class="form-group" style="display: none">
              			<input type="text"  class="form-control" name= "usuario" value="<%= Usuario%>" required>
            		</div>
            		
            		<button type="submit" class="btn btn-success" name="registrarpaquetecasaplaya"  value="registrarcasaplaya">Guardar</button>
                    </form>
      		</div>
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
                                </div>
                            </div>
                        </nav>
                    </div> <!-- Header -->
                        <div class="clearfix"></div>
                    <br>
                    <br>
                     <div class="col-lg-12">
                    <h2 class="text-center">Casas de Playa Registradas</h2> 
                       <table class="table table-hover">
      				<thead>
      				<th>Codigo</th>
      				<th>EstadoActual</th>
      				<th>#-Banos</th>
      				<th>#-Cocinas</th>
      				<th>#-Comedores</th>
      				<th>#-Estacionamientos</th>
                                <th>#-Habitaciones</th>
      				<th>#-Poblacion</th>
      				<th>#-Propietario</th>
                            </thead>
                        <%
                            try{
                                SessionFactory sesion = NewHibernateUtil.getSessionFactory();
                                Session session1;
                                session1 = sesion.openSession();
                                Transaction tx = session1.beginTransaction();
                                
                                String hql = "FROM Casaplaya CP ";
                                Query query = session1.createQuery(hql);
                                Iterator<Casaplaya> resultCasaPlaya = query.list().iterator();
      					
      					
      				%>
      				<tbody>
      				<%while(resultCasaPlaya.hasNext()){ 
      					Casaplaya t = resultCasaPlaya.next();
      				%>
      					<form method="post" action="VerPaquete">
      					<tr>     						
                                            <input type="hidden" name="codigocasa" value = "<%=t.getCodigo() %>">
                                            <td><%= t.getCodigo() %></td>
                                            <input type="hidden" name="nbanos" value = "<%=t.getNbanos() %>">
                                            <td><%= t.getNbanos() %></td>
                                            <input type="hidden" name="ncocinas" value = "<%=t.getNcocinas() %>">
                                            <td><%= t.getNcocinas() %></td>
                                            <input type="hidden" name="ncomedores" value = "<%=t.getNcomedores() %>">
                                            <td><%= t.getNcomedores() %></td>
                                            <input type="hidden" name="nestacionamientos" value = "<%=t.getNestacionamientos() %>">
                                            <td><%= t.getNestacionamientos() %></td>
                                            <input type="hidden" name="nhabitaciones" value = "<%=t.getNhabitaciones() %>">
                                            <td><%= t.getNhabitaciones() %></td>
                                            <input type="hidden" name="poblacion" value = "<%=t.getPoblacion() %>">
                                            <td><%= t.getPoblacion()  %></td>
                                            <input type="hidden" name="propietario" value = "<%=t.getPropietario().getPersona().getNombre() %>">
                                            <td><%= t.getPropietario().getIdpersona() %></td>
                                            <td><button type="submit" class="btn btn-info">Ver Paquetes</button></td>
      					</tr>
                                        </form>
      				<%
                                    }      					
      				}catch(Exception e){
      					%><%="Error" %><%
      				}
      				%>
                       </tb>			
                            </table>
                        </div> 
                    <br>
                            <%}%>                                   
                    </div>
                </body>
</html>