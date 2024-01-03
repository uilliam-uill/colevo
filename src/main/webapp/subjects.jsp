<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Aluno - Plano de Aula</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/studentToken.css">
</head>

<body>
<div class = "header">
		<div class="icons">
			<img src="imagens/logobranca.png" width="100">
			<h1 style="color: white">Colégio Evolução - Plano de Aula</h1>
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
    <div class="row align-items-center vh-100">
        <div class="col-6 mx-auto">
            <div class="card shadow border">
                <div class="card-body d-flex flex-column align-items-center">
                <h3 class="titleNota">Atualize Plano de Aula</h3>
                <%
            /*    Connection conexao = ConectionMysql.conectar();
                PreparedStatement selectSubject = null;
            	ResultSet rsSubject = null;
            	
            	selectSubject = conexao.prepareStatement("SELECT unidade, asuntos FROM plano_de_aula WHERE id_materia = ?");
            //	selectSubject.setInt(1, Integer.parseInt(request.getParameter("idMateria")));
            	
            	//rsSubject = selectSubject.executeQuery();
                /*%>*/
                	     
	                    <label>Primeiro Trimestre</label> 
	                    <textarea class="form-control rounded-0" <% while(rsSubject.next()){ if(rsSubject.getInt("unidade") == 1){%>value="<%=rsSubject.getString("asuntos") %>" <%}} %>id="unidade1" rows="3"></textarea>

						<label>Segundo Trimestre</label> 
	                    <textarea class="form-control rounded-0"  <%while(rsSubject.next()){ if(rsSubject.getInt("unidade") == 2){%>value="<%=rsSubject.getString("asuntos") %>" <%}} %> id="unidade2" rows="3"></textarea>
						
						<label>Terceiro Trimestre</label> 
	                    <textarea class="form-control rounded-0"  <%while(rsSubject.next()){ if(rsSubject.getInt("unidade") == 3){%>value="<%=rsSubject.getString("asuntos") %>" <%}} %> id="unidade3" rows="3"></textarea>
	                    
	                    <label>Recuperação</label> 
	                    <textarea class="form-control rounded-0"  <%while(rsSubject.next()){ if(rsSubject.getInt("unidade") == 4){%>value="<%=rsSubject.getString("asuntos") %>" <%}}%> id="recuperacao" rows="3"></textarea>
						<br> <br>
						<button type="button" class="btn btn-success" onclick="planoDeAula()">Salvar plano de aula</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
function planoDeAula(){
	var unidade1 =  document.getElementById('unidade1') || "";
	var unidade2 =  document.getElementById('unidade2') || "";
	var unidade3 =  document.getElementById('unidade3') || "";
	var recuperacao =  document.getElementById('recuperacao') || "";
	
	var urlParams = new URLSearchParams(window.location.search);
    var idMateria = urlParams.get('idMateria');
	
   window.location.href = "updateSubjects.jsp?recuperacao=" + recuperacao + "&untres=" + unidade3 + "&undois=" + unidade2
		   + "&unum=" + unidade1 + "&idmateria=" + idMateria;
	    
}
</script>

</body>
</html>