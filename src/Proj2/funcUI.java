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
        JFrame frame = new JFrame("Lista de Funcionários");
        JFrame.setDefaultLookAndFeelDecorated(false);
        frame.setIconImage(Toolkit.getDefaultToolkit().getImage(menuPrincipal.class.getResource("../assets/ve-logo-40x40.png")));

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

                    String codigoD = table1.getModel().getValueAt(table1.getSelectedRow(), 4).toString();;
                    System.out.println(codigo);
                    String codDM;
                    int codD;

                    if(codigoD.equals("Sim")){
                        codD = 1;
                        codDM = "Demitir";
                    }else{
                        codD = 0;
                        codDM = "Readmitir";
                    }

                    System.out.println(codD);

                    Object[] options = {"Editar", codDM, "Cancelar"};
                    int n = JOptionPane.showOptionDialog(frame,
                            "Prentende mudar o funcionário " + value + "?",
                            "Demitir funcionário",
                            JOptionPane.YES_NO_OPTION,
                            JOptionPane.QUESTION_MESSAGE,
                            null,
                            options,
                            options[0]);
                    if(n == JOptionPane.YES_OPTION) {
                        modFuncUI mod = new modFuncUI(Integer.parseInt(data[v][0]), data[v][1], data[v][2], data[v][3], data[v][4]);

                        frame.setVisible(false);
                        frame.dispose();
                    }
                    if(n == JOptionPane.NO_OPTION) {
                        funcionario.atualizaAdmissao(codFunc, codD);

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
                    }
                }
            }
        });
    }
}
