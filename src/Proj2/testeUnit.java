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

        String[] funcLgValor = testeEnc.read(33);

        Assertions.assertEquals(33, Integer.parseInt(funcLgValor[0]));
    }

    /**
     * Verifica se os valores inseridos são verdadeiros
     */
    @Test
    public void comValoresEnc(){
        encomendaCliente testeEnc = new encomendaCliente();

        String[] funcLgValor = testeEnc.read(31);

        Assertions.assertEquals(31, Integer.parseInt(funcLgValor[0]));
    }

    /* --- Login --- */
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

    /* --- Ingredientes --- */
    /**
     * Verifica se os valores inseridos são falsos
     */
    @Test
    public void semValorFalsoIngr(){
        ingredientes lgTeste = new ingredientes();

        ArrayList<String[]> funcLgValor = lgTeste.readIngPrato(0);

        Assertions.assertEquals(null, funcLgValor.get(1)[0]);
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
}
