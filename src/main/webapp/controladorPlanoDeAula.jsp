<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="javaClass.Person"%>
<%@ page import="javaClass.ConectionMysql"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	if (request.getParameter("idAula") == null) {
		Connection conexao = ConectionMysql.conectar();
		PreparedStatement stPda = null;
		Date dataInsert = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			dataInsert = sdf.parse(request.getParameter("dataAula"));
			stPda = conexao
			.prepareStatement("INSERT INTO plano_de_aula (id_materia, dia_assunto, assunto)" + " VALUES (?,?,?,?)");
			stPda.setInt(1, Integer.parseInt(request.getParameter("idMateria")));
			stPda.setDate(2, new java.sql.Date(dataInsert.getTime()));
			stPda.setString(3, request.getParameter("assuntosDia"));
			stPda.execute();
		} catch (SQLException ex) {
			// Tratamento de erro específico para o loop
			ex.printStackTrace();
		}
	}
	%>
</body>
</html>