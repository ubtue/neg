package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@MappedSuperclass
public abstract class SelektionBezeichnung extends Selektion {
    @Column(name = "Bezeichnung", length=255)
    private String bezeichnung;

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }
}
