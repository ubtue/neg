package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "benutzer_gruppe")
public class BenutzerGruppe {
    @Id @GeneratedValue
    @Column(name = "ID")
    private int ID;

    @Column(name = "Bezeichnung")
    private String Bezeichnung;

    public int getID() {
        return ID;
    }

    public String getBezeichnung() {
        return Bezeichnung;
    }
}
