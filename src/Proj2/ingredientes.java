package Proj2;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class ingredientes {
    private int ref;
    private String nome;
    private int nfunc;
    private int qtdAtual;
    private float qtdMin;
    private Date dAtualizacao;

    public ingredientes() {
    }

    /**
     * <h1> Insert na BD </h1>
     *//*
    public void create(){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "INSERT INTO MENU COLUMNS(menuRefPrato, menuNome, menuDescricao, menuPrecoCusto," +
                "menuPrecoPVP, menuDataAtualizacao, menuDataCriacao, menuNEncomendas) VALUES(?, ?, ?, ?, ?, ?, NOW(), ?)";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, this.nMenu);
            st.setString(2, this.nome);
            st.setString(3, this.descricao);
            st.setFloat(4, this.pCusto);
            st.setFloat(5, this.pVenda);
            st.setDate(6, (java.sql.Date) this.dAtualizacao);
            st.setInt(7, this.nEncomendas);

            st.execute();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }*/

    /**
     * <h1> Ler a BD </h1>
     *//*
    public void read(int nMenu){
        Connection conn = util.criarConexao();

        String sqlCommand = "SELECT * FROM MENU WHERE menuRefPrato = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, nMenu);

            ResultSet rs = st.executeQuery();

            if(rs.next()){
                this.nMenu = nMenu;
                if (rs.getString("menuNome") != null) this.nome = rs.getString("menuNome");
                else this.nome = "";
                if (rs.getString("menuDescricao") != null) this.descricao = rs.getString("menuDescricao");
                else this.descricao = "";
            }
            else{
                System.out.println("ERRO: Não existe Cliente com o ID definido ");
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }*/

    /**
     * <h1> Ler todos os registos de ingredientes </h1>
     *
     * @return lista com: | 1 : Ref Produto | 2 : Nome Produto
     */
    public static String[][] readAll() {
        Connection conn = util.criarConexao();
        String[][] lista = new String[0][4];

        String sqlCommand = "SELECT materiaPrimaRefProduto, materiaPrimaNome, materiaPrimaQuantidadeAtual, materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao FROM materiaPrima";
        String count = "SELECT COUNT(*) as n FROM materiaPrima";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);

            PreparedStatement ts = conn.prepareStatement(count);
            ResultSet ss = ts.executeQuery();
            ss.next();
            int n = ss.getInt("n");

            lista = new String[n][5];
            ResultSet rs = st.executeQuery();

            int i = 0;
            while (rs.next()) {

                lista[i][0] = (rs.getString("materiaPrimaRefProduto"));

                if (rs.getString("materiaPrimaNome") != null) {
                    lista[i][1] = (rs.getString("materiaPrimaNome"));
                }
                if (rs.getString("materiaPrimaQuantidadeAtual") != null) {
                    lista[i][2] = (rs.getString("materiaPrimaQuantidadeAtual"));
                }
                if (rs.getString("materiaPrimaQuantidadeMinima") != null) {
                    lista[i][3] = (rs.getString("materiaPrimaQuantidadeMinima"));
                }
                if (rs.getString("materiaPrimaDataHoraVerificacao") != null) {
                    lista[i][4] = (rs.getString("materiaPrimaDataHoraVerificacao"));
                }

                i++;
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
        return lista;
    }

    /**
     * <h1> Ler todos os registos de ingredientes de cada prato </h1>
     *
     * @param id - id do prato a buscar os ingredientes
     * @return lista - 1 : Ref Produto - 2 : Nome Produto
     */
    public static ArrayList<String[]> readIngPrato(int id) {
        Connection conn = util.criarConexao();
        ArrayList<String[]> lista = new ArrayList<>();

        String sqlCommand = "SELECT idProduto, nomeProduto, quantidade FROM materiaisPrato WHERE idPrato = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, id);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                String[] aux = new String[3];

                if (rs.getString("idProduto") != null) {
                    aux[0] = (rs.getString("idProduto"));
                }
                if (rs.getString("nomeProduto") != null) {
                    aux[1] = (rs.getString("nomeProduto"));
                }
                if (rs.getString("quantidade") != null) {
                    aux[2] = (rs.getString("quantidade"));
                }
                lista.add(aux);
            }
        } catch (SQLException ex) {
            System.out.println("ERRO - readIngPrato: " + ex.getMessage());
        }
        return lista;
    }

    /**
     * <h1> "Remover" da BD um menu </h1>
     * \p Faz update da variavel em uso para marcar o prato como "removido"
     *
     * @param id - menuRefPrato da linha a remover
     */
    public static void remove(int id){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "UPDATE menu SET EmUso = 1 WHERE menuRefPrato = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, id);
            st.executeQuery();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Update ingrediente</h1>
     */

    public static void updateIngrediente(int idProduto, int qtdAtual, int qtdMin) {
        Connection conn = util.criarConexao();

        String sqlCommand = "UPDATE materiaPrima SET materiaPrimaQuantidadeAtual=?, materiaPrimaQuantidadeMinima=?, materiaPrimaDataHoraVerificacao=(select sysdate from dual) WHERE materiaPrimaRefProduto=?";

        try {
            PreparedStatement st1 = conn.prepareStatement(sqlCommand);

            st1.setInt(1, qtdAtual);
            st1.setInt(2, qtdMin);
            st1.setInt(3, idProduto);

            st1.execute();
            conn.commit();

        } catch (SQLException ex) {
            System.out.println("ERRO updateEstado: " + ex.getMessage());
        }
    }
}
