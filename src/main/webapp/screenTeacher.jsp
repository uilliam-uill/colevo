<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<title>Colégio Evolução</title>
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="assets/bootstrap/bootstrap.bundle.min.afs"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/bootstrap.js.map"></script>
<meta charset="UTF-8">
</head>
<body>
	<div class = "header">
		<div class="icons">
			<img src="imagens\Captura de tela 2024-01-02 174742-fotor-bg-remover-20240102174819.png" width="300">
			<h1 style="color: white; margin-left:220px; margin-top: 50px">Acesso Professor</h1>
		</div>
		
		<div>
			<button id="alterarSenhaBtn" class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" style="margin-top: 50px; margin-right: 20px">Alterar senha</button>
		</div>
	</div>
		<%
		response.setCharacterEncoding("UTF-8");
	Person personTeacher = Person.getInstance();
		%>
	<br> <br>
	<div class="teacherData">
	<h1 class="titleTeacher">Olá <%=personTeacher.getName()%>, a seguir segue suas materias e turmas </h1>
	</div>
	
	<div class="modal fade" id="modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header float-right">
                    <h5>Atualizar Senha</h5>
                    <div class="text-right">
                        <i data-dismiss="modal" aria-label="Close" class="fa fa-close"></i>
                    </div>
                </div>
                <div class="modal-body">
				 <div class="alert alert-danger" role="alert" id="senhaVazia" style="display:none;">
					Preencha todos os campos !
				</div>
				
				<div class="alert alert-danger" role="alert" id="senhaNovaErrada" style="display:none;">
					Você digitou incorreto a confirmação de senha !
				</div>
				<form onsubmit="submitForm(event)">
                
                <label for="idMateria">Nova senha</label>
                
                <div class="inputOcultsenha">
                	<input type="password" id="senha2" class="form-control" name="idMateria" id="senha2" >
                </div>
                <label for="dataAula">Confirme a nova senha</label>
                <div class="inputOcultsenha">
                	<input type="password" id="senha3" class="form-control" name="senhaNova">
                	<button type="button" id="mostrarSenha" class="toggle-password btn btn-outline-info" onclick="toggleSenhas()">Mostrar</button>
				</div>
                <button type="submit" class="btn btn-success btn-block mt-3">Salvar Senha</button>
                </form>
                </div>
            </div>
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
    	var iduser = urlParams.get('iduser');
    	var senhauser= urlParams.get('senha');
    	
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
    
    document.addEventListener("DOMContentLoaded", function() {
        // Adiciona um ouvinte de eventos para o clique no botão
        document.getElementById("alterarSenhaBtn").addEventListener("click", function() {
            // Abre o modal usando a API do Bootstrap
            var modal = new bootstrap.Modal(document.getElementById("modal"));
            modal.show();
        });
    });
    
    function toggleSenhas() {
        var camposSenha = document.querySelectorAll('.form-control');
        var mostrarSenhaBtn = document.getElementById("mostrarSenha");

        camposSenha.forEach(function(senhaInput) {
            if (senhaInput.type === 'password') {
                senhaInput.type = 'text';
                mostrarSenhaBtn.textContent = "Ocultar";
            } else {
                senhaInput.type = 'password';
                mostrarSenhaBtn.textContent = "Mostrar";
            }
        });
    }
    
    function submitForm(event) {
        event.preventDefault(); // Evita o comportamento padrão do formulário

        const urlParams = new URLSearchParams(window.location.search);
        var senha = urlParams.get('senha');
        var idUser = urlParams.get('idUser');
        var senhaNova = document.getElementById("senha2").value.trim();
        var senhaNovaConfirmar = document.getElementById("senha3").value.trim();

        if (senhaNova === '' || senhaNovaConfirmar === '') {
            document.getElementById('senhaVazia').style.display = 'block';
        } else if (senhaNova !== senhaNovaConfirmar) {
            document.getElementById('senhaNovaErrada').style.display = 'block';
        } else {
            window.location.href = "mudarSenha.jsp?senha=" + senhaNova + "&id=" + idUser;
        }
    }

</script>
</body>
</html>