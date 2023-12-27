<%@page import="javaClass.Teacher"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Notas Aluno</title>
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
	<div class="container">
        <div class="col-6 mx-auto">
            <div class="card shadow border">
                <div class="card-body d-flex flex-column align-items-center">
                <h3 class="titleNota">Unidade <%=request.getParameter("unidade") %></h3>
                <%
                Teacher t = Teacher.getInstance();
                PreparedStatement notasAtiv = null;
                ResultSet rsAtiv = null;
                Double notaAD = 0.0;
    			Double notaAPS = 0.0;
    			Double notaAS = 0.0;
    			Double notaAFT = 0.0;
    			Connection conexao = ConectionMysql.conectar();
                if(Integer.parseInt(request.getParameter("idTurma"))!= 12){ %>
                <%
                 if (conexao != null){
            		try{
            			notasAtiv = conexao.prepareStatement("SELECT avaliacao.nota_tirada, avaliacao.id_avaliacao FROM avaliacao " +
            			" INNER JOIN tipos_avaliacao ON avaliacao.id_avaliacao = tipos_avaliacao.id_avaliacao" + 
            			" WHERE avaliacao.unidade = ? AND avaliacao.id_aluno = ? AND avaliacao.id_materia = ?" + 
            			" AND avaliacao.id_turma = ? AND avaliacao.id_avaliacao IN (2, 3, 4, 5);");
            			notasAtiv.setInt(1, Integer.parseInt(request.getParameter("unidade")));
            			notasAtiv.setInt(2, Integer.parseInt(request.getParameter("id")));
            			notasAtiv.setInt(3, Integer.parseInt(request.getParameter("idMateria")));
            			notasAtiv.setInt(4, Integer.parseInt(request.getParameter("idTurma")));
            			notasAtiv.execute();
            			rsAtiv = notasAtiv.executeQuery();
            			while(rsAtiv.next()){
            				if(rsAtiv.getInt("id_avaliacao") == 2){
            					notaAD = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 3){
            					notaAPS = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 4){
            					notaAS = rsAtiv.getDouble("nota_tirada");
            				}
            				if(rsAtiv.getInt("id_avaliacao") == 5){
            					notaAFT = rsAtiv.getDouble("nota_tirada");
            				}
            			}
            		}catch (SQLException e) {
                        e.printStackTrace();
                    }
                 }
                }
                %>
                	<form method="post">
                		<label>AD - Atividade Diversificada:</label>
                		<input type="number" id="ad" name="notaAd" onchange="somaNota()" value="<%=notaAD %>" name="ad">
                		<br>
                		<label>APS - Avaliação Parcial Semanal:</label>
                		<input type="number" id="aps" name="notaAps" onchange="somaNota()" value="<%=notaAPS %>" name="aps">
                		<br>
                		<label>AS - Avaliação Sistemática:</label>
                		<input type="number" id="as" name="notaAs" onchange="somaNota()" value="<%=notaAS %>" name="as">
                		<br>
                		<label>AFT: Avaliação Final Trimestral:</label>
                		<input type="number" id="aft" name="notaAft" onchange="somaNota()" value="<%=notaAFT %>" name="aft">
                		<br>
                		<label>Nota Final</label>
                		<input type="number" id="soma" name="notaAd" value=""> <br>
                		<button type="submit" class="btn btn-success">Salvar</button>
                	</form>
               <%PreparedStatement updateNota = null;
               ResultSet rsnotas = null;
               if(conexao != null){
            	   updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma, id_professor," +
            	 " nota_tirada, unidade, id_avaliacao)" +
            	   " VALUES (?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
            	   updateNota.setInt(1, Integer.parseInt(request.getParameter("id")));
            	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
            	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma")));
            	   updateNota.setInt(4, Integer.parseInt(request.getParameter("idprofessor")));
            	   updateNota.setDouble(5, Double.parseDouble(request.getParameter("notaAd")));
            	   updateNota.setInt(6, Integer.parseInt(request.getParameter("unidade")));
            	   updateNota.setInt(7, 2);
            	   updateNota.setDouble(8, Double.parseDouble(request.getParameter("notaAd")));
            	   updateNota.execute();
            	   
            	   updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma, id_professor," +
                      	 " nota_tirada, unidade, id_avaliacao)" +
                      	   " VALUES (?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
                      	   updateNota.setInt(1, Integer.parseInt(request.getParameter("id")));
                      	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
                      	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma")));
                      	 updateNota.setInt(4, Integer.parseInt(request.getParameter("idprofessor")));
                      	   updateNota.setDouble(5, Double.parseDouble(request.getParameter("notaAps")));
                      	   updateNota.setInt(6, Integer.parseInt(request.getParameter("unidade")));
                      	   updateNota.setInt(7, 3);
                      	   updateNota.setDouble(8, Double.parseDouble(request.getParameter("notaAps")));
                      	   updateNota.execute();
            	   
                      	 updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma, id_professor," +
                              	 " nota_tirada, unidade, id_avaliacao)" +
                              	   " VALUES (?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
                              	   updateNota.setInt(1, Integer.parseInt(request.getParameter("id")));
                              	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
                              	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma")));
                              	 updateNota.setInt(4, Integer.parseInt(request.getParameter("idprofessor")));
                              	   updateNota.setDouble(5, Double.parseDouble(request.getParameter("notaAs")));
                              	   updateNota.setInt(6, Integer.parseInt(request.getParameter("unidade")));
                              	   updateNota.setInt(7, 4);
                              	   updateNota.setDouble(8, Double.parseDouble(request.getParameter("notaAs")));
                              	   updateNota.execute(); 
                              	   
                              	 updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma, id_professor," +
                                      	 " nota_tirada, unidade, id_avaliacao)" +
                                      	   " VALUES (?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
                                      	   updateNota.setInt(1, Integer.parseInt(request.getParameter("id")));
                                      	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
                                      	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma")));
                                      	   updateNota.setInt(4, Integer.parseInt(request.getParameter("idprofessor")));
                                      	   updateNota.setDouble(5, Double.parseDouble(request.getParameter("notaAft")));
                                      	   updateNota.setInt(6, Integer.parseInt(request.getParameter("unidade")));
                                      	   updateNota.setInt(7, 5);
                                      	   updateNota.setDouble(8, Double.parseDouble(request.getParameter("notaAft")));
                                      	   updateNota.execute();      	   
               }
               %>
                </div>
            </div>
        </div>
</div>
</body>
<script>
var ad = parseFloat(document.getElementById('ad').value) || 0;
var aps = parseFloat(document.getElementById('aps').value) || 0;
var as = parseFloat(document.getElementById('as').value) || 0;
var aft = parseFloat(document.getElementById('aft').value) || 0;
var finalGrade = ad + aps + as + aft;
document.getElementById('soma').value = finalGrade;
	function somaNota(){
		var ad = parseFloat(document.getElementById('ad').value) || 0;
		var aps = parseFloat(document.getElementById('aps').value) || 0;
		var as = parseFloat(document.getElementById('as').value) || 0;
		var aft = parseFloat(document.getElementById('aft').value) || 0;
		var finalGrade = ad + aps + as + aft;
		document.getElementById('soma').value = finalGrade;
	}
</script>
</html>