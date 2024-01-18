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
<%@ page import="javaClass.Teacher"%>
<%@ page import="javaClass.ConectionMysql"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conexao = ConectionMysql.conectar();
	conexao.setAutoCommit(false);
	try {
		String[] idAlunoStrings = request.getParameterValues("getId");

		String[] ad1Strings = request.getParameterValues("ad1");
		String[] aps1Strings = request.getParameterValues("aps1");
		String[] sas11Strings = request.getParameterValues("sas11");
		String[] sas21Strings = request.getParameterValues("sas21");
		String[] rpt1Strings = request.getParameterValues("rpt1");
		String[] trimestre1String = request.getParameterValues("unidadeum");

		String[] ad2Strings = request.getParameterValues("ad2");
		String[] aps2Strings = request.getParameterValues("aps2");
		String[] sas12Strings = request.getParameterValues("sas12");
		String[] sas22Strings = request.getParameterValues("sas22");
		String[] rpt2Strings = request.getParameterValues("rpt2");
		String[] trimestre2String = request.getParameterValues("unidadedois");

		String[] ad3Strings = request.getParameterValues("ad3");
		String[] aps3Strings = request.getParameterValues("aps3");
		String[] sas13Strings = request.getParameterValues("sas13");
		String[] sas23Strings = request.getParameterValues("sas23");
		String[] rpt3Strings = request.getParameterValues("rpt3");
		String[] trimestre3String = request.getParameterValues("unidadetres");

		String[] provaFinalStrings = request.getParameterValues("provaFinalNote");

		PreparedStatement insertNotes = null;
		PreparedStatement insertNotesTrimestres = null;
		for (int i = 0; i < idAlunoStrings.length; i++) {
			try {
		//trimestre um
		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 2) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(ad1Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(ad1Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 3) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(aps1Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(aps1Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 6) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(sas11Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(sas11Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 7) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(sas21Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(sas21Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 8) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(rpt1Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(rpt1Strings[i].replace(",", ".")));
		insertNotes.execute();

		Double triUm = Double.parseDouble(ad1Strings[i].replace(",", ".")) + Double.parseDouble(aps1Strings[i].replace(",", "."))
				+ Double.parseDouble(sas11Strings[i].replace(",", ".")) + Double.parseDouble(sas21Strings[i].replace(",", "."))
				+ Double.parseDouble(rpt1Strings[i].replace(",", "."));
		//trimestre dois
		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 2) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(ad2Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(ad2Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 3) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(aps2Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(aps2Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 6) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(sas12Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(sas12Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 7) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(sas22Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(sas22Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 8) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(rpt2Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(rpt2Strings[i].replace(",", ".")));
		insertNotes.execute();

		Double triDois = Double.parseDouble(ad2Strings[i].replace(",", ".")) + Double.parseDouble(aps2Strings[i].replace(",", "."))
				+ Double.parseDouble(sas12Strings[i].replace(",", ".")) + Double.parseDouble(sas22Strings[i].replace(",", "."))
				+ Double.parseDouble(rpt2Strings[i].replace(",", "."));
		//trimestre tres

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 2) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(ad3Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(ad3Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 3) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(aps3Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(aps3Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 6) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(sas13Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(sas13Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 7) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(sas23Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(sas23Strings[i].replace(",", ".")));
		insertNotes.execute();

		insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
				+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 8) ON "
				+ " DUPLICATE KEY UPDATE nota_tirada = ?");
		insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
		insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
		insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
		insertNotes.setDouble(4, Double.parseDouble(rpt3Strings[i].replace(",", ".")));
		insertNotes.setDouble(5, Double.parseDouble(rpt3Strings[i].replace(",", ".")));
		insertNotes.execute();
		Double triTres = Double.parseDouble(ad3Strings[i].replace(",", ".")) + Double.parseDouble(aps3Strings[i].replace(",", "."))
				+ Double.parseDouble(sas23Strings[i].replace(",", ".")) + Double.parseDouble(sas13Strings[i].replace(",", "."))
				+ Double.parseDouble(rpt3Strings[i].replace(",", "."));

		//trimestre um media
		if(triUm == 5.9){
			triUm = 6.0;
		}
		
		if(triDois == 5.9){
			triDois = 6.0;
		}
		
		if(triTres == 5.9){
			triTres = 6.0;
		}
		Double media_soma = Double.parseDouble(trimestre1String[i]) + Double.parseDouble(trimestre2String[i])
				+ Double.parseDouble(trimestre3String[i]);
		Double media_total = media_soma / 3;
		if (media_total >= 5.7 || media_total <= 5.9) {
			media_total = 6.0;
		}
		boolean aprovacao = false;
		if (media_total >= 6.0 || Double.parseDouble(provaFinalStrings[i]) >= 5.0) {
			aprovacao = true;
		} else {
			aprovacao = false;
		}

		insertNotesTrimestres = conexao.prepareStatement("UPDATE notas SET primeira_und = ?, segunda_und = ?,"
				+ " terceira_und = ?, prova_final = ?, nota_final = ?, media_nota = ?, aprovado = ? WHERE id_aluno = ? AND id_materia = ?");
		insertNotesTrimestres.setDouble(1, triUm);
		insertNotesTrimestres.setDouble(2, triDois);
		insertNotesTrimestres.setDouble(3, triTres);
		insertNotesTrimestres.setDouble(4, Double.parseDouble(provaFinalStrings[i]));
		insertNotesTrimestres.setDouble(5, media_soma);
		insertNotesTrimestres.setDouble(6, media_total);
		insertNotesTrimestres.setBoolean(7, aprovacao);
		insertNotesTrimestres.setInt(8, Integer.parseInt(idAlunoStrings[i]));
		insertNotesTrimestres.setInt(9, Integer.parseInt(request.getParameter("idmateria")));
		insertNotesTrimestres.executeUpdate();
		System.out.print(Double.parseDouble(provaFinalStrings[i]));
		insertNotes.close();
		insertNotesTrimestres.close();
			} catch (SQLException ex) {
		// Tratamento de erro específico para o loop
		ex.printStackTrace();
			}
		}

		conexao.commit();
	} catch (SQLException e) {
		if (conexao != null) {
			try {
		conexao.rollback(); // Desfaz as alterações em caso de erro
			} catch (SQLException ex) {
		ex.printStackTrace(); // Trate a exceção de rollback
			}
		}
		e.printStackTrace(); // Trate a exceção principal
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