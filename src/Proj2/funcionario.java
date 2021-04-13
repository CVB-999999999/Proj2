package Proj2;

import java.util.Date;

import java.sql.*;

public class funcionario {

    private int idFunc;
    private String nome;
    private String funcao;
    private Date dataAdmissao;

    public funcionario(){}

    public int getIdFunc() {return idFunc;}

    public void setIdFunc(int idFunc) {this.idFunc = idFunc;}

    public String getNome() {return nome;}

    public void setNome(String nome) {this.nome = nome;    }

    public String getFuncao() {return funcao;}

    public void setFuncao(String funcao) {this.funcao = funcao;}

    public Date getDataAdmissao() {return dataAdmissao;}

    public void setDataAdmissao(Date dataAdmissao) {this.dataAdmissao = dataAdmissao;}

    /**
     * <h1> Insert na BD </h1>
     */
    public void create(){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "INSERT INTO FUNCIONARIOS COLUMNS(funcionariosCodFuncionario, funcionariosNome, funcionariosFuncao, funcionariosDataAdmissao) VALUES(?, ?, ?, NOW())";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, this.idFunc);
            st.setString(2, this.nome);
            st.setString(3, this.funcao);

            st.execute();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler a BD Funcionari especifico</h1>
     */
    public void read(int idFunc){
        Connection conn = util.criarConexao();

        String sqlCommand = "SELECT * FROM FUNCIONARIOS WHERE funcionariosCodFuncionario = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, idFunc);

            ResultSet rs = st.executeQuery();

            if(rs.next()){
                this.idFunc = idFunc;
                if (rs.getString("funcionariosNome") != null) this.nome = rs.getString("funcionariosNome");
                else this.nome = "";
                if (rs.getString("funcionariosFuncao") != null) this.funcao = rs.getString("funcionariosFuncao");
                else this.funcao = "";
                if (rs.getDate("funcionariosDataAdmissao") != null) this.dataAdmissao = rs.getDate("funcionariosDataAdmissao");

            }
            else{
                System.out.println("ERRO: Não existe Funcionario com o ID definido ");
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

}
