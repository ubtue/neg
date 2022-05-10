package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "edition")
public class Edition {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Titel", length=255)
    private String titel;

    @Column(name = "Jahr", length=255)
    private String jahr;

    @Column(name = "Seiten", length=255)
    private String seiten;

    @Column(name = "Zitierweise", length=255)
    private String zitierweise;

    @Column(name = "OrtID")
    private Integer ort;
    
    @Column(name = "ReiheID")
    private Integer reihe;
    
    @Column(name = "SammelbandID")
    private Integer sammelband;

    @Column(name = "Verbindlich")
    private Integer verbindlich;
    
    @Column(name = "BearbeitungsstatusID")
    private Integer bearbeitungsstatus;
    
    @Column(name = "LetzteAenderung")
    private Date letzteAenderung;
    
    @Column(name = "LetzteAenderungVon")
    private Integer letzteAenderungVon;
    
    @Column(name = "Erstellt")
    private Date erstellt;
    
    @Column(name = "ErstelltVon")
    private Integer erstelltVon;
    
    @Column(name = "GehoertGruppe")
    private Integer gehoertGruppe;
    
    @Column(name = "BandNummer", length=100)
    private String bandNummer;
    
    @Column(name = "dMGHBandID")
    private Integer dMGHBand; 
    
}
