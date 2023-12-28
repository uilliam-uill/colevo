<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
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
<%@ page import="javaClass.ConectionMysql" %>

    <%
    Connection conexao = ConectionMysql.conectar();
    PreparedStatement updateNota = null;
    PreparedStatement updateUnidade= null;
	ResultSet rsnotas = null;
            	   updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma," +
            	 " nota_tirada, unidade, id_avaliacao)" +
            	   " VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
            	   updateNota.setInt(1, Integer.parseInt(request.getParameter("idAluno").trim()));
            	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria").trim()));
            	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma".trim())));
            	   updateNota.setDouble(4, Double.parseDouble(request.getParameter("notaAd").trim()));
            	   updateNota.setInt(5, Integer.parseInt(request.getParameter("unidade").trim()));
            	   updateNota.setInt(6, 2);
            	   updateNota.setDouble(7, Double.parseDouble(request.getParameter("notaAd").trim()));
            	   updateNota.execute();
            	   
            	   updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma," +
                      	 " nota_tirada, unidade, id_avaliacao)" +
                      	   " VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
                      	   updateNota.setInt(1, Integer.parseInt(request.getParameter("idAluno").trim()));
                      	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria").trim()));
                      	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma").trim()));
                      	   updateNota.setDouble(4, Double.parseDouble(request.getParameter("notaAps").trim()));
                      	   updateNota.setInt(5, Integer.parseInt(request.getParameter("unidade").trim()));
                      	   updateNota.setInt(6, 3);
                      	   updateNota.setDouble(7, Double.parseDouble(request.getParameter("notaAps").trim()));
                      	   updateNota.execute();
            	   
                      	 updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma," +
                              	 " nota_tirada, unidade, id_avaliacao)" +
                              	   " VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
                              	   updateNota.setInt(1, Integer.parseInt(request.getParameter("idAluno").trim()));
                              	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria").trim()));
                              	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma").trim()));
                              	   updateNota.setDouble(4, Double.parseDouble(request.getParameter("notaAs").trim()));
                              	   updateNota.setInt(5, Integer.parseInt(request.getParameter("unidade").trim()));
                              	   updateNota.setInt(6, 4);
                              	   updateNota.setDouble(7, Double.parseDouble(request.getParameter("notaAs").trim()));
                              	   updateNota.execute(); 
                              	   
                              	 updateNota = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, id_turma," +
                                      	 " nota_tirada, unidade, id_avaliacao)" +
                                      	   " VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nota_tirada = ?;" );
                                      	   updateNota.setInt(1, Integer.parseInt(request.getParameter("idAluno").trim()));
                                      	   updateNota.setInt(2, Integer.parseInt(request.getParameter("idMateria").trim()));
                                      	   updateNota.setInt(3, Integer.parseInt(request.getParameter("idTurma").trim()));
                                      	   updateNota.setDouble(4, Double.parseDouble(request.getParameter("notaAft").trim()));
                                      	   updateNota.setInt(5, Integer.parseInt(request.getParameter("unidade").trim()));
                                      	   updateNota.setInt(6, 5);
                                      	   updateNota.setDouble(7, Double.parseDouble(request.getParameter("notaAft").trim()));
                                      	   updateNota.execute();   
			Double mediaFinal = Double.parseDouble(request.getParameter("notaAft").trim()) + 
								Double.parseDouble(request.getParameter("notaAs").trim()) +
								Double.parseDouble(request.getParameter("notaAps").trim()) +
								Double.parseDouble(request.getParameter("notaAd").trim());
		

			if(Integer.parseInt(request.getParameter("unidade").trim()) == 1){
			    updateUnidade = conexao.prepareStatement("UPDATE notas SET primeira_und = ? WHERE id_aluno = ? AND id_materia = ?");
			    updateUnidade.setDouble(1, mediaFinal);
			    updateUnidade.setInt(2, Integer.parseInt(request.getParameter("idAluno").trim()));
			    updateUnidade.setInt(3, Integer.parseInt(request.getParameter("idMateria").trim()));
			    updateUnidade.executeUpdate();
			} else if(Integer.parseInt(request.getParameter("unidade").trim()) == 2){
			    updateUnidade = conexao.prepareStatement("UPDATE notas SET segunda_und = ? WHERE id_aluno = ? AND id_materia = ?");
			    updateUnidade.setDouble(1, mediaFinal);
			    updateUnidade.setInt(2, Integer.parseInt(request.getParameter("idAluno").trim()));
			    updateUnidade.setInt(3, Integer.parseInt(request.getParameter("idMateria").trim()));
			    updateUnidade.executeUpdate();
			} else if(Integer.parseInt(request.getParameter("unidade").trim()) == 3){
			    updateUnidade = conexao.prepareStatement("UPDATE notas SET terceira_und = ? WHERE id_aluno = ? AND id_materia = ?");
			    updateUnidade.setDouble(1, mediaFinal);
			    updateUnidade.setInt(2, Integer.parseInt(request.getParameter("idAluno").trim()));
			    updateUnidade.setInt(3, Integer.parseInt(request.getParameter("idMateria").trim()));
			    updateUnidade.executeUpdate();
			}
			%>

<script>
	window.history.back();
</script>
</body>
</html>