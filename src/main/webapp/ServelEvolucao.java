

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import javaClass.*;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class ServelEvolucao
 */
@WebServlet("/ServelEvolucao")
public class ServelEvolucao extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServelEvolucao() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        Connection conexao = null; 
        try {
		 	StringBuilder sb = new StringBuilder();
	        BufferedReader reader = request.getReader();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            sb.append(line);
	        }
	        ObjectMapper objectMapper = new ObjectMapper();
	        Map<String, Object> jsonData = objectMapper.readValue(sb.toString(), Map.class);

	        conexao = ConectionMysql.conectar();
	        for (Map.Entry<String, Object> entry : jsonData.entrySet()) {
	          try {
	        	String id = entry.getKey();
	        	Map<String, Object> studentData = (Map<String, Object>) entry.getValue();
	        	int idTurma = (int) studentData.get("idTurma");
	        	int idMateria= (int) studentData.get("idMateria");
	        	Student student = new Student();
	        	student.setId((int) studentData.get("id"));
	        	
	        	student.setAd1((Double) studentData.get("ad1"));
	            student.setAs1((Double) studentData.get("as1"));
	            student.setAps1((Double) studentData.get("aps1"));
	            student.setAft1((Double) studentData.get("aft1"));
	            student.setRpt1((Double) studentData.get("rpt1"));
	            
	            student.setAd2((Double) studentData.get("ad2"));
	            student.setAs2((Double) studentData.get("as2"));
	            student.setAps2((Double) studentData.get("aps2"));
	            student.setAft2((Double) studentData.get("aft2"));
	            student.setRpt2((Double) studentData.get("rpt2"));
	            
	            student.setAd3((Double) studentData.get("ad3"));
	            student.setAs((Double) studentData.get("as3"));
	            student.setAps3((Double) studentData.get("aps3"));
	            student.setAft3((Double) studentData.get("aft3"));
	            student.setRpt3((Double) studentData.get("rpt3"));
	            
	            student.setTrimestreUm((Double) studentData.get("unidadeum"));
	            student.setTrimestreDois((Double) studentData.get("unidadedois"));
	            student.setTrimestreTres((Double) studentData.get("unidadetres"));
	            
	            student.setProvaFinal((Double) studentData.get("provaFinal"));
	            Double trimestreUm = 
	            		student.getAd1() + 
	            		student.getAs1() + 
	            		student.getAft1() + 
	            		student.getAps1() + 
	            		student.getRpt1();
	            
	            	if(trimestreUm == 5.9) {
	            		trimestreUm = 6.0;
	            	}	
	            
	            Double trimestreDois = 
	            		student.getAd2() + 
	            		student.getAs2() + 
	            		student.getAft2() + 
	            		student.getAps2() + 
	            		student.getRpt2();
	            
	            	if(trimestreDois == 5.9) {
	            		trimestreDois = 6.0;
	            	}
	            	
	            Double trimestreTres = 
	            		student.getAd3() + 
	            		student.getAs3() + 
	            		student.getAft3() + 
	            		student.getAps3() + 
	            		student.getRpt3();
	            
	            	if(trimestreTres == 5.9) {
	            		trimestreTres = 6.0;
	            	}
	            
	            Double somaNotas = trimestreUm + trimestreDois + trimestreTres;
	            Double mediaNota = somaNotas/3;
	            boolean aprovado = false;
	            if(mediaNota == 5.7) {
	            	mediaNota = 6.0;
	            }
	            if(mediaNota >= 6.0 || student.getProvaFinal() >= 5) {
	            	aprovado = true;
	            } else {
	            	aprovado = false;
	            }
	            
	           
					PreparedStatement st1 = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
							+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, ?, ?) ON "
							+ " DUPLICATE KEY UPDATE nota_tirada = ?");
					//insert notas trimestre um
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAd1());
					st1.setInt(5, 1);
					st1.setInt(6, 2);
					st1.setDouble(7, student.getAd1());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAs1());
					st1.setInt(5, 1);
					st1.setInt(6, 4);
					st1.setDouble(7, student.getAs1());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAps1());
					st1.setInt(5, 1);
					st1.setInt(6, 3);
					st1.setDouble(7, student.getAps1());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAft1());
					st1.setInt(5, 1);
					st1.setInt(6, 5);
					st1.setDouble(7, student.getAft1());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getRpt1());
				 	st1.setInt(5, 1);
					st1.setInt(6, 8);
					st1.setDouble(7, student.getRpt1());
					st1.execute();
					
					//insert notas trimestre dois
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAd2());
					st1.setInt(5, 2);
					st1.setInt(6, 2);
					st1.setDouble(7, student.getAd2());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAs2());
					st1.setInt(5, 2);
					st1.setInt(6, 4);
					st1.setDouble(7, student.getAs2());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAps2());
					st1.setInt(5, 1);
					st1.setInt(6, 3);
					st1.setDouble(7, student.getAps2());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAft2());
					st1.setInt(5, 2);
					st1.setInt(6, 5);
					st1.setDouble(7, student.getAft2());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getRpt2());
					st1.setInt(5, 2);
					st1.setInt(6, 8);
					st1.setDouble(7, student.getRpt2());
					st1.execute();
					
					//insert notas trimestre 3
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAd3());
					st1.setInt(5, 3);
					st1.setInt(6, 2);
					st1.setDouble(7, student.getAd3());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAs3());
					st1.setInt(5, 3);
					st1.setInt(6, 4);
					st1.setDouble(7, student.getAs3());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAps3());
					st1.setInt(5, 3);
					st1.setInt(6, 3);
					st1.setDouble(7, student.getAps3());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getAft3());
					st1.setInt(5, 3);
					st1.setInt(6, 5);
					st1.setDouble(7, student.getAft3());
					st1.execute();
					
					st1.setInt(1, student.getId());
					st1.setInt(2, idMateria);
					st1.setInt(3, idTurma);
					st1.setDouble(4, student.getRpt3());
					st1.setInt(5, 3);
					st1.setInt(6, 8);
					st1.setDouble(7, student.getRpt3());
					st1.execute();
					PreparedStatement st2 = conexao.prepareStatement
						    ("UPDATE notas SET primeira_und = ?, segunda_und = ?, terceira_und = ? WHERE id_aluno = ? AND id_materia = ?");
					st2.setDouble(1, trimestreUm);
					st2.setDouble(2, trimestreDois);
					st2.setDouble(3, trimestreTres);
					st2.setDouble(4, student.getId());
					st2.setDouble(5, idMateria);
					st2.execute();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        } 
	        }
	} finally {
        if (conexao != null) {
            try {
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
}