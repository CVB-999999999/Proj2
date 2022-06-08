package Proj2;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class clienteLista {
    private JPanel clientes;
    private JTable table1;
    private JButton voltarAoMenuButton;
    private JToolBar toolBar;
    private String[][] data;
    private DefaultTableModel model = new DefaultTableModel();

    public clienteLista(){
        JFrame.setDefaultLookAndFeelDecorated(false);
        JFrame frame = new JFrame("Lista de Clientes");
        frame.setIconImage(Toolkit.getDefaultToolkit().getImage(menuPrincipal.class.getResource("../assets/ve-logo-40x40.png")));
        frame.setContentPane(clientes);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        table1.setAutoCreateRowSorter(true);
        table1.setFillsViewportHeight(true);
        table1.setPreferredScrollableViewportSize(new Dimension(550, 200));
        model.addColumn("Id Cliente");
        model.addColumn("Nome");
        model.addColumn("Email");
        model.addColumn("Telemóvel");
        data = cliente.readAll();

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


        //Bloqueia a opção de edição de cliente
        table1.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                //super.mouseClicked(e);
                boolean a = table1.isEditing();

                if(a==false){
                    JOptionPane.showMessageDialog(null, "Não pode editar este campo!");
                }
            }
        });
    }
}
