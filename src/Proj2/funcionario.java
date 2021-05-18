package Proj2;

import java.util.Date;

import java.sql.*;

public class funcionario {

    private int idFunc;
    private String nome;
    private String funcao;
    private long dataAdmissao;
    private Boolean existeFunc;

    public funcionario(){}

    public int getIdFunc() {return idFunc;}

    public void setIdFunc(int idFunc) {this.idFunc = idFunc;}

    public String getNome() {return nome;}

    public void setNome(String nome) {this.nome = nome;    }

    public String getFuncao() {return funcao;}

    public void setFuncao(String funcao) {this.funcao = funcao;}

    public long getDataAdmissao() {return dataAdmissao;}

    public void setDataAdmissao(long dataAdmissao) {this.dataAdmissao = dataAdmissao;}

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
     * <h1> Ler a BD Funcionario especifico</h1>
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
                if (rs.getString("funcionariosDataAdmissao") != null) this.dataAdmissao = rs.getLong("funcionariosDataAdmissao");
                existeFunc = Boolean.TRUE;

            }
            else{
                System.out.println("ERRO: Não existe Funcionario com o ID definido ");
                existeFunc = Boolean.FALSE;
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
            existeFunc = Boolean.FALSE;
        }
    }

    /**
     * <h1> Ler todos os registos de funcionarios </h1>
     */
    public static String[][] readAll() {
        Connection conn = util.criarConexao();

        String sqlCommand = "SELECT * FROM funcionarios";
        String count = "SELECT COUNT(*) as n FROM funcionarios";

        String[][] funcionario = new String[0][];
        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);

            //  Conta as linhas que vao resultar da query
            PreparedStatement ts = conn.prepareStatement(count);
            ResultSet ss = ts.executeQuery();
            ss.next();
            int n = ss.getInt("n");

            n=100;
            ResultSet rs = st.executeQuery();
            funcionario = new String[n][4];
            int i = 0;
            while (rs.next()) {


                funcionario[i][0] = (rs.getString("funcionariosCodFuncionario"));

                if (rs.getString("funcionariosNome") != null) {
                    funcionario[i][1] = (rs.getString("funcionariosNome"));
                }
                if (rs.getString("funcionariosFuncao") != null) {
                    funcionario[i][2] = String.valueOf((rs.getInt("funcionariosFuncao")));
                }
                if (rs.getString("funcionariosDataAdmissao") != null) {
                    funcionario[i][3] = rs.getString("funcionariosDataAdmissao");
                }
                i++;
            }

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }

        return funcionario;
    }


    public int login(int id, String pass) {
        read(id);

        if(!existeFunc) {
            System.out.println("Ocorreu um erro");
            return 1;

        } else {
            if(pass.compareTo("admin") == 0) {
                return 2;
            }
        }
        return 0;
    }
}
