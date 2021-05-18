package Proj2;

import javax.sound.midi.SysexMessage;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class login {
    private JPasswordField passwordField1;
    private JTextField textField1;
    private JPanel login;
    private JLabel Login;
    private JLabel PalavraPasse;
    private JLabel IDFuncionario;
    private JButton cancelarButton;
    private JButton iniciarSessãoButton;
    private JLabel erro;
    private int codigo = 0;

    public login() {
        JFrame frame = new JFrame("login");
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(login);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        funcionario f = new funcionario();

        cancelarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });
        iniciarSessãoButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String pass = new String(passwordField1.getPassword());
                int id = Integer.parseInt(textField1.getText());

                System.out.println(id + pass);

                codigo = f.login( id, pass);

                switch (codigo) {
                    case 2: {
                        erro.setText("O ID do Funcionario não foi encontrado");
                        break;
                    }
                    case 1: {
                        erro.setForeground(Color.GREEN);
                        erro.setText("Sucesso");

                        menuPrincipal mp = new menuPrincipal();
                        frame.setVisible(false);
                        frame.dispose();

                        break;
                    }
                    default:
                        System.out.println("Erro");
                }
            }
        });
    }}
