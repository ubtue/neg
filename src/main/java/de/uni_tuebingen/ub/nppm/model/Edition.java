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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitel() {
        return titel;
    }

    public void setTitel(String titel) {
        this.titel = titel;
    }

    public String getJahr() {
        return jahr;
    }

    public void setJahr(String jahr) {
        this.jahr = jahr;
    }

    public String getSeiten() {
        return seiten;
    }

    public void setSeiten(String seiten) {
        this.seiten = seiten;
    }

    public String getZitierweise() {
        return zitierweise;
    }

    public void setZitierweise(String zitierweise) {
        this.zitierweise = zitierweise;
    }

    public Integer getOrt() {
        return ort;
    }

    public void setOrt(Integer ort) {
        this.ort = ort;
    }

    public Integer getReihe() {
        return reihe;
    }

    public void setReihe(Integer reihe) {
        this.reihe = reihe;
    }

    public Integer getSammelband() {
        return sammelband;
    }

    public void setSammelband(Integer sammelband) {
        this.sammelband = sammelband;
    }

    public Integer getVerbindlich() {
        return verbindlich;
    }

    public void setVerbindlich(Integer verbindlich) {
        this.verbindlich = verbindlich;
    }

    public Integer getBearbeitungsstatus() {
        return bearbeitungsstatus;
    }

    public void setBearbeitungsstatus(Integer bearbeitungsstatus) {
        this.bearbeitungsstatus = bearbeitungsstatus;
    }

    public Date getLetzteAenderung() {
        return letzteAenderung;
    }

    public void setLetzteAenderung(Date letzteAenderung) {
        this.letzteAenderung = letzteAenderung;
    }

    public Integer getLetzteAenderungVon() {
        return letzteAenderungVon;
    }

    public void setLetzteAenderungVon(Integer letzteAenderungVon) {
        this.letzteAenderungVon = letzteAenderungVon;
    }

    public Date getErstellt() {
        return erstellt;
    }

    public void setErstellt(Date erstellt) {
        this.erstellt = erstellt;
    }

    public Integer getErstelltVon() {
        return erstelltVon;
    }

    public void setErstelltVon(Integer erstelltVon) {
        this.erstelltVon = erstelltVon;
    }

    public Integer getGehoertGruppe() {
        return gehoertGruppe;
    }

    public void setGehoertGruppe(Integer gehoertGruppe) {
        this.gehoertGruppe = gehoertGruppe;
    }

    public String getBandNummer() {
        return bandNummer;
    }

    public void setBandNummer(String bandNummer) {
        this.bandNummer = bandNummer;
    }

    public Integer getdMGHBand() {
        return dMGHBand;
    }

    public void setdMGHBand(Integer dMGHBand) {
        this.dMGHBand = dMGHBand;
    }
    
}
