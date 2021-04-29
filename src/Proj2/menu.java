package Proj2;

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
                System.out.println("ERRO: Não existe Cliente com o ID definido ");
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler todos os registos de clientes </h1>
     *//*
    public static List<Menu> readAll(){
        Connection conn = Util.criarConexao();

        String sqlCommand = "SELECT menuRefPrato, menuNome, menuDescricao, menuPrecoPVP FROM Menu";

        List<Menu> lista = new ArrayList<>();

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);


            ResultSet rs = st.executeQuery();

            while(rs.next()){
                Menu mn = new Menu();

                Menu.setnMenu(rs.getInt("menuRefPrato"));
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
    }*/
}
