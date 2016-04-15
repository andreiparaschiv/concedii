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

public class registerServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");  
        PrintWriter pw = response.getWriter(); 
        Connection conn;
        String url="jdbc:mysql://localhost:3306/";
        String dbName="java";
        String driver="com.mysql.jdbc.Driver";
        try{  
          String Fname = request.getParameter("first_name").trim();   
          String Lname = request.getParameter("last_name").trim();  
          String Uname = request.getParameter("id").trim();
          String Pass = request.getParameter("pass").trim();
          String Email = request.getParameter("email").trim();  
          String Data = request.getParameter("datastart");  
          Class.forName(driver).newInstance();  
          conn = DriverManager.getConnection(url+dbName,"root", "Zap2klaz");
          conn.setAutoCommit(false);
          try (PreparedStatement pst = (PreparedStatement) 
                conn.prepareStatement("insert into java.prj_members(first_name,"
                        + "last_name,email,uname,pass,regdate, poza) "
                        + "values(?,?,?,?,?,?,'default.png')")) 
                {
                pst.setString(1,Fname);
                pst.setString(2,Lname);
                pst.setString(3,Email);
                pst.setString(4,Uname);
                pst.setString(5,Pass);
                pst.setString(6,Data);
                int i = pst.executeUpdate();
                conn.commit();
                String msg;
                if(i!=0){
                    msg = "Utilizatorul a fost inregistrat cu succes ";
                    pw.println("<font size='4' color=blue>" + msg + "</font>");
                }
                else{
                    msg="Eroare la inregistrarea utilizatorului in baza de date";
                    pw.println("<font size='4' color=red>" + msg + "</font>");
                }}
        }  
        catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException e){  
          pw.println(e);  
        }  
}      
}