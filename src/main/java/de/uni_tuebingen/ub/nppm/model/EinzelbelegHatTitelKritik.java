package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "einzelbeleg_hattitelkritik")
public class EinzelbelegHatTitelKritik  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

     @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;


    @ManyToOne(targetEntity = SelektionTitelKritik.class)
    @JoinColumn(name = "TitelkritikID", referencedColumnName = "ID")
    private SelektionTitelKritik selektionTitelKritik;

    public Integer getId() {
        return id;
    }

    public Einzelbeleg getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }

    public SelektionTitelKritik getSelektionTitelKritik() {
        return selektionTitelKritik;
    }

    public void setSelektionTitelKritik(SelektionTitelKritik selektionTitelKritik) {
        this.selektionTitelKritik = selektionTitelKritik;
    }
}

