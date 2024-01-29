<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/student.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="assets/bootstrap/bootstrap.bundle.min.afs"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<div class="header">
		<div class="icons">
			
			<h1 style="color: white">Acesso Aluno</h1>
		</div>
	</div>


<%
Connection conexao = ConectionMysql.conectar();
ResultSet rsNotas = null;
ResultSet rsTurma = null;
PreparedStatement stAula = null;
PreparedStatement stTurma = null;
PreparedStatement stNotasTr = null;	
PreparedStatement stNotes = null;
if(conexao != null){
	
	try{
	stNotasTr = conexao.prepareStatement
			("SELECT  notas.primeira_und, notas.segunda_und, notas.id_materia, turma.id_turma, notas.terceira_und, notas.aprovado, notas.nota_final, notas.media_nota,"+
			  " notas.prova_final, materias.nome_materia, turma.serie FROM notas INNER JOIN materias ON notas.id_materia = materias.id_materia " +
			  " INNER JOIN turma ON materias.id_turma = turma.id_turma WHERE id_aluno = ?;");
	stNotasTr.setInt(1,Integer.parseInt(request.getParameter("idAluno")));
	rsNotas = stNotasTr.executeQuery();
	
	stTurma = conexao.prepareStatement("SELECT aluno.id_turma, turma.serie FROM aluno INNER JOIN turma ON turma.id_turma " +
			"= aluno.id_turma WHERE id_aluno = ?");
	stTurma.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
	rsTurma = stTurma.executeQuery();
	
	%>
	
	<div> 
		<div class="iconsAdm">
			<h1 style="color: rgb(63 , 63, 202);"><%=request.getParameter("nomeAluno") %></h1>
		</div>
	</div>
	
<div class="apresentacao">
    <div class="imagem-container">
        <img src="imagens\Captura de tela 2024-01-17 180901.png" width="250" style="margin-bottom: 20px;">
    </div>
    <div class="turma">
        <div class="turmaMateria">
        <%if(rsTurma.next()) {%>
            <h3>Turma:</h3>
            <h3><%=rsTurma.getString("serie")%></h3>
            <%} %>
        </div>
    </div>
</div>	

<br>

		<table id="datesStudent">
		
			<tr class="provas">
				<td class="provas">Aula</td>	
				<td class="" width="15px">ID</td>
				<td class="provas">Matéria</td>
				<td class="provas" >1º TRIMESTRE</td>
				<td class="provas">2º TRIMESTRE</td>
				<td class="provas">3º TRIMESTRE</td>
				<td class="provas">RESULTADO FINAL</td>
			</tr>
			<tr>
				<td class="provas"></td>
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
						</tr>
					</table>
				</td>
				
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
						</tr>
					</table>
				</td>
				
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
							<td class="provas">AD <br> 2.0</td>
							<td class="provas">APS <br> 3.0</td>
							<td class="provas">AS <br> 1.0</td>
							<td class="provas">AFT <br> 4.0</td>
							<td class="provas">RPT <br> 3.0</td>
							<td class="provas">M.T</td>
						</tr>
					</table>
				</td>
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
							<td class="provas">AD <br> 2.0</td>
							<td class="provas">APS <br> 3.0</td>
							<td class="provas">AS <br> 1.0</td>
							<td class="provas">AFT <br> 4.0</td>
							<td class="provas">RPT <br> 3.0</td>
							<td class="provas">M.T</td>
						</tr>
					</table>
				</td>
				<!-- Adicionei mais tabelas para cada conjunto de inputs -->
				<td class="provas">
					<table class="inner-table">
						<tr class="provas">
							<td class="provas">AD <br> 2.0</td>
							<td class="provas">APS <br> 3.0</td>
							<td class="provas">AS <br> 1.0</td>
							<td class="provas">AFT <br> 4.0</td>
							<td class="provas">RPT <br> 3.0</td>
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
							<td class="provas">PF <br> 5.0</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
	
<%

while (rsNotas.next()) {
	stAula = conexao.prepareStatement("SELECT dia_assunto, assunto FROM plano_de_aula WHERE id_materia = ?;");
	stAula.setInt(1, rsNotas.getInt("id_materia"));
	ResultSet rsAula = stAula.executeQuery();
	int count = 1;
%>
 <!-- Abertura do modal -->
    
 <%  Double media_nota = rsNotas.getDouble("media_nota");
    Double pf = rsNotas.getDouble("prova_final");

    stNotes = conexao.prepareStatement("SELECT nota_tirada, unidade, id_avaliacao, id_aluno "
            + " FROM avaliacao WHERE id_aluno = ? AND id_materia = ? AND id_turma = ?");
    stNotes.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
    stNotes.setInt(2, rsNotas.getInt("id_materia"));
    stNotes.setInt(3, rsNotas.getInt("id_turma"));

    ResultSet rsNotes = stNotes.executeQuery();
    double ad1 = 0.0, aps1 = 0.0, as1 = 0.0, aft1 = 0.0, rpt1 = 0.0;
    double ad2 = 0.0, aps2 = 0.0, as2 = 0.0, aft2 = 0.0, rpt2 = 0.0;
    double ad3 = 0.0, aps3 = 0.0, as3 = 0.0, aft3 = 0.0, rpt3 = 0.0;

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
					if (idAvaliacao == 4) {
						as1 = notaTirada;
					}
					if (idAvaliacao == 5) {
						aft1 = notaTirada;
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
					if (idAvaliacao == 4) {
						as2 = notaTirada;
					}
					if (idAvaliacao == 5) {
						aft2 = notaTirada;
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
					if (idAvaliacao == 4) {
						as3 = notaTirada;
					}
					if (idAvaliacao == 5) {
						aft3 = notaTirada;
					}
					if (idAvaliacao == 8) {
						rpt3 = notaTirada;
					}
						}%>
					
					<%}
					%>
			<tr>
				<td> 
					<button class="btn btn-primary open-modal-btn" data-toggle="modal" data-target="#modal_<%= count %>">
						<img src="imagens/prancheta.png">
					</button>  
				</td>
				<td width="15px"><input type="text" value="<%=rsNotas.getInt("id_materia") %>" style="width: 38px"></td>
				<td><input type="text" value="<%=rsNotas.getString("nome_materia")%>" readonly></td>
				<td>
					<table class="inner-table" id="quarterOne">
						<tr data-id="1">
							<td><input type="text" class="inputNotes provas1"
								value="<%=ad1%>" id="ad1" name="ad1" readonly></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=aps1%>" id="aps1" name="aps1" readonly></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=as1%>" id="as1" name="as1" readonly></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=aft1%>" id="aft1" name="aft1" readonly></td>
							<td><input type="text" class="inputNotes provas1"
								value="<%=rpt1%>" id="rpt1" name="rpt1" readonly></td>
							<td><input type="text" class="inputNotes" id="unidadeum"
								name="unidadeum"
								value="<%=rsNotas.getDouble("primeira_und") %>"
								class="unidaddeum" readonly></td>
						</tr>
					</table>
				</td>
				<!-- Repetindo a estrutura para os demais conjuntos de inputs -->
				<td>
					<table class="inner-table" id="quarterTwo">
						<tr data-id="2">
							<td><input type="text" class="inputNotes provas2"
								value="<%=ad2%>" id="ad2" name="ad2" readonly></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=aps2%>" id="aps2" name="aps2" readonly></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=as2%>" id="as2" name="as2" readonly></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=aft2%>" id="aft2" name="aft2" readonly></td>
							<td><input type="text" class="inputNotes provas2"
								value="<%=rpt2%>" id="rpt2" name="rpt2" readonly></td>
							<td><input type="text" class="inputNotes" id="unidadedois"
								name="unidadedois"
								value="<%=rsNotas.getDouble("segunda_und") %>"
								class="unidadedosis" readonly></td>
						</tr>
					</table>
				</td>
				<td>
					<table class="inner-table" id="quarterThree">
						<tr data-id="3">
							<td><input type="text" class="inputNotes provas3"
								value="<%=ad3%>" id="ad3" name="ad3" readonly></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=aps3%>" id="aps3" name="aps3" readonly></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=as3%>" id="as3" name="as3" readonly></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=aft3%>" id="aft3" name="aft3" readonly></td>
							<td><input type="text" class="inputNotes provas3"
								value="<%=rpt3%>" id="rpt3" name="rpt3" readonly></td>
							<td><input type="text" class="inputNotes" id="unidadetres" 
								name="unidadetres"
								value="<%=rsNotas.getDouble("terceira_und") %>"
								class="ssunidadetres" readonly></td>
						</tr>
					</table>
				</td>
				<td>
					<table class="inner-table" id="quartetFinish">
						<tr>
							
							<td><input type="text" class="inputNotes" id="somanota"
								value="<%=rsNotas.getDouble("nota_final") %>" readonly></td>
								<td><input type="text" class="inputNotes" id="medianota"
								value="<%=rsNotas.getDouble("media_nota") %>" readonly></td>
							<td>
								<div class="bolinha"></div> <%
							 if (rsNotas.getBoolean("aprovado") == true) {
 %>
								<div class="bolinhaGreen"></div>
								<%
								} else {
								%>
								<div class="bolinhaRed"></div>
								<%
								}
								%>
							</td>
							<td><input type="text" class="inputNotes"
								id="provaFinalNote" name="provaFinalNote" value="<%=pf%>" readonly></td>
						</tr>
					</table>
				</td>

			</tr>
				<%

count = count + 1;

}	
	}catch (SQLException e) {
                e.printStackTrace();
            } finally {
            	conexao.close();
            }
}
%>
</table>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var btns = document.querySelectorAll(".open-modal-btn");

    btns.forEach(function(btn) {
        btn.addEventListener("click", function() {
            var modalNumber = btn.getAttribute("data-target").split("_")[1];
            var modal = new bootstrap.Modal(document.getElementById("modal_" + modalNumber));

            // Adiciona um evento para lidar com a exibição do modal
            modal._element.addEventListener("shown.bs.modal", function() {
                // Ao exibir o modal, remove a classe d-none da tabela
                document.getElementById("modalTable_" + modalNumber).classList.remove("d-none");
            });

            modal.show();
        });
    });
});
var buttons = document.querySelectorAll('.btn-primary.open-modal-btn');
buttons.forEach(function(button) {
    button.addEventListener('click', function() {
        // Obtenha o <td> pai do botão
        var tdParent = this.parentNode;

        // Em seguida, encontre o <input> dentro desse <td>
        var idMateria = tdParent.nextElementSibling.querySelector('input').value;
        window.location.href = "aulaData.jsp?idmateria=" + idMateria;
    });
});
</script>
</body>
</html>