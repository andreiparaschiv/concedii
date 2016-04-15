<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inregistrare Utilizator</title>
        <link href="login.css" rel="stylesheet" type="text/css">
    </head>
    <body>
    <center><img src="Jademy.png" alt="Jademy.png"/></center>
        <form action="registerServlet" method="post" name="frm" >
            <center><p>INREGISTRARE UTILIZATOR NOU</p></center>
            <table style="margin: auto;">
                <tr>
                    <td>Utilizator :</td>
                    <td><input type="text" name="id" id="id" value="${id}"/></td>
                </tr>
                <tr>
                    <td>Parola :</td>
                    <td><input type="password" name="pass" id="pass" value="${pass}"/></td>
                </tr>
                <tr>
                    <td>Prenume :</td>
                    <td><input type="text" name="first_name" id="first_name" value="${first_name}"/></td>
                </tr>
                <tr>
                    <td>Nume :</td>
                    <td><input type="text" name="last_name" id="last_name" value="${last_name}"/></td>
                </tr>
                <tr>
                    <td>Email :</td>
                    <td><input type="text" name="email" id="email" value="${email}"/></td>
                </tr>
                <%@page import="java.text.SimpleDateFormat"%>
                <%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
                <tr>
                    <td>Data :</td>
                    <td><input type="text" value="<%= df.format(new java.util.Date()) %>" name="datastart" id="datastart"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="Inregistreaza"></td>
                </tr>
            </table>
        </form>
</html>
