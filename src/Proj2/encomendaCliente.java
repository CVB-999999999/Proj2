package Proj2;

import java.sql.*;
import java.time.Instant;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class encomendaCliente {
    private int refPrato;
    private String nomePrato;
    private int idEncomenda;
    private long dataEncomenda;
    private String estado;


    // Contrutor
    public encomendaCliente() {
    }

    public int getRefPrato() {
        return refPrato;
    }

    public void setRefPrato(int refPrato) {
        this.refPrato = refPrato;
    }

    public String getNomePrato() {
        return nomePrato;
    }

    public void setNomePrato(String nomePrato) {
        this.nomePrato = nomePrato;
    }

    public int getIdEncomenda() {
        return idEncomenda;
    }

    public void setIdEncomenda(int idEncomenda) {
        this.idEncomenda = idEncomenda;
    }

    public long getDataEncomenda() {
        return dataEncomenda;
    }

    public void setDataEncomenda(long dataEncomenda) {
        this.dataEncomenda = dataEncomenda;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    /**
     * <h1> Insert na BD </h1>
     */
    public void create(){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand1 = "INSERT INTO ENCOMENDAS COLUMNS(encomendasIDEncomenda, encomendasRefPrato, encomendasNCliente, encomendasDataHora," +
                "encomendasMetodoPagamento, encomendasConfirmarRecebido) VALUES(?, ?, ?, ?, ?, ?)";
        String sqlCommand2 = "INSERT INTO DETALHEENCOMENDA COLUMNS(DETALHEENCOMENDAREFPRATO, DETALHEENCOMENDAIDENCOMENDA, DETALHEENCOMENDAPRECO, DETALHEENCOMENDAQUANTIDADE) VALUES(?, ?, ?, ?)";

        try {
            PreparedStatement st1 = conn.prepareStatement(sqlCommand1);
            PreparedStatement st2 = conn.prepareStatement(sqlCommand2);
            st1.setInt(1, this.idEncomenda);
            st1.setInt(2, this.refPrato);
            st1.setInt(3, 1234234);
            st1.setDate(4, Date.valueOf(LocalDate.now()));
            st1.setString(5, "mbway");
            st1.setString(6, "true");

            st2.setInt(1, this.refPrato);
            st2.setInt(2, this.idEncomenda);
            st2.setInt(3, 1);
            st2.setInt(4, 1);

            st1.execute();
            st2.execute();


        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler a BD </h1>
     *//*
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
                if (rs.getString("CLIENTEENDERECOLINHA1") != null) this.rua = rs.getString("CLIENTEENDERECOLINHA1");
                else this.rua = "";
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

        String sqlCommand = "SELECT ENCOMENDASIDENCOMENDA, ENCOMENDASREFPRATO, ENCOMENDASDATAHORA FROM ENCOMENDAS";

        String[][] encomenda = new String[0][];
        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);


            ResultSet rs = st.executeQuery();
            encomenda = new String[100][3];
            int i = 0;
            while (rs.next()) {

                encomenda[i][0] = (rs.getString("ENCOMENDASIDENCOMENDA"));
                if (rs.getString("ENCOMENDASREFPRATO") != null)
                    encomenda[i][1] = (rs.getString("ENCOMENDASREFPRATO"));
                if (rs.getString("ENCOMENDASDATAHORA") != null)
                    encomenda[i][2] = (rs.getString("ENCOMENDASDATAHORA"));

                i++;
            }

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }


        return encomenda;
    }

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
