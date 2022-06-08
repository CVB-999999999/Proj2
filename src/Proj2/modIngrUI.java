package Proj2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class modIngrUI {

    JFrame frame = new JFrame("Lista");
    private JPanel panel;
    private JButton confirmarButton;
    private JButton cancelarButton;
    private JTextField atualTf;
    private JTextField minTf;
    private JLabel idLb;
    private JLabel nomeLb;
    private JLabel dataLb;
    private JButton voltarAoMenuButton;

    public modIngrUI(int idProduto, String nome, int qtdAtual, int qtdMinima, String data){

        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setIconImage(Toolkit.getDefaultToolkit().getImage(menuPrincipal.class.getResource("../assets/ve-logo-40x40.png")));

        frame.setContentPane(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        idLb.setText(String.valueOf(idProduto));
        nomeLb.setText(String.valueOf(nome));

        atualTf.setText(String.valueOf(qtdAtual));
        minTf.setText(String.valueOf(qtdMinima));

        dataLb.setText(data);

        voltarAoMenuButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                frame.setVisible(false);
                frame.dispose();
            }
        });

        //Cancelar
        cancelarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                frame.setVisible(false);
                frame.dispose();
            }
        });

        // Guardar e sair
        confirmarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                saveChanges(idProduto);
                frame.setVisible(false);
                frame.dispose();
            }
        });
    }

    public void saveChanges(int idProduto){
        int qtdAtual = Integer.parseInt(atualTf.getText());
        int qtdMinima = Integer.parseInt(minTf.getText());

        ingredientes.updateIngrediente(idProduto,qtdAtual, qtdMinima);

        System.out.println("Exit and Save");
    }
}