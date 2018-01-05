import database.DBDataGenerator;
import database.DBManager;
import entities.VyradenyVozen;
import entities.Zamestnanec;

import java.sql.Date;
import java.util.GregorianCalendar;

public class App {

    public static void main(String[] args) {
        DBManager dbManager = new DBManager();
        DBDataGenerator dbDataGenerator = new DBDataGenerator(dbManager);
        dbManager.connect();

//        Zamestnanec zam = new Zamestnanec();
//        zam.setRodCislo("4948937478");
//        zam.setIdSpolocnosti(1);
//        zam.setDatumPrijatia(new Date(2005, 3, 25));
//        dbManager.insertZamestnanec(zam);

        VyradenyVozen vyradenyVozen = new VyradenyVozen();
        vyradenyVozen.setDatumVyradenia(new Date(2005, 3, 25));
        dbManager.insertVyradenyVozen(vyradenyVozen);
    }
}
