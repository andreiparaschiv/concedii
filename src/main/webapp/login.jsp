<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>PAGINA LOGIN - Echipa Jademy #8</title>
        <link href="login.css" rel="stylesheet" type="text/css">
        <script>
            function validateForm()
            {
                if (document.frm.id.value === "")
                {
                    alert("Numele utilizatorului nu trebuie sa fie gol");
                    document.frm.id.focus();
                    return false;
                } else if (document.frm.password.value === "")
                {
                    alert("Va rugam introduceti o parola pentru utilizator");
                    document.frm.password.focus();
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <br>
        <br>
        <center><img src="Jademy.png" alt="Jademy.png"/></center>
        <form action="loginServlet" method="post" name="frm" onSubmit="return validateForm()">
            <center><p>AUTENTIFICARE APLICATIE CONCEDII</p></center>
            <center><p> <%= (new java.util.Date())%></p></center>
            <table style="margin: auto;">
                <tr>
                    <td>Utilizator :</td>
                    <td><input type="text" name="id"/></td>
                </tr>
                <tr>
                    <td>Parola :</td>
                    <td><input type="password" name="password"/></td>
                </tr>
                <tr>
                    <td colspan="2">Nu esti inregistrat? <a href="register.jsp">Inregistreaza-te</a></td>
                </tr>
                <br>
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="Conectare"></td>
                </tr>
            </table>
        </form>
    </body>
</html>