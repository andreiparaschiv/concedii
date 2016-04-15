package com.jademy.mavenproject3;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class uploadServlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        String UPLOAD_DIRECTORY = getServletContext().getRealPath(".");
        String utilizator = request.getParameter("utilizator");
        String name = "";
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        name = new File(item.getName()).getName();
                        item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
                    }
                }
               request.setAttribute("message", "Poza a fost uploadata cu succes");
            } catch (Exception ex) {
               request.setAttribute("message", "Eroare la upload: " + ex);
            }         
        }else{
            request.setAttribute("message","SAcest servlet proceseaza doar cereri de upload");
        } 
     //   request.getRequestDispatcher("/result.jsp").forward(request, response);

     //update in baza

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pw = response.getWriter(); 
        Connection conn;
        String url="jdbc:mysql://localhost:3306/java";
        String driver="com.mysql.jdbc.Driver";
        try{  
          Class.forName(driver).newInstance();  
          conn = DriverManager.getConnection(url,"root", "Zap2klaz");
          conn.setAutoCommit(false);
          try (PreparedStatement pst = (PreparedStatement) 
                conn.prepareStatement("update java.prj_members set poza=? where uname='andrei'"))
                {
                pst.setString(1,name);
            //    pst.setString(2,utilizator);
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
                    msg="Eroare la uploadul pozei de profil in baza de date";
                    pw.println("<font size='4' color=red>" + msg + "</font>");
                }}
        }  
        catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException e){  
          pw.println(e);  
        }  
    }
}