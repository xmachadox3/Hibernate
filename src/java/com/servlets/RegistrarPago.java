/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.controlador.NewHibernateUtil;
import com.persistentes.Cliente;
import com.persistentes.Pago;
import com.persistentes.Paquete;
import com.persistentes.Persona;
import com.persistentes.Reserva;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author jeny
 */
@WebServlet(name = "RegistrarPago", urlPatterns = {"/RegistrarPago"})
public class RegistrarPago extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String codigoreserva = request.getParameter("codigoreserva");
            String loginusuario  = request.getParameter("loginusuario");
            String clave 		 = request.getParameter("clave");
            String ndeposito	 = request.getParameter("ndeposito");
            String telefono		 = request.getParameter("telefono");
	
           
		
            SessionFactory sesion = NewHibernateUtil.getSessionFactory();
            Session session1;
            session1 = sesion.openSession();
            Transaction tx = session1.beginTransaction();
            
         
            String hql = "FROM Reserva R where R.codigo = \'"  + codigoreserva + "\'";
                                
            Query query = session1.createQuery(hql);
            Iterator<Reserva> resultReserva = query.list().iterator();
            Reserva reserva = resultReserva.next();
            if(reserva != null){	
                Paquete paquete = reserva.getPaquete();
                paquete.setEstados(3);
                session1.save(paquete);
                String  hql1 = "FROM Persona P where P.login = \'"  + loginusuario+ "\'";
                Query query1 = session1.createQuery(hql1);
                Iterator<Persona> resultPersona = query1.list().iterator();
                Persona persona = resultPersona.next();
                persona.setTelefono(telefono);
                session1.save(persona);
                Cliente cliente = persona.getCliente();
                cliente.setNdeposito(ndeposito);
                session1.save(cliente);
                Pago pago = new Pago(reserva.getCodigo(),reserva.getCliente(),reserva.getPaquete());
                session1.delete(reserva);
                session1.save(pago);
                tx.commit();
                String mensaje = "Proceso realizado satisfactoriamente";
		request.setAttribute("mensaje", mensaje);
		request.getRequestDispatcher("mensaje.jsp").forward(request, response);
            }else{
                String mensaje = "Ha ocurrido un error,  ya existen los datos colocados";
		request.setAttribute("mensaje", mensaje);
		request.getRequestDispatcher("mensaje.jsp").forward(request, response);
            }	
    }
				
			
			
			
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
