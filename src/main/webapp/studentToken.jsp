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

    if (conexao != null) {
        PreparedStatement loginPerson = null;
        ResultSet rsLoginPerson = null;
        try{
        	
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	%>
	<div class="container">
    <div class="row align-items-center vh-100">
        <div class="col-6 mx-auto">
            <div class="card shadow border">
                <div class="card-body d-flex flex-column align-items-center">
                <h3 class="titleNota">Atualize a Nota</h3>
	                <form>
	                    <label>Código do aluno</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Nome</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>CPF</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Primeira Unidade</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Segunda Unidade</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Terceira Unidade</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Recuperação</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Nota Final</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Aprovado</label> 
	                    <input type="text" class="form-control"> <br>
	                    
	                    <label>Notas</label>
	                    <div class="form-outline">
							  <textarea class="form-control" id="textAreaExample1" rows="4"></textarea>
						</div>
	                    <button type="button" class="btn btn-success">Enviar</button>
	                </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>