package Proj2;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

public class foodUI {
    private JTable table1;
    private JButton voltarAoMenuButton;

    public foodUI() {
        JFrame f = new JFrame();
        JFrame.setDefaultLookAndFeelDecorated(false);

        f.setTitle("Materias Primas");

        String[][] data = encomendaCliente.readAll();

        String[] columnNames = { "ID Encomenda", "ID Prato", "Hora do Pedido" };

        table1 = new JTable(data, columnNames);
        table1.setBounds(30, 40, 200, 300);


        JScrollPane sp = new JScrollPane(table1);
        f.add(sp);
        f.setVisible(true);

        table1.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent event) {
                if (table1.getSelectedRow() > -1) {
                    // print first column value from selected row
                    System.out.println(table1.getValueAt(table1.getSelectedRow(), 0).toString());
                    String value = table1.getModel().getValueAt(table1.getSelectedRow(), 0).toString();

                    Object[] options = {"Sim", "Não"};
                    int n = JOptionPane.showOptionDialog(f,
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
        });
    }
}
