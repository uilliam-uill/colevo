<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Colégio Aluno - Ficha Aluno</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style/screenTeacher.css">
<link rel="stylesheet" type="text/css" href="style/studentToken.css">
<link rel="stylesheet" type="text/css" href="style/controlNotes.css">
<link rel="stylesheet" type="text/css" href="style/planoAula.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    if (performance.navigation.type === 2) {
        // A página foi acessada pelo histórico, então recarrega
        window.location.reload();
    }
</script>

</head>

<body>
	<div class="header">
		<div class="icons">

			<h1 style="color: white">Troca de Senha</h1>
		</div>
	</div>
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

	<div class="container">
    <div class="col-md-6 mx-auto" id="cardBlue">
        <div class="card shadow border">
            <div class="card-body d-flex flex-column align-items-center">
                <div class="alert alert-danger" id="preenchaCampos" role="alert" style="display: none;">
                    Preencha Todos o Campos!
                </div>
                
                <div class="alert alert-danger" id="senhasDiferentes" role="alert" style="display: none;">
                    Senhas não são iguais!
                </div>
                <h3 class="titleNota">Atualize Sua Senha</h3>

                <label for="idAula">Insira sua senha antiga</label>
                
                <div class="inputOcultsenha">
	                <input type="password" id="senha1" class="form-control" name="senha1" >
                </div>
                
                <label for="idMateria">Nova senha</label>
                
                <div class="inputOcultsenha">
                	<input type="password" id="senha2" class="form-control" name="idMateria" id="senha2" >
                </div>
                <label for="dataAula">Confirme a nova senha</label>
                <div class="inputOcultsenha">
                	<input type="password" id="senha3" class="form-control" name="senhaNova">
                	<button type="button" id="mostrarSenha" class="toggle-password btn btn-outline-info" onclick="toggleSenhas()">Mostrar</button>
				</div>
                <button type="submit" class="btn btn-success btn-block mt-3" onclick="getSenhas()">Salvar Senha</button>
            </div>
        </div>
    </div>
</div>
<%
Connection conexao = ConectionMysql.conectar();
	if(conexao != null){
		PreparedStatement stMs = null;
		ResultSet rsMs = null;
	}
%>
</body>
<script>
function toggleSenhas() {
    var camposSenha = document.querySelectorAll('.form-control');
    var mostrarSenhaBtn = document.getElementById("mostrarSenha");

    camposSenha.forEach(function(senhaInput) {
        if (senhaInput.type === 'password') {
            senhaInput.type = 'text';
            mostrarSenhaBtn.textContent = "Ocultar";
        } else {
            senhaInput.type = 'password';
            mostrarSenhaBtn.textContent = "Mostrar";
        }
    });
}

function getSenhas() {
    var senha1 = document.getElementById('senha1').value;
    var senha2 = document.getElementById('senha2').value;
    var senhaNova = document.getElementById('senha3').value;

    var alertPC = document.getElementById('preenchaCampos');
    var alertSD = document.getElementById('senhasDiferentes');

    if ((!senha1 || senha1.length === 0) ||
        (!senha2 || senha2.length === 0) ||
        (!senhaNova || senhaNova.length === 0)) {
        alertPC.style.display = 'block';
    }else{
    	alertPC.style.display = 'none';
    }
    	if (senha2 !== senhaNova) {
        alertSD.style.display = 'block';
    } else {
    	alertSD.style.display = 'none';
    }

    return true;
}


</script>
</html>