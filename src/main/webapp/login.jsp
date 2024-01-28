<%@page import="javaClass.Teacher"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Col�gio Evolu��o</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/loginUser.css">
</head>
<body>
<section class="h-100 gradient-form" style="background-color: rgb(210,209,202);">

  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-xl-10">
        <div class="card rounded-3 text-black">
          <div class="row g-0">
            <div class="col-lg-6" style = "background-color: white">
              <div class="card-body p-md-5 mx-md-4" style = "background-color: white">
 
                <div class="text-center">
                  <img src="imagens/Captura_de_tela_2023-12-11_153011-removebg-preview.png"
                    style="width: 185px;" alt="logo">
                  <h4 class="mt-1 mb-5 pb-1">Col�gio Evolu��o</h4>
                </div>
                <form method="post">
                	<p id = "bancoNaoConectado" style="color: red; display: none;"> N�O FOI POSSIVEL SE CONECTAR AO BANCO DE DADOS, TENTE NOVAMENTE</p>
                	<p id = "senhaIncorreta" style="color: red; display: none;"> CPF E/OU SENHA EST�O INCORRETOS OU VAZIOS</p>
                    <p>Insira seu CPF sem caracteres</p>

                  <div class="form-outline mb-4">
                   <label class="form-label" for="form2Example11">CPF</label>
                   <input type="text" id="form2Exaample111" class="form-control" id="inputCpf"
                      placeholder="Seu cpf" name="cpf-person"/>
                  </div>

                  <div class="form-outline mb-4">
                    <label class="form-label" for="form2Example22">SENHA</label>
                    <div class="password-container">
					    <input type="password" id="form2Example22" name="password-person" class="form-control">
					    <button type="button" id="mostrarSenha" class="toggle-password btn btn-outline-info" onclick="toggleSenha()">Mostrar</button>
					</div>
					
					<div class="text-center pt-1 mb-5 pb-1">
                    	<button type="submit" class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" onclick="validateInputs()">Entrar</button>
                  	</div>
                  
                 </div>
                </form>
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
    if (request.getParameter("cpf-person") != null && request.getParameter("password-person") != null &&
        request.getParameter("password-person").length() > 0 && request.getParameter("cpf-person").length() > 0) {
        Person personLogin = Person.getInstance();
        personLogin.setCpf(request.getParameter("cpf-person"));
        personLogin.setPassword(request.getParameter("password-person"));

        Connection conexao = ConectionMysql.conectar();

        if (conexao != null) {
            PreparedStatement loginPerson = null;
            ResultSet rsLoginPerson = null;
            try {
                loginPerson = conexao.prepareStatement("SELECT pessoa.id_pessoa, pessoa.senha, pessoa.nome, pais.id_pai,aluno.id_aluno," +
               " CASE WHEN pais.id_pai IS NOT NULL THEN 'Pai' WHEN aluno.id_pessoa IS NOT NULL THEN 'Aluno' " + 
               " ELSE 'Nenhum' END AS tipo_usuario FROM pessoa LEFT JOIN pais ON pessoa.id_pessoa = pais.id_pessoa " +
               " LEFT JOIN aluno ON pessoa.id_pessoa = aluno.id_pessoa 	" +
               "WHERE pessoa.cpf = ? AND pessoa.senha = ?;");
                loginPerson.setString(1, personLogin.getCpf());
                loginPerson.setString(2, personLogin.getPassword());

                rsLoginPerson = loginPerson.executeQuery();

                String tipo_usuario = "";
                while (rsLoginPerson.next()) {
                    tipo_usuario = rsLoginPerson.getString("tipo_usuario");
                    
                    personLogin.setName(rsLoginPerson.getString("nome"));
                    if (tipo_usuario.equals("Pai")) {
                    	personLogin.setId(rsLoginPerson.getInt("id_pai"));
                        RequestDispatcher dispatcher = request.getRequestDispatcher("telaPai.jsp?idProfessor=" + personLogin.getId());
                        dispatcher.forward(request, response);
                    } else if (tipo_usuario.equals("Aluno")) {
                    	personLogin.setId(rsLoginPerson.getInt("id_aluno"));
                        RequestDispatcher dispatcher = request.getRequestDispatcher("screenStudent.jsp?idAluno=" + personLogin.getId() +
                        "&nomeAluno=" +	rsLoginPerson.getString("nome"));
                        dispatcher.forward(request, response);
                    }
                }
                if(!rsLoginPerson.next()){%>
                 <script>
          			document.getElementById('senhaIncorreta').style.display = 'block';
       			 </script>
                <%}
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
            	ConectionMysql.closeConnection(conexao, loginPerson, rsLoginPerson);
            }
        } else {%>
        <script>
  			document.getElementById('bancoNaoConectado').style.display = 'block';
  		</script>
        <%}
    }
%>
              </div>
            </div>
            <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
              <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                <h4 class="mb-4">Tela Login</h4>
                <p class="small mb-0">Nossa tela de login diferencia o acesso para professores lan�arem notas e alunos visualizarem seu desempenho. Professores t�m acesso exclusivo para inserir informa��es precisas, enquanto os alunos podem facilmente conferir suas notas, oferecendo transpar�ncia e acompanhamento direto do progresso acad�mico.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
<script>
function toggleSenha() {
    var senhaInput = document.getElementById("form2Example22");
    var mostrarSenhaBtn = document.getElementById("mostrarSenha");

    if (senhaInput.type === "password") {
        senhaInput.type = "text";
        mostrarSenhaBtn.textContent = "Ocultar";
    } else {
        senhaInput.type = "password";
        mostrarSenhaBtn.textContent = "Mostrar";
    }
}

</script>
</html>