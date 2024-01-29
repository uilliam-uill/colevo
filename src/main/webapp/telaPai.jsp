<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="javaClass.Person" %> 
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
			<h1 style="color: white">Acesso dos Pais</h1>
		</div>
	</div>
	<br>
	<div> 
	<%
	PreparedStatement stPai = null;
	PreparedStatement stAluno= null;
	ResultSet rsPai = null;
	ResultSet rsAluno = null;
	Connection conexao = ConectionMysql.conectar();
	try{
	stPai = conexao.prepareStatement("SELECT aluno.id_aluno FROM pessoa INNER JOIN pais ON pessoa.id_pessoa = pais.id_pessoa" +
		 " INNER JOIN aluno ON pais.id_aluno = aluno.id_aluno WHERE pessoa.id_pessoa = ?");
	stPai.setInt(1, Integer.parseInt(request.getParameter("idPessoa")));
	rsPai = stPai.executeQuery();
	
	
	%>
		<div class="iconsAdm">
			<h1 style="color: rgb(63 , 63, 202);"><%=personLogin.getName() %></h1>
		</div>
	</div>
	<br>
	<div class="container text-center">
    	<div class="row justify-content-center">
    		<div class="col-md-8">
				<table class="table" style="padding: 150px">
				  <thead class="thead-light">
				    <tr>
				      <th scope="col">Código do aluno</th>
				      <th scope="col" >Nome</th>
				      <th scope="col" >Acessar</th>
				    </tr>
				  </thead>
				  <%while(rsPai.next()){
					  stAluno = conexao.prepareStatement("SELECT pessoa.nome, aluno.id_aluno FROM aluno INNER JOIN pessoa" +
							 " ON pessoa.id_pessoa = aluno.id_pessoa WHERE id_aluno = ?;");
					  stAluno.setInt(1, rsPai.getInt("id_aluno"));
					  rsAluno = stAluno.executeQuery();
					  while(rsAluno.next()){
				  %>
				  <tbody>
				    <tr>
       					 <td width="90px"><%= rsAluno.getInt("id_aluno") %></td>
      					 <td><%= rsAluno.getString("nome") %></td>
      					 <td> <button type="submit" class="btn btn-primary">Acessar</button> </td>
				      	<%} }%>
				    </tr>
				  </tbody>
				</table>
			</div>
		</div>
	</div>
	 <% } catch (SQLException e) {
        e.printStackTrace();
    } finally {
    	ConectionMysql.closeConnection(conexao, stPai, rsPai);
    }%>
</body>
<script>
var buttons = document.querySelectorAll('.btn-primary');

buttons.forEach(function(button) {
    button.addEventListener('click', function() {
        var idAluno = this.closest('tr').querySelectorAll('td')[0].textContent;  
        var nome = this.closest('tr').querySelectorAll('td')[1].textContent; 

        // Use o window.location.replace para redirecionar
        window.location.replace("screenStudent.jsp?idAluno=" + idAluno + "&nomeAluno=" + nome);
    });
});
</script>

</html>