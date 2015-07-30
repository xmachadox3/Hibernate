package com.servlets;

import com.controlador.NewHibernateUtil;
import com.persistentes.Persona;
import com.persistentes.Propietario;
import java.io.IOException;
import java.util.List;
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
 * @author Jesús Machado
 */
@WebServlet(name = "RegistrarPropietario", urlPatterns = {"/RegistrarPropietario"})
public class RegistrarPropietario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cedula 	= request.getParameter("cedula");
	String apellido = request.getParameter("apellido");
        String nombre 	= request.getParameter("nombre");
        String login 	= request.getParameter("login");
        String clave 	= request.getParameter("clave");
	String ncuenta 	= request.getParameter("ncuenta");
	String telefono = request.getParameter("telefono");
        
        
        SessionFactory sesion = NewHibernateUtil.getSessionFactory();
        Session session;
        session = sesion.openSession();
            Transaction tx = session.beginTransaction();
            //Busqueda previa si ya existe ese propietario
            String hql = "FROM Persona P where P.cedula = " + cedula ;
            Query query = session.createQuery(hql);
            List personas = query.list();
            if(!personas.isEmpty()){
                tx.commit();
                session.close();
                String mensaje = "Ha ocurrido un error, la cedula: " + cedula + " ya existe";
		request.setAttribute("mensaje", mensaje);
		request.getRequestDispatcher("mensaje.jsp").forward(request, response);
            }
            else{
                Persona persona;
                Propietario propietario;
                persona = new Persona(cedula,nombre,apellido,telefono,clave,login,null,null);
                propietario = new Propietario(persona,ncuenta,null);
                persona.setPropietario(propietario);           
                session.save(persona);
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
