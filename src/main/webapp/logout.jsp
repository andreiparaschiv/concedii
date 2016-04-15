<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deconectare Aplicatie</title>
        <link href="login.css" rel="stylesheet" type="text/css">
            <script type="text/javascript">
                function cancelAction()
                {	
                    document.location.href("login.jsp"); 
                }	
            </script>
    </head> 
    <body>
        <center><img src="Jademy.png" alt="Jademy.png"/></center>
        <h1>Ati fost deconectat de la aplicatie</h1>
        <center><a href="login.jsp">Pagina Login</a></center>
    </body>
    <%
    session.setAttribute("userid", null);
    session.invalidate();
    %>
</html>

