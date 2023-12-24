<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Evolução</title>
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<script src="js/bootstrap.js.map"></script>
</head>
<body>
	<div class = "header">
		<div class="icons">
			<img src="imagens/logobranca.png" width="100">
			<h1 style="color: white">Colégio Evolução - Acesso Professor</h1>
		</div>
	</div>
		<%
	Person personTeacher = Person.getInstance();
		%>
	<br> <br>
	<div class="teacherData">
	<h1 class="titleTeacher">Olá <%=personTeacher.getName()%>, a seguir segue suas materias e turmas </h1>
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
<div class="tableClass">
<table class="table">
	 <thead class="thead-light">
	    <tr>
	      <th scope="col">Código da Turma</th>
	      <th scope="col">Turma</th>
	      <th scope="col">Código da Matéria</th>
	      <th scope="col">Matéria</th>
	      <th scope="col">Acessar</th>
	    </tr>
  	</thead>
  <tbody>
	<%
    Teacher teacherPerson = Teacher.getInstance();
    Connection conexao = ConectionMysql.conectar();

    if (conexao != null) {
        PreparedStatement stMaterias = null;
        ResultSet rsMaterias = null;
        try {
            stMaterias = conexao.prepareStatement("SELECT materias.nome_materia, turma.serie,turma.id_turma, materias.id_materia" +
            		" FROM materias INNER JOIN professor ON materias.id_professor = professor.id_professor INNER JOIN " +
            		" turma ON materias.id_turma = turma.id_turma WHERE professor.id_professor = ?");
            stMaterias.setInt(1, 1);

            rsMaterias = stMaterias.executeQuery();%>
			
	            <% while (rsMaterias.next()) { %> 
						<tr> 
							<td><%=rsMaterias.getInt("id_turma")%></td>
							<td><%=rsMaterias.getString("serie")%></td>
							<td><%=rsMaterias.getInt("id_materia")%></td>
							<td><%=rsMaterias.getString("nome_materia")%></td>
							<td><button class="btn-primary">Acessar</button></td>
						</tr>
						<% } 
        }catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConectionMysql.closeConnection(conexao, stMaterias, rsMaterias);
        }
    } %>
    </tbody>
    </table> 
    </div>
    <script>
    var buttons = document.querySelectorAll('.btn-primary');

    // Iterar sobre cada botão para adicionar um evento de clique
    buttons.forEach(function(button) {
      button.addEventListener('click', function() {
        // Acessar o valor da terceira célula (índice 2, pois começamos do zero) 
        var materiaId = this.closest('tr').querySelectorAll('td')[2].textContent;
        var turmaJs = this.closest('tr').querySelectorAll('td')[1].textContent;   
        var materiaNome = this.closest('tr').querySelectorAll('td')[3].textContent;
        
        // Fazer algo com o ID da matéria, como exibir em um console
       window.location.href = "screenClassTeacher.jsp?id=" + materiaId + "&materia=" + materiaNome + "&turma=" + turmaJs;
      });
    });
    </script>
</body>
</html>