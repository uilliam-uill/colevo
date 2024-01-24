<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.DecimalFormat"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/controlNotes.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    if (performance.navigation.type === 2) {
        // A página foi acessada pelo histórico, então recarrega
        window.location.reload();
    }
</script>

</head>
<body>
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
	<%@ page import="javaClass.Teacher"%>
	<%@ page import="javaClass.ConectionMysql"%>



	<%
	DecimalFormat df = new DecimalFormat("#0.0");
	Connection conexao = ConectionMysql.conectar();

	PreparedStatement stDateAluno = null;
	PreparedStatement stNotes = null;
	ResultSet rsAlunoDate = null;
	ResultSet rsNotes = null;

	String nome = "";
	int idAluno = 0;
	if (conexao != null) {
		stDateAluno = conexao.prepareStatement("SELECT notas.primeira_und, notas.segunda_und, notas.terceira_und,"
		+ " notas.media_nota, notas.nota_final,notas.aprovado, notas.prova_final, "
		+ " pessoa.nome, pessoa.id_pessoa, aluno.id_aluno" + " FROM notas"
		+ " INNER JOIN aluno ON notas.id_aluno = aluno.id_aluno"
		+ " INNER JOIN pessoa ON aluno.id_pessoa = pessoa.id_pessoa WHERE id_materia = ?");
		stDateAluno.setInt(1, Integer.parseInt(request.getParameter("idmateria")));
		rsAlunoDate = stDateAluno.executeQuery();
	%>

	<div class="header">
		<div class="icons">

			<h1 style="color: white">Acesso Professor</h1>
		</div>
	</div>


	<div class="apresentacao">
		<div>
			<img src="imagens\Captura de tela 2024-01-17 180901.png" width="250">
		</div>
		<div class="turma">
			<div>
				<h3>Turma:</h3>
				<h7><%=request.getParameter("turma").replace("%AA%20", "º")%></h7>
			</div>
			<div>
				<h3>Matéria:</h3>
				<h7><%=request.getParameter("materia")%></h7>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>

	<div class="list">
		<ul>
			<li>AD - Atividade Diversificada</li>
			<li>APS - Avaliação Parcial Semanal</li>
			<li>SAS 1 - SAS Enem 1</li>
			<li>SAS 2 - SAS Enem 2</li>
		</ul>
	</div>
	<br>
	<div class="list">
		<ul>
			<li>MT - Media Trimestral</li>
			<li>SM - Soma das Notas</li>
			<li>MF - Media Final</li>
			<li>ST - Status</li>
			<li>PF - Prova Final</li>
		</ul>
	</div>
	<br>
	<br>
	<form method="post"
		action="controlador3.jsp?idmateria=<%=request.getParameter("idmateria")%>&idturma=<%=request.getParameter("idturma")%>"
		onsubmit="return verificarInputsNulos()">
		
		<div class="alert alert-danger" id="preenchaCampos" role="alert" style="display: none;">
			Preencha Todos o Campos!
		</div>
		<table id="datesStudent">
			<tr class="provas">
				<td style="width: 10px;">Nº</td>
				<td class="provas">Aluno</td>
				<td class="provas">1º TRIMESTRE</td>
				<td class="provas">2º TRIMESTRE</td>
				<td class="provas">3º TRIMESTRE</td>
				<td class="provas">RESULTADO FINAL</td>
			</tr>
			<tr>
				<td class="provas"></td>
				<td class="provas"></td>
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
							<td class="provas">AD <br> 2.0
							</td>
							<td class="provas">APS <br> 3.0
							</td>
							<td class="provas">SAS1 <br> 2.0
							</td>
							<td class="provas">SAS2 <br> 3.0
							</td>
							<td class="provas">RPT <br> 3.0
							</td>
							<td class="provas">M.T</td>
						</tr>
					</table>
				</td>
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
							<td class="provas">AD <br> 2.0
							</td>
							<td class="provas">APS <br> 3.0
							</td>
							<td class="provas">SAS1 <br> 2.0
							</td>
							<td class="provas">SAS2 <br> 3.0
							</td>
							<td class="provas">RPT <br> 3.0
							</td>
							<td class="provas">M.T</td>
						</tr>
					</table>
				</td>
				<!-- Adicionei mais tabelas para cada conjunto de inputs -->
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
							<td class="provas">AD <br> 2.0
							</td>
							<td class="provas">APS <br> 3.0
							</td>
							<td class="provas">SAS1 <br> 2.0
							</td>
							<td class="provas">SAS2 <br> 3.0
							</td>
							<td class="provas">RPT <br> 3.0
							</td>
							<td class="provas">M.T</td>
						</tr>
					</table>
				</td>
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
							<td class="provas">SM</td>
							<td class="provas">MF</td>
							<td class="provas">ST</td>
							<td class="provas">PF <br> 5.0
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<%
				while (rsAlunoDate.next()) {
					nome = rsAlunoDate.getString("nome");
					idAluno = rsAlunoDate.getInt("id_aluno");
					stNotes = conexao.prepareStatement("SELECT nota_tirada, unidade, id_avaliacao, id_aluno "
					+ " FROM avaliacao WHERE id_aluno = ? AND id_materia = ? AND id_turma = ?;");
					stNotes.setInt(1, rsAlunoDate.getInt("id_aluno"));
					stNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
					stNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));

					double ad1 = 0.0, aps1 = 0.0, sas11 = 0.0, sas21 = 0.0, rpt1 = 0.0;
					double ad2 = 0.0, aps2 = 0.0, sas12 = 0.0, sas22 = 0.0, rpt2 = 0.0;
					double ad3 = 0.0, aps3 = 0.0, sas13 = 0.0, sas23 = 0.0, rpt3 = 0.0;

					rsNotes = stNotes.executeQuery();
					while (rsNotes.next()) {
						int unidade = rsNotes.getInt("unidade");
						int idAvaliacao = rsNotes.getInt("id_avaliacao");
						double notaTirada = rsNotes.getDouble("nota_tirada");
						if (unidade == 1) {
					if (idAvaliacao == 2) {
						ad1 = notaTirada;
					}
					if (idAvaliacao == 3) {
						aps1 = notaTirada;
					}
					if (idAvaliacao == 6) {
						sas11 = notaTirada;
					}
					if (idAvaliacao == 7) {
						sas21 = notaTirada;
					}
					if (idAvaliacao == 8) {
						rpt1 = notaTirada;
					}
						}
						if (unidade == 2) {
					if (idAvaliacao == 2) {
						ad2 = notaTirada;
					}
					if (idAvaliacao == 3) {
						aps2 = notaTirada;
					}
					if (idAvaliacao == 6) {
						sas12 = notaTirada;
					}
					if (idAvaliacao == 7) {
						sas22 = notaTirada;
					}
					if (idAvaliacao == 8) {
						rpt2 = notaTirada;
					}
						}
						if (unidade == 3) {
							if (idAvaliacao == 2) {
								ad3 = notaTirada;
							}
							if (idAvaliacao == 3) {
								aps3 = notaTirada;
							}
							if (idAvaliacao == 6) {
								sas13 = notaTirada;
							}
							if (idAvaliacao == 7) {
								sas23 = notaTirada;
							}
							if (idAvaliacao == 8) {
								rpt3 = notaTirada;
							}
						}
					}
				%>
			
			<tr>
				<td width="10px"><input type="text" id="getId" readonly
					name="getId" value="<%=idAluno%>" style="width: 50px;" readonly></td>
				<td><input type="text" value="<%=nome%>" disabled="disabled"></td>
				<td>
					<table class="inner-table" id="quarterOne">
						<tr data-id="1">
							<td><input type="text" class="inputNotes provas1"
								value="<%=ad1%>" id="ad1" name="ad1"
								onchange="somarNotasUm(this)"></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=aps1%>" id="aps1" name="aps1"
								onchange="somarNotasUm(this)"></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=sas11%>" id="sas11" name="sas11"
								onchange="somarNotasUm(this)"></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=sas21%>" id="sas21" name="sas21"
								onchange="somarNotasUm(this)"></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=rpt1%>" id="rpt1" name="rpt1"
								onchange="somarNotasUm(this)"></td>
							<td><input type="text" class="inputNotes" id="unidadeum"
								name="unidadeum"
								value="<%=rsAlunoDate.getDouble("primeira_und")%>"
								class="unidaddeum" readonly></td>
						</tr>
					</table>
				</td>
				<!-- Repetindo a estrutura para os demais conjuntos de inputs -->
				<td>
					<table class="inner-table" id="quarterTwo">
						<tr data-id="2">
							<td><input type="text" class="inputNotes provas2"
								value="<%=ad2%>" id="ad2" name="ad2"
								onchange="somarNotasDois(this)"></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=aps2%>" id="aps2" name="aps2"
								onchange="somarNotasDois(this)"></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=sas12%>" id="sas12" name="sas12"
								onchange="somarNotasDois(this)"></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=sas22%>" id="sas22" name="sas22"
								onchange="somarNotasDois(this)"></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=rpt2%>" id="rpt2" name="rpt2"
								onchange="somarNotasDois(this)"></td>
							<td><input type="text" class="inputNotes" id="unidadedois"
								name="unidadedois"
								value="<%=rsAlunoDate.getDouble("segunda_und")%>"
								class="unidadedosis" readonly></td>
						</tr>
					</table>
				</td>
				<td>
					<table class="inner-table" id="quarterThree">
						<tr data-id="3">
							<td><input type="text" class="inputNotes provas3"
								value="<%=ad3%>" id="ad3" name="ad3"
								onchange="somarNotasTres(this)"></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=aps3%>" id="aps3" name="aps3"
								onchange="somarNotasTres(this)"></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=sas13%>" id="sas13" name="sas13"
								onchange="somarNotasTres(this)"></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=sas23%>" id="sas23" name="sas23"
								onchange="somarNotasTres(this)"></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=rpt3%>" id="rpt3" name="rpt3"
								onchange="somarNotasTres(this)"></td>
							<td><input type="text" class="inputNotes" id="unidadetres"
								name="unidadetres"
								value="<%=rsAlunoDate.getDouble("terceira_und")%>"
								class="ssunidadetres" readonly></td>
						</tr>
					</table>
				</td>
				<td>
					<table class="inner-table" id="quartetFinish">
						<tr>
							<%
							double pf = rsAlunoDate.getDouble("prova_final");
							double soma_nota = rsAlunoDate.getDouble("primeira_und") + rsAlunoDate.getDouble("segunda_und")
									+ rsAlunoDate.getDouble("terceira_und");

							double media_nota = soma_nota / 3;

							if (media_nota == 5.7) {
								media_nota = 6.0;
							}
							%>
							<td><input type="text" class="inputNotes" id="somanota"
								value="<%=df.format(soma_nota)%>" readonly></td>
							<td><input type="text" class="inputNotes" id="medianota"
								value="<%=df.format(media_nota)%>" readonly></td>
							<td>
								<div class="bolinha"></div> <%
 if (media_nota >= 6 || pf >= 5) {
 %>
								<div class="bolinhaGreen"></div> <%
 } else {
 %>
								<div class="bolinhaRed"></div> <%
 }
 %>
							</td>
							<td><input type="text" class="inputNotes"
								id="provaFinalNote" name="provaFinalNote" value="<%=pf%>"></td>
						</tr>
					</table>
				</td>

			</tr>
			<%
			}
			}
			conexao.close();
			stDateAluno.close();
			stNotes.close();
			rsAlunoDate.close();
			rsNotes.close();
			%>
		</table>
		<button type="submit" class="btn btn-primary btn-lg btn-block">Processar
			Dados</button>
	</form>
	<br>
	<br>
</body>
<script>
	function somarNotasUm(input) {
		let unidadeum = 0.0;
		let linha = input.closest('tr');
		let ad1 = parseFloat(linha.querySelector('#ad1').value) || 0;
		let aps1 = parseFloat(linha.querySelector('#aps1').value) || 0;
		let sas11 = parseFloat(linha.querySelector('#sas11').value) || 0;
		let sas21 = parseFloat(linha.querySelector('#sas21').value) || 0;
		let rpt1 = parseFloat(linha.querySelector('#rpt1').value) || 0;
		unidadeum = ad1 + aps1 + sas11 + sas21 + rpt1;
		let unidadeUmInput = linha.querySelector('#unidadeum');
		unidadeUmInput.value = unidadeum.toFixed(1);
	}

	function somarNotasDois(input) {
		let linha = input.closest('tr');

		let ad2 = parseFloat(linha.querySelector('#ad2').value) || 0;
		let aps2 = parseFloat(linha.querySelector('#aps2').value) || 0;
		let sas12 = parseFloat(linha.querySelector('#sas12').value) || 0;
		let sas22 = parseFloat(linha.querySelector('#sas22').value) || 0;
		let rpt2 = parseFloat(linha.querySelector('#rpt2').value) || 0;
		unidadeTwo = ad2 + aps2 + sas12 + sas22 + rpt2;
		let unidadeDoisInput = linha.querySelector('#unidadedois');
		unidadeDoisInput.value = unidadeTwo.toFixed(1);;
	}

	function somarNotasTres(input) {
		let linha = input.closest('tr');

		let ad3 = parseFloat(linha.querySelector('#ad3').value) || 0;
		let aps3 = parseFloat(linha.querySelector('#aps3').value) || 0;
		let sas13 = parseFloat(linha.querySelector('#sas13').value) || 0;
		let sas23 = parseFloat(linha.querySelector('#sas23').value) || 0;
		let rpt3 = parseFloat(linha.querySelector('#rpt3').value) || 0;
		unidadetres = ad3 + aps3 + sas13 + sas23 + rpt3;
		let unidadeTresInput = linha.querySelector('#unidadetres');
		unidadeTresInput.value = unidadetres.toFixed(1);;
	}
	
	 function verificarInputsNulos() {

	        var inputs = document.getElementsByTagName('input');

	        for (var i = 0; i < inputs.length; i++) {
	            if (inputs[i].value.trim() === '') {
	                
	                document.getElementById('preenchaCampos').style.display = 'block';
	                return false; 
	            }
	        }

	        document.getElementById('preenchaCampos').style.display = 'none';
	        return true; 
	    }
</script>
</html>