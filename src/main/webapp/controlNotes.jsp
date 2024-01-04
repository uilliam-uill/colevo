<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/controlNotes.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
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
<%@ page import="javaClass.Teacher" %> 
<%@ page import="javaClass.ConectionMysql" %> 

<%
Connection conexao = ConectionMysql.conectar();

PreparedStatement stDateAluno = null;
PreparedStatement stNotes = null;
ResultSet rsAlunoDate = null;
ResultSet rsNotes = null;

if (conexao != null) {
    	stDateAluno = conexao.prepareStatement("SELECT notas.primeira_und, notas.segunda_und, notas.terceira_und," +  
   				" notas.media_nota, notas.nota_final,notas.aprovado," +
    		    " pessoa.nome, pessoa.id_pessoa, aluno.id_aluno" +
    		    " FROM notas" +
    		    " INNER JOIN aluno ON notas.id_aluno = aluno.id_aluno" +
    		    " INNER JOIN pessoa ON aluno.id_pessoa = pessoa.id_pessoa");
    	rsAlunoDate = stDateAluno.executeQuery();
%>

	<div class = "header">
		<div class="icons">
			<img src="imagens\Captura de tela 2024-01-02 174742-fotor-bg-remover-20240102174819.png" width="300">
			<h1 style="color: white">Acesso Professor</h1>
		</div>
	</div>
	
<br> <br>
	<table border="1">
    <tr>
        <td id="codigo">Nº</td>
        <td>Aluno</td>
        <td>1º TRIMESTRE</td>
        <td>2º TRIMESTRE</td>
        <td>3º TRIMESTRE</td>
        <td>M.T</td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td>
            <table class="inner-table">
                <tr>
                    <td class="provas">AD</td>
                    <td class="provas">APS</td>
                    <td class="provas">AS</td>
                    <td class="provas">AFT</td>
                    <td class="provas">RPT</td>
                    <td class="provas">M.T</td>
                </tr>
            </table>
        </td>
        <td>
            <table class="inner-table">
                <tr>
                    <td>AD</td>
                    <td>APS</td>
                    <td>AS</td>
                    <td>AFT</td>
                    <td>RPT</td>
                    <td>M.T</td>
                </tr>
            </table>
        </td>
        <!-- Adicionei mais tabelas para cada conjunto de inputs -->
        <td>
            <table class="inner-table">
                <tr>
                    <td>AD</td>
                    <td>APS</td>
                    <td>AS</td>
                    <td>AFT</td>
                    <td>RPT</td>
                    <td>M.T</td>
                </tr>
            </table>
        </td>
        <td>
            <table class="inner-table">
                <tr>
                    <td>MF</td>
                    <td>TP</td>
                    <td>RS</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr> <%
    while(rsAlunoDate.next()){
    	stNotes = conexao.prepareStatement("SELECT nota_tirada, unidade, id_avaliacao, id_aluno " +
    			" FROM avaliacao WHERE id_aluno = ? AND id_materia = ? AND id_turma = ?;");
    	stNotes.setInt(1, rsAlunoDate.getInt("id_aluno"));
    	stNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
    	stNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
    	
    	
    	rsNotes = stNotes.executeQuery();
    while(rsAlunoDate.next() && rsNotes.next()){ %>
    <tr>
        <td><input type="text" value="<%=rsAlunoDate.getInt("id_aluno") %>" style="width: 50px;"></td>
        <td><input type="text" value="<%=rsAlunoDate.getString("nome") %>"></td>
        <td>
            <table class="inner-table">
                <tr>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 1 && rsNotes.getInt("id_avaliacao") == 2) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 1 && rsNotes.getInt("id_avaliacao") == 3) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 1 && rsNotes.getInt("id_avaliacao") == 4) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 1 && rsNotes.getInt("id_avaliacao") == 5) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 1 && rsNotes.getInt("id_avaliacao") == 8) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rsAlunoDate.getDouble("media_nota")%>">
                    </td>
                </tr>
            </table>
        </td>
        <!-- Repetindo a estrutura para os demais conjuntos de inputs -->
        <td>
            <table class="inner-table">
              <tr>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 2 && rsNotes.getInt("id_avaliacao") == 2) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 2 && rsNotes.getInt("id_avaliacao") == 3) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 2 && rsNotes.getInt("id_avaliacao") == 4) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 2 && rsNotes.getInt("id_avaliacao") == 5) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 2 && rsNotes.getInt("id_avaliacao") == 8) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rsAlunoDate.getDouble("primeira_und")%>">
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table class="inner-table">
               <tr>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 3 && rsNotes.getInt("id_avaliacao") == 2) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 3 && rsNotes.getInt("id_avaliacao") == 3) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 3 && rsNotes.getInt("id_avaliacao") == 4) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 3 && rsNotes.getInt("id_avaliacao") == 5) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%= (rsNotes.getInt("unidade") == 3 && rsNotes.getInt("id_avaliacao") == 8) ? rsNotes.getInt("nota_tirada") : "0.0" %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rsAlunoDate.getDouble("segunda_und")%>">
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table class="inner-table">
                <tr>
                    <td><input type="text" class="inputNotes"
                    value = "<%= rsAlunoDate.getDouble("media_nota")%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rsAlunoDate.getDouble("nota_final")%>">
                    </td>
                    <td><input type="text" class="inputNotes" id = "result"
                    <%if(rsAlunoDate.getBoolean("aprovado") == true){%>
                    	style="#id{background-color:green}"
                  <%  }else{%>
                  		style="#id{background-color:red}"
                  <%}%>
                  >
                    </td>
                </tr>
            </table>
            </tr>
        <%} } } %>
</table>
</body>
</html>