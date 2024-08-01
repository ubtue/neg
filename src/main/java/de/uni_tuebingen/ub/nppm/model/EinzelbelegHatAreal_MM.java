package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "einzelbeleg_hatareal")
public class EinzelbelegHatAreal_MM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;

    @ManyToOne(targetEntity = SelektionAreal.class)
    @JoinColumn(name = "ArealID", referencedColumnName = "ID")
    private SelektionAreal areal;

    public Integer getId() {
        return id;
    }

    public Einzelbeleg getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }

    public SelektionAreal getAreal() {
        return areal;
    }

    public void setAreal(SelektionAreal areal) {
        this.areal = areal;
    }


}
