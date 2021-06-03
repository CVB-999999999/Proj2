package Proj2;


import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;

public class testeUnit {

    /* --- Load  Pedidos --- */
    /**
     * Verifica se os valores inseridos são falsos
     */
    @Test
    public void semValorFalsoEnc(){
        encomendaCliente testeEnc = new encomendaCliente();

        String[] funcLgValor = testeEnc.read(0);

        Assertions.assertEquals(null, funcLgValor[0]);
    }

    /**
     * Verifica se os valores inseridos são verdadeiros
     */
    @Test
    public void comValoresEnc(){
        encomendaCliente testeEnc = new encomendaCliente();

        String[] funcLgValor = testeEnc.read(2);

        Assertions.assertEquals(2, Integer.parseInt(funcLgValor[0]));
    }

    /* --- Login --- */
    /**
     * Verifica se os valores inseridos são falsos
     */
    @Test
    public void semValorFalso(){
        funcionario lgTeste = new funcionario();

        int funcLgValor = lgTeste.login(99, "teste");

        Assertions.assertEquals(2, funcLgValor);
    }

    /**
     * Verifica se os valores inseridos são verdadeiros
     */
    @Test
    public void comValores(){
        funcionario lgTeste = new funcionario();

        int funcLgValor = lgTeste.login(1, "Latifah");

        Assertions.assertEquals(1, funcLgValor);
    }

    /* --- Ingredientes --- */
    /**
     * Verifica se os valores inseridos são falsos
     */
    @Test
    public void semValorFalsoIngr(){
        ingredientes lgTeste = new ingredientes();

        ArrayList<String[]> funcLgValor = lgTeste.readIngPrato(999999);

        Assertions.assertEquals(new ArrayList<>(), funcLgValor);
    }

    /**
     * Verifica se os valores inseridos são verdadeiros
     */
    @Test
    public void comValoresIngr(){
        ingredientes lgTeste = new ingredientes();

        ArrayList<String[]> funcLgValor = lgTeste.readIngPrato(1);

        Assertions.assertEquals(8, Integer.parseInt(funcLgValor.get(1)[0]));
    }

    /* --- Conexão --- */
    /**
     * Verifica se é possivel existir uma conexão
     */
    @Test
    public void testarConexao(){
        util con = new util();

        Assertions.assertNotEquals(null, con);
    }

}
