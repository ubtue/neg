package de.uni_tuebingen.ub.nppm.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "mgh_lemma_bearbeiter")
public class MghLemmaBearbeiter {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;
    
    @Column(name = "Zeitstempel", columnDefinition = "DATETIME")
    private Date zeitstempel;
    
    @OneToOne(targetEntity = Benutzer.class)
    @JoinColumn(name = "BenutzerID", referencedColumnName="ID")
    private Benutzer benutzer;
    
    @OneToOne(targetEntity = MghLemma.class)
    @JoinColumn(name = "MGHLemmaID", referencedColumnName="ID")
    private MghLemma mghLemma;

    public int getId() {
        return id;
    }

    public Date getZeitstempel() {
        return zeitstempel;
    }

    public void setZeitstempel(Date zeitstempel) {
        this.zeitstempel = zeitstempel;
    }

    public Benutzer getBenutzer() {
        return benutzer;
    }

    public void setBenutzer(Benutzer benutzer) {
        this.benutzer = benutzer;
    }

    public MghLemma getMghLemma() {
        return mghLemma;
    }

    public void setMghLemma(MghLemma mghLemma) {
        this.mghLemma = mghLemma;
    }
}
