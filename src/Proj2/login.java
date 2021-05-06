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

    JFrame frame = new JFrame("login");

    public login() {
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
                //Login.setText("OKOKOK");

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

                        frame.setVisible(false);



                        menuPrincipal mp = new menuPrincipal();
                        mp.createmenuPrincipal();

                        break;
                    }
                    default:
                        System.out.println("Erro");
                }
            }
        });

        frame.setVisible(false);
    }

    public void createLogin() {
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(new login().login);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
