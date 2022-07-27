package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "datenbank_sprachen")
public class DatenbankSprache {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Sprache", length = 45)
    private String Sprache;

    @Column(name = "Kuerzel", length = 3)
    private String Kuerzel;

    public Integer getId() {
        return id;
    }

    public String getSprache() {
        return Sprache;
    }

    public void setSprache(String Sprache) {
        this.Sprache = Sprache;
    }

    public String getKuerzel() {
        return Kuerzel;
    }

    public void setKuerzel(String Kuerzel) {
        this.Kuerzel = Kuerzel;
    }
}
