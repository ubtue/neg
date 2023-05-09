package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "einzelbeleg_hatmghlemma")
public class EinzelbelegMghLemma_MM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;

    @ManyToOne(targetEntity = MghLemma.class)
    @JoinColumn(name = "MGHLemmaID", referencedColumnName = "ID")
    private MghLemma mghLemma;

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

    public MghLemma getMghLemma() {
        return mghLemma;
    }

    public void setMghLemma(MghLemma mghLemma) {
        this.mghLemma = mghLemma;
    }
}
