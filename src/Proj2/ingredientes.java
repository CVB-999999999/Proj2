package Proj2;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
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
     * @return lista - 1 : Ref Produto - 2 : Nome Produto
     */
    public static String[][] readAll() {
        Connection conn = util.criarConexao();
        String[][] lista = new String[0][4];

        String sqlCommand = "SELECT materiaPrimaRefProduto, materiaPrimaNome FROM materiaPrima";
        String count = "SELECT COUNT(*) as n FROM materiaPrima";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);

            PreparedStatement ts = conn.prepareStatement(count);
            ResultSet ss = ts.executeQuery();
            ss.next();
            int n = ss.getInt("n");

            lista = new String[n][2];
            ResultSet rs = st.executeQuery();

            int i = 0;
            while (rs.next()) {

                lista[i][0] = (rs.getString("materiaPrimaRefProduto"));

                if (rs.getString("materiaPrimaNome") != null) {
                    lista[i][1] = (rs.getString("materiaPrimaNome"));
                }
                i++;
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
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
}
