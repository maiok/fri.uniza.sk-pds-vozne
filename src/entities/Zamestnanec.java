package entities;

import java.sql.Date;

public class Zamestnanec {

    private String rodCislo;
    private int idSpolocnosti;
    private Date datumPrijatia;
    private Date datumPrepustenia;

    public Zamestnanec() {
    }


    public Date getDatumPrijatia() {
        return datumPrijatia;
    }

    public void setDatumPrijatia(Date datumPrijatia) {
        this.datumPrijatia = datumPrijatia;
    }

    public Date getDatumPrepustenia() {
        return datumPrepustenia;
    }

    public void setDatumPrepustenia(Date datumPrepustenia) {
        this.datumPrepustenia = datumPrepustenia;
    }

    public int getIdSpolocnosti() {
        return idSpolocnosti;
    }

    public void setIdSpolocnosti(int idSpolocnosti) {
        this.idSpolocnosti = idSpolocnosti;
    }

    public String getRodCislo() {
        return rodCislo;
    }

    public void setRodCislo(String rodCislo) {
        this.rodCislo = rodCislo;
    }
}
