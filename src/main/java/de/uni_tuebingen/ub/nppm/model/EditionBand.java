package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "edition_band")
public class EditionBand {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @OneToOne(targetEntity = Edition.class)
    @JoinColumn(name = "EditionID", referencedColumnName="ID")
    private Edition edition;

    @Column(name = "BandNummer", length=255)
    private String bandNummer;

    @Column(name = "Jahr", length=255)
    private String jahr;

    @Column(name = "Standard")
    private int standard;  
}
