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
if (conexao != null) {
    	stDateAluno = conexao.prepareStatement("SELECT notas.primeira_und, notas.segunda_und, notas.terceira_und," +  
   				" notas.media_nota, notas.nota_final,notas.aprovado, notas.prova_final, " +
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
	<table border="1" id="datesStudent">
    <tr class="provas">
        <td style="width: 10px;">Nº</td>
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
                    <td class="provas">SM</td>
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
    <tr id=<%=idAluno %>>
        <td width="10px"><input type="text" id="id" value="<%=idAluno%>" style="width: 50px;" disabled="disabled"></td>
        <td><input type="text" value="<%=nome%>" disabled="disabled"></td>
        <td>
            <table class="inner-table" id="quarterOne">
                <tr data-id="1">
                    <td><input type="text" class="inputNotes provas1"
                    value = "<%=ad1 %>" id="ad1" onchange="somarNotasUm(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas1"
                    value = "<%=aps1%>" id="aps1" onchange="somarNotasUm(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas1"
                    value = "<%=as1%>" id="as1" onchange="somarNotasUm(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas1"
                    value = "<%=aft1%>" id="aft1" onchange="somarNotasUm(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas1"
                    value = "<%=rpt1%>" id="rpt1" onchange="somarNotasUm(this)">
                    </td>
                    <td><input type="text" class="inputNotes" id="unidadeum"
                    value = "<%=rsAlunoDate.getDouble("primeira_und")%>" class="unidaddeum">
                    </td>
                </tr>
            </table>
        </td>
        <!-- Repetindo a estrutura para os demais conjuntos de inputs -->
        <td>
            <table class="inner-table" id="quarterTwo">
              <tr data-id="2">
                    <td><input type="text" class="inputNotes provas2"
                    value = "<%=ad2 %>" id="ad2" onchange="somarNotasDois(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas2"
                    value = "<%=aps2%>" id="aps2" onchange="somarNotasDois(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas2"
                    value = "<%=as2%>" id="as2" onchange="somarNotasDois(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas2"
                    value = "<%=aft2%>" id="aft2" onchange="somarNotasDois(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas2"
                    value = "<%=rpt2%>" id="rpt2" onchange="somarNotasDois(this)">
                    </td>
                    <td><input type="text" class="inputNotes" id="unidadedois"
                    value = "<%=rsAlunoDate.getDouble("segunda_und")%>" class="unidadedosis">
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table class="inner-table" id="quarterThree">
               <tr data-id="3">
                    <td><input type="text" class="inputNotes provas3"
                    value = "<%=ad3 %>" id="ad3" onchange="somarNotasTres(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas3"
                    value = "<%=aps3%>" id="aps3" onchange="somarNotasTres(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas3"
                    value = "<%=as3%>" id="as3" onchange="somarNotasTres(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas3"
                    value = "<%=aft3%>"id="aft3" onchange="somarNotasTres(this)">
                    </td>
                    <td><input type="text" class="inputNotes provas3"
                    value = "<%=rpt3%>" id="rpt3" onchange="somarNotasTres(this)">
                    </td>
                    <td><input type="text" class="inputNotes" id="unidadetres" 
                    value = "<%=rsAlunoDate.getDouble("terceira_und")%>" class="ssunidadetres"> 
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table class="inner-table" id="quartetFinish">
                <tr class="notas">
                <%
                double pf = rsAlunoDate.getDouble("prova_final");
                double soma_nota = 
                rsAlunoDate.getDouble("primeira_und") + 
                rsAlunoDate.getDouble("segunda_und") +
                rsAlunoDate.getDouble("terceira_und");
                
                double media_nota = soma_nota/3;
                
                if(media_nota == 5.7){
                	media_nota = 6.0;
                }
                %>
                
                    <td><input type="text" class="inputNotes" id="medianota"
                    value = "<%= media_nota%>">
                    </td>
                    <td><input type="text" class="inputNotes" id="somanota"
                    value = "<%=soma_nota%>" >
                    </td>
                    <td> <%if(media_nota >= 6 || pf >= 5){%> 
                    <input type="checkbox" id="meuCheckbox" checked>
                    <%}else{ %>
                    	<input type="checkbox" id="meuCheckbox">
                    <%} %>
                    </td>
                    <td><input type="text" class="inputNotes" id="provaFinal"
                    value = "<%=pf%>" >
                    </td>
                </tr>
            </table>
            </tr>
        <%} }%>
</table>
<br> <br> 
<button type="button" class="btn btn-primary btn-lg btn-block" onclick="sendDates()">Processar Dados</button>
</body>
<script>
function somarNotasUm(input) {
	let unidadeum = 0;
	unidadeTwo = 0;
	unidadetres = 0;
    let linha = input.closest('tr');
    let ad1 = parseFloat(linha.querySelector('#ad1').value) || 0;
    let aps1 = parseFloat(linha.querySelector('#aps1').value) || 0;
    let as1 = parseFloat(linha.querySelector('#as1').value) || 0;
    let aft1 = parseFloat(linha.querySelector('#aft1').value) || 0;
    let rpt1 = parseFloat(linha.querySelector('#rpt1').value) || 0;
    unidadeum = ad1 + aps1 + as1 + aft1 + rpt1;
    let unidadeUmInput = linha.querySelector('#unidadeum');
    unidadeUmInput.value = unidadeum;
    
    somarNotasFinal(input);
}
0
function somarNotasDois(input) {
    let linha = input.closest('tr');
   
    let ad2 = parseFloat(linha.querySelector('#ad2').value) || 0;
    let aps2 = parseFloat(linha.querySelector('#aps2').value) || 0;
    let as2 = parseFloat(linha.querySelector('#as2').value) || 0;
    let aft2 = parseFloat(linha.querySelector('#aft2').value) || 0;
    let rpt2 = parseFloat(linha.querySelector('#rpt2').value) || 0;
    unidadeTwo = ad2 + aps2 + as2 + aft2 + rpt2;
    let unidadeDoisInput = linha.querySelector('#unidadedois'); 
    unidadeDoisInput.value = unidadeTwo;

    somarNotasFinal(input);
}

function somarNotasTres(input) {
    let linha = input.closest('tr');
   
    let ad3 = parseFloat(linha.querySelector('#ad3').value) || 0;
    let aps3 = parseFloat(linha.querySelector('#aps3').value) || 0;
    let as3 = parseFloat(linha.querySelector('#as3').value) || 0;
    let aft3 = parseFloat(linha.querySelector('#aft3').value) || 0;
    let rpt3 = parseFloat(linha.querySelector('#rpt3').value) || 0;
    unidadetres = ad3 + aps3 + as3 + aft3 + rpt3;
    let unidadeTresInput = linha.querySelector('#unidadetres'); 
    unidadeTresInput.value = unidadetres;

    somarNotasFinal(input);
}


function sendDates() {
    var tableStudent = document.querySelector('#datesStudent');
    var quarterOne = document.querySelector('#quarterOne');
    var quarterTwo = document.querySelector('#quarterTwo');
    var quarterThree = document.querySelector('#quarterThree');
    var quarterFinish = document.querySelector('#quartetFinish');
    
    const urlParams = new URLSearchParams(window.location.search);
    

    function coletarDados(rows, data) {
    	var idMateria = urlParams.get('idmateria');
        var idTurma = urlParams.get('idturma');
        for (var j = 0; j < rows.length; j++) {
            var cells = rows[j].querySelectorAll('input');
            var linhaData = {}; 
            var idMateria = urlParams.get('idmateria');
            var idTurma = urlParams.get('idturma');
            linhaData['idMateria'] = idMateria;
            linhaData['idTurma'] = idTurma;
            for (var i = 0; i < cells.length; i++) {
                var cell = cells[i];
                linhaData[cell.id] = cell.value;
            }
			
            data.push(linhaData); 
            console.log(linhaData);
        }
    }

    var dadosStudent = [];
    var dadosOne = [];
    var dadosTwo = [];
    var dadosThree = [];
    var dadosFinish = [];

    coletarDados(tableStudent.querySelectorAll('tr'), dadosStudent);

    fetch('src/main/java/ServelEvolucao', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
    })
    .catch(error => console.error('Erro:', error));
}
</script>
</html>