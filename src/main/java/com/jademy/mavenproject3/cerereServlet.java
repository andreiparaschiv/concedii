package com.jademy.mavenproject3;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class cerereServlet extends HttpServlet {
 
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
          String Email = request.getParameter("email").trim();  
          String TipCO = request.getParameter("dropdown");
          String Pass = request.getParameter("id");  
          String DataStart = request.getParameter("datastart");  
          String DataFinal = request.getParameter("datafinal"); 
          
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          Date ds = sdf.parse(request.getParameter("datastart"));
          Date df = sdf.parse(request.getParameter("datafinal"));
          long NrZile = ((df.getTime()-ds.getTime())) / (1000 * 60 * 60 * 24) + 1;
          
          Class.forName(driver).newInstance();  
          conn = DriverManager.getConnection(url+dbName,"root", "Zap2klaz");
          conn.setAutoCommit(false);
          try (PreparedStatement pst = (PreparedStatement) 
                conn.prepareStatement("insert into java.prj_cereri(first_name,"
                        + "last_name,email,uname,tipconcediu,pass,datastart,datafinal,nrzile,status) "
                        + "values(?,?,?,?,?,?,?,?,?,?)")) 
                {
                pst.setString(1,Fname);
                pst.setString(2,Lname);
                pst.setString(3,Email);
                pst.setString(4,Uname);
                pst.setString(5,TipCO);
                pst.setString(6,Pass);
                pst.setString(7,DataStart);
                pst.setString(8,DataFinal);
                pst.setString(9, Long.toString(NrZile));
                pst.setString(10, "INITIATA");
                int i = pst.executeUpdate();
                conn.commit();
                String msg;
                if(i!=0){
                    msg = "Cererea de concediu a fost inregistrata cu succes ";
                    pw.println("<font size='4' color=blue>" + msg + "</font>");
                }
                else{
                    msg="Eroare la inregistrarea cererii de concediu in baza de date";
                    pw.println("<font size='4' color=red>" + msg + "</font>");
                }}
        }  
        catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException e){  
          pw.println(e);  
        } catch (ParseException ex) {
            Logger.getLogger(cerereServlet.class.getName()).log(Level.SEVERE, null, ex);
        }  
}      
}