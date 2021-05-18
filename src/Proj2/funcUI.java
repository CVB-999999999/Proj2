package Proj2;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class funcUI {
    private JTable table1;
    private JButton voltarAoMenuButton;
    private JToolBar toolBar;
    private JPanel funcui;

    public funcUI() {
        JFrame frame = new JFrame();
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setContentPane(funcui);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        DefaultTableModel model = new DefaultTableModel();
        table1.setAutoCreateRowSorter(true);
        table1.setFillsViewportHeight(true);
        table1.setPreferredScrollableViewportSize(new Dimension(550, 200));
        model.addColumn("Número");
        model.addColumn("Nome");
        model.addColumn("Posto de Trabalho");
        model.addColumn("Data de Admissão");
        model.addColumn("Funcionario Ativo");
        String[][] data = funcionario.readAll();

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

        /*table1.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent event) {
                if (table1.getSelectedRow() > -1) {
                    // print first column value from selected row
                    System.out.println(table1.getValueAt(table1.getSelectedRow(), 0).toString());
                    String value = table1.getModel().getValueAt(table1.getSelectedRow(), 0).toString();

                    Object[] options = {"Sim", "Não"};
                    int n = JOptionPane.showOptionDialog(frame,
                            "Prentende marcar o pedido nº " + value + " como concluido?",
                            "Marcar o pedido como concluido",
                            JOptionPane.YES_NO_OPTION,
                            JOptionPane.QUESTION_MESSAGE,
                            null,
                            options,
                            options[0]);
                    if(n == JOptionPane.YES_OPTION) {
                        String[][] data = encomendaCliente.readAll();
                        table1.updateUI();
                    }
                }
            }
        });*/
    }
}
