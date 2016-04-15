package com.jademy.mavenproject3;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class aprobaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pw = response.getWriter(); 
        Connection conn;
        String url="jdbc:mysql://localhost:3306/java";
        String driver="com.mysql.jdbc.Driver";
        try{  
          Class.forName(driver).newInstance();  
          conn = DriverManager.getConnection(url,"root", "Zap2klaz");
          conn.setAutoCommit(false);
          String status = " ";
          String Uid = " ";
          if (!"".equals(request.getParameter("hiddenid")))
          {
              status = "APROBATA";
              Uid = request.getParameter("hiddenid").trim(); 
          }
          else
          {
              status = "RESPINSA";
              Uid = request.getParameter("hiddenidreject").trim(); 
          }
          try (PreparedStatement pst = (PreparedStatement) 
                conn.prepareStatement("update java.prj_cereri set status=? where id=?"))
                {
                pst.setString(1,status);
                pst.setString(2,Uid);
                int i = pst.executeUpdate();
                conn.commit();
                String msg;
                if(i!=0){
                //    msg = "Cererea de concediu a fost aprobata cu succes";
                //    pw.println("<font size='4' color=blue>" + msg + "</font>");
                //    pw.println("<center><a href='succes.jsp'>Pagina Login</a></center>");
                    response.sendRedirect("succes.jsp");
                }
                    else{
                    msg="Eroare la aprobare cererii de concediu in baza de date";
                    pw.println("<font size='4' color=red>" + msg + "</font>");
                }}
        }  
        catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException e){  
          pw.println(e);  
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
