package Proj2;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class diversosEstados {
    private int idEstado;
    private String nome;
    private String descricao;

    public diversosEstados() {
    }

    public int getIdEstado() {return idEstado; }

    public void setIdEstado(int idEstado) {  this.idEstado = idEstado; }

    public String getNome() { return nome; }

    public void setNome(String nome) { this.nome = nome;}

    public String getDescricao() {return descricao;}

    public void setDescricao(String descricao) {this.descricao = descricao;}

    /**
     * <h1> Ler a BD </h1>
     */
    public void read(int idEstado){
        Connection conn = util.criarConexao();

        String sqlCommand = "SELECT * FROM diversosEstados WHERE diversosEstadosIDEstado = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, idEstado);

            ResultSet rs = st.executeQuery();

            if(rs.next()){
                this.idEstado = idEstado;
                if (rs.getString("diversosEstadosNome") != null) this.nome = rs.getString("diversosEstadosNome");
                else this.nome = "";
                if (rs.getString("diversosEstadosDescricao") != null) this.descricao = rs.getString("diversosEstadosDescricao");
                else this.descricao = "";
            }
            else{
                System.out.println("ERRO: Não existe Estado com o ID definido ");
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }
}
