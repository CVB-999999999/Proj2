package Proj2;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableColumnModel;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class tabelaClientes {

    private JTable table1;
    private JPanel panel1;

    public tabelaClientes(){
        List<cliente> lista = new ArrayList<>();

        try {
            lista = cliente.readAll();
        }
        catch(SQLException ex){
            /*ERRO erro = new ERRO();
            System.out.println(ex.getMessage());
            erro.getMensagemErro().setText(ex.getMessage());
            erro.setVisible(true);*/
        }
        DefaultTableModel tmodel = (DefaultTableModel)table1.getModel();

        for(cliente cli : lista){
            String [] linhaTabela = new String[4];
            linhaTabela[0] = String.valueOf(cli.getIdCliente());
            linhaTabela[1] = cli.getNome();
            linhaTabela[2] = cli.getTelemovel();
            linhaTabela[3] = cli.getNif();

            tmodel.addRow(linhaTabela);
            //System.out.println(linhaTabela[0]);
        }
    }

    public JTable getTable1() {
        return table1;
    }

    public void setTable1(JTable table1) {
        this.table1 = table1;
    }

    public JPanel getPanel1() {
        return panel1;
    }

    public void setPanel1(JPanel panel1) {
        this.panel1 = panel1;
    }

    private void createUIComponents() {
        // TODO: place custom component creation code here
    }
}
