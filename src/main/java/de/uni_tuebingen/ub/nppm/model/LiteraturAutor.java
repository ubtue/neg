package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "literatur_autor")
public class LiteraturAutor {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @Column(name = "Vorname", length=255)
    private String vorname;

    @Column(name = "Nachname", length=255)
    private String nachname;

    @OneToOne(targetEntity = Literatur.class)
    @JoinColumn(name = "LiteraturID", referencedColumnName="ID")
    private Literatur literatur;

    public int getId() {
        return id;
    }

    public String getVorname() {
        return vorname;
    }

    public void setVorname(String vorname) {
        this.vorname = vorname;
    }

    public String getNachname() {
        return nachname;
    }

    public void setNachname(String nachname) {
        this.nachname = nachname;
    }

    public Literatur getLiteratur() {
        return literatur;
    }

    public void setLiteratur(Literatur literatur) {
        this.literatur = literatur;
    }
}
