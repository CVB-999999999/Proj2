package Proj2;


import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class testeUnit {

    /**
     * Verifica se foram enviados dados para atualização
     */
    @Test
    public void semValorFornecido(){
        funcionario lgTeste = new funcionario();

        double funcLgValor = funcionario.readAll().length;

        Assertions.assertEquals(0, funcLgValor);
    }

    /**
     * Verifica a qualidade dos dados
     */
    @Test
    public void comValores(){

    }
}
