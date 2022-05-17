package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_funktion")
public class SelektionFunktion {
    @Id @GeneratedValue
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length=255)
    private String bezeichnung;

    public Integer getId() {
        return id;
    }

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }
}
