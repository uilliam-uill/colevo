<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Aluno - Ficha Aluno</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/studentToken.css">
</head>
<body>
<div class = "header">
		<div class="icons">
			<img src="imagens/logobranca.png" width="100">
			<h1 style="color: white">Colégio Evolução - Ficha Aluno</h1>
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
<%@ page import="javaClass.ConectionMysql" %> 
	<%
	Connection conexao = ConectionMysql.conectar();
	PreparedStatement getStudentData = null;
    ResultSet rsStudentData = null;
    if (conexao != null) {
        try{
        	getStudentData = conexao.prepareStatement("SELECT aluno.id_aluno, pessoa.nome, notas.primeira_und, notas.segunda_und, " +
        		" notas.terceira_und, notas.recuperacao, notas.nota_final, notas.aprovado, notas.notas_detalhada, pessoa.cpf " + 
        		" FROM notas INNER JOIN aluno ON aluno.id_aluno = notas.id_aluno INNER JOIN pessoa ON pessoa.id_pessoa " + 
        		" = aluno.id_pessoa where aluno.id_aluno = ?;");
        	getStudentData.setInt(1, Integer.parseInt(request.getParameter("id")));
        	rsStudentData = getStudentData.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    while(rsStudentData.next()){
	%>
	<div class="container">
    <div class="row align-items-center vh-100">
        <div class="col-6 mx-auto">
            <div class="card shadow border">
                <div class="card-body d-flex flex-column align-items-center">
                <h3 class="titleNota">Atualize a Nota</h3>
	                <form method="post">
	                    <label>Código do aluno</label> 
	                    <input type="text" class="form-control" id="idAluno" value="<%=rsStudentData.getInt("id_aluno")%>" > <br>
	                    
	                    <label>Nome</label> 
	                    <input type="text" class="form-control" value="<%=rsStudentData.getString("nome")%>" disabled="disabled"> <br>
	                    
	                    <label>CPF</label> 
	                    <input type="text" class="form-control" value="<%=rsStudentData.getString("cpf") %>" disabled="disabled"> <br>
	                    
	                    <label>Primeira Unidade</label> 
	                    <input type="number" name="notaunidadeum"  step="0.1" class="form-control" id="unidOne" onchange="aprovar()" value="<%=rsStudentData.getDouble("primeira_und") %>"> <br>
	                    
	                    <label>Segunda Unidade</label> 
	                    <input type="number" name="notaunidadedois" step="0.1" class="form-control" id="unidTwo" onchange="aprovar()" value="<%=rsStudentData.getDouble("segunda_und") %>"> <br>
	                    
	                    <label>Terceira Unidade</label> 
	                    <input type="number" name="notaunidadetres" step="0.1" class="form-control" id="unidThree" onchange="aprovar()" value="<%=rsStudentData.getDouble("terceira_und") %>"> <br>
	                    
	                    <label>Recuperação</label> 
	                    <input type="number" name="notarecuperacao" step="0.1" class="form-control" value="<%=rsStudentData.getDouble("recuperacao") %>"> <br>
	                    
	                    <label>Nota Final</label> 
	                    <input type="number" name="notafinal" class="form-control" step="0.1" id="somaNotas" value="<%=rsStudentData.getDouble("nota_final") %>"> <br>
	                    <label>Aprovação:</label>
	                    <input type="radio" name="status" value="true" <% if (rsStudentData.getBoolean("aprovado")) { %> checked <% } %>>
	                    <label>Sim</label> 
						<input type="radio" name="status" value="false" <% if (!rsStudentData.getBoolean("aprovado")) { %> checked <% } %>>
						<label>Não</label>  <br> <br> 
	                    
	                    <label>Notas</label>
	                    <div class="form-outline">
							  <textarea class="form-control" name="detalhesnota" id="textAreaExample1" rows="4"></textarea>
						</div>
	                    <button type="submit" class="btn btn-success">Enviar</button>
	                </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%} 
%>

<%
PreparedStatement updateDataStudent = null;
ResultSet rsUpdate= null;
if(conexao != null && request.getParameter("idAluno") != null){
	try{
	updateDataStudent = conexao.prepareStatement("UPDATE notas SET primeira_und = ?, segunda_und = ?, terceira_und = ?, " + 
			" recuperacao = ?, nota_final = ?, aprovado = ?, notas_detalhdas = ? WHERE id_materia = ? AND id_aluno = ?;");
	updateDataStudent.setDouble(1, Double.parseDouble(request.getParameter("notaunidadeum")));
	updateDataStudent.setDouble(2, Double.parseDouble(request.getParameter("notaunidadedois")));
	updateDataStudent.setDouble(3, Double.parseDouble(request.getParameter("notaunidadetres")));
	updateDataStudent.setDouble(4, Double.parseDouble(request.getParameter("notarecuperacao")));
	updateDataStudent.setDouble(5, Double.parseDouble(request.getParameter("notafinal")));
	if(request.getParameter("status").equals("true")){
		updateDataStudent.setBoolean(6, true);
	}else if (request.getParameter("status").equals("false")){
		updateDataStudent.setBoolean(6, false);
	}
	if(request.getParameter("detalhesnota") == null){
		updateDataStudent.setString(7, "...");
	} else if(request.getParameter("detalhesnota") != null){
		updateDataStudent.setString(7, request.getParameter("detalhesnota"));	
	}
	updateDataStudent.setInt(8, Integer.parseInt(request.getParameter("idmateria")));
	updateDataStudent.setInt(9, Integer.parseInt(request.getParameter("id")));
	updateDataStudent.executeUpdate();
	}catch (SQLException e) {
        e.printStackTrace();
    }
}
%>

</body>
<script>
	function aprovar(){
		var one_unid = parseFloat(document.getElementById('unidOne').value) || 0;
		var two_unid = parseFloat(document.getElementById('unidTwo').value) || 0;
		var three_unid = parseFloat(document.getElementById('unidThree').value) || 0;
		var finalGrade = one_unid + two_unid + three_unid;
		document.getElementById('somaNotas').value = finalGrade;
		
		if (finalGrade > 18.0) {
			document.querySelector('input[name="status"][value="true"]').checked = true;
		} else {
			document.querySelector('input[name="status"][value="false"]').checked = true;
		}
	}
</script>
</html>