package Proj2;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class foodUI {
    private JTable table1;
    private JButton voltarAoMenuButton;
    private JPanel food;
    private DefaultTableModel model = new DefaultTableModel();
    private String[][] data;

    JFrame frame = new JFrame("Lista de Materias Primas");

    public foodUI() {
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setIconImage(Toolkit.getDefaultToolkit().getImage(menuPrincipal.class.getResource("../assets/ve-logo-40x40.png")));

        frame.setContentPane(food);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
        table1.setAutoCreateRowSorter(true);
        table1.setFillsViewportHeight(true);
        table1.setPreferredScrollableViewportSize(new Dimension(550, 200));

        model.addColumn("Referencia Produto");
        model.addColumn("Nome da Matéria Prima");
        model.addColumn("Quantidade Atual");
        model.addColumn("Quantidade Minima");
        model.addColumn("Ultima Verificação");

        data = ingredientes.readAll();

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
                    int v = table1.getSelectedRow();

                    System.out.println(table1.getValueAt(table1.getSelectedRow(), 1).toString());
                    String value = table1.getModel().getValueAt(table1.getSelectedRow(), 1).toString();

                    String codigo = table1.getModel().getValueAt(table1.getSelectedRow(), 0).toString();
                    System.out.println(codigo);
                    int codFunc = Integer.parseInt(codigo);

                    Object[] options = {"Editar", "Cancelar"};
                    int n = JOptionPane.showOptionDialog(frame,
                            "Prentende mudar o ingrediente com a Referencia: " + codigo + ", Nome: " + value + "?",
                            "Edição de Ingrediente",
                            JOptionPane.YES_NO_OPTION,
                            JOptionPane.QUESTION_MESSAGE,
                            null,
                            options,
                            options[0]);
                    if(n == JOptionPane.YES_OPTION) {
                        modIngrUI mod = new modIngrUI(Integer.parseInt(data[v][0]), data[v][1], Integer.parseInt(data[v][2]), Integer.parseInt(data[v][3]), data[v][4]);
                    }
                }
            }
        });
    }
}
