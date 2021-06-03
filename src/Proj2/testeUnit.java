package Proj2;


import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class testeUnit {

    /**
     * Verifica se os valores inseridos são falsos
     */
    @Test
    public void semValorFalso(){
        funcionario lgTeste = new funcionario();

        int funcLgValor = lgTeste.login(0, "123");

        Assertions.assertEquals(2, funcLgValor);
    }

    /**
     * Verifica se os valores inseridos são verdadeiros
     */
    @Test
    public void comValores(){
        funcionario lgTeste = new funcionario();

        int funcLgValor = lgTeste.login(6, "Maia");

        Assertions.assertEquals(1, funcLgValor);
    }

    /**
     * Verifica ...
     */
    @Test
    public void aaa(){
        funcionario lgTeste = new funcionario();

        int funcLgValor = funcionario.atualizaAdmissao(0,0);

        Assertions.assertEquals(1, funcLgValor);
    }
}
