package Proj2;

/*public class main {
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

        c.create();
        c.read(65);
        System.out.println(c.getIdCliente() + " " + c.getNome());

        tabelaClientes listarCli = new tabelaClientes();
        this.painelVisivel = listarCli;

    }
}*/
import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;


public class main extends JFrame {

    private JMenuBar barraMenu;
    private JMenu menuCliente;
    private JMenuItem menuCriarCli;
    private JMenuItem menuListarCli;

    public main(){
        menuCriarCli = new JMenuItem("Criar");
        menuListarCli = new JMenuItem("Listar");
        menuCliente = new JMenu();
        barraMenu = new JMenuBar();

        menuCliente.setText("Cliente");
        //menuCliente.add(menuCriarCli);
        menuCliente.add(menuListarCli);
        barraMenu.add(menuCliente);

        /*menuCriarCli.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                criarClienteActionPerformed(e);
            }
        });*/

        menuListarCli.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                listarClienteActionPerformed(e);
            }
        });

        this.setJMenuBar(barraMenu);

       /* WelcomeForm wform = new WelcomeForm();
        this.getContentPane().add(wform.getWelcomePanel());
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);*/
    }

    /*public void criarClienteActionPerformed(java.awt.event.ActionEvent e)
    {
        EditCliente form = new EditCliente();

        form.getpEditCliente().setVisible(true);
        this.setContentPane(form.getpEditCliente());
        this.pack();
        //this.getContentPane().add(form.getpEditCliente());
        this.repaint();

    }
*/
    public void listarClienteActionPerformed(java.awt.event.ActionEvent e)
    {
        try {
            Proj2.tabelaClientes lista;
            lista = new Proj2.tabelaClientes();
            lista.getPanel1().setVisible(true);
            this.setContentPane(lista.getPanel1());
            this.pack();
            this.repaint();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public static void main(String[] args) {
        // write your code here
        main frame = new main();

        frame.pack();
        frame.setVisible(true);
    }
}
