<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Aluno - Ficha Aluno</title>
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
<%@ page import="javaClass.Teacher" %> 
<%@ page import="javaClass.ConectionMysql" %> 
<%@ page import="java.sql.*, java.util.List, java.util.ArrayList" %>
</head>
<body>
<%
Connection conexao = ConectionMysql.conectar();
	if(conexao != null){
		PreparedStatement stMs = null;
		 try{
			stMs = conexao.prepareStatement(" UPDATE pessoa SET senha = ? WHERE id_pessoa = ?;"); 
			stMs.setString(1, request.getParameter("senha"));
			stMs.setInt(2, Integer.parseInt(request.getParameter("id")));
			stMs.executeUpdate();
		 } catch (SQLException e) {
             e.printStackTrace();
         }
		 finally {
			 conexao.close();
			 stMs.close();
         }
	}
	%>
</body>
<script>
	window.location.href = "loginSec.jsp";
</script>

</html>