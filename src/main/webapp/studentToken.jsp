<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Col�gio Aluno - Ficha Aluno</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/studentToken.css">
</head>
<body>
<div class = "header">
		<div class="icons">
			<img src="imagens/logobranca.png" width="100">
			<h1 style="color: white">Col�gio Evolu��o - Ficha Aluno</h1>
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
                	<form>
	                    <label>C�digo do aluno</label> 
	                    <input type="text" class="form-control" id="idAluno" value="<%=rsStudentData.getInt("id_aluno")%>" readonly> <br>
	                    
	                    <label>Nome</label> 
	                    <input type="text" class="form-control" value="<%=rsStudentData.getString("nome")%>" disabled="disabled"> <br>
	                    
	                    <label>CPF</label> 
	                    <input type="text" class="form-control" value="<%=rsStudentData.getString("cpf") %>" disabled="disabled"> <br>
	               </form>     
	                    <label>Primeiro Trimestre</label> 
	                    <div class="buttonUnid">
		                    <input type="number" name="notaunidadeum"  step="0.1" class="form-control" id="unidOne" onchange="aprovar()" value="<%=rsStudentData.getDouble("primeira_und") %>"readonly> 
		                    <button class="btn-primary" id="unidadeUm" >Acessar Notas</button>
	                    </div>
	                    <label>Segundo Trimestre</label>
	                     <div class="buttonUnid"> 
		                    <input type="number" name="notaunidadedois" step="0.1" class="form-control" id="unidTwo" onchange="aprovar()" value="<%=rsStudentData.getDouble("segunda_und") %>" readonly> <br>
	                    <button class="btn-primary" id="unidadeDois">Acessar Notas</button>
	                    </div>
	                    <label>Terceiro Trimestre</label>
	                     <div class="buttonUnid">  
		                    <input type="number" name="notaunidadetres" step="0.1" class="form-control" id="unidThree" onchange="aprovar()" value="<%=rsStudentData.getDouble("terceira_und") %>" readonly> <br>
	                    <button class="btn-primary" id="unidadeTres">Acessar Notas</button>
	                    </div> 
	               <form>
	                    <label>Recupera��o</label> 
	                    <input type="number" name="notarecuperacao" step=".1" class="form-control" value="<%=rsStudentData.getDouble("recuperacao") %>"> <br>
	                    
	                    <label>Somat�rio de Notas</label> 
	                    <input type="number" name="notafinal" class="form-control" step="0.1" id="somaNotas" value="<%=rsStudentData.getDouble("nota_final") %>" readonly> <br>
	                    <label>M�dia de Notas</label> 
	                    <input type="number" name="notafinal" class="form-control" id="mediaFinal" value="<%=rsStudentData.getDouble("nota_final") %>" readonly> <br>
	                    <label>Aprova��o:</label>
	                    <input type="radio" name="status" value="true" <% if (rsStudentData.getBoolean("aprovado")) { %> checked <% } %> readonly>
	                    <label>Sim</label> 
						<input type="radio" name="status" value="false" <% if (!rsStudentData.getBoolean("aprovado")) { %> checked <% } %> readonly>
						<label>N�o</label> 
	                    <button type="submit" class="btn btn-success">Salvar Aprova��o</button>
	              </form>           
                </div>
            </div>
        </div>
    </div>
</div>
<%} 
%>

<%/*
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
}*/
%>

</body>
<script>
		var one_unid = parseFloat(document.getElementById('unidOne').value) || 0;
		var two_unid = parseFloat(document.getElementById('unidTwo').value) || 0;
		var three_unid = parseFloat(document.getElementById('unidThree').value) || 0;
		var finalGrade = one_unid + two_unid + three_unid;
		var medianota = finalGrade/3;
		document.getElementById('somaNotas').value = finalGrade;
		document.getElementById('mediaFinal').value = medianota;
		
		if (finalGrade > 18.0) {
			document.querySelector('input[name="status"][value="true"]').checked = true;
		} else {
			document.querySelector('input[name="status"][value="false"]').checked = true;
		}
	var buttonUm = document.getElementById('unidadeUm');

	buttonUm.addEventListener('click', function() {
	    var idAluno = document.getElementById('idAluno').value;
	    var urlParams = new URLSearchParams(window.location.search);

	    // Capturando o valor do par�metro 'idmateria' e 'idTurma'
	    var idMateria = urlParams.get('idmateria');
	    var idTurma = urlParams.get('idTurma');

	    // Corrigindo a concatena��o para redirecionamento
	    window.location.href = "notesScreen.jsp?id=" + idAluno + "&idMateria=" + idMateria + "&idTurma=" + idTurma + "&unidade=1";
	});

	var buttonDois = document.getElementById('unidadeDois');

	buttonDois.addEventListener('click', function() {
	    var idAluno = document.getElementById('idAluno').value;
	    var urlParams = new URLSearchParams(window.location.search);

	    // Capturando o valor do par�metro 'idmateria' e 'idTurma'
	    var idMateria = urlParams.get('idmateria');
	    var idTurma = urlParams.get('idTurma');

	    // Corrigindo a concatena��o para redirecionamento
	    window.location.href = "notesScreen.jsp?id=" + idAluno + "&idMateria=" + idMateria + "&idTurma=" + idTurma + "&unidade=2";
	});
	
	var buttonTres = document.getElementById('unidadeTres');

	buttonTres.addEventListener('click', function() {
	    var idAluno = document.getElementById('idAluno').value;
	    var urlParams = new URLSearchParams(window.location.search);

	    // Capturando o valor do par�metro 'idmateria' e 'idTurma'
	    var idMateria = urlParams.get('idmateria');
	    var idTurma = urlParams.get('idTurma');
	    var idProfessor = urlParams.get('idProfessor');
	    // Corrigindo a concatena��o para redirecionamento
	    window.location.href = "notesScreen.jsp?id=" + idAluno + "&idMateria=" + idMateria + "&idTurma=" + idTurma + "&unidade=3&idprofessor=" + idProfessor;
	});
	
	var input = document.getElementById('somaNotas');

	    // Obt�m o valor atual do input
	var valor = input.value;

	    // Se houver um valor, formata para exibir apenas uma casa decimal
	    if (valor !== "") {
	        // Converte para n�mero
	        var numero = parseFloat(valor);

	        // Verifica se � um n�mero v�lido
	        if (!isNaN(numero)) {
	            // Formata para exibir apenas uma casa decimal
	            input.value = numero.toFixed(1);
	        } else {
	            // Caso n�o seja um n�mero v�lido, limpa o valor do input
	            input.value = "";
	        }
	    }

	    var inputMf = document.getElementById('mediaFinal');

	    // Obt�m o valor atual do input
	var valorMf = inputMf.value;

	    // Se houver um valor, formata para exibir apenas uma casa decimal
	    if (valorMf !== "") {
	        // Converte para n�mero
	        var numeroMf = parseFloat(valorMf);

	        // Verifica se � um n�mero v�lido
	        if (!isNaN(numeroMf)) {
	            // Formata para exibir apenas uma casa decimal
	            inputMf.value = numeroMf.toFixed(1);
	        } else {
	            // Caso n�o seja um n�mero v�lido, limpa o valor do input
	            inputMf.value = "";
	        }
	    }



	var inputMedia = document.getElementById('mediaFinal');

	inputMedia.addEventListener('input', function() {
	    // Obt�m o valor atual do input
	    var valor = input.value;

	    // Remove qualquer caractere que n�o seja n�mero ou ponto decimal
	    valor = valor.replace(/[^0-9.]/g, '');

	    // Divida o n�mero em parte inteira e decimal
	    var partes = valor.split('.');
	    var parteDecimal = partes[1];

	    // Limita a parte decimal a uma casa decimal
	    if (parteDecimal && parteDecimal.length > 1) {
	        parteDecimal = parteDecimal.slice(0, 1); // Mant�m apenas a primeira casa decimal
	        valor = partes[0] + '.' + parteDecimal;
	    }

	    // Atualiza o valor do input
	    inputMedia.value = valor;
	});

	
</script>
</html>