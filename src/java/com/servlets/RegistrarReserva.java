/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.controlador.NewHibernateUtil;
import com.persistentes.Cliente;
import com.persistentes.Paquete;
import com.persistentes.Persona;
import com.persistentes.Reserva;
import java.io.IOException;
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
@WebServlet(name = "RegistrarReserva", urlPatterns = {"/RegistrarReserva"})
public class RegistrarReserva extends HttpServlet {

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
       try{
            String codigopaquete = request.getParameter("codigopaquete");
            SessionFactory sesion = NewHibernateUtil.getSessionFactory();
            Session session1;
            session1 = sesion.openSession();
            Transaction tx = session1.beginTransaction();
            
         
            String hql = "FROM Paquete CP where CP.codigo = \'"  + codigopaquete + "\'";
                                
            Query query = session1.createQuery(hql);
            Iterator<Paquete> resultPaquete = query.list().iterator();
            
            
            
		
            
            String cedula 	= request.getParameter("cedula");
            String apellido     = request.getParameter("apellido");
            String nombre 	= request.getParameter("nombre");
            String login 	= request.getParameter("login");
            String clave 	= request.getParameter("clave");
           
           
            String hql1 = "FROM Persona P where P.cedula = \'"  + cedula + "\' or P.login = \'" + login + "\'";
            Query query1 = session1.createQuery(hql1);            
            
            Iterator<Persona> resultPersona = query1.list().iterator();
            boolean aceptado = true;
            while(resultPersona.hasNext()){
                if(resultPersona.next().getCedula().equals(cedula)){
                    aceptado = false;
                    break;
                }
            } 
            if(aceptado){
                Paquete paquete  = resultPaquete.next();
                paquete.setEstados(2);
                 Persona x = new Persona(cedula, nombre,apellido, null,clave, login, null, null);
                Cliente cliente = new Cliente(paquete,x ,null, null,null);
                Reserva reserva = new Reserva(codigopaquete, cliente, paquete);
		session1.save(paquete);
                session1.save(x);
                session1.save(cliente);
                session1.save(reserva);
                tx.commit();
                String mensaje = "Se ha realizado la reserva, su codigo es: <strong> "  + paquete.getCodigo()+"</strong>";
                request.setAttribute("mensaje", mensaje);			
                request.getRequestDispatcher("mensaje.jsp").forward(request, response);
            }
            else{
                String mensaje = "Ha ocurrido un error,  ya existen los datos colocados";
		request.setAttribute("mensaje", mensaje);
		request.getRequestDispatcher("mensaje.jsp").forward(request, response);
            }
           
    }catch(Exception e) {
      System.out.println(e.getCause());
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
