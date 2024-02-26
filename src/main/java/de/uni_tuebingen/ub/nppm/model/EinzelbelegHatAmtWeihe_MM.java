package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "einzelbeleg_hatamtweihe")
public class EinzelbelegHatAmtWeihe_MM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @ManyToOne(targetEntity = SelektionAmtWeihe.class)
    @JoinColumn(name = "AmtWeiheID", referencedColumnName = "ID")
    private SelektionAmtWeihe amtWeihe;

    @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;

    public Integer getId() {
        return id;
    }

    public SelektionAmtWeihe getAmtWeihe() {
        return amtWeihe;
    }

    public void setAmtWeihe(SelektionAmtWeihe amtWeihe) {
        this.amtWeihe = amtWeihe;
    }

    public Einzelbeleg getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }


}
