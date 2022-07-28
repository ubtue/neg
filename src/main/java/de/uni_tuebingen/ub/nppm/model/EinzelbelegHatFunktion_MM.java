package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "einzelbeleg_hatfunktion")
public class EinzelbelegHatFunktion_MM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Nummer", length = 255)
    private String nummer;

    @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;

    @ManyToOne(targetEntity = SelektionFunktion.class)
    @JoinColumn(name = "FunktionID", referencedColumnName = "ID")
    private SelektionFunktion funktion;

    public Integer getId() {
        return id;
    }

    public String getNummer() {
        return nummer;
    }

    public void setNummer(String nummer) {
        this.nummer = nummer;
    }

    public Einzelbeleg getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }

    public SelektionFunktion getFunktion() {
        return funktion;
    }

    public void setFunktion(SelektionFunktion funktion) {
        this.funktion = funktion;
    }
}
