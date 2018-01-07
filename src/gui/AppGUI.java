package gui;

import database.DBManager;
import entities.Vozen;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.*;
import java.sql.Date;
import java.sql.ResultSet;

public class AppGUI {
    private JPanel panelMain;
    private JTabbedPane tabbedPane1;
    private JTabbedPane tabbedPane2;
    private JTabbedPane tabbedPane3;
    private JComboBox<String> comboBox3;
    private JComboBox<String> comboBox4;
    private JComboBox<String> comboBox1;
    private JComboBox<String> comboBox2;
    private JComboBox comboBox5;
    private JComboBox comboBox6;
    private JComboBox comboBox7;
    private JButton ButtonVlozitVlak;

    DBManager dbManager;
    ResultSet rs; // pomocna premenna pre selekty

    private AppGUI() {

//        JOptionPane.showMessageDialog(null, "test");

        // Pripojenie do databazy
        dbManager = new DBManager();
        dbManager.connect();

        /*
        Pociatocne naplnenie vsetkych poli na prvom tabe (Pridaj vozen)
         */
        refreshPridajVozen();

        /*
          Button pre vlozenie vozna
         */
        ButtonVlozitVlak.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String typVozna = (String) comboBox1.getSelectedItem();
                Integer idTypuVozna;
                String nazovVlastnika = (String) comboBox3.getSelectedItem();
                Integer idVlastnika;
                String nazovVyrobcu = (String) comboBox4.getSelectedItem();
                Integer idVyrobcu;
                String nazovStanice = (String) comboBox2.getSelectedItem();
                Integer idStanice;

                try {
                    // Nacitanie typ vozna
                    rs = dbManager.selectTypVoznaPodlaTypu(typVozna);
                    if (rs.next())
                        idTypuVozna = rs.getInt(1);
                    else idTypuVozna = null;
                    rs.close();

                    // Nacitanive vlastnikov
                    rs = dbManager.selectSpolocnotiPodlaNazvu(nazovVlastnika);
                    if (rs.next())
                        idVlastnika = rs.getInt(1);
                    else idVlastnika = null;
                    rs.close();

                    // Nacitanie vyrobcov
                    rs = dbManager.selectSpolocnotiPodlaNazvu(nazovVyrobcu);
                    if (rs.next())
                        idVyrobcu = rs.getInt(1);
                    else idVyrobcu = null;
                    rs.close();

                    // Nacitanie stanice
                    rs = dbManager.selectStanicePodlaNazvu(nazovStanice);
                    if (rs.next())
                        idStanice = rs.getInt(1);
                    else idStanice = null;
                    rs.close();

                    int den = (int) comboBox5.getSelectedItem();
                    int mesiac = (int) comboBox6.getSelectedItem();
                    int rok = (int) comboBox7.getSelectedItem();

                    Vozen vozen = new Vozen();
                    vozen.setIdDomovskejStanice(idStanice);
                    vozen.setIdTypuVozna(idTypuVozna);
                    vozen.setIdVlastnika(idVlastnika);
                    vozen.setIdVyrobcu(idVyrobcu);
                    vozen.setDatumNadobudnutia(new Date(den, mesiac, rok));

                    dbManager.insertVozen(vozen);
                    JOptionPane.showMessageDialog(null, "Vozen bol uspesne vlozeny.");

                } catch (Exception ex) {
                    idTypuVozna = null;
                    idVlastnika = null;
                    idVyrobcu = null;
                    idStanice = null;
                    System.out.println("Chyba pri citani niektorej z hodnoty");
                } finally {
                    try {
                        rs.close();
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }
//                JOptionPane.showMessageDialog(null, idTypuVozna + ", " + idVlastnika + ", " + idVyrobcu + ", " + idStanice);
            }
        });

        /*
          Listener ked sa prepinaju taby v metodach
         */
        tabbedPane2.addChangeListener(new ChangeListener() {
            @Override
            public void stateChanged(ChangeEvent e) {
                refreshPridajVozen();
            }
        });
    }

    /*
    Aktualizovanie vsetkych poli pod tabom Pridaj vozen
     */
    private void refreshPridajVozen() {
        try {
            // Typ vozna
            rs = dbManager.selectTypyVoznov();
            comboBox1.removeAllItems();
            comboBox1.addItem("");
            while (rs.next()) {
                comboBox1.addItem(rs.getString(4));
            }
            rs.close();

            // Vlastnik
            rs = dbManager.selectSpolocnosti();
            comboBox3.removeAllItems();
            comboBox3.addItem("");
            while (rs.next()) {
                comboBox3.addItem(rs.getString(3));
            }
            rs.close();

            // Vyrobca
            rs = dbManager.selectDodavatelia();
            comboBox4.removeAllItems();
            comboBox4.addItem("");
            while (rs.next()) {
                comboBox4.addItem(rs.getString(3));
            }
            rs.close();

            // Domovska stanica
            rs = dbManager.selectStanice();
            comboBox2.removeAllItems();
            comboBox2.addItem("");
            while (rs.next()) {
                comboBox2.addItem(rs.getString(2));
            }
            rs.close();

            // Datum
            nastavDatumovePolia(comboBox7, comboBox6, comboBox5);

        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Chyba pri nacitani poloziek pre Pridanie vozna");
        } finally {
            try {
                rs.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void nastavDatumovePolia(JComboBox<Integer> boxDen, JComboBox<Integer> boxMesiac, JComboBox<Integer> boxRok) {

        boxDen.removeAllItems();
        boxMesiac.removeAllItems();
        boxRok.removeAllItems();

        for (int i = 1; i <= 31; i++) {
            boxDen.addItem(i);
        }
        for (int i = 1; i <= 12; i++) {
            boxMesiac.addItem(i);
        }
        for (int i = 2000; i <= 2020; i++) {
            boxRok.addItem(i);
        }
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Správa železničných vozňov");
        frame.setContentPane(new AppGUI().panelMain);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
