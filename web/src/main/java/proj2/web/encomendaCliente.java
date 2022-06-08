package proj2.web;

import java.sql.*;
import java.time.LocalDate;

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
     * @return
     */
    public String[] read(int idEncomenda){
        Connection conn = util.criarConexao();
        String[] encomenda = new String[5];

        String sqlCommand = "SELECT idEncomenda, menu, quantidade, datahora, estado FROM mostraDetalhes WHERE idEncomenda = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, idEncomenda);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                encomenda[0] = (rs.getString("idEncomenda"));

                if (rs.getString("menu") != null) {
                    encomenda[1] = (rs.getString("menu"));
                }
                if (rs.getString("quantidade") != null) {
                    encomenda[2] = String.valueOf((rs.getInt("quantidade")));
                }
                if (rs.getString("datahora") != null) {
                    encomenda[3] = (rs.getString("datahora"));
                }
                if (rs.getString("estado") != null) {
                    encomenda[4] = (rs.getString("estado"));
                }
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
        return encomenda;
    }

    /**
     * <h1> Ler todos os registos de encomendas </h1>
     */
    public static String[][] readAll() {
        Connection conn = util.criarConexao();

        /*String sqlCommand = "SELECT idEncomenda, menu, quantidade, datahora, estado FROM mostraDetalhes";
        String count = "SELECT COUNT(*) as n FROM mostraDetalhes";*/

        String sqlCommand = "SELECT idEncomenda, menu, quantidade, datahora, idEstado FROM mostraDetalhes1";
        String count = "SELECT COUNT(*) as n FROM mostraDetalhes1";

        String[][] encomenda = new String[0][];
        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);

            //  Conta as linhas que vao resultar da query
            PreparedStatement ts = conn.prepareStatement(count);
            ResultSet ss = ts.executeQuery();
            ss.next();
            int n = ss.getInt("n");

            ResultSet rs = st.executeQuery();
            encomenda = new String[n][6];
            int i = 0;
            while (rs.next()) {

                encomenda[i][0] = (rs.getString("idEncomenda"));

                if (rs.getString("menu") != null) {
                    encomenda[i][1] = (rs.getString("menu"));
                }
                if (rs.getString("quantidade") != null) {
                    encomenda[i][2] = String.valueOf((rs.getInt("quantidade")));
                }
                if (rs.getString("datahora") != null) {
                    encomenda[i][3] = (rs.getString("datahora"));
                }
                /*if (rs.getString("idEstado") != null) {
                    encomenda[i][4] = (rs.getString("idEstado"));
                }*/
                switch(rs.getInt("idEstado")){
                    case 1: {
                        encomenda[i][4] = "Pendente";
                        break;
                    }
                    case 2: {
                        encomenda[i][4] = "Confirmado";
                        break;
                    }
                    case 3: {
                        encomenda[i][4] = "Em preparação";
                        break;
                    }
                }

               i++;
            }

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }

        return encomenda;
    }

    /**
     * <h1> Update estado do pedido</h1>
     */

    public static void updateEstado(String idEncomenda, int codFunc, int tipo) {
        Connection conn = util.criarConexao();

        String sqlCommand = "INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) " +
                "VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement st1 = conn.prepareStatement(sqlCommand);

            st1.setDate(1, Date.valueOf(LocalDate.now()));
            st1.setInt(2, Integer.parseInt(idEncomenda));
            st1.setInt(3, tipo);
            st1.setInt(4, codFunc);


            st1.execute();
            conn.commit();
            System.out.println("Estado updated");

        } catch (SQLException ex) {
            System.out.println("ERRO updateEstado: " + ex.getMessage());
        }
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
