package database;

import constants.AppConstants;
import entities.Osoba;

public class DBDataGenerator {

    private DBManager manager;

    public DBDataGenerator(DBManager manager) {
        this.manager = manager;
    }

    public void generujZamestnancov() {

        int i = 0;
        for (i = 0; i < AppConstants.DB_POC_ZAM; i++) {
            Osoba osoba = new Osoba();

            //TODO tu bude generator objektu Osoba

            manager.insertOsoba(osoba);
        }

    }

}
