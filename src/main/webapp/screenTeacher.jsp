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
			<img src="imagens\Captura de tela 2024-01-02 174742-fotor-bg-remover-20240102174819.png" width="300">
			<h1 style="color: white; margin-left:220px; margin-top: 50px">Acesso Professor</h1>
		</div>
		
		<div>
		<a href="mudarSenha.jsp">
			<button class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" style="margin-top: 50px; margin-right: 20px">Alterar senha</button>
		</a>
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
	    <tr class="trBlue">
	      <th scope="col">Código da Turma</th>
	      <th scope="col">Turma</th>
	      <th scope="col">Código da Matéria</th>
	      <th scope="col">Matéria</th>
	      <th scope="col">Acessar</th>
	       <th scope="col">Plano de Aula</th>
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
            stMaterias = conexao.prepareStatement("SELECT materias.nome_materia, materias.id_materia, " +
            		" materias.id_turma, turma.serie FROM materias INNER JOIN materia_professor " + 
            		" ON materias.id_materia = materia_professor.id_materia INNER JOIN turma " + 
            		" ON materias.id_turma = turma.id_turma WHERE materia_professor.id_professor = ?;");
            stMaterias.setInt(1, Integer.parseInt(request.getParameter("idProfessor")));

            rsMaterias = stMaterias.executeQuery();%>
			
	            <% while (rsMaterias.next()) { %> 
						<tr> 
							<td><%=rsMaterias.getInt("id_turma")%></td>
							<td><%=rsMaterias.getString("serie")%></td>
							<td><%=rsMaterias.getInt("id_materia")%></td>
							<td><%=rsMaterias.getString("nome_materia")%></td>
							<td><button class="btn-primary" id="acessar">Acessar</button></td>
							<td><button class="btn-primary" id="pda">Plano de Aula</button></td>
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
        var turmaCodificado = encodeURIComponent(turmaJs);
        var turmaId = this.closest('tr').querySelectorAll('td')[0].textContent;
        var materiaNome = this.closest('tr').querySelectorAll('td')[3].textContent;
        const urlParams = new URLSearchParams(window.location.search);
    	var idProfessor = urlParams.get('idProfessor');
    	
        var buttonId = this.id;
        switch(buttonId){
        case 'acessar':
    		if(turmaId == 12){
    		 	window.location.href = "controlNotesTerceiroAno.jsp?idmateria=" + materiaId + "&idturma="
    	        + turmaId + "&turma=" + turmaJs.replace('º', '%C2%BA') + "&materia=" + materiaNome;
    		}else{
           	window.location.href = "controlNotes.jsp?idmateria=" + materiaId + "&idturma="
            + turmaId + "&turma=" + turmaCodificado + "&materia=" + materiaNome;
    		}
        	break;
        	
        case 'pda':
        	window.location.href = "planoAula.jsp?idmateria=" + materiaId + "&turma=" + turmaCodificado + "&materia="+ materiaNome
        			+ "&update=0";
        	break;
        }
       	var idProfessor = urlParams.get('idProfessor');

      });
    });
    
 // Selecionando todos os inputs do tipo number
    var inputs = document.querySelectorAll('input[type="number"]');

    // Adicionando um listener de evento 'input' para cada input
    inputs.forEach(function(input) {
        input.addEventListener('input', function() {
            if (input.value !== '') {
                var valor = parseFloat(input.value);
                input.value = valor.toFixed(1); // Limitando para uma casa decimal
            }
        });
    });

    </script>
</body>
</html>