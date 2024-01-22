<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="javaClass.Person"%>
<%@ page import="javaClass.ConectionMysql"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <%
    Connection conexao = ConectionMysql.conectar();
    try {
        String dataString = request.getParameter("data");
        SimpleDateFormat formatoEntrada = new SimpleDateFormat("dd-MM-yyyy"); // Alteração aqui
        Date dataOriginal = formatoEntrada.parse(dataString);

        // Formatar a data para o formato desejado
        SimpleDateFormat formatoSaida = new SimpleDateFormat("yyyy-MM-dd"); // Alteração aqui
        String dataFormatada = formatoSaida.format(dataOriginal);

        // Converter a data formatada de volta para um objeto Date
        Date dataFormatadaDate = formatoSaida.parse(dataFormatada);

        if (request.getParameter("idaula") != null && !request.getParameter("idaula").isEmpty()) {
            PreparedStatement stPda = conexao.prepareStatement("UPDATE plano_de_aula SET dia_assunto = STR_TO_DATE(?, '%Y-%m-%d'), assunto = ? WHERE id_pda = ?");
            stPda.setString(1, dataFormatada);
            stPda.setString(2, request.getParameter("assunto"));
            stPda.setInt(3, Integer.parseInt(request.getParameter("idaula")));
            stPda.executeUpdate();
            stPda.close();
        } else {
            PreparedStatement stPdaIn = conexao.prepareStatement("INSERT INTO plano_de_aula (id_materia, dia_assunto, assunto) VALUES (?, STR_TO_DATE(?, '%Y-%m-%d'), ?)");
            stPdaIn.setInt(1, Integer.parseInt(request.getParameter("idMateria")));
            stPdaIn.setString(2, dataFormatada);
            stPdaIn.setString(3, request.getParameter("assunto"));
            stPdaIn.execute();
            stPdaIn.close();
        }
    } catch (Exception ex) {
        // Tratamento de erro específico para o loop
        ex.printStackTrace();
    } finally {
        if (conexao != null) {
            try {
                conexao.close(); // Fecha a conexão
            } catch (SQLException e) {
                e.printStackTrace(); // Trate a exceção de fechamento de conexão
            }
        }
    }
    %>
</body>
<script>
    window.history.back();
</script>
</html>
