package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "einzelbeleg_hatangabe")
public class EinzelbelegHatAngabe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;

    @ManyToOne(targetEntity = SelektionAngabe.class)
    @JoinColumn(name = "AngabeID", referencedColumnName = "ID")
    private SelektionAngabe selektionAngabe;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Einzelbeleg getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }

    public SelektionAngabe getSelektionAngabe() {
        return selektionAngabe;
    }

    public void setSelektionAngabe(SelektionAngabe selektionAngabe) {
        this.selektionAngabe = selektionAngabe;
    }
}