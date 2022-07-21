package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "bemerkung")
public class Bemerkung {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bemerkung", columnDefinition="LONGTEXT")
    private String bemerkung;

    @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;

    @ManyToOne(targetEntity = Quelle.class)
    @JoinColumn(name = "QuelleID", referencedColumnName = "ID")
    private Quelle quelle;

    @ManyToOne(targetEntity = Edition.class)
    @JoinColumn(name = "EditionID", referencedColumnName = "ID")
    private Edition edition;

    @ManyToOne(targetEntity = Handschrift.class)
    @JoinColumn(name = "HandschriftID", referencedColumnName = "ID")
    private Handschrift handschrift;

    @ManyToOne(targetEntity = NamenKommentar.class)
    @JoinColumn(name = "NamenkommentarID", referencedColumnName = "ID")
    private NamenKommentar namenKommentar;

    @ManyToOne(targetEntity = MghLemma.class)
    @JoinColumn(name = "MGHLemmaID", referencedColumnName = "ID")
    private MghLemma mghLemma;

    @ManyToOne(targetEntity = BenutzerGruppe.class)
    @JoinColumn(name = "GruppeID", referencedColumnName = "ID")
    private BenutzerGruppe gruppe;

    @ManyToOne(targetEntity = Benutzer.class)
    @JoinColumn(name = "BenutzerID", referencedColumnName = "ID")
    private Benutzer benutzer;

    public Integer getId() {
        return id;
    }

    public String getBemerkung() {
        return bemerkung;
    }

    public void setBemerkung(String bemerkung) {
        this.bemerkung = bemerkung;
    }

    public Einzelbeleg getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }

    public Quelle getQuelle() {
        return quelle;
    }

    public void setQuelle(Quelle quelle) {
        this.quelle = quelle;
    }

    public Edition getEdition() {
        return edition;
    }

    public void setEdition(Edition edition) {
        this.edition = edition;
    }

    public Handschrift getHandschrift() {
        return handschrift;
    }

    public void setHandschrift(Handschrift handschrift) {
        this.handschrift = handschrift;
    }

    public NamenKommentar getNamenKommentar() {
        return namenKommentar;
    }

    public void setNamenKommentar(NamenKommentar namenKommentar) {
        this.namenKommentar = namenKommentar;
    }

    public MghLemma getMghLemma() {
        return mghLemma;
    }

    public void setMghLemma(MghLemma mghLemma) {
        this.mghLemma = mghLemma;
    }

    public BenutzerGruppe getGruppe() {
        return gruppe;
    }

    public void setGruppe(BenutzerGruppe gruppe) {
        this.gruppe = gruppe;
    }

    public Benutzer getBenutzer() {
        return benutzer;
    }

    public void setBenutzer(Benutzer benutzer) {
        this.benutzer = benutzer;
    }

}
