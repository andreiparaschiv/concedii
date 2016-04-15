package com.jademy.mavenproject3;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class pictureServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {    
    String poza = "";
    Statement querySmt = null;
    ResultSet result = null;
    try
    {
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/java";
    Connection connection = DriverManager.getConnection(url, "root","Zap2klaz");
    if (connection.equals(null)) {
            System.out.println("conexiunea a esuat");
        } else {
            System.out.print("conectare cu succes: ");
            querySmt = connection.createStatement();
            result = querySmt.executeQuery("select * from prj_members where uname = '" + request.getParameter("id") + "'");
            if (!result.equals(null)) {
                while (result.next()) {
                    poza = result.getString("poza").trim();
                    System.out.println("Poza de descarcat: " + poza);
                }
            }
        }
    } catch (Exception exception) {
            exception.printStackTrace();
        } finally {
            try {
                result.close();
                querySmt.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    response.setContentType("image/jpeg");  
    ServletOutputStream out;  
    out = response.getOutputStream();  
    FileInputStream fin = new FileInputStream(getServletContext().getRealPath(".") + "/" + poza);       
    BufferedInputStream bin = new BufferedInputStream(fin);  
    int ch =0; ;  
    while((ch=bin.read())!=-1)  
    {  
    out.write(ch);  
    }       
    bin.close();  
    fin.close();    
    out.close();  
        
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
