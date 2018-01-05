package database;

import constants.AppConstants;
import entities.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class DBManager {

    private Connection conn;
    private Statement stmt;
    private PreparedStatement ps;
    private String query = "";

    // zoznamy objektov
    // Osoba
    private ArrayList<Osoba> arrOsoby = new ArrayList<>();

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

        query = "insert into osoba (rod_cislo, meno, priezvisko, dat_narodenia, adresa_osoby," +
                "kontakt_osoby) values(?,?,?,?,?,?)";
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
            if (response != 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertZamestnanec(Zamestnanec zam) {

        query = "insert into zamestnanec (rod_cislo, id_spolocnosti, datum_prijatia, datum_prepustenia) " +
                "values(?,?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, zam.getRodCislo());
            // Takto sa definuje FK typu Integer, pretoze narozdiel od typu int
            // Integer moze byt NULL
            ps.setObject(2, zam.getIdSpolocnosti(), Types.INTEGER);
            ps.setDate(3, zam.getDatumPrijatia());
            ps.setDate(4, zam.getDatumPrepustenia());

            int response = ps.executeUpdate();
            if (response != 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertSpolocnost(Spolocnost spolocnost) {

        query = "insert into spolocnost (id_typu_spolocnosti, nazov_spolocnosti, adresa_spolocnosti, kontakt_spolocnosti) " +
                "values(?,?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setObject(1, spolocnost.getIdTypu(), Types.INTEGER);
            ps.setString(2, spolocnost.getNazov());
            ps.setString(3, spolocnost.getAdresa());
            ps.setString(4, spolocnost.getKontakt());

            int response = ps.executeUpdate();
            if (response != 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertVozen(Vozen vozen) {

        query = "insert into vozen (id_typu_vozna, id_vlastnika, id_vyrobcu, id_domovskej_stanice, datum_nadobudnutia) " +
                "values(?,?,?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setObject(1, vozen.getIdTypuVozna(), Types.INTEGER);
            ps.setObject(2, vozen.getIdVlastnika(), Types.INTEGER);
            ps.setObject(3, vozen.getIdVyrobcu(), Types.INTEGER);
            ps.setObject(4, vozen.getIdDomovskejStanice(), Types.INTEGER);
            ps.setDate(5, vozen.getDatumNadobudnutia());

            int response = ps.executeUpdate();
            if (response != 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertVyradenyVozen(VyradenyVozen vyradenyVozen) {

        query = "insert into vyradeny_vozen (id_vozna, datum_vyradenia, popis_vyradenia) " +
                "values(?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setObject(1, vyradenyVozen.getIdVozna(), Types.INTEGER);
            ps.setDate(2, vyradenyVozen.getDatumVyradenia());
            ps.setString(3, vyradenyVozen.getPopis());

            int response = ps.executeUpdate();
            if (response != 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertOprava(Oprava oprava) {

        query = "insert into oprava (id_kontroly, id_typu_opravy, popis_opravy) " +
                "values(?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setObject(1, oprava.getIdKontroly(), Types.INTEGER);
            ps.setObject(2, oprava.getIdTypu(), Types.INTEGER);
            ps.setString(3, oprava.getPopis());

            int response = ps.executeUpdate();
            if (response != 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertSuciastka(Suciastka suciastka) {

        query = "insert into suciastka (id_typu_suciastky, id_dodavatela, cena_suciastky) " +
                "values(?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setObject(1, suciastka.getIdTypu(), Types.INTEGER);
            ps.setObject(2, suciastka.getIdDodavatela(), Types.INTEGER);
            ps.setDouble(3, suciastka.getCena());

            int response = ps.executeUpdate();
            if (response != 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void generujBlobyTypVozna() {

        query = "update typ_vozna set foto_vozna = ? where id_typu_vozna = ?";

        try {
            for (int i = 1; i <= 11; i++) {
                PreparedStatement pstmt = conn.prepareStatement(query);
                File blob = new File(System.getProperty("user.dir") + "/bloby/blob_" + i + ".jpg");
                FileInputStream in = new FileInputStream(blob);
                pstmt.setBinaryStream(1, in, (int) blob.length());
                pstmt.setInt(2, i);
                pstmt.executeUpdate();
                pstmt.close();
            }
        } catch (SQLException | FileNotFoundException e) {
            e.printStackTrace();
        }
    }

}
