package proj2.web;

import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class menu {
    private int nMenu;
    private String nome;
    private String descricao;
    private float pCusto;
    private float pVenda;
    private Date dAtualizacao;
    private Date dCriacao;
    private int nEncomendas;

    public menu() {
    }

    public int getnMenu() { return nMenu;  }

    public void setnMenu(int nMenu) { this.nMenu = nMenu;   }

    public String getNome() {  return nome;  }

    public void setNome(String nome) { this.nome = nome; }

    public String getDescricao() { return descricao; }

    public void setDescricao(String descricao) { this.descricao = descricao; }

    public float getpCusto() {return pCusto;}

    public void setpCusto(float pCusto) {this.pCusto = pCusto; }

    public float getpVenda() {return pVenda;}

    public void setpVenda(float pVenda) {this.pVenda = pVenda;}

    public Date getdAtualizacao() {return dAtualizacao;}

    public void setdAtualizacao(Date dAtualizacao) {this.dAtualizacao = dAtualizacao;}

    public Date getdCriacao() { return dCriacao; }

    public void setdCriacao(Date dCriacao) {this.dCriacao = dCriacao;}

    public int getnEncomendas() { return nEncomendas; }

    public void setnEncomendas(int nEncomendas) { this.nEncomendas = nEncomendas; }


    /**
     * <h1> Insert na BD </h1>
     */
    public void create(String nomeC){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "INSERT INTO MENU COLUMNS(menuNome, menuDescricao, menuPrecoCusto," +
                "menuPrecoPVP, menuDataAtualizacao, menuDataCriacao) VALUES(?, ?, ?, ?, (select sysdate from dual), (select sysdate from dual))";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setString(1, nomeC);
            st.setString(2, "Descricao");
            st.setFloat(3, 999999);
            st.setFloat(4, 999999);

            st.execute();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler a BD </h1>
     */
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
                System.out.println("ERRO: Não existe menu com o ID definido ");
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler todos os registos de menus </h1>
     */
    public static String[][] readAll() {
        Connection conn = util.criarConexao();
        String[][] lista = new String[0][4];

        String sqlCommand = "SELECT menuRefPrato, menuNome, menuDescricao, menuPrecoPVP FROM Menu where EmUso IS NULL";
        String count = "SELECT COUNT(*) as n FROM Menu where EmUso IS NULL";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);

            PreparedStatement ts = conn.prepareStatement(count);
            ResultSet ss = ts.executeQuery();
            ss.next();
            int n = ss.getInt("n");

            lista = new String[n][4];
            ResultSet rs = st.executeQuery();

            int i = 0;
            while (rs.next()) {

                lista[i][0] = (rs.getString("menuRefPrato"));

                if (rs.getString("menuNome") != null) {
                    lista[i][1] = (rs.getString("menuNome"));
                }
                if (rs.getString("menuDescricao") != null) {
                    lista[i][3] = (rs.getString("menuDescricao"));
                }
                if (rs.getString("menuPrecoPVP") != null) {
                    lista[i][2] = (rs.getString("menuPrecoPVP"));
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
