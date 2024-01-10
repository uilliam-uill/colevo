

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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class ServelEvolucao
 */
public class ServelEvolucao extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServelEvolucao() {
        super();
        // TODO Auto-generated constructor stub
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 StringBuilder sb = new StringBuilder();
	        BufferedReader reader = request.getReader();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            sb.append(line);
	        }
	        ObjectMapper objectMapper = new ObjectMapper();
	        Map<String, Object> jsonData = objectMapper.readValue(sb.toString(), Map.class);

	        for (Map.Entry<String, Object> entry : jsonData.entrySet()) {
	        	String id = entry.getKey();
	        	 Map<String, Object> studentData = (Map<String, Object>) entry.getValue();
	        	Student student = new Student();
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
	            student.setAs2((Double) studentData.get("as3"));
	            student.setAps3((Double) studentData.get("aps3"));
	            student.setAft3((Double) studentData.get("aft3"));
	            student.setRpt3((Double) studentData.get("rpt3"));
	            
	            student.setTrimestreUm((Double) studentData.get("unidadeum"));
	            student.setTrimestreDois((Double) studentData.get("unidadedois"));
	            student.setTrimestreTres((Double) studentData.get("aps1"));
	        }
	}

}
