package Proj2;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class modMenuUI {
    private JButton cancelarButton;
    private JButton guardarButton;
    private JTable table1;
    private JTextField textField1;
    private JTextField textField2;
    private JTextField textField3;
    private JButton adicionarIngredienteButton;
    private JPanel panel;
    private String[][] data;
    private String[][] ingr;
    private DefaultTableModel model = new DefaultTableModel();
    JFrame frame = new JFrame();

    public modMenuUI() {
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        table1.setAutoCreateRowSorter(true);
        table1.setFillsViewportHeight(true);
        table1.setPreferredScrollableViewportSize(new Dimension(550, 200));

        model.addColumn("Referencia Ingrediente");
        model.addColumn("Nome Ingrediente");
        model.addColumn("Preco");
        model.addColumn("Quantidade");

        data = menu.readAll();
        ingr = ingredientes.readAll();

        int i=0;
        for (i=0 ; i<data.length ; i++) {
            model.addRow(data[i]);
        }

        // Cria um array com todos os ingredientes que o utilizador pode adicionar ao menu
        String[] possibilities = new String[ingr.length];
        for (i=0 ; i<ingr.length ; i++) {
            possibilities[i] = ingr[i][1];
        }
        table1.setModel(model);

        // Mostra popup com as acoes que pode realizar antes de sair
        cancelarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Object[] options = {"Sair e Guardar", "Sair sem Guardar", "Cancelar"};
                int n = JOptionPane.showOptionDialog(frame,
                        "Pretende guardar as alterações antes de sair?",
                        "Guardar antes de sair",
                        JOptionPane.YES_NO_CANCEL_OPTION,
                        JOptionPane.QUESTION_MESSAGE,
                        null,
                        options,
                        options[0]);
                //  Guardar as alterações e sair
                if(n == JOptionPane.YES_OPTION) {
                    frame.setVisible(false);
                    frame.dispose();
                }
                //  Sair
                if(n == JOptionPane.NO_OPTION) {
                    frame.setVisible(false);
                    frame.dispose();
                }
            }
        });

        // Guardar e sair
        guardarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                frame.setVisible(false);
                frame.dispose();
            }
        });

        // Adicionar ingredientes a partir de uma lista
        adicionarIngredienteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String s = (String)JOptionPane.showInputDialog(
                        frame,
                        "Escolha um ingredientes a adicionar",
                        "Adicionar ingrediente",
                        JOptionPane.PLAIN_MESSAGE,
                        null,
                        possibilities,
                        possibilities[0]);

                // add ao array de ingredientes e so no fim guardar na bd
                if ((s != null) && (s.length() > 0)) {
                    System.out.println(s);
                }
            }
        });

        // Modificar os ingredientes
        table1.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent event) {
                if (table1.getSelectedRow() > -1) {

                    int value = Integer.parseInt(table1.getValueAt(table1.getSelectedRow(), 0).toString());
                    System.out.println(value);

                    Object[] options = {"Alterar quantidade", "Remover", "Cancelar"};
                    int n = JOptionPane.showOptionDialog(frame,
                            "Escolha um opção:",
                            "Modificar ingrediente",
                            JOptionPane.YES_NO_CANCEL_OPTION,
                            JOptionPane.QUESTION_MESSAGE,
                            null,
                            options,
                            options[0]);
                    //  Alterar a qtd do ingrediente
                    if(n == JOptionPane.YES_OPTION) {
                    }
                    //  Remover o ingrediente
                    if(n == JOptionPane.NO_OPTION) {
                    }
                }
            }
        });
    }
}
