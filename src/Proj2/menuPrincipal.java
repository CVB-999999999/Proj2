package Proj2;

import javax.swing.*;
import java.awt.*;
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
    private JButton clientesButton;

    JFrame frame = new JFrame("Menu Principal");

    menuPrincipal(String funcao) {
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setIconImage(Toolkit.getDefaultToolkit().getImage(menuPrincipal.class.getResource("../assets/ve-logo-40x40.png")));

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
                if(funcao.equals("Cozinheiro") || funcao.equals("Cozinheira") || funcao.equals("Recessionista") || funcao.equals("Gerente")){
                    pedidos p = new pedidos();
                }
                else{
                    JDialog d = new JDialog(frame, "Erro Sem Permissão");
                    JLabel l = new JLabel("Infelizmente não tem permissão para entrar aqui!!", JLabel.CENTER);
                    l.setHorizontalTextPosition(JLabel.CENTER);
                    d.add(l);
                    d.setSize(400,200);
                    d.setLocationRelativeTo(null);
                    // set visibility of dialog
                    d.setVisible(true);
                }
            }
        });
        funcionariosButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(funcao.equals("Gerente")) {
                    funcUI func = new funcUI();
                }
                else{
                    JDialog d = new JDialog(frame, "Erro Sem Permissão");
                    JLabel l = new JLabel("Infelizmente não tem permissão para entrar aqui!!", JLabel.CENTER);
                    l.setHorizontalTextPosition(JLabel.CENTER);
                    d.add(l);
                    d.setSize(400,200);
                    d.setLocationRelativeTo(null);
                    // set visibility of dialog
                    d.setVisible(true);
                }
            }
        });

        clientesButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(funcao.equals("Gerente")) {
                    clienteLista cliente = new clienteLista();
                }
                else{
                    JDialog d = new JDialog(frame, "Erro Sem Permissão");
                    JLabel l = new JLabel("Infelizmente não tem permissão para entrar aqui!!", JLabel.CENTER);
                    l.setHorizontalTextPosition(JLabel.CENTER);
                    d.add(l);
                    d.setSize(400,200);
                    d.setLocationRelativeTo(null);
                    // set visibility of dialog
                    d.setVisible(true);
                }
            }
        });
        menusEPratosButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(funcao.equals("Gerente")) {
                    menuUI mui = new menuUI();
                }
                else{
                    JDialog d = new JDialog(frame, "Erro Sem Permissão");
                    JLabel l = new JLabel("Infelizmente não tem permissão para entrar aqui!!", JLabel.CENTER);
                    l.setHorizontalTextPosition(JLabel.CENTER);
                    d.add(l);
                    d.setSize(400,200);
                    d.setLocationRelativeTo(null);
                    // set visibility of dialog
                    d.setVisible(true);
                }
            }
        });
        matériasPrimasButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(funcao.equals("Gerente")) {
                    foodUI fui = new foodUI();
                }
                else{
                    JDialog d = new JDialog(frame, "Erro Sem Permissão");
                    JLabel l = new JLabel("Infelizmente não tem permissão para entrar aqui!!", JLabel.CENTER);
                    l.setHorizontalTextPosition(JLabel.CENTER);
                    d.add(l);
                    d.setSize(400,200);
                    d.setLocationRelativeTo(null);
                    // set visibility of dialog
                    d.setVisible(true);
                }
            }
        });
    }
}
