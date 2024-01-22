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
<link rel="stylesheet" type="text/css" href="style/controlNotes.css">
<link rel="stylesheet" type="text/css" href="style/planoAula.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>

<body>
	<div class="header">
		<div class="icons">

			<h1 style="color: white">Plano de Aula</h1>
		</div>
	</div>
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
	<%@ page import="javaClass.ConectionMysql"%>
	<%
	String turmaCodificada = request.getParameter("turma");
	String turmaDecodificada = java.net.URLDecoder.decode(turmaCodificada, "UTF-8");
	%>
	<div class="apresentacao">
		<div class="imagem-container">
			<img src="imagens\Captura de tela 2024-01-17 180901.png" width="250"
				style="margin-bottom: 20px;">
		</div>
		<div class="turma">
			<div class="turmaMateria">
				<h3>Turma:</h3>
				<h3><%=turmaDecodificada%></h3>
			</div>
			<br>
			<div class="turmaMateria" style="margin-top: 20px;">
				<h3>Matéria:</h3>
				<h3><%=request.getParameter("materia")%></h3>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="col-6 mx-auto">
			<div class="card shadow border">
				<div class="card-body d-flex flex-column align-items-center">
					<div class="alert alert-danger" id="preenchaCampos" role="alert" style="display: none;">
						Preencha Todos o Campos!
					</div>
					<h3 class="titleNota">Atualize o Plano de Aula</h3>

					<label>Código da Aula</label> <input type="text" id="idAula"
						class="form-control" name="idAula" value="" readonly> <br>
					<label>Código da Materia</label> <input type="text"
						class="form-control" name="idMateria" id="idMateria"
						value="<%=request.getParameter("idmateria")%>" readonly> <br>
					<label>Data da Aula</label> <input type="date" id="dataAula"
						class="form-control" name="dataAula" value=""> <br> <label>Assunto</label>
					<div class="form-outline">
						<textarea class="form-control" id="textAreaExample1"
							name="assuntosDia" rows="4"></textarea>
					</div>
					<button type="submit" class="btn btn-success" onclick="update()">Salvar
						Aprovação</button>
				</div>
			</div>
		</div>
	</div>
	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th scope="col" width="80px">Id Materia</th>
				<th scope="col" width="110px">Data da Aula</th>
				<th scope="col" width="80px">Materia</th>
				<th scope="col" width="80px">Id Aula</th>
				<th scope="col">Assunto</th>
				<th scope="col"width="100px">Atualizar</th>
				<th scope="col" width="100px">Deletar</th>
			</tr>


			<%
			Connection conexao = ConectionMysql.conectar();
			PreparedStatement srPda = null;
			ResultSet rsPda = null;
			try {
				srPda = conexao.prepareStatement("SELECT * from plano_de_aula WHERE id_materia = ?");
				srPda.setInt(1, Integer.parseInt(request.getParameter("idmateria")));
				rsPda = srPda.executeQuery();

				while (rsPda.next()) {
			%>
			<tr>
				<td><%=rsPda.getInt("id_materia")%></td>
				<td><%=rsPda.getDate("dia_assunto")%>
				<td><%=request.getParameter("turma")%></td>
				<td><%=rsPda.getInt("id_pda")%></td>
				<td><%=rsPda.getString("assunto")%>
				<td><button class="btn-primary" id="update">Atulizar</button></td>
				<td><button class="btn-primary" id="delete">Deletar</button></td>
			</tr>
			<%
			}
			} catch (SQLException ex) {
			ex.printStackTrace(); // Trate a exceção de rollback
			} finally {
			ConectionMysql.closeConnection(conexao, srPda, rsPda);
			}
			%>
		</thead>
	</table>

</body>
<script>
	var buttons = document.querySelectorAll('.btn-primary');

	// Iterar sobre cada botão para adicionar um evento de clique
	buttons
			.forEach(function(button) {
				button
						.addEventListener(
								'click',
								function() {
									// Acessar o valor da terceira célula (índice 2, pois começamos do zero)   
									var idmateria = this.closest('tr')
											.querySelectorAll('td')[0].textContent;
									var idaula = this.closest('tr')
											.querySelectorAll('td')[3].textContent;
									var buttonId = this.id;
									switch (buttonId) {
									case 'delete':
										window.location.href = "deletePlanoDeAula.jsp?idaula="
												+ idaula;
										break;

									case 'update':
										var idaula = this.closest('tr')
												.querySelectorAll('td')[3].textContent;
										var dataaula = this.closest('tr')
												.querySelectorAll('td')[1].textContent;
										var assuntoTb = this.closest('tr')
												.querySelectorAll('td')[4].textContent;

										// Atribuir os valores aos campos do formulário
										document.getElementById('idAula').value = idaula;
										document.getElementById('dataAula').value = dataaula;
										document
												.getElementById('textAreaExample1').value = assuntoTb;
										break;
									}

								});
			});

	function update() {
		var idmateria = document.getElementById('idMateria').value;
		var idaula = document.getElementById('idAula').value;
		var assunto = document.getElementById('textAreaExample1').value;
		var data = document.getElementById('dataAula').value;
		var partesData = data.split("-");
		var dataFormatada = partesData[2] + "-" + partesData[1] + "-"
				+ partesData[0];
		if (assunto.trim() === '' || data.trim() === '') {
			var alertPC = document.getElementById('preenchaCampos');
			alertPC.style.display = 'block';
		}else{	window.location.href = "controladorPlanoDeAula.jsp?idMateria="
				+ idmateria + "&idaula=" + idaula + "&assunto=" + assunto
				+ "&data=" + dataFormatada;
		}
	}
</script>
</html>