package javaClass;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;


public class ConectionMysql {private static Connection conexao = null;

public static Connection conectar() {
    try {
        if (conexao == null || conexao.isClosed()) {
            Class.forName("com.mysql.jdbc.Driver");
            Properties prop = new Properties();
            InputStream input = new FileInputStream("C://Users//uilli//eclipse-workspace//ColegioEvolucao//src//main//java//javaClass//db.properties/");
            prop.load(input);

            String url = prop.getProperty("url");
            String usuario = prop.getProperty("usuario");
            String senha = prop.getProperty("senha");

            conexao = DriverManager.getConnection(url, usuario, senha);
        }
    } catch (IOException | SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    return conexao;
}

public static void closeConnection(Connection conexao, Statement statement, ResultSet resultSet) {
    try {
        if (resultSet != null) {
            resultSet.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (conexao != null) {
            conexao.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
}