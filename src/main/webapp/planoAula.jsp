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
	<div class="apresentacao">
    <div class="imagem-container">
        <img src="imagens\Captura de tela 2024-01-17 180901.png" width="250" style="margin-bottom: 20px;">
    </div>
    <div class="turma">
        <div class="turmaMateria">
            <h3>Turma:</h3>
            <h3><%=request.getParameter("turma")%></h3>
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
						<h3 class="titleNota">Atualize o Plano de Aula</h3>
						<form method="post" action="controladorPlanoDeAula.jsp?idmateria=">
						<label>Código da Aula</label> <input type="text"
								class="form-control" name="idAula" value="" readonly> <br>
							<label>Código da Materia</label> <input type="text"
								class="form-control" name="idMateria" value="<%=request.getParameter("idmateria")%>" readonly> <br>
						
							<label>Data da Aula</label> <input type="date"
								class="form-control" name="dataAula" value=""> <br>

							<label>Assunto</label>
							<div class="form-outline">
								<textarea class="form-control" id="textAreaExample1" name="assuntosDia" rows="4"></textarea>
							</div>
							<button type="submit" class="btn btn-success"
								onclick="aprovarAluno()">Salvar Aprovação</button>
						</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script></script>
</html>