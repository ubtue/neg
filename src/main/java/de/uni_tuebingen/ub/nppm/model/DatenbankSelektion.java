package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "datenbank_selektion")
public class DatenbankSelektion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "selektion", length = 255)
    private String selektion;

    @Column(name = "tabelle", length = 255)
    private String tabelle;

    @Column(name = "spalte", length = 255)
    private String spalte;

    public Integer getId() {
        return id;
    }

    public String getSelektion() {
        return selektion;
    }

    public void setSelektion(String selektion) {
        this.selektion = selektion;
    }

    public String getTabelle() {
        return tabelle;
    }

    public void setTabelle(String tabelle) {
        this.tabelle = tabelle;
    }

    public String getSpalte() {
        return spalte;
    }

    public void setSpalte(String spalte) {
        this.spalte = spalte;
    }
}
