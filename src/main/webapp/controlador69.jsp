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

		String[] idAlunoStrings = request.getParameterValues("getId");

		String[] ad1Strings = request.getParameterValues("ad1");
		String[] aps1Strings = request.getParameterValues("aps1");
		String[] as1Strings = request.getParameterValues("as1");
		String[] aft1Strings = request.getParameterValues("aft1");
		String[] rpt1Strings = request.getParameterValues("rpt1");
		String[] trimestre1String = request.getParameterValues("unidadeum");

		String[] ad2Strings = request.getParameterValues("ad2");
		String[] aps2Strings = request.getParameterValues("aps2");
		String[] as2Strings = request.getParameterValues("as2");
		String[] aft2Strings = request.getParameterValues("aft2");
		String[] rpt2Strings = request.getParameterValues("rpt2");
		String[] trimestre2String = request.getParameterValues("unidadedois");

		String[] ad3Strings = request.getParameterValues("ad3");
		String[] aps3Strings = request.getParameterValues("aps3");
		String[] as3Strings = request.getParameterValues("as3");
		String[] aft3Strings = request.getParameterValues("aft3");
		String[] rpt3Strings = request.getParameterValues("rpt3");
		String[] trimestre3String = request.getParameterValues("unidadetres");

		String[] provaFinalStrings = request.getParameterValues("provaFinalNote");

		PreparedStatement insertNotes = null;
		for (int i = 0; i < idAlunoStrings.length; i++) {
			//trimestre um
			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 2) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(ad1Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(ad1Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 3) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(aps1Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(aps1Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 4) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(as1Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(as1Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 5) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(aft1Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(aft1Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 1, 8) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(rpt1Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(rpt1Strings[i]));
			insertNotes.execute();

			//trimestre dois
			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 2) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(ad2Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(ad2Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 3) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(aps2Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(aps2Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 4) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(as2Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(as2Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 5) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(aft2Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(aft2Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 2, 8) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(rpt2Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(rpt2Strings[i]));
			insertNotes.execute();

			//trimestre tres

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 2) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(ad3Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(ad3Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 3) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(aps3Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(aps3Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 4) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(as3Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(as3Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 5) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(aft3Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(aft3Strings[i]));
			insertNotes.execute();

			insertNotes = conexao.prepareStatement("INSERT INTO avaliacao (id_aluno, id_materia, "
			+ " id_turma, nota_tirada, unidade, id_avaliacao)  VALUES (?, ?, ?, ?, 3, 8) ON "
			+ " DUPLICATE KEY UPDATE nota_tirada = ?");
			insertNotes.setInt(1, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(2, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.setInt(3, Integer.parseInt(request.getParameter("idturma")));
			insertNotes.setDouble(4, Double.parseDouble(rpt3Strings[i]));
			insertNotes.setDouble(5, Double.parseDouble(rpt3Strings[i]));
			insertNotes.execute();

			//trimestre um media
			insertNotes = conexao.prepareStatement("UPDATE notas SET primeira_und = ?, segunda_und = ?,"
			+ "terceira_und = ?, prova_final = ? WHERE id_aluno = ? AND id_materia = ?");
			insertNotes.setDouble(1, Double.parseDouble(trimestre1String[i]));
			insertNotes.setDouble(2, Double.parseDouble(trimestre2String[i]));
			insertNotes.setDouble(3, Double.parseDouble(trimestre3String[i]));
			insertNotes.setDouble(4, Double.parseDouble(provaFinalStrings[i]));
			insertNotes.setInt(5, Integer.parseInt(idAlunoStrings[i]));
			insertNotes.setInt(6, Integer.parseInt(request.getParameter("idmateria")));
			insertNotes.executeUpdate();
		}

	%>
</body>
<script>
	window.history.back();
</script>
</html>