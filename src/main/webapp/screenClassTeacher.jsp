<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Evolução</title>
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
</head>
<body>
	<div class = "header">
		<div class="icons">
			<img src="imagens/logobranca.png" width="100">
			<h1 style="color: white">Colégio Evolução - Acesso Professor</h1>
		</div>
	</div>
	
	
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
	<%
    Teacher teacherPerson = Teacher.getInstance();
    Connection conexao = ConectionMysql.conectar();
	String turmaJs = request.getParameter("turma");
	String materiaJs = request.getParameter("materia");
    if (conexao != null) {
        PreparedStatement stAlunosMat = null;
        ResultSet rsNotas = null;
        try {
        	stAlunosMat = conexao.prepareStatement("SELECT pessoa.nome, notas.primeira_und, notas.segunda_und, notas.terceira_und," +
            	       " notas.recuperacao, notas.nota_final, notas.aprovado " +
            	       " FROM notas INNER JOIN aluno ON aluno.id_aluno = notas.id_aluno" +
            	       " INNER JOIN pessoa ON pessoa.id_pessoa = aluno.id_pessoa;");

        	rsNotas = stAlunosMat.executeQuery();%>
        	<h1 class="titleTeacher"><%=turmaJs + materiaJs%></h1>
			<table class="table">
				<thead class="thead-light">
				    <tr>
				      <th scope="col">Nome</th>
				      <th scope="col">Primeria Unidade</th>
				      <th scope="col">Segunda Unidade</th>
				      <th scope="col">Terceira Unidade</th>
				      <th scope="col">Recuperação</th>
				      <th scope="col">Nota Final</th>
				      <th scope="col">Aprovado</th>
				    </tr>
  				</thead>
	            <% while (rsNotas.next()) { %> 
	            </tbody>
						<tr> 
							<td><%=rsNotas.getString("nome")%></td>
							<td><%=rsNotas.getDouble("primeira_und")%></td>
							<td><%=rsNotas.getDouble("segunda_und")%></td>
							<td><%=rsNotas.getDouble("terceira_und")%></td>
							<td><%=rsNotas.getDouble("recuperacao")%></td>
							<td><%=rsNotas.getDouble("nota_final")%></td>
							<td><%=rsNotas.getBoolean("aprovado")%></td>
							<td><button class="btn-primary">Atualizar Nota</button></td>
						</tr>
						<% } 
        }catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConectionMysql.closeConnection(conexao, stAlunosMat, rsNotas);
        }
    } %>
    </tbody>
    </table> 
</body>
</html>