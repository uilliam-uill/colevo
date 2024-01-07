<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

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

/*Double ad1 = 0.0;
Double ad2 = 0.0;
Double ad3 = 0.0;

Double aps1 = 0.0;
Double aps2 = 0.0;
Double aps3 = 0.0;

Double as1 = 0.0;
Double as2 = 0.0;
Double as3 = 0.0;

Double aft1 = 0.0;
Double aft2 = 0.0;
Double aft3 = 0.0;

Double rpt1 = 0.0;
Double rpt2 = 0.0;
Double rpt3 = 0.0;*/
String nome = "";
int idAluno = 0;
Double pf = 0.0;
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
    <tr class="provas">
        <td id="codigo" class="provas">Nº</td>
        <td class="provas">Aluno</td>
        <td class="provas">1º TRIMESTRE</td>
        <td class="provas">2º TRIMESTRE</td>
        <td class="provas">3º TRIMESTRE</td>
        <td class="provas">M.T</td>
    </tr>
    <tr>
        <td class="provas"></td>
        <td class="provas"></td>
        <td class="provas">
            <table class="inner-table">
                <tr class="provas">
                    <td class="provas">AD</td>
                    <td class="provas">APS</td>
                    <td class="provas">AS</td>
                    <td class="provas">AFT</td>
                    <td class="provas">RPT</td>
                    <td class="provas">M.T</td>
                </tr>
            </table>
        </td>
        <td class="provas">
            <table class="inner-table">
                <tr class="provas">
                    <td class="provas">AD</td>
                    <td class="provas">APS</td>
                    <td class="provas">AS</td>
                    <td class="provas">AFT</td>
                    <td class="provas">RPT</td>
                    <td class="provas">M.T</td>
                </tr>
            </table>
        </td>
        <!-- Adicionei mais tabelas para cada conjunto de inputs -->
        <td class="provas">
            <table class="inner-table">
                <tr class="provas">
                    <td class="provas">AD</td>
                    <td class="provas">APS</td>
                    <td class="provas">AS</td>
                    <td class="provas">AFT</td>
                    <td class="provas">RPT</td>
                    <td class="provas">M.T</td>
                </tr>
            </table>
        </td>
        <td class="provas">
            <table class="inner-table">
                <tr class="provas">
                    <td class="provas">MF</td>
                    <td class="provas">TP</td>
                    <td class="provas">RS</td>
                    <td class="provas">PF</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr> <%
   // Map<Integer, List<Double>> notasPorAluno = new HashMap<>();
    while(rsAlunoDate.next()){
    	nome = rsAlunoDate.getString("nome");
    	idAluno = rsAlunoDate.getInt("id_aluno");
    	stNotes = conexao.prepareStatement("SELECT nota_tirada, unidade, id_avaliacao, id_aluno " +
    			" FROM avaliacao WHERE id_aluno = ? AND id_materia = ? AND id_turma = ?;");
    	stNotes.setInt(1, rsAlunoDate.getInt("id_aluno"));
    	stNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
    	stNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
    	
    	double ad1 = 0.0, aps1 = 0.0, as1 = 0.0, aft1 = 0.0, rpt1 = 0.0;
		double ad2 = 0.0, aps2 = 0.0, as2 = 0.0, aft2 = 0.0, rpt2 = 0.0;
		double ad3 = 0.0, aps3 = 0.0, as3 = 0.0, aft3 = 0.0, rpt3 = 0.0;
    	
    	rsNotes = stNotes.executeQuery();
    	while(rsNotes.next()){
		int unidade = rsNotes.getInt("unidade");
        int idAvaliacao = rsNotes.getInt("id_avaliacao");
        double notaTirada = rsNotes.getDouble("nota_tirada");
		if(unidade == 1){
            if(idAvaliacao == 2){ ad1 = notaTirada; }
            if(idAvaliacao == 3){ aps1 = notaTirada; }
            if(idAvaliacao == 4){ as1 = notaTirada; }
            if(idAvaliacao == 5){ aft1 = notaTirada; }
            if(idAvaliacao == 8){ rpt1 = notaTirada; }
       }
		if(unidade == 2){
            if(idAvaliacao == 2){ ad2 = notaTirada; }
            if(idAvaliacao == 3){ aps2 = notaTirada; }
            if(idAvaliacao == 4){ as2 = notaTirada; }
            if(idAvaliacao == 5){ aft2 = notaTirada; }
            if(idAvaliacao == 8){ rpt2 = notaTirada; }
       }
		if(unidade == 3){
            if(idAvaliacao == 2){ ad3 = notaTirada; }
            if(idAvaliacao == 3){ aps3 = notaTirada; }
            if(idAvaliacao == 4){ as3 = notaTirada; }
            if(idAvaliacao == 5){ aft3 = notaTirada; }
            if(idAvaliacao == 8){ rpt3 = notaTirada; }
       }
	//	int i = i++;
		/*List<Double> notasDoAluno = new ArrayList<>();
		notasDoAluno.add(idAluno, ad1);
		notasDoAluno.add(idAluno, aps1);
		notasDoAluno.add(idAluno, as1);
		notasDoAluno.add(idAluno, aft1);
		notasDoAluno.add(idAluno, rpt1);
		notasDoAluno.add(idAluno, ad2);
		notasDoAluno.add(idAluno, aps2);
		notasDoAluno.add(idAluno, as2);
		notasDoAluno.add(idAluno, aft2);
		notasDoAluno.add(idAluno, rpt2);
		notasDoAluno.add(idAluno, ad3);
		notasDoAluno.add(idAluno, aps3);
		notasDoAluno.add(idAluno, as3);
		notasDoAluno.add(idAluno, aft3);
		notasDoAluno.add(idAluno, rpt3);*/
    	}
    %>
    <tr>
        <td><input type="text" value="<%=idAluno%>" style="width: 50px;"></td>
        <td><input type="text" value="<%=nome%>"></td>
        <td>
            <table class="inner-table">
                <tr>
                    <td><input type="text" class="inputNotes"
                    value = "<%=ad1 %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=aps1%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=as1%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=aft1%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rpt1%>">	
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rsAlunoDate.getDouble("primeira_und")%>">
                    </td>
                </tr>
            </table>
        </td>
        <!-- Repetindo a estrutura para os demais conjuntos de inputs -->
        <td>
            <table class="inner-table">
              <tr>
                    <td><input type="text" class="inputNotes"
                    value = "<%=ad2 %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=aps2%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=as2%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=aft2%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rpt2%>">	
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
                    value = "<%=ad3 %>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=aps3%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=as3%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=aft3%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rpt3%>">
                    </td>
                    <td><input type="text" class="inputNotes"
                    value = "<%=rsAlunoDate.getDouble("terceira_und")%>">
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
                    <td><input type="text" class="inputNotes"
                    value = "<%=rsAlunoDate.getDouble("nota_final")%>">
                    </td>
                </tr>
            </table>
            </tr>
        <%} }%>
</table>
</body>
</html>