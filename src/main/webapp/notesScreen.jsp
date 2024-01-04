<%@page import="javaClass.Teacher"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Notas Aluno</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/studentToken.css">
</head>
<body>
<div class = "header">
		<div class="icons">
			<img src="imagens\Captura de tela 2024-01-02 174742-fotor-bg-remover-20240102174819.png" width="300">
			<h1 style="color: white">Ficha Aluno</h1>
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
	<div class="container">
        <div class="col-6 mx-auto">
            <div class="card shadow border">
                <div class="card-body d-flex flex-column align-items-center">
                <h3 class="titleNota"><%=request.getParameter("unidade")%>º Trimestre</h3>
                <%
                Teacher t = Teacher.getInstance();
                PreparedStatement notasAtiv = null;
                ResultSet rsAtiv = null;
                Double notaAD = 0.0;
    			Double notaAPS = 0.0;
    			Double notaAS = 0.0;
    			Double notaAFT = 0.0;
    			Double sasUm = 0.0;
    			Double sasDois = 0.0;
    			Double notaRpt = 0.0;
    			Connection conexao = ConectionMysql.conectar();
                %>
                <%
                 if (conexao != null){
            		try{
            			notasAtiv = conexao.prepareStatement("SELECT avaliacao.nota_tirada, avaliacao.id_avaliacao FROM avaliacao " +
            			" INNER JOIN tipos_avaliacao ON avaliacao.id_avaliacao = tipos_avaliacao.id_avaliacao" + 
            			" WHERE avaliacao.unidade = ? AND avaliacao.id_aluno = ? AND avaliacao.id_materia = ?" + 
            			" AND avaliacao.id_turma = ? AND avaliacao.id_avaliacao IN (2, 3, 4, 5, 6, 7, 8);");
            			notasAtiv.setInt(1, Integer.parseInt(request.getParameter("unidade")));
            			notasAtiv.setInt(2, Integer.parseInt(request.getParameter("id")));
            			notasAtiv.setInt(3, Integer.parseInt(request.getParameter("idMateria")));
            			notasAtiv.setInt(4, Integer.parseInt(request.getParameter("idTurma")));
            			notasAtiv.execute();
            			rsAtiv = notasAtiv.executeQuery();
            			while(rsAtiv.next()){
            				if(rsAtiv.getInt("id_avaliacao") == 2){
            					notaAD = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 3){
            					notaAPS = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 4){
            					notaAS = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 5){
            					notaAFT = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 6){
            					sasUm = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 7){
            					sasDois = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 8){
            					notaRpt = rsAtiv.getDouble("nota_tirada");
            				}
            			}
            		}catch (SQLException e) {
                        e.printStackTrace();
                    }
                 }
                %>
             	   		<div class="alert alert-success" id="salvoSucess" role="alert">
  							Salvo com Sucesso!!!
						</div>
                		<label>AD - Atividade Diversificada:<span class="noteProva">2.0</span></label> 
                		<input type="number" id="ad" name="notaAd" onchange="somaNota()" value="<%=notaAD %>">
                		<br>
                		<label>APS - Avaliação Parcial Semanal:<span class="noteProva">3.0</span></label>
                		<input type="number" id="aps" name="notaAps" onchange="somaNota()" value="<%=notaAPS %>">
                		<br>
                		<%if(Integer.parseInt(request.getParameter("idTurma")) == 12) {%>
	                		<label>SAS1 = Enem 1:<span class="noteProva">2.0</span></label>
	                		<input type="number" id="sas1ouas" name="notaAsOuSasum" onchange="somaNota()" value="<%=sasUm %>">
	                		<br>
	                		<label>SAS2 = Enem 2:<span class="noteProva">3.0</span></label>
	                		<input type="number" id="sas2ouaft" name="notaAftOuSasdois" onchange="somaNota()" value="<%=sasDois %>">
                		<%} else if (Integer.parseInt(request.getParameter("idTurma")) != 12){ %>
	                		<label>AS - Avaliação Sistemática:<span class="noteProva">1.0</span></label>
	                		<input type="number" id="sas1ouas" name="notaAsOuSasum" onchange="somaNota()" value="<%=notaAS %>">
	                		<br>
	                		<label>AFT: Avaliação Final Trimestral:<span class="noteProva">4.0</span></label>
	                		<input type="number" id="sas2ouaft" name="notaAftOuSasdois" onchange="somaNota()" value="<%=notaAFT %>">
                		<%} %>
                		<br>
                		<label>RPT - Recuperação Trimestral:<span class="noteProva">3.0</span></label>
                		<input type="number" id="notaRpt" name="rpt" onchange="somaNota()" value="<%=notaRpt %>">
                		<br>
                		<label>Média trimestral</label>
                		<input type="number" id="soma" name="notaFinal" value="" readonly> <br>
                		<button type="button" onclick="updateNotas()" class="btn btn-success">Salvar</button>
                </div>
            </div>
        </div>
</div>
</body>
<script>
	document.getElementById('salvoSucess').style.display = 'none';
    var ad = parseFloat(document.getElementById('ad').value) || 0;
    var aps = parseFloat(document.getElementById('aps').value) || 0;
    var as = parseFloat(document.getElementById('sas1ouas').value) || 0;
    var aft = parseFloat(document.getElementById('sas2ouaft').value) || 0;
    var rpt = parseFloat(document.getElementById('notaRpt').value) || 0;
    var finalGrade = ad + aps + as + aft + rpt;
    document.getElementById('soma').value = finalGrade;

    function somaNota() {
        var ad = parseFloat(document.getElementById('ad').value) || 0;
        var aps = parseFloat(document.getElementById('aps').value) || 0;
        var as = parseFloat(document.getElementById('sas1ouas').value) || 0;
        var aft = parseFloat(document.getElementById('sas2ouaft').value) || 0;
        var rptValue = parseFloat(document.getElementById('notaRpt').value) || 0; // Renomeando a variável rpt
        var finalGrade = ad + aps + as + aft + rptValue;
        document.getElementById('soma').value = finalGrade;
        var somaIn = document.getElementById('soma');
        somaIn.addEventListener('input', function() {
            // Obtém o valor atual do input e converte para número com uma casa decimal
            this.value = parseFloat(this.value).toFixed(1);
        });
        if(parseFloat(document.getElementById('soma').value) == 5.9){
        	document.getElementById('soma').value = 6.0;
        }
         }

    function updateNotas() {
        var urlParams = new URLSearchParams(window.location.search);
        var idAluno = urlParams.get('id');
        var idMateria = urlParams.get('idMateria');
        var idTurma = urlParams.get('idTurma');
        var unidade = urlParams.get('unidade');
        var rptWn = parseFloat(document.getElementById('notaRpt').value) || 0;
    	document.getElementById('salvoSucess').style.display = 'block';
        window.location.href = "updateInsertNotes.jsp?idAluno=" + idAluno +
            "&idUnidade=" + unidade + "&idMateria=" + idMateria +
            "&idTurma=" + idTurma + "&unidade=" + unidade +
            "&notaAd=" + parseFloat(document.getElementById('ad').value) +
            "&notaAps=" + parseFloat(document.getElementById('aps').value) +
            "&notaAsOuSasum=" + parseFloat(document.getElementById('sas1ouas').value) +
            "&notaAftOuSasdois=" + parseFloat(document.getElementById('sas2ouaft').value) +
            "&notaFinal=" + document.getElementById('soma').value +
            "&idProfessor=" + urlParams.get('idprofessor') + "&rpt=" + rptWn + "&mediaTrimestral=" + parseFloat(document.getElementById('soma').value);
    }
    
    var inputMf = document.getElementById('soma');

	var valorMf = inputMf.value;

    if (valorMf !== "") {
        var numeroMf = parseFloat(valorMf);
        
        if (!isNaN(numeroMf)) {
            inputMf.value = numeroMf.toFixed(1);
        } else {
            inputMf.value = "";
        }
    }
    
    document.addEventListener('DOMContentLoaded', function() {
	    var inputs = document.querySelectorAll('input[type="number"]');

	    inputs.forEach(function(input) {
	        input.addEventListener('click', function() {
	            var valorAtual = parseFloat(input.value);
	            var novoValor = (valorAtual + 0.1).toFixed(1);
	            input.value = novoValor;
	        });
	    });
	});
    
    var inputs = document.getElementById('soma');

    // Itera sobre todos os inputs encontrados
    for (var i = 0; i < inputs.length; i++) {
        // Verifica se o input é do tipo 'number'
        if (inputs[i].type === 'number') {
            // Adiciona um listener para o evento 'input' em cada input
            inputs[i].addEventListener('input', function() {
                // Obtém o valor atual do input e converte para número com uma casa decimal
                this.value = parseFloat(this.value).toFixed(1);
            });
        }
    }
</script>
</html>