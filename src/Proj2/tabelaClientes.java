package Proj2;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableColumnModel;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;

public class tabelaClientes {

    private JTable showTable;

    public tabelaClientes(){
        createTable();
    }

    private void createUIComponents() {
        // TODO: place custom component creation code here
    }

    private void createTable(){
        cliente c = new cliente();
        c.read(65);

        Object[][] data = {
                {c.getIdCliente(), c.getNome(), c.getNif(), c.getTelemovel()}
        };

        showTable.setModel(new DefaultTableModel(
                null,
                new String[]{"ID Cliente", "Nome", "NIF", "Telemovel"}
        ));
        TableColumnModel columns = showTable.getColumnModel();
        columns.getColumn(0).setMinWidth(200);

        DefaultTableCellRenderer centerRender = new DefaultTableCellRenderer();
        centerRender.setHorizontalAlignment(JLabel.CENTER);
        columns.getColumn(1).setCellRenderer(centerRender);
        columns.getColumn(2).setCellRenderer(centerRender);
        columns.getColumn(3).setCellRenderer(centerRender);
    }
}
