<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javaClass.Person" %> 
<%@ page import="javaClass.ConectionMysql" %>

    <%
    Connection conexao = ConectionMysql.conectar();
    PreparedStatement updateSubject = null;
	ResultSet rsnotas = null;
				  updateSubject = conexao.prepareStatement("INSERT INTO plano_de_aula (id_materia, unidade,asunto)" +
            	   " VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE assunto = ?;" );
				  updateSubject.setInt(1, Integer.parseInt(request.getParameter("idmateria").trim()));
				  updateSubject.setInt(2, 1);
				  updateSubject.setString(3, request.getParameter("unum"));
				  updateSubject.setString(4, request.getParameter("unum"));
				  updateSubject.execute();
				  
				  updateSubject = conexao.prepareStatement("INSERT INTO plano_de_aula (id_materia, unidade,asunto)" +
		            	   " VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE assunto = ?;" );
						  updateSubject.setInt(1, Integer.parseInt(request.getParameter("idmateria").trim()));
						  updateSubject.setInt(2, 2);
						  updateSubject.setString(3, request.getParameter("undois"));
						  updateSubject.setString(4, request.getParameter("undois"));
						  updateSubject.execute();
						  
				  updateSubject = conexao.prepareStatement("INSERT INTO plano_de_aula (id_materia, unidade,asunto)" +
				           " VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE assunto = ?;" );
						  updateSubject.setInt(1, Integer.parseInt(request.getParameter("idmateria").trim()));
						  updateSubject.setInt(2, 3);
						  updateSubject.setString(3, request.getParameter("untres"));
						  updateSubject.setString(4, request.getParameter("untres"));
						  updateSubject.execute();
						  
				  updateSubject = conexao.prepareStatement("INSERT INTO plano_de_aula (id_materia, unidade,asunto)" +
					       " VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE assunto = ?;" );
						   updateSubject.setInt(1, Integer.parseInt(request.getParameter("idmateria").trim()));
						   updateSubject.setInt(2, 4);
						   updateSubject.setString(3, request.getParameter("recuperacao"));
						   updateSubject.setString(4, request.getParameter("recuperacao"));
						   updateSubject.execute();			  
			%>

<script>
	window.history.back();
</script>
</body>
</html>