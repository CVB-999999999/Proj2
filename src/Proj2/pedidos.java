package Proj2;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.time.format.SignStyle;

public class pedidos {
    private JPanel pedidos;
    private JTable table1;
    private JButton voltarAoMenuButton;
    private JToolBar toolBar;
    private String[][] data;
    private DefaultTableModel model = new DefaultTableModel();

    public pedidos() {
        JFrame.setDefaultLookAndFeelDecorated(false);
        JFrame frame = new JFrame();
        frame.setContentPane(pedidos);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        table1.setAutoCreateRowSorter(true);
        table1.setFillsViewportHeight(true);
        table1.setPreferredScrollableViewportSize(new Dimension(550, 200));
        model.addColumn("Id Encomenda");
        model.addColumn("Prato");
        model.addColumn("Quantidade");
        model.addColumn("Hora Pedido");
        model.addColumn("Estado");
        data = encomendaCliente.readAll();

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

        /**
         * PopUp a perguntar se o utilizador quer alterar o estado do pedido
         */
        table1.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent event) {
                if (table1.getSelectedRow() > -1) {
                    // print first column value from selected row
                    System.out.println(table1.getValueAt(table1.getSelectedRow(), 0).toString());
                    String value = table1.getModel().getValueAt(table1.getSelectedRow(), 0).toString();
                    int linha = Integer.valueOf(value);

                    Object[] options = {"Sim", "Não"};

                    if (data[linha][4].compareToIgnoreCase("Em preparação") == 0) {
                        int n = JOptionPane.showOptionDialog(frame,
                                "Prentende marcar o pedido nº " + value + " como \"Concluido\"?",
                                "Marcar o pedido como \"Concluido\"",
                                JOptionPane.YES_NO_OPTION,
                                JOptionPane.QUESTION_MESSAGE,
                                null,
                                options,
                                options[0]);
                        if (n == JOptionPane.YES_OPTION) {
                            encomendaCliente.updateEstado(data[linha][0], 1, 4);
                            updateTable();
                        }


                    } else {
                        int n = JOptionPane.showOptionDialog(frame,
                                "Prentende marcar o pedido nº " + value + " como \"Em preparação\"?",
                                "Marcar o pedido como \"Em preparação\"",
                                JOptionPane.YES_NO_OPTION,
                                JOptionPane.QUESTION_MESSAGE,
                                null,
                                options,
                                options[0]);
                        if (n == JOptionPane.YES_OPTION) {
                            encomendaCliente.updateEstado(data[linha][0], 1, 3);
                            String[][] data = encomendaCliente.readAll();
                            table1.updateUI();
                        }
                    }
                }
            }
        });
    }
    private void updateTable() {
        model.setNumRows(0);

        data = encomendaCliente.readAll();

        int i=0;
        for (i=0 ; i<data.length ; i++) {
            model.addRow(data[i]);
        }
        table1.setModel(model);
    }
}

