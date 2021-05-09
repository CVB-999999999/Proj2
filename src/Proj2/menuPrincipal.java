package Proj2;

import javax.swing.*;

public class menuPrincipal {
    private JPanel menuMain;
    private JToolBar MenuToolBar;
    private JButton sairButton;
    private JLabel MenuPLabel;
    private JButton funcionariosButton;
    private JButton matériasPrimasButton;
    private JButton menusEPratosButton;
    private JButton terminarSessãoButton;
    private JButton pedidosButton;

    JFrame frame = new JFrame("Menu Principal");

    menuPrincipal() {

    }

    public void createmenuPrincipal() {
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(new menuPrincipal().menuMain);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
