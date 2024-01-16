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
<%@ page import="javaClass.ConectionMysql" %> 
<%@ page import="javaClass.Student" %> 
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javaClass.Student" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="java.sql.SQLException" %>


    <%
    Connection conexao = null;
    PreparedStatement st1 = null;
    PreparedStatement st2 = null;
    try {
       

        conexao = ConectionMysql.conectar();
    	
    
        Double trimestreUm = Double.parseDouble(request.getParameter("ad1")) +
        					Double.parseDouble(request.getParameter("aps1")) +
        					Double.parseDouble(request.getParameter("as1")) +
        					Double.parseDouble(request.getParameter("aft1")) +
        					Double.parseDouble(request.getParameter("rpt1"));
					        if(trimestreUm == 5.9) {
					    		trimestreUm = 6.0;
					    	}	
        
        Double trimestreDois = Double.parseDouble(request.getParameter("ad2")) +
								Double.parseDouble(request.getParameter("aps2")) +
								Double.parseDouble(request.getParameter("as2")) +
								Double.parseDouble(request.getParameter("aft2")) +
								Double.parseDouble(request.getParameter("rpt2"));
							if(trimestreDois == 5.9) {
						    		trimestreDois = 6.0;
						    	}
        
        Double trimestreTres = Double.parseDouble(request.getParameter("ad3")) +
							Double.parseDouble(request.getParameter("aps3")) +
							Double.parseDouble(request.getParameter("as3")) +
							Double.parseDouble(request.getParameter("aft3")) +
							Double.parseDouble(request.getParameter("rpt3"));        
				        	if(trimestreTres == 5.9) {
				        		trimestreTres = 6.0;
				        	}
		Double provaFinal = Double.parseDouble(request.getParameter("provaF"));
        Double somaNotas = trimestreUm + trimestreDois + trimestreTres;
        Double mediaNota = somaNotas/3;
        boolean aprovado = false;
        if(5.7 >= mediaNota && mediaNota <= 5.9) {
        	mediaNota = 6.0;
        }
        if(mediaNota >= 6.0 || provaFinal >= 5) {
        	aprovado = true;
        } else {
        	aprovado = false;
        }
        
       
			st1 = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
					+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, ?, ?) ON "
					+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			//insert notas trimestre um
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3, Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("ad1")));
			st1.setInt(5, 1);
			st1.setInt(6, 2);
			st1.setDouble(7, Double.parseDouble(request.getParameter("ad1")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("as1")));
			st1.setInt(5, 1);
			st1.setInt(6, 4);
			st1.setDouble(7, Double.parseDouble(request.getParameter("as1")));
			st1.execute();
			
			st1.setInt(1,Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3, Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("aps1")));
			st1.setInt(5, 1);
			st1.setInt(6, 3);
			st1.setDouble(7, Double.parseDouble(request.getParameter("aps1")));
			st1.execute();
			
			st1.setInt(1,Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2,Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("aft1")));
			st1.setInt(5, 1);
			st1.setInt(6, 5);
			st1.setDouble(7, Double.parseDouble(request.getParameter("aft1")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2,Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("rpt1")));
		 	st1.setInt(5, 1);
			st1.setInt(6, 8);
			st1.setDouble(7, Double.parseDouble(request.getParameter("rpt1")));
			st1.execute();
			
			//insert notas trimestre dois
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("ad2")));
			st1.setInt(5, 2);
			st1.setInt(6, 2);
			st1.setDouble(7,Double.parseDouble(request.getParameter("ad2")));
			st1.execute();
			
			st1.setInt(1,Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("as2")));
			st1.setInt(5, 2);
			st1.setInt(6, 4);
			st1.setDouble(7, Double.parseDouble(request.getParameter("as2")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("aps2")));
			st1.setInt(5, 1);
			st1.setInt(6, 3);
			st1.setDouble(7, Double.parseDouble(request.getParameter("aps2")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("aft2")));
			st1.setInt(5, 2);
			st1.setInt(6, 5);
			st1.setDouble(7, Double.parseDouble(request.getParameter("aft2")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2,Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));;
			st1.setDouble(4,Double.parseDouble(request.getParameter("rpt2")));
			st1.setInt(5, 2);
			st1.setInt(6, 8);
			st1.setDouble(7,Double.parseDouble(request.getParameter("rpt2")));
			st1.execute();
			
			//insert notas trimestre 3
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("ad3")));
			st1.setInt(5, 3);
			st1.setInt(6, 2);
			st1.setDouble(7,Double.parseDouble(request.getParameter("ad3")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("as3")));
			st1.setInt(5, 3);
			st1.setInt(6, 4);
			st1.setDouble(7, Double.parseDouble(request.getParameter("as3")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3, Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("aps3")));
			st1.setInt(5, 3);
			st1.setInt(6, 3);
			st1.setDouble(7, Double.parseDouble(request.getParameter("aps3")));
			st1.execute();
			
			st1.setInt(1,Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(4, Double.parseDouble(request.getParameter("aft3")));
			st1.setInt(5, 3);
			st1.setInt(6, 5);
			st1.setDouble(7, Double.parseDouble(request.getParameter("aft3")));
			st1.execute();
			
			st1.setInt(1, Integer.parseInt(request.getParameter("idAluno")));
			st1.setInt(2, Integer.parseInt(request.getParameter("idMateria")));
			st1.setInt(3,  Integer.parseInt(request.getParameter("idTurma")));
			st1.setDouble(7, Double.parseDouble(request.getParameter("rpt3")));
			st1.setInt(5, 3);
			st1.setInt(6, 8);
			st1.setDouble(7, Double.parseDouble(request.getParameter("rpt3")));
			st1.execute();
		    st2 = conexao.prepareStatement
				    ("UPDATE notas SET primeira_und = ?, segunda_und = ?, terceira_und = ? WHERE id_aluno = ? AND id_materia = ?");
			st2.setDouble(1, trimestreUm);
			st2.setDouble(2, trimestreDois);
			st2.setDouble(3, trimestreTres);
			st2.setInt(4, Integer.parseInt(request.getParameter("idAluno")));
			st2.setInt(5,  Integer.parseInt(request.getParameter("idMateria")));
			st2.execute();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } 
 		finally {
        if (conexao != null) {
            try {
                if (st1 != null) {
                    st1.close();
                }
                if (st2 != null) {
                    st2.close();
                }
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
	window.history.back();
</script>
</head>
<body>

</body>
</html>