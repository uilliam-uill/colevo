<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="javaClass.Person" %> 
    <%Person personLogin = Person.getInstance(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/admTela.css">
</head>
<body>

	<div class="headerAdm">
		<div class="iconsAdm">
			<h1 style="color: white">Area da Secretaria</h1>
		</div>
	</div>
	<br>
	<div> 
		<div class="iconsAdm">
			<h1 style="color: rgb(63 , 63, 202);"><%=personLogin.getName() %></h1>
		</div>
	</div>
	<br>
	
<div class="d-grid gap-2 col-6 mx-auto">

  <button class="btn btn-primary" type="button">
  <img src="imagens/diplomado.png">
  Turmas
  </button>
  
  <button class="btn btn-primary" type="button">
  <img src="imagens/aluno-com-limite-de-graduacao.png">
  Alunos
  </button>
  
  <button class="btn btn-primary" type="button">
  <img src="imagens/professor-no-quadro.png">
  Professores
  </button>
  <button class="btn btn-primary" type="button">
  <img src="imagens/familia (1).png">
  Pais
  </button>
</div>
	
</body>
</html>