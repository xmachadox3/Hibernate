/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.controlador.NewHibernateUtil;
import com.persistentes.Casaplaya;
import com.persistentes.Persona;
import com.persistentes.Propietario;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "RegistrarCasaPlaya", urlPatterns = {"/RegistrarCasaPlaya"})
public class RegistrarCasaPlaya extends HttpServlet {

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
        
        String 	codigo              = request.getParameter("codigo");
	String 	poblacion           = request.getParameter("poblacion");
	Integer nbanos              = Integer.parseInt(request.getParameter("nbanos"));
	Integer ncocinas            = Integer.parseInt(request.getParameter("ncocinas"));
	Integer ncomedores          = Integer.parseInt(request.getParameter("ncomedores"));
	Integer nestacionamientos   = Integer.parseInt(request.getParameter("nestacionamientos"));
	Integer	nhabitaciones       = Integer.parseInt(request.getParameter("nhabitaciones"));
        
	String  login = request.getParameter("usuario");
	System.out.println(login);
        SessionFactory sesion = NewHibernateUtil.getSessionFactory();
        Session session;
        session = sesion.openSession();
            Transaction tx = session.beginTransaction();
            //Busqueda previa si ya existe ese propietario
            String hql = "FROM Casaplaya CP where CP.codigo = " + "\'" + codigo + "\'" ;
            Query query = session.createQuery(hql);
            List Casaplayas = query.list();
            if(!Casaplayas.isEmpty()){
                tx.commit();
                session.close();
                String mensaje = "No se pudo procesar su solicitud";
		request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("mensaje.jsp").forward(request, response); 
            }
            else{
                String hql1 = "FROM Persona P where P.login = " + "\'" + login + "\'" ;
                Query query1 = session.createQuery(hql1);
                List Personas = query1.list();        
                Persona usuario = (Persona) Personas.get(0);
                Propietario propietario = usuario.getPropietario();
                System.out.println(propietario.toString());
                Casaplaya casaplaya = new Casaplaya(codigo,propietario,poblacion,nhabitaciones,nbanos,ncocinas,ncomedores,nestacionamientos,true,null);
                Set<Casaplaya> x = propietario.getCasaplayas();
                x.add(casaplaya);
                propietario.setCasaplayas(x);
                session.save(casaplaya);
                session.save(propietario);
        
                
                tx.commit();
                session.close();
                
                String mensaje = "Se ha registrado satisfactoriamente";
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
