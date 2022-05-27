package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "literatur")
public class Literatur {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @Column(name = "Titel", length=255)
    private String titel;

    @Column(name = "Titel2", length=255)
    private String titel2;
    
    @OneToOne(targetEntity = SelektionLiteraturtyp.class)
    @JoinColumn(name = "LiteraturTypID", referencedColumnName="ID")
    private SelektionLiteraturtyp literaturTyp;
    
    @Column(name = "Auflage", length=255)
    private String auflage;
    
    @Column(name = "Ort", length=255)
    private String ort;
    
    @Column(name = "Jahr", length=255)
    private String jahr;
    
    @Column(name = "Seite", length=255)
    private String seite;
    
    @Column(name = "Reihe", length=255)
    private String reihe;

    @Column(name = "BearbeitungsstatusID")
    private Integer bearbeitungsstatus;

    @Column(name = "Kurzzitierweise", length=255)
    private String kurzzitierweise;
 
    @Column(name = "PhilologischRelevant", columnDefinition="BIT DEFAULT NULL")
    private Boolean philologischRelevant;
    
    @Column(name = "LetzteAenderung")
    private Date letzteAenderung;
    
    @OneToOne(targetEntity = Benutzer.class)
    @JoinColumn(name = "LetzteAenderungVon", referencedColumnName="ID")
    private Benutzer letzteAenderungVon;
    
    @Column(name = "Erstellt")
    private Date erstellt;
    
    @OneToOne(targetEntity = Benutzer.class)
    @JoinColumn(name = "ErstelltVon", referencedColumnName="ID")
    private Benutzer erstelltVon;
    
    @OneToOne(targetEntity = BenutzerGruppe.class)
    @JoinColumn(name = "GehoertGruppe", referencedColumnName="ID")
    private BenutzerGruppe gehoertGruppe;
    
    @Column(name = "inLitID")
    private Integer inLitID;
    
    @Column(name = "inBand", length=45)
    private String inBand;
 
    @Column(name = "Umfang", length=45)
    private String umfang;
  
    @Column(name = "AutorJahr", length=255)
    private String autorJahr;

    public int getId() {
        return id;
    }

    public String getTitel() {
        return titel;
    }

    public void setTitel(String titel) {
        this.titel = titel;
    }

    public String getTitel2() {
        return titel2;
    }

    public void setTitel2(String titel2) {
        this.titel2 = titel2;
    }

    public SelektionLiteraturtyp getLiteraturTyp() {
        return literaturTyp;
    }

    public void setLiteraturTyp(SelektionLiteraturtyp literaturTyp) {
        this.literaturTyp = literaturTyp;
    }

    public String getAuflage() {
        return auflage;
    }

    public void setAuflage(String auflage) {
        this.auflage = auflage;
    }

    public String getOrt() {
        return ort;
    }

    public void setOrt(String ort) {
        this.ort = ort;
    }

    public String getJahr() {
        return jahr;
    }

    public void setJahr(String jahr) {
        this.jahr = jahr;
    }

    public String getSeite() {
        return seite;
    }

    public void setSeite(String seite) {
        this.seite = seite;
    }

    public String getReihe() {
        return reihe;
    }

    public void setReihe(String reihe) {
        this.reihe = reihe;
    }

    public Integer getBearbeitungsstatus() {
        return bearbeitungsstatus;
    }

    public void setBearbeitungsstatus(Integer bearbeitungsstatus) {
        this.bearbeitungsstatus = bearbeitungsstatus;
    }

    public String getKurzzitierweise() {
        return kurzzitierweise;
    }

    public void setKurzzitierweise(String kurzzitierweise) {
        this.kurzzitierweise = kurzzitierweise;
    }

    public Boolean getPhilologischRelevant() {
        return philologischRelevant;
    }

    public void setPhilologischRelevant(Boolean philologischRelevant) {
        this.philologischRelevant = philologischRelevant;
    }

    public Date getLetzteAenderung() {
        return letzteAenderung;
    }

    public void setLetzteAenderung(Date letzteAenderung) {
        this.letzteAenderung = letzteAenderung;
    }

    public Benutzer getLetzteAenderungVon() {
        return letzteAenderungVon;
    }

    public void setLetzteAenderungVon(Benutzer letzteAenderungVon) {
        this.letzteAenderungVon = letzteAenderungVon;
    }

    public Date getErstellt() {
        return erstellt;
    }

    public void setErstellt(Date erstellt) {
        this.erstellt = erstellt;
    }

    public Benutzer getErstelltVon() {
        return erstelltVon;
    }

    public void setErstelltVon(Benutzer erstelltVon) {
        this.erstelltVon = erstelltVon;
    }

    public BenutzerGruppe getGehoertGruppe() {
        return gehoertGruppe;
    }

    public void setGehoertGruppe(BenutzerGruppe gehoertGruppe) {
        this.gehoertGruppe = gehoertGruppe;
    }

    public int getInLitID() {
        return inLitID;
    }

    public void setInLitID(Integer inLitID) {
        this.inLitID = inLitID;
    }

    public String getInBand() {
        return inBand;
    }

    public void setInBand(String inBand) {
        this.inBand = inBand;
    }

    public String getUmfang() {
        return umfang;
    }

    public void setUmfang(String umfang) {
        this.umfang = umfang;
    }

    public String getAutorJahr() {
        return autorJahr;
    }

    public void setAutorJahr(String autorJahr) {
        this.autorJahr = autorJahr;
    }
    
    
}
