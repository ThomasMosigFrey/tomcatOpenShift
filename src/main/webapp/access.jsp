<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"   %>
<%@page import="javax.naming.InitialContext"   %>
<%@page import="javax.naming.NamingException"   %>
<%@page import="javax.sql.DataSource"   %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sendungsdaten</title>
    </head>
    <body>
        <table border="1">
         <tr>
           <td > ID </td>
           <td > ART </td>
           <td > GEW </td>
           <td > PORTS </td>
       </tr>

 <%
 Context initCtx = new InitialContext();
 DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/sendungsdaten");
 Connection conn = ds.getConnection();

     Statement stmt = conn.createStatement();
     String query="select * from SENDUNGSDATEN";

    ResultSet result = stmt.executeQuery(query);
     while (result.next())
     {
  %>
    <tr>
   <td> <%= result.getString("ID") %> </td>
   <td> <%= result.getString("ART") %> </td>
   <td> <%= result.getString("GEW") %> </td>
   <td> <%= result.getString("PORTO") %> </td>
   </tr>
 <%
     }
 %>

 </table>
    </body>
</html>