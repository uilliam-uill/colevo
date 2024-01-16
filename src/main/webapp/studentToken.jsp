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
			<img src="imagens\Captura de tela 2024-01-02 174742-fotor-bg-remover-20240102174819.png" width="300">
			<h1 style="color: white;   margin-left:220px; margin-top: 50px" >Desempenho do Aluno</h1>
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
        		" notas.terceira_und, notas.prova_final, notas.nota_final, notas.media_nota, notas.aprovado, pessoa.cpf " + 
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
	                    <label>Código do aluno</label> 
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
	                    <label style="color: red; font-weight: bolder">Prova Final</label> 
	                 	<input type="number" name="notarecuperacao" id="recuperacaoId" class="form-control" onchange="noteRecu()" value="<%=rsStudentData.getDouble("prova_final") %>">
   
	                    <label>Somatório de Notas</label> 
	                    <input type="number" name="notafinal" class="form-control" step="0.1" id="somaNotas" value="<%=rsStudentData.getDouble("nota_final") %>" readonly> <br>
	                    <label>Média de Notas</label> 
	                    <input type="number" name="notafinal" class="form-control" step="0.1"  id="mediaFinal" value="<%=rsStudentData.getDouble("nota_final") %>" readonly> <br>
	                    <label>Aprovação:</label>
	                    <input type="radio" name="status" value="true" <% if (rsStudentData.getBoolean("aprovado")) { %> checked <% } %> readonly>
	                    <label>Sim</label> 
						<input type="radio" name="status" value="false" <% if (!rsStudentData.getBoolean("aprovado")) { %> checked <% } %> readonly>
						<label>Não</label> 
				 </form>    		
	                    <button type="button" class="btn btn-success" onclick="aprovarAluno()">Salvar Aprovação</button>
	                    
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
		//somar notas
		var one_unid = parseFloat(document.getElementById('unidOne').value) || 0;
		var two_unid = parseFloat(document.getElementById('unidTwo').value) || 0;
		var three_unid = parseFloat(document.getElementById('unidThree').value) || 0;
		var recuperacao = parseFloat(document.getElementById('recuperacaoId').value) || 0;
		var finalGrade = one_unid + two_unid + three_unid;
		var medianota = finalGrade/3;
		if(medianota > 5.6 && medianota<6){
			medianota = 6;
		}
		document.getElementById('somaNotas').value = finalGrade;
		document.getElementById('mediaFinal').value = medianota;
		
		if (medianota >= 6) {
			document.querySelector('input[name="status"][value="true"]').checked = true;
		} else {
			document.querySelector('input[name="status"][value="false"]').checked = true;
		}

		//encaminhar pagina trimestre 1
		var buttonUm = document.getElementById('unidadeUm');

		buttonUm.addEventListener('click', function() {
		    var idAluno = document.getElementById('idAluno').value;
		    var urlParams = new URLSearchParams(window.location.search);
	
		    var idMateria = urlParams.get('idmateria');
		    var idTurma = urlParams.get('idTurma');
	
		    window.location.href = "notesScreen.jsp?id=" + idAluno + "&idMateria=" + idMateria + "&idTurma=" + idTurma + "&unidade=1";
	});

		//encaminhar pagina trimestre 12
		var buttonDois = document.getElementById('unidadeDois');

		buttonDois.addEventListener('click', function() {
		    var idAluno = document.getElementById('idAluno').value;
		    var urlParams = new URLSearchParams(window.location.search);
	
		    var idMateria = urlParams.get('idmateria');
		    var idTurma = urlParams.get('idTurma');
	
		    window.location.href = "notesScreen.jsp?id=" + idAluno + "&idMateria=" + idMateria + "&idTurma=" + idTurma + "&unidade=2";
	});
	
		//encaminhar pagina trimestre 3
		var buttonTres = document.getElementById('unidadeTres');

		buttonTres.addEventListener('click', function() {
		    var idAluno = document.getElementById('idAluno').value;
		    var urlParams = new URLSearchParams(window.location.search);
	
		    var idMateria = urlParams.get('idmateria');
		    var idTurma = urlParams.get('idTurma');
		    var idProfessor = urlParams.get('idProfessor');
		    
		    window.location.href = "notesScreen.jsp?id=" + idAluno + "&idMateria=" + idMateria + "&idTurma=" + idTurma + "&unidade=3&idprofessor=" + idProfessor;
	});
	
	var input = document.getElementById('somaNotas');

	var valor = input.value;


	    if (valor !== "") {
	    	
	        var numero = parseFloat(valor);

	        if (!isNaN(numero)) {
	        	
	            input.value = numero.toFixed(1);
	        } else {
	        	
	            input.value = "";
	        }
	    }

	var inputMf = document.getElementById('mediaFinal');

	    // Obtém o valor atual do input
	var valorMf = inputMf.value;

	    // Se houver um valor, formata para exibir apenas uma casa decimal
	    if (valorMf !== "") {
	        // Converte para número
	        var numeroMf = parseFloat(valorMf);

	        // Verifica se é um número válido
	        if (!isNaN(numeroMf)) {
	            // Formata para exibir apenas uma casa decimal
	            inputMf.value = numeroMf.toFixed(1);
	        } else {
	            // Caso não seja um número válido, limpa o valor do input
	            inputMf.value = "";
	        }
	    }

	var inputMedia = document.getElementById('mediaFinal');

	inputMedia.addEventListener('input', function() {
	    // Obtém o valor atual do input
	    var valor = input.value;

	    // Remove qualquer caractere que não seja número ou ponto decimal
	    valor = valor.replace(/[^0-9.]/g, '');

	    // Divida o número em parte inteira e decimal
	    var partes = valor.split('.');
	    var parteDecimal = partes[1];

	    // Limita a parte decimal a uma casa decimal
	    if (parteDecimal && parteDecimal.length > 1) {
	        parteDecimal = parteDecimal.slice(0, 1); // Mantém apenas a primeira casa decimal
	        valor = partes[0] + '.' + parteDecimal;
	    }

	    // Atualiza o valor do input
	    inputMedia.value = valor;
	});

	function aprovarAluno() {
	    var radios = document.getElementsByName("status");
	    var recuperacao = parseFloat(document.getElementById('recuperacaoId').value) || 0;
	    var aprovado;

	    radios.forEach(function(radio) {
	        if (radio.checked) {
	            aprovado = radio.value;
	        }
	    });

	    var urlParams = new URLSearchParams(window.location.search);
	    var idAluno = document.getElementById('idAluno').value;
	    var idMateria = urlParams.get('idmateria');
	    var mediaFinal = document.getElementById('mediaFinal').value;
	    var notaFinal = document.getElementById('somaNotas').value;
	    var prova_final = document.getElementById('recuperacaoId').value;
	    // Monta a URL corretamente com os parâmetros
	    window.location.href = "updateApproved.jsp?idAluno=" + idAluno + "&idMateria=" + idMateria + "&aprovado=" + aprovado
	    		+ "&medianota=" + mediaFinal + "&notaFinal=" + notaFinal + "&provafinal=" + prova_final;
	}
	
	//inserir nota recuperação
	function noteRecu() {
	    var one_unidR = parseFloat(document.getElementById('unidOne').value) || 0;
	    var two_unidR = parseFloat(document.getElementById('unidTwo').value) || 0;
	    var three_unidR = parseFloat(document.getElementById('unidThree').value) || 0;
	    var recuperacaonotaR = parseFloat(document.getElementById('recuperacaoId').value) || 0;
	    var finalGradeR = one_unidR + two_unidR + three_unidR;
	    var medianotaR = finalGradeR / 3; // Dividindo por 4 (3 unidades + recuperação)

	    document.getElementById('somaNotas').value = finalGradeR.toFixed(1); // Atualiza a soma das notas
	    document.getElementById('mediaFinal').value = medianotaR.toFixed(1); // Atualiza a média final

	    // Atualiza o status baseado na nota final
	    if (finalGradeR > 18.0) {
	        document.querySelector('input[name="status"][value="true"]').checked = true;
	    } else {
	        document.querySelector('input[name="status"][value="false"]').checked = true;
	    }	    
	}
	 var untres = document.getElementById('unidadeTres');
	 untres.addEventListener('input', function() {
         // Obtém o valor atual do input e converte para número com uma casa decimal
         this.value = parseFloat(this.value).toFixed(1);
     });
	
	 var unddois = document.getElementById('unidadeDois');
	 unddois.addEventListener('input', function() {
         // Obtém o valor atual do input e converte para número com uma casa decimal
         this.value = parseFloat(this.value).toFixed(1);
     });
     
     var unum = document.getElementById('unidadeUm');
     unum.addEventListener('input', function() {
         // Obtém o valor atual do input e converte para número com uma casa decimal
         this.value = parseFloat(this.value).toFixed(1);
     });
     
     
</script>
</html>