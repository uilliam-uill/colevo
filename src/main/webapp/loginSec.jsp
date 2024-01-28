<%@page import="javaClass.Teacher"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Evolução</title>
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
                  <img src="imagens/area-restrita.png">
                  <h4 class="mt-1 mb-5 pb-1">Colégio Evolução</h4>
                </div>
                <form method="post">
                	<p id = "bancoNaoConectado" style="color: red; display: none;"> NÃO FOI POSSIVEL SE CONECTAR AO BANCO DE DADOS, TENTE NOVAMENTE</p>
                	<p id = "senhaIncorreta" style="color: red; display: none;"> CPF E/OU SENHA ESTÃO INCORRETOS OU VAZIOS</p>
                  <p>Insira seu CPF sem caracteres</p>

                  <div class="form-outline mb-4">
                    <input type="text" id="form2Exaample111" class="form-control" id="inputCpf"
                      placeholder="Seu cpf" name="cpf-person"/>
                    <label class="form-label" for="form2Example11">CPF</label>
                  </div>

                  <div class="form-outline mb-4">
                    <input type="password" id="form2Example22" class="form-control" name="password-person" id="inputSenha"/>
                    <label class="form-label" for="form2Example22">SENHA</label>
                  </div>

                  <div class="text-center pt-1 mb-5 pb-1">
                    <button type="submit" class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" onclick="validateInputs()">Entrar</button>
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

<%  if (request.getParameter("cpf-person") != null && request.getParameter("password-person") != null &&
        request.getParameter("password-person").length() > 0 && request.getParameter("cpf-person").length() > 0) {
        Person personLogin = Person.getInstance();
        personLogin.setCpf(request.getParameter("cpf-person"));
        personLogin.setPassword(request.getParameter("password-person"));

        Connection conexao = ConectionMysql.conectar();

        if (conexao != null) {
            PreparedStatement loginPerson = null;
            ResultSet rsLoginPerson = null;
            try {
                loginPerson = conexao.prepareStatement("SELECT pessoa.id_pessoa, pessoa.nome, administrador.id_pessoa, " + 
              "  professor.id_professor, CASE WHEN " +
              "  administrador.id_pessoa IS NOT NULL THEN 'adm' WHEN professor.id_pessoa IS NOT NULL THEN 'professor' " +
              "  ELSE 'Nenhum' END AS tipo_usuario FROM pessoa 	LEFT JOIN administrador ON pessoa.id_pessoa " +
              " = administrador.id_pessoa LEFT JOIN professor ON pessoa.id_pessoa = professor.id_pessoa" +
              "  WHERE pessoa.cpf = ? AND pessoa.senha = ?;");
                loginPerson.setString(1, personLogin.getCpf());
                loginPerson.setString(2, personLogin.getPassword());

                rsLoginPerson = loginPerson.executeQuery();

                String tipo_usuario = "";
                while (rsLoginPerson.next()) {
                    tipo_usuario = rsLoginPerson.getString("tipo_usuario");
                    personLogin.setId(rsLoginPerson.getInt("id_pessoa"));
                    personLogin.setName(rsLoginPerson.getString("nome"));
                    if (tipo_usuario.equals("professor")) {
                    	 RequestDispatcher dispatcher = request.getRequestDispatcher("screenTeacher.jsp?idProfessor=" + rsLoginPerson.getInt("professor.id_professor"));
                        dispatcher.forward(request, response);
                    } else if (tipo_usuario.equals("adm")) {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("admTela.jsp?idAdm=" + rsLoginPerson.getInt("administrador.id_pessoa"));
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
                <h4 class="mb-4">Area Restritra</h4>
                <p class="small mb-0">Este espaço é destinado exclusivamente aos coordenadores e membros da secretaria. Aqui, você encontrará ferramentas e recursos específicos para facilitar suas responsabilidades administrativas.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
</html>