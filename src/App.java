import database.DBDataGenerator;
import database.DBManager;
import entities.Osoba;
public class App {

    public static void main(String[] args) {
        DBManager manager = new DBManager();
        DBDataGenerator dbDataGenerator = new DBDataGenerator(manager);
        manager.connect();

        Osoba os = new Osoba();
        os.setRodCislo("910325/8319");
        os.setMeno("Mario");
        os.setPriezvisko("Priezvisko");

        manager.insertOsoba(os);
    }
}
