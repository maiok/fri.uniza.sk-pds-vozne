package entities;

import java.sql.Date;

public class VyradenyVozen {

    private int id;
    private Integer idVozna;
    private Date datumVyradenia;

    public VyradenyVozen() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getIdVozna() {
        return idVozna;
    }

    public void setIdVozna(Integer idVozna) {
        this.idVozna = idVozna;
    }

    public Date getDatumVyradenia() {
        return datumVyradenia;
    }

    public void setDatumVyradenia(Date datumVyradenia) {
        this.datumVyradenia = datumVyradenia;
    }
}
