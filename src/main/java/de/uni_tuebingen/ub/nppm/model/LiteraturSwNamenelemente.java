package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "literatur_sw_namenelemente")
public class LiteraturSwNamenelemente {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @Column(name = "Schlagwort", length=255)
    private String schlagwort;

    @OneToOne(targetEntity = Literatur.class)
    @JoinColumn(name = "LiteraturID", referencedColumnName="ID")
    private Literatur literatur;
    
    public int getId() {
        return id;
    }

    public String getSchlagwort() {
        return schlagwort;
    }

    public void setSchlagwort(String schlagwort) {
        this.schlagwort = schlagwort;
    }

    public Literatur getLiteratur() {
        return literatur;
    }

    public void setLiteratur(Literatur literatur) {
        this.literatur = literatur;
    }
}
