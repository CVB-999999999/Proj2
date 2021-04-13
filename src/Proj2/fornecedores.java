package Proj2;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class fornecedores {
    private int codFornecedor;
    private String nome;
    private String email;
    private String telemovel;
    private String rua;
    private String codPostal;
    private String descricao;

    public fornecedores() {
    }

    public int getCodFornecedor() { return codFornecedor;  }

    public void setCodFornecedor(int codFornecedor) {this.codFornecedor = codFornecedor;}

    public String getNome() { return nome; }

    public void setNome(String nome) { this.nome = nome;}

    public String getEmail() {return email; }

    public void setEmail(String email) {this.email = email;}

    public String getTelemovel() {return telemovel; }

    public void setTelemovel(String telemovel) { this.telemovel = telemovel; }

    public String getRua() {   return rua;  }

    public void setRua(String rua) {  this.rua = rua; }

    public String getCodPostal() {  return codPostal;}

    public void setCodPostal(String codPostal) { this.codPostal = codPostal; }

    public String getDescricao() {return descricao; }

    public void setDescricao(String descricao) {this.descricao = descricao; }


    /**
     * <h1> Insert na BD </h1>
     */
    public void create(){
        // PreparedStatement
        Connection conn = util.criarConexao();

        String sqlCommand = "INSERT INTO FORNECEDORES COLUMNS(fornecedoresCodFornecedor, fornecedoresNome, fornecedoresEmail, fornecedoresTelemovel," +
                "fornecedoresEnderecoLinha1, fornecedoresEnderecoLinha2, fornecedoresCidade, fornecedoresCodigoPostal, fornecedoresDescricao) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, this.codFornecedor);
            st.setString(2, this.nome);
            st.setString(3, this.email);
            st.setString(4, this.telemovel);
            st.setString(5, this.rua);
            st.setString(6, this.rua);
            st.setString(7, this.rua);
            st.setString(8, this.codPostal);
            st.setString(9, this.descricao);

            st.execute();

        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }

    /**
     * <h1> Ler a BD </h1>
     */
    public void read(int CodFornecedor){
        Connection conn = util.criarConexao();

        String sqlCommand = "SELECT * FROM FORNECEDORES WHERE fornecedoresCodFornecedor = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sqlCommand);
            st.setInt(1, CodFornecedor);

            ResultSet rs = st.executeQuery();

            if(rs.next()){
                this.codFornecedor = CodFornecedor;
                if (rs.getString("fornecedoresNome") != null) this.nome = rs.getString("fornecedoresNome");
                else this.nome = "";
                if (rs.getString("fornecedoresEnderecoLinha1") != null) this.rua = rs.getString("fornecedoresEnderecoLinha1");
                else this.rua = "";
                if (rs.getString("fornecedoresCodigoPostal") != null) this.codPostal = rs.getString("fornecedoresCodigoPostal");
                else this.codPostal = "";
            }
            else{
                System.out.println("ERRO: Não existe Fornecedor com o ID definido ");
            }
        } catch (SQLException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
    }
}
