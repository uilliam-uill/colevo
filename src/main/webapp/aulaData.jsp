<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Colégio Aluno - Ficha Aluno</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/studentToken.css">
<link rel="stylesheet" type="text/css" href="style/controlNotes.css">
<link rel="stylesheet" type="text/css" href="style/planoAula.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>

<body>
	<div class="header">
		<div class="icons">

			<h1 style="color: white">Plano de Aula</h1>
		</div>
	</div>
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
	<%Connection conexao = ConectionMysql.conectar();
	PreparedStatement stAssuntos = null;
	ResultSet rsAssunto = null;
	if(conexao != null){
		try {
		stAssuntos = conexao.prepareStatement("SELECT dia_assunto, assunto FROM plano_de_aula WHERE id_materia = ?;");
		stAssuntos.setInt(1, Integer.parseInt(request.getParameter("idmateria")));
		rsAssunto = stAssuntos.executeQuery();
	%>
	<div class="container">
    <div class="col-md-6 mx-auto" id="cardBlue">
        <div class="card shadow border">
            <div class="card-body d-flex flex-column align-items-center">
            <table class="table">
				  <thead class="thead-light">
				    <tr>
				      <th scope="col" style="color: white">Data da Aula</th>
				      <th scope="col" style="color: white">Assunto</th>
				    </tr>
				  </thead>
				  <%while(rsAssunto.next()){
				  %>
				  <tbody>
				    <tr>
				      <td style="color: white" width="90px"><%=rsAssunto.getDate("dia_assunto") %></td>
				      <td style="color: white"><%=rsAssunto.getString("assunto") %></td>
				      	<% }%>
				    </tr>
				  </tbody>
				</table>
            </div>
        </div>
    </div>
    <% } catch (SQLException e) {
        e.printStackTrace();
    } finally {
    	ConectionMysql.closeConnection(conexao, stAssuntos, rsAssunto);
    }
		}%>
</div>
</body>
</html>