package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "schlagwort_sprachherkunft")
public class SchlagwortSprachherkunft {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;
    
    @OneToOne(targetEntity = NamenKommentar.class)
    @JoinColumn(name = "NamenkommentarID", referencedColumnName="ID")
    private NamenKommentar namenKommentar;
    
    @Column(name = "schlagwort", length = 255)
    private String schlagwort;

    public int getId() {
        return id;
    }

    public NamenKommentar getNamenKommentar() {
        return namenKommentar;
    }

    public void setNamenKommentar(NamenKommentar namenKommentar) {
        this.namenKommentar = namenKommentar;
    }

    public String getSchlagwort() {
        return schlagwort;
    }

    public void setSchlagwort(String schlagwort) {
        this.schlagwort = schlagwort;
    }
}