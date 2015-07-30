/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.controlador.NewHibernateUtil;
import com.persistentes.Casaplaya;
import com.persistentes.Paquete;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;
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
@WebServlet(name = "RegistrarPaqueteCasaPlaya", urlPatterns = {"/RegistrarPaqueteCasaPlaya"})
public class RegistrarPaqueteCasaPlaya extends HttpServlet {

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
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	String codigocasa 		= request.getParameter("codigocasa");
	String codigopaquete 	= request.getParameter("codigopaquete"); 
	Float  precio 			= Float.parseFloat(request.getParameter("precio"));
  		
  	Date fechainicial = null;
  	Date fechafinal = null;
  	try {  			
            fechainicial = formatter.parse(request.getParameter("finicial"));
            System.out.println(fechainicial);
            System.out.println(formatter.format(fechainicial));
	} catch (java.text.ParseException e) {
            e.printStackTrace();
	}
  	try {
            fechafinal = formatter.parse(request.getParameter("ffinal"));
            System.out.println(fechafinal );
            System.out.println(formatter.format(fechafinal ));
	} catch (java.text.ParseException e) {
            e.printStackTrace();
	}
            System.out.println(fechainicial + " - " + fechafinal);
  		
  	SessionFactory sesion = NewHibernateUtil.getSessionFactory();
        Session session;
        session = sesion.openSession();
            Transaction tx = session.beginTransaction();
            //Busqueda previa si ya existe ese propietario
            String hql = "FROM Paquete P where P.codigo = " + "\'" + codigopaquete + "\'" ;
            Query query = session.createQuery(hql);
            List Paquetes = query.list();
            if(!Paquetes.isEmpty()){
                tx.commit();
                session.close();
                String mensaje = "No se pudo procesar su solicitud";
		request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("mensaje.jsp").forward(request, response);
            }
            else{
                String hql1 = "FROM Casaplaya CP where CP.codigo = " + "\'" + codigocasa + "\'" ;
                query = session.createQuery(hql1);
                List CasasPlayas;
                CasasPlayas = query.list();
                Paquete paquete = new Paquete(codigopaquete,(Casaplaya)CasasPlayas.get(0),fechainicial,fechafinal,precio,1,null,null,null);
                session.save(paquete);
                tx.commit();
                session.close();
                String mensaje = "Se ha registrado satisfactoriamente";
		request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("mensaje.jsp").forward(request, response);
            }
  		
  		
  		
		
  		
  		
  		
  		response.sendRedirect("index.jsp");
		
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
