<%@page import="com.persistentes.Reserva"%>
<%@page import="com.persistentes.Cliente"%>
<%@page import="com.persistentes.Persona"%>
<%@page import="com.persistentes.Propietario"%>
<%@page import="com.persistentes.Paquete"%>
<%@page import="java.text.SimpleDateFormat"%>
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
      				tx.commit();
                                session1.close();
      					
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
                <div class="col-9">
                    <div class="col-lg-9">
                    <h2 class="text-center">Paquete de las Casas de Playa</h2> 
                    <table class="table table-hover">
                        <thead>
                            <th>Codigo Casa</th>
                            <th>Codigo Paquete</th>
                            <th>Fecha Inicial</th>
                            <th>Fecha Final</th>
                            <th>Precio</th>
      			  
                        </thead>
                    <%
                        try{
                            SessionFactory sesion = NewHibernateUtil.getSessionFactory();
                            Session session1;
                            session1 = sesion.openSession();
                            Transaction tx = session1.beginTransaction();                                
                            String hql = "FROM Casaplaya CP where CP.propietario.persona.login = " + "\'" + Usuario + "\'" ;
                            
                            Query query = session1.createQuery(hql);
                            
                            Iterator<Casaplaya> resultCasaPlaya =  query.list().iterator();
                             
                            Casaplaya t;
                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); %>
      				
                        <tbody>
      				<%while(resultCasaPlaya.hasNext()){ 
      					t = resultCasaPlaya.next();
                                        
                                    
      					Iterator<Paquete> resultPaquete   = t.getPaquetes().iterator();
                                        Paquete p;
      					while(resultPaquete.hasNext()){
      						p = resultPaquete.next();
      				%>
      					<tr>
      						<td><%= t.getCodigo() %></td>
      						<td><%= p.getCodigo() %></td>
      						<td><%= formatter.format(p.getFechainicio())%></td>
      						<td><%= formatter.format(p.getFechafinal())  %></td>
      						<td><%= p.getPrecio() %></td>      						
      						
      					</tr>
      				<%
      				}
      					}
                                }catch(Exception e){
      					%><%= "error" %><%
      				}
      					
      				%>
      				</tbody>
  				</table>
      		</div>
      		</div>
      	</div>
        <div class="row">
      		<div class="col-lg-4">
      			<h4>Casas de Playas Reservadas</h4>
      			<table class="table table-hover">
      				<thead>
      					<th>C.Casa</th>
      					
      					<th>F.Inicial</th>
      					<th>F.Final</th>
      					<th>Precio</th>
      					
      					<th>C.Cliente</th>
      					<th>N.Cliente</th>
      				</thead>
      				<%
                                    try{
                                        SessionFactory sesion = NewHibernateUtil.getSessionFactory();
                                        Session session1;
                                        session1 = sesion.openSession();
                                        Transaction tx = session1.beginTransaction();                                
                                        String hql = "FROM Persona P where P.login = " + "\'" + Usuario + "\'" ;
                            
                                        Query query = session1.createQuery(hql);
      					Iterator<Persona> resultPropietario = query.list().iterator();
  					Persona x = null;
  					boolean flagsPropietario = false;
  					while(resultPropietario.hasNext()){
                                            x = resultPropietario.next();
                                            if(x.getLogin().equals(Usuario)){
                                                flagsPropietario = true;
                                                break;
                                            }				
                                        }
                                        Iterator<Casaplaya> resultCasaPlaya =  x.getPropietario().getCasaplayas().iterator();
  					Casaplaya t = null;
  					Paquete p = null;      				
      				%>
      				<%SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); %>
      				<tbody>
      				<%while(resultCasaPlaya.hasNext()){ 
      					t = resultCasaPlaya.next();
      					Iterator<Paquete>   resultPaquete   = t.getPaquetes().iterator();
      					while(resultPaquete.hasNext()){
      						p = resultPaquete.next();
                                                Iterator<Reserva> resultReserva = p.getReservas().iterator();
                                                while(resultReserva.hasNext()){
                                                    Reserva r = resultReserva.next();
      				%>
      					<tr>
      						<td><%= t.getCodigo() %></td>
      						
      						<td><%= formatter.format(p.getFechainicio()) %></td>
      						<td><%= formatter.format(p.getFechafinal()) %></td>
      						<td><%= p.getPrecio() %></td>      		
      						
      						<td><%= r.getCliente().getPersona().getCedula() %></td>
      						<td><%= r.getCliente().getPersona().getNombre() %></td>			
      						
      					</tr>
      					<%}}
      					} 
                                    }catch(Exception e){%>
                                        <%= e.getCause() %>
                                        <%
                                    }
                                        %>
      					
      				</tbody>
      			</table>
      		</div>
        </div>
      	
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
                    <br>
                    <br>
                    <br>
                    <br>
                    <div class="clearfix"></div>
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form class="form-inline" action="PasarIndex" method="post">
  					<div class="form-group">
                                            <label for="exampleInputName2">Poblacion</label>
                                            <%
                                                try{
                                                    SessionFactory sesion = NewHibernateUtil.getSessionFactory();
                                                    Session session1;
                                                    session1 = sesion.openSession();
                                                    Transaction tx = session1.beginTransaction();                                
                                                    String hql = "FROM Casaplaya " ;
                            
                                                    Query query = session1.createQuery(hql);
                                                    System.out.println(query.list().size());
                                                    Iterator<Casaplaya> resultCasaPlaya =  query.iterate();
                                                    Casaplaya t;
                                                    
      					%>
    					<select class="form-control" name="bpoblacion">
    						<option></option>
	    					<%while(resultCasaPlaya.hasNext()){ 
	      						t = resultCasaPlaya.next();
	      					%>
	  							<option><%= t.getPoblacion() %></option>
	  							
	  						<%
      						}      					
      					}catch(Exception e){
      					%><%="Error" %><%
      					}
      				%>
						</select>
  					</div>
  					<div class="form-group">
    					<label for="exampleInputEmail2">Codigo</label>
    					<input type="text" class="form-control" id="exampleInputEmail2" placeholder="" name="codigo">
  					</div>
  					<button type="submit" class="btn btn-default">Buscar</button>
				</form>
      		</div>
      	</div>
      		<div class="row">
      			<div class="col-lg-12">
      				 
      				<table class="table table-hover">
      					<thead>
      						<th>Codigo</th>
      						<th>#-Banos</th>
      						<th>#-Cocinas</th>
      						<th>#-Comedores</th>
      						<th>#-Estacionamientos</th>
      						<th>#-Habitaciones</th>
      						<th>#-Poblacion</th>
      						<th>#-Propietario</th>
      						<th> Opcion </th>
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
                                            <td><%= t.getPropietario().getPersona().getNombre() %></td>
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