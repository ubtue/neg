package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_amtstandweihe")
public class SelektionAmtStandWeihe {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length=50)
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