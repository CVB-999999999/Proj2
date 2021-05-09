package Proj2;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

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
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(menuMain);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        sairButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });
        terminarSessãoButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                login lg = new login();
                frame.setVisible(false);
                frame.dispose();
            }
        });
        pedidosButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                pedidos p = new pedidos();
            }
        });
        funcionariosButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                funcUI func = new funcUI();
            }
        });
        menusEPratosButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                menuUI mui = new menuUI();
            }
        });
        matériasPrimasButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                foodUI fui = new foodUI();
            }
        });
    }
}
