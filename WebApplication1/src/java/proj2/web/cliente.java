package proj2.web;

import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class cliente {
    private int idCliente;
    private String nome;
    private String telemovel;
    private int nif;
    private String rua;
    private String email;
    private String codPostal;
    private String pass;
    private String end1;
    private String end2;
    private String cidade;

    // Contrutor
    public cliente() {
    }

    public String getEnd1() {
        return end1;
    }

    public void setEnd1(String end1) {
        this.end1 = end1;
    }

    public String getEnd2() {
        return end2;
    }

    public void setEnd2(String end2) {
        this.end2 = end2;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    // Getters e Setters
    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTelemovel() {
        return telemovel;
    }

    public void setTelemovel(String telemovel) {
        this.telemovel = telemovel;
    }

    public int getNif() {
        return nif;
    }

    public void setNif(int nif) {
        this.nif = nif;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCodPostal() {
        return codPostal;
    }

    public void setCodPostal(String codPostal) {
        this.codPostal = codPostal;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    /**
     * <h1> Insert na BD </h1>
     */
    public void create(){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "INSERT INTO CLIENTE COLUMNS(clienteNCliente, clienteNome, clienteEmail, clienteTelemovel," +
                "clienteEnderecoLinha1, clienteEnderecoLinha2, clienteCidade, clienteCodigoPostal, clientePass) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, this.idCliente);
            st.setString(2, this.nome);
            st.setString(3, this.email);
            st.setString(4, this.telemovel);
            st.setString(5, this.end1);
            st.setString(6, this.end2);
            st.setString(7, this.cidade);
            st.setString(8, this.codPostal);
            st.setString(9, this.pass);

            st.execute();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler a BD </h1>
     */
    public void read(int idCliente1){
        Connection conn = util.criarConexao();

        //String sqlCommand = "SELECT CLIENTENOME, CLIENTEENDERECOLINHA1, CLIENTECODIGOPOSTAL FROM CLIENTE WHERE CLIENTENCLIENTE = ?";
        String sqlCommand = "SELECT * FROM CLIENTE WHERE CLIENTENCLIENTE = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, idCliente1);

            ResultSet rs = st.executeQuery();

            if(rs.next()){
                this.idCliente = idCliente1;
                if (rs.getString("CLIENTENOME") != null) this.nome = rs.getString("CLIENTENOME");
                else this.nome = "";
                if (rs.getString("CLIENTEENDERECOLINHA1") != null) this.end1 = rs.getString("CLIENTEENDERECOLINHA1");
                else this.end1 = "";
                if (rs.getString("CLIENTECODIGOPOSTAL") != null) this.codPostal = rs.getString("CLIENTECODIGOPOSTAL");
                else this.codPostal = "";
            }
            else{
                System.out.println("ERRO: Não existe Cliente com o ID definido ");
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler todos os registos de clientes </h1>
     */
    public static String[][] readAll() {
        Connection conn = util.criarConexao();

        String sqlCommand = "SELECT clienteNCliente, clienteNome, clienteEmail, clienteTelemovel FROM cliente";
        String count = "SELECT COUNT(*) as n FROM cliente";

        String[][] cliente = new String[0][];
        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);

            //  Conta as linhas que vao resultar da query
            PreparedStatement ts = conn.prepareStatement(count);
            ResultSet ss = ts.executeQuery();
            ss.next();
            int n = ss.getInt("n");

            n=100;
            ResultSet rs = st.executeQuery();
            cliente = new String[n][4];
            int i = 0;
            while (rs.next()) {


                cliente[i][0] = (rs.getString("clienteNCliente"));

                if (rs.getString("clienteNome") != null) {
                    cliente[i][1] = (rs.getString("clienteNome"));
                }
                if (rs.getString("clienteEmail") != null) {
                    cliente[i][2] = (rs.getString("clienteEmail"));
                }
                if (rs.getString("clienteTelemovel") != null) {
                    cliente[i][3] = (rs.getString("clienteTelemovel"));
                }
                i++;
            }

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }

        return cliente;
    }
    /*
    public static List<Cliente> readAll(){
        Connection conn = Util.criarConexao();

        String sqlCommand = "";

        List<Cliente> lista = new ArrayList<>();

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);


            ResultSet rs = st.executeQuery();

            while(rs.next()){
                Cliente cli = new Cliente();

                cli.setIdCliente(rs.getInt("clienteNCliente"));
                if (rs.getString("clienteNome") != null) cli.setNome(rs.getString("clienteNome"));
                //
                if (rs.getString("clienteEmail") != null) cli.setEmail(rs.getString("clienteEmail"));
                //
                if (rs.getString("clienteTelemovel") != null) cli.setTelemovel(rs.getString("clienteTelemovel"));

                lista.add(cli);
            }

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }

        return lista;
    }*/

    /**
     * <h1> Ler todos os registos de clientes parecidos com x </h1>
     *//*
    public static List<Cliente> readAll(String nome){
        Connection conn = util.criarConexao();

        String sqlCommand = "SELECT IDCLIENTE, NOME, MORADA, CPOSTAL FROM CLIENTE1 WHERE NOME LIKE ?";

        List<Cliente> lista = new ArrayList<>();

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setString(1, "%"+nome+"%");

            ResultSet rs = st.executeQuery();

            while(rs.next()){
                Cliente cli = new Cliente();

                cli.setIdCliente(rs.getInt("IDCLIENTE"));
                if (rs.getString("NOME") != null) cli.setNome(rs.getString("NOME"));
                //
                if (rs.getString("MORADA") != null) cli.setMorada(rs.getString("MORADA"));
                //
                if (rs.getString("CPOSTAL") != null) cli.setCpostal(rs.getString("CPOSTAL"));

                lista.add(cli);
            }

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }

        return lista;
    }

    /**
     * <h1> Update registos de clientes </h1>
     *//*
    public void update(){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "UPDATE CLIENTE1 SET NOME = ?, MORADA = ?, CPOSTAL = ? WHERE IDCLIENTE = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setString(1, this.nome);
            st.setString(2, this.morada);
            st.setString(3, this.cpostal);
            st.setInt(4, this.idCliente);

            st.execute();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Apagar registos de clientes </h1>
     *//*
    public void delete(){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "DELETE CLIENTE1 WHERE IDCLIENTE = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, this.idCliente);

            st.execute();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }*/
}
