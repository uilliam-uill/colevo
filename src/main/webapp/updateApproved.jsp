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
    PreparedStatement updateApproved = null;
	ResultSet rsnotas = null;
	updateApproved = conexao.prepareStatement("UPDATE notas SET recuperacao = ?, aprovado = ? WHERE id_aluno = ? AND id_materia = ?;");
	updateApproved.setDouble(1, Double.parseDouble(request.getParameter("recuperacao")));
		if(request.getParameter("aprovado") != null && request.getParameter("aprovado").equals("true")){		
			updateApproved.setBoolean(2, true);
		}else if(request.getParameter("aprovado") != null && request.getParameter("aprovado").equals("false")){
			updateApproved.setBoolean(2, false);
		}
		updateApproved.setDouble(3, Double.parseDouble(request.getParameter("idAluno")));
		updateApproved.setDouble(4, Double.parseDouble(request.getParameter("idMateria")));
		updateApproved.executeUpdate();
 	%>

<script>
	window.history.back();
</script>
</body>
</html>