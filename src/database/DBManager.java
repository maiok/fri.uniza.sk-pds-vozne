package database;

import constants.AppConstants;
import entities.Osoba;
import entities.Zamestnanec;

import java.sql.*;
import java.util.ArrayList;

public class DBManager {

    private Connection conn;
    private Statement stmt;
    private PreparedStatement ps;
    private String query = "";

    // zoznamy objektov
    // Osoba
    private ArrayList<Osoba> arrOsoby = new ArrayList<>();
    private Osoba osoba;

    public DBManager() {
    }

    public void connect() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(AppConstants.DB_CONNECTION_STRING, AppConstants.DB_USER, AppConstants.DB_PASSW);
            stmt = conn.createStatement();
            System.out.println("Prihlasenie do DB prebehlo uspesne.");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.toString());
        }
    }

    public boolean insertOsoba(Osoba osoba) {

        query = "INSERT INTO \"Osoba\" (\"rod_cislo\", \"meno\", \"priezvisko\", \"dat_narodenia\", \"adresa_osoby\", " +
                "\"kontakt_osoby\") values(?,?,?,?,?,?)";

        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, osoba.getRodCislo());
            ps.setString(2, osoba.getMeno());
            ps.setString(3, osoba.getPriezvisko());
            ps.setDate(4, osoba.getDatNarodenia());
            ps.setString(5, osoba.getAdresaOsoby());
            ps.setString(6, osoba.getKontaktOsoby());

            int response = ps.executeUpdate();

            // pokial vrati ine ako 0, insert sa vykonal
            if(response != 0) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean insertZamestnanec(Zamestnanec zam, Osoba osoba) {

        if(osoba != null) {
            insertOsoba(osoba);
        }

        query = "INSERT INTO \"Zamestnanec\" (\"rod_cislo\", \"id_spolocnosti\", \"datum_prijatia\", \"datum_prepustenia\") " +
                "VALUES (?,?,?,?)";

        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, (osoba!=null) ? osoba.getRodCislo() : null);
//            ps.setInt(2, (spol!=null) ? spol.getIdSpolocnosti() : null);
            ps.setDate(3, new Date(0));
            ps.setDate(4, new Date(0));

            int response = ps.executeUpdate();

            if(response != 0) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

}
