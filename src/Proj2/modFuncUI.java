package Proj2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class modFuncUI {
    private JButton cancelarButton;
    private JButton guardarButton;
    private JTextField textField1;
    private JTextField textField2;
    private JTextField textField3;
    private JPanel panel;
    private JLabel codigo;
    private JTextField textField4;
    JFrame frame = new JFrame();

    public modFuncUI(int cdo, String nome, String funcao, String dataAdmissao, String admissao){

        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        codigo.setText(String.valueOf(cdo));

        textField1.setText(nome);

        textField2.setText(admissao);
        textField2.setEditable(false);

        textField3.setText(dataAdmissao);
        textField3.setEditable(false);

        textField4.setText(funcao);

        //Cancelar
        cancelarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                frame.setVisible(false);
                frame.dispose();
            }
        });

        // Guardar e sair
        guardarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                saveChanges(cdo);
                frame.setVisible(false);
                frame.dispose();
            }
        });
    }

    public void saveChanges(int codigoFuncionario){
        String nome = textField1.getText();
        String funcao = textField4.getText();

        funcionario.updateFuncionario(codigoFuncionario,nome, funcao);

        System.out.println("Exit and Save");
    }
}
