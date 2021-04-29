package Proj2;

import javax.swing.*;

public class login {
    private JTextField loginTextField;
    private JPasswordField passwordField1;
    private JTextField textField1;
    private JPanel login;

    public login() {

    }

    public void createLogin() {
        JFrame.setDefaultLookAndFeelDecorated(false);
        JFrame frame = new JFrame("login");
        frame.setContentPane(new login().login);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
