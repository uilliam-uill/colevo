<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Evolução</title>
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/screenClassTeacher.css">
<script src="js/bootstrap.js.map"></script>
</head>
<body>
	<div class = "header" style="background-color: rgb(63 , 63, 202);">
		<div class="icons">
			<img src="imagens\Captura de tela 2024-01-02 174742-fotor-bg-remover-20240102174819.png" width="300">
			<h1 style="color: white;  margin-left:220px; margin-top: 50px" >Controle de Notas</h1>
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
        	stAlunosMat = conexao.prepareStatement("SELECT aluno.id_aluno, pessoa.nome, notas.primeira_und, notas.segunda_und, notas.terceira_und," +
            	       " notas.prova_final, notas.nota_final, notas.aprovado, notas.media_nota " +
            	       " FROM notas INNER JOIN aluno ON aluno.id_aluno = notas.id_aluno" +
            	       " INNER JOIN pessoa ON pessoa.id_pessoa = aluno.id_pessoa WHERE notas.id_materia = ?");
        	stAlunosMat.setInt(1, Integer.parseInt(request.getParameter("id")));

        	rsNotas = stAlunosMat.executeQuery();%>
<br> <br>
<button type="button" class="btn btn-outline-primary" onclick="planoDeAula()">Atualize seu plano de aula</button>

<div class="tableDiv">
			<table class="table tableText" border="3px">
				<thead class="thead-light">
				    <tr class="trBlue">
				      <th style="width: 50px;">Código do Aluno</th>
				      <th style="width: 50px;">Código da Matéria</th>
				      <th scope="col">Nome</th>
				      <th scope="col">Primeria Unidade</th>
				      <th scope="col">Segunda Unidade</th>
				      <th scope="col">Terceira Unidade</th>
				      <th scope="col">Prova Final</th>
				      <th scope="col">Nota Final</th>
				      <th scope="col">Média de Notas</th>
				      <th scope="col">Aprovado</th>
				      <th scope="col">    </th>
				    </tr>
  				</thead>
	            <% while (rsNotas.next()) { %> 
	            </tbody>
						<tr> 
							<td><%=rsNotas.getInt("id_aluno")%></td>
							<td><%=request.getParameter("id") %></td>
							<td><%=rsNotas.getString("nome")%></td>
							<td><%=rsNotas.getDouble("primeira_und")%></td>
							<td><%=rsNotas.getDouble("segunda_und")%></td>
							<td><%=rsNotas.getDouble("terceira_und")%></td>
							<td><%=rsNotas.getDouble("prova_final")%></td>
							<td><%= Double.parseDouble(rsNotas.getString("primeira_und")) +
         					Double.parseDouble(rsNotas.getString("segunda_und")) +
         					Double.parseDouble(rsNotas.getString("terceira_und")) %>
         					<td><%=rsNotas.getDouble("media_nota") %></td>
							</td>
							<%if(rsNotas.getBoolean("aprovado") == true ||
								rsNotas.getDouble("prova_final") >= 5){ %>
								<td><p style="color: green">APROVADO</p></td>
							<%}else{%>
								<td><p style="color: red">RECUPERAÇÃO</p></td>
							<% } %>
							<td><button type="button" class="btn-primary">Atualizar Nota</button></td>
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
    </div>
<script>
var buttonsAula = document.querySelectorAll('.btn-primary');

//Iterar sobre cada botão para adicionar um evento de clique
buttonsAula.forEach(function(button) {
button.addEventListener('click', function() {
 // Acessar o valor da terceira célula (índice 2, pois começamos do zero) 
 var idAluno = this.closest('tr').querySelectorAll('td')[0].textContent;
 var idMateria = this.closest('tr').querySelectorAll('td')[1].textContent;
 const urlParams = new URLSearchParams(window.location.search);

 // Capturando o valor do parâmetro 'idTurma' e 'idProfessor'
 var idTurma = urlParams.get('idTurma');
 var idProfessor = urlParams.get('idProfessor');

 // Fazer algo com os IDs, como redirecionar para outra página
 window.location.href = "studentToken.jsp?id=" + idAluno + "&idmateria=" + idMateria + "&idTurma=" + idTurma + "&idProfessor=" + idProfessor;
});
});

//Exemplo de manipulação de elementos para outro evento
var buttonsPlanoAula = document.querySelectorAll('.planoaula');

buttonsPlanoAula.forEach(function(button) {
button.addEventListener('click', function() {
 var idMateria = this.closest('tr').querySelectorAll('td')[1].textContent;
 window.location.href = "subjects.jsp?idMateria=" + idMateria;
});
});

var cells = document.querySelectorAll('td');

cells.forEach(function(cell) {
        // Obtém o valor atual da célula e converte para número com uma casa decimal
        var valorAtual = parseFloat(this.textContent);
        var novoValor = valorAtual.toFixed(1);

        // Atualiza o valor da célula
        this.textContent = novoValor;
});

function planoDeAula() {
	window.location.href = "subjects.jsp";
}

</script>
</body>
</html>