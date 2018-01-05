package entities;

import java.sql.Blob;

public class TypVozna {

    private int id;
    private double cena;
    private Blob foto;
    private String typ;
    private double odpis;

    public TypVozna() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getCena() {
        return cena;
    }

    public void setCena(double cena) {
        this.cena = cena;
    }

    public Blob getFoto() {
        return foto;
    }

    public void setFoto(Blob foto) {
        this.foto = foto;
    }

    public String getTyp() {
        return typ;
    }

    public void setTyp(String typ) {
        this.typ = typ;
    }

    public double getOdpis() {
        return odpis;
    }

    public void setOdpis(double odpis) {
        this.odpis = odpis;
    }
}
