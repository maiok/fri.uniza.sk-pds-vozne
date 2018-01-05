import database.DBManager;

public class App {

    public static void main(String[] args) {
        DBManager dbManager = new DBManager();
        dbManager.connect();

//        Zamestnanec zam = new Zamestnanec();
//        zam.setRodCislo("4948937478");
//        zam.setIdSpolocnosti(1);
//        zam.setDatumPrijatia(new Date(2005, 3, 25));
//        dbManager.insertZamestnanec(zam);

//        VyradenyVozen vyradenyVozen = new VyradenyVozen();
//        vyradenyVozen.setDatumVyradenia(new Date(2005, 3, 25));
//        dbManager.insertVyradenyVozen(vyradenyVozen);

        dbManager.generujBlobyTypVozna();
    }
}
