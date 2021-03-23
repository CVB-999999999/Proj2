package Proj2;

public class main {
    public static void main(String[] args) {
        cliente c = new cliente();

       /* c.setCodPostal("99999999999");
        c.setEmail("99999999999");
        c.setPass("99999999999");
        c.setIdCliente(99999999);
        c.setNif(999999);
        c.setNome("99999999999");
        c.setPass("99999999999");
        c.setTelemovel("99999999999");
        c.setRua("99999999999");

        c.create();*/
        c.read(65);
        System.out.println(c.getIdCliente() + " " + c.getNome());
    }
}
