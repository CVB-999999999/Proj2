package Proj2;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class menuUI {
    private JTable table1;
    private JButton voltarAoMenuButton;
    private JPanel menusPratos;
    private JToolBar toolBar;
    private JButton adicionarPratoButton;
    private String[][] data;
    private DefaultTableModel model = new DefaultTableModel();
    JFrame frame = new JFrame();

    public menuUI() {
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(menusPratos);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
        table1.setAutoCreateRowSorter(true);
        table1.setFillsViewportHeight(true);
        table1.setPreferredScrollableViewportSize(new Dimension(550, 200));

        model.addColumn("Referencia Prato");
        model.addColumn("Nome Prato");
        model.addColumn("Preco");
        model.addColumn("Descrição");

        data = menu.readAll();

        int i=0;
        for (i=0 ; i<data.length ; i++) {
            model.addRow(data[i]);
        }
        table1.setModel(model);

        voltarAoMenuButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                frame.setVisible(false);
                frame.dispose();
            }
        });

        table1.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent event) {
                if (table1.getSelectedRow() > -1) {
                    // print first column value from selected row
                    System.out.println(table1.getValueAt(table1.getSelectedRow(), 0).toString());

                    int value = table1.getSelectedRow();

                    Object[] options = {"Alterar", "Remover", "Cancelar"};
                    int n = JOptionPane.showOptionDialog(frame,
                            "Pretende modificar o prato com: \n\tReferencia: " + data[value][0] + "\n\tNome: " + data[value][1],
                            "Modificar Prato",
                            JOptionPane.YES_NO_CANCEL_OPTION,
                            JOptionPane.QUESTION_MESSAGE,
                            null,
                            options,
                            options[0]);
                    //  Alterar o prato
                    if(n == JOptionPane.YES_OPTION) {
                        modMenuUI mod = new modMenuUI(Integer.parseInt(data[value][0]));
                    }
                    //  Remover o prato
                    if(n == JOptionPane.NO_OPTION) {
                        menu.remove(Integer.parseInt(data[value][0]));
                        updateTable();
                    }
                }
            }
        });
    }
    private void updateTable() {
        model.setNumRows(0);

        data = menu.readAll();

        int i=0;
        for (i=0 ; i<data.length ; i++) {
            model.addRow(data[i]);
        }
        table1.setModel(model);
    }
}
