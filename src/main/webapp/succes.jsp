<%@page import="org.jfree.util.Rotation"%>
<%@page import="org.jfree.chart.plot.PiePlot3D"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="java.sql.*"%>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cerere Noua de Concediu</title>
<link href="login.css" rel="stylesheet" type="text/css">       
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js" type="text/javascript"></script> 
<script type="text/javascript">
    $(function () {
        $('#datastart').datepicker({dateFormat: 'yy-mm-dd'}).datepicker("setDate", new Date());
        $('#datastart').datepicker();
        $('#datafinal').datepicker({dateFormat: 'yy-mm-dd'}).datepicker("setDate", new Date());
        $('#datafinal').datepicker();
    });
</script>

<script type="text/javascript">
    $(document).ready(function(){
    $('#id').attr('readonly', true);
    $('#id').addClass('input-disabled');
});
</script>

<script>
    $(function() {
        $( "#tabs" ).tabs();
    });
</script>

<script>
    function validateForm()
    {
        if (document.frm.datastart.value > document.frm.datafinal.value)
        {
            alert("Data de inceput trebuie sa fie mai mica decat data de sfarsit");
            document.frm.datastart.focus();
            return false;
        } 
    }
</script>
      
<script type="text/javascript">
    function setHiddenId(val){
        document.getElementById('hiddenid').value = val;
        alert('Cererea de concediu cu numarul ' + val + ' a fost aprobata');
    }
</script>

<script type="text/javascript">
    function setHiddenIdReject(val){
        document.getElementById('hiddenidreject').value = val;
        alert('Cererea de concediu cu numarul ' + val + ' a fost respinsa');
    }
</script>

</head>

<center><img src="Jademy.png" alt="Jademy.png"/></center>
<h1>APLICATIE CONCEDII - Echipa Jademy #8</h1>
<a href='logout.jsp'>Deconectare [<%= session.getAttribute("userid")%>]</a>
<div id="tabs">
    <ul>
        <li><a href="#cerere">Cerere Noua</a></li>
        <li><a href="#aprobare">Aprobare Concedii</a></li>
        <li><a href="#rapoarte">Rapoarte</a></li>
        <li><a href="#profil">Profil</a></li>
    </ul>
    <div id="cerere">
        <form action="cerereServlet" method="post" name="frm" onSubmit="return validateForm()">
            <p>Situatia concediilor la data: <%= (new java.util.Date())%></p>
            <table class="imagetable">
                <tr>
                    <th>ID</th>
                    <th>PRENUME</th>
                    <th>NUME</th>
                    <th>EMAIL</th>
                    <th>TIP CONCEDIU</th>
                    <th>DATA START</th>
                    <th>DATA FINAL</th>
                    <th>ZILE</th>
                    <th>STATUS</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/java";
                        String username = "root";
                        String password = "Zap2klaz";
                        String query = "select * from prj_cereri where uname='" + session.getAttribute("userid") + "'";
                        Connection conn = DriverManager.getConnection(url, username, password);
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);
                        while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getInt("id")%></td>
                    <td><%=rs.getString("first_name")%></td>
                    <td><%=rs.getString("last_name")%></td>
                    <td><%=rs.getString("email")%></td>
                    <td><%=rs.getString("tipconcediu")%></td>
                    <td><%=rs.getString("datastart")%></td>
                    <td><%=rs.getString("datafinal")%></td>
                    <td><%=rs.getString("nrzile")%></td>
                    <td><%=rs.getString("status")%></td>
                </tr>
                <%

                    }
                %>
            </table>
            <%
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <p>CERERE NOUA DE CONCEDIU</p>
            <table>
                <tr>
                    <td>Utilizator :</td>
                    <td><input type="text" name="id" id="id" value="<%= session.getAttribute("userid")%>"/></td>
                    <td rowspan="7"><img src="/mavenproject3/pictureServlet?id=<%= session.getAttribute("userid")%>" width="200" border="1"/></td>
                </tr>
                <tr>
                    <td>Prenume :</td>
                    <td><input type="text" name="first_name" value="<%= session.getAttribute("first_name")%>"/></td>
                </tr>
                <tr>
                    <td>Nume :</td>
                    <td><input type="text" name="last_name" value="<%= session.getAttribute("last_name")%>"/></td>
                </tr>
                <tr>
                    <td>Email :</td>
                    <td><input type="text" name="email" value="<%= session.getAttribute("email")%>"/></td>
                </tr>
                <tr>
                    <td>Tip Concediu :</td>
                    <td>
                        <select name="dropdown" id="dropdown">
                            <option value="Concediu De Odihna" selected>Concediu De Odihna</option>
                            <option value="Concediu De Studii">Concediu De Studii</option>
                            <option value="Concediu Medical">Concediu Medical</option>
                            <option value="Concediu Fara Plata">Concediu Fara Plata</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Data Start :</td>
                    <td><input type="text" name="datastart" id="datastart"/></td>
                </tr>
                <tr>
                    <td>Data Final :</td>
                    <td><input type="text" name="datafinal" id="datafinal"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="left"><input type="submit" value="Depune Cererea"></td>
                </tr>
            </table>
        </form>
    </div>

    <div id="aprobare">
       <form action="aprobaServlet" method="post" name="frm1">
            <p>Situatia concediilor de aprobat la data: <%= (new java.util.Date())%></p>
            <table class="imagetable">
                <tr>
                    <th>ID</th>
                    <th>PRENUME</th>
                    <th>NUME</th>
                    <th>EMAIL</th>
                    <th>TIP CONCEDIU</th>
                    <th>DATA START</th>
                    <th>DATA FINAL</th>
                    <th>ZILE</th>
                    <th>STATUS</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/java";
                        String username = "root";
                        String password = "Zap2klaz";
                        String query = "select * from prj_cereri where status='INITIATA'";
                        Connection conn = DriverManager.getConnection(url, username, password);
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);
                        while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getInt("id")%></td>
                    <td><%=rs.getString("first_name")%></td>
                    <td><%=rs.getString("last_name")%></td>
                    <td><%=rs.getString("email")%></td>
                    <td><%=rs.getString("tipconcediu")%></td>
                    <td><%=rs.getString("datastart")%></td>
                    <td><%=rs.getString("datafinal")%></td>
                    <td><%=rs.getString("nrzile")%></td>
                    <td><%=rs.getString("status")%></td>
                    <td><input type="submit" id="btnApprove" onclick="setHiddenId(<%=rs.getInt("id")%>);" value="Aproba Cererea" /></td> 
                    <td><input type="submit" id="btnReject" onclick="setHiddenIdReject(<%=rs.getInt("id")%>);" value="Respinge Cererea"/></td> 
                </tr>
                <%

                    }
                %>
            </table>
            <%
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <input type="hidden" name="hiddenid" id="hiddenid"/>   
            <input type="hidden" name="hiddenidreject" id="hiddenidreject"/>  
       </form>
    </div>
                
    <div id="rapoarte">
        <form method="post">
            <%@ page import="java.awt.*" %>
            <%@ page import="java.io.*" %>
            <%@ page import="org.jfree.chart.*" %>
            <%@ page import="org.jfree.chart.entity.*" %>
            <%@ page import ="org.jfree.data.general.*"%>
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection connect = DriverManager.getConnection( 
                "jdbc:mysql://localhost:3306/java" , "root","Zap2klaz");
                Statement statement = connect.createStatement();
                ResultSet resultSet = statement.executeQuery("select tipconcediu, "
                        + "sum(nrzile) as total from java.prj_cereri where uname='" + session.getAttribute("userid") + "' " + "GROUP BY tipconcediu");
                DefaultPieDataset dataset = new DefaultPieDataset();
                while(resultSet.next()) 
                {
                    dataset.setValue( 
                    resultSet.getString("tipconcediu"),
                    Double.parseDouble(resultSet.getString("total")));
                }          
                JFreeChart chart = ChartFactory.createPieChart("Raport concedii efectuate - " + session.getAttribute("userid"), dataset, true, true, false);
                try {
                    final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                    final File file1 = new File(getServletContext().getRealPath(".") + "/" + session.getAttribute("userid") + "_piechart.png");
                    System.out.println(getServletContext().getRealPath("."));
                    ChartUtilities.saveChartAsPNG(file1, chart, 500, 400, info);
                } catch (Exception e) {
                    out.println(e);
                }
            %>       
            <img src="<%= session.getAttribute("userid") %>_piechart.png" width="500" height="400" border="0" usemap="#chart">
            <img src="<%= session.getAttribute("userid") %>_piechart.png" width="500" height="400" border="0" usemap="#chart">
        </form>
    </div>

    <div id="profil">
        <form action="uploadServlet" method="post" name="frm2" enctype="multipart/form-data">
            <p>ACTUALIZARE PROFIL UTILIZATOR</p>
            <table>
                <tr>
                    <td>Utilizator :</td>
                    <td><input type="text" name="id" id="id" value="<%= session.getAttribute("userid")%>"/></td>
                    <td rowspan="7"><img src="/mavenproject3/pictureServlet?id=<%= session.getAttribute("userid")%>" width="200" border="1"/></td>
                </tr>
                <tr>
                    <td>Prenume :</td>
                    <td><input type="text" name="first_name" value="<%= session.getAttribute("first_name")%>"/></td>
                </tr>
                <tr>
                    <td>Nume :</td>
                    <td><input type="text" name="last_name" value="<%= session.getAttribute("last_name")%>"/></td>
                </tr>
                <tr>
                    <td>Email :</td>
                    <td><input type="text" name="email" value="<%= session.getAttribute("email")%>"/></td>
                </tr> 
                <tr>
                    <td colspan="2"><input type="file" name="file"/></td>
                </tr> 
                <tr>
                    <td colspan="2"><input type="submit" value="Upload" /></td>
                </tr> 
                <tr>
                    <td></td>
                </tr> 
            </table>
            <input type="text" name="utilizator" id="utilizator" value="<%= session.getAttribute("userid")%>"/>
        </form>
    </div>

</div>     
</html>