package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "PKZ", length = 10)
    private String pkz;

    @Column(name = "Standardname", length = 255)
    private String standardname;

    @OneToOne(targetEntity = SelektionGeschlecht.class)
    @JoinColumn(name = "Geschlecht", referencedColumnName = "ID")
    private SelektionGeschlecht geschlecht;

    @OneToOne(targetEntity = SelektionJaNein.class)
    @JoinColumn(name = "Fiktiv", referencedColumnName = "ID")
    private SelektionJaNein fiktiv;

    @OneToOne(targetEntity = SelektionBearbeitungsstatus.class)
    @JoinColumn(name = "BearbeitungsstatusID", referencedColumnName = "ID")
    private SelektionBearbeitungsstatus bearbeitungsstatus;

    @Column(name = "KommentarEthnie", columnDefinition = "LONGTEXT")
    private String kommentarEthnie;

    @Column(name = "KommentarAreal", columnDefinition = "LONGTEXT")
    private String kommentarAreal;

    @Column(name = "Identifizierungsproblem", columnDefinition = "LONGTEXT")
    private String identifizierungsproblem;

    @Column(name = "Ort", length = 255)
    private String ort;

    @Column(name = "LetzteAenderung")
    private Date letzteAenderung;

    @OneToOne(targetEntity = Benutzer.class)
    @JoinColumn(name = "LetzteAenderungVon", referencedColumnName = "ID")
    private Benutzer letzteAenderungVon;

    @Column(name = "Erstellt")
    private Date erstellt;

    @OneToOne(targetEntity = Benutzer.class)
    @JoinColumn(name = "ErstelltVon", referencedColumnName = "ID")
    private Benutzer erstelltVon;

    @OneToOne(targetEntity = BenutzerGruppe.class)
    @JoinColumn(name = "GehoertGruppe", referencedColumnName = "ID")
    private BenutzerGruppe gehoertGruppe;

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "person_hatstand",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "StandID")}
    )
    Set<SelektionStand> stand = new HashSet<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "person_hatamtstandweihe",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "AmtWeiheID")}
    )
    Set<SelektionAmtWeihe> amtWeihe = new HashSet<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "person_hatareal",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "ArealID")}
    )
    Set<SelektionAreal> areal = new HashSet<>();

     @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "person_hatgruppeherkunftareal",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "ArealID")}
    )
    Set<SelektionAreal> arealGruppe = new HashSet<>();

    @OneToMany(mappedBy = "person", cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    private List<PersonQuiet> quiet = new ArrayList<>();

    @OneToMany(mappedBy = "person", cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    private List<PersonVariante> variante = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "person_hatethnie",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "EthnieID")}
    )
    Set<SelektionEthnie> ethnie = new HashSet<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "person_hatethnie",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "EthnienerhaltID")}
    )
    Set<SelektionEthnienErhalt> ethnieErhalt = new HashSet<>();

    @ManyToMany(mappedBy = "person")
    private Set<Einzelbeleg> einzelbeleg = new HashSet<>();

    public Integer getId() {
        return id;
    }

    public String getPkz() {
        return pkz;
    }

    public void setPkz(String pkz) {
        this.pkz = pkz;
    }

    public String getStandardname() {
        return standardname;
    }

    public void setStandardname(String standardname) {
        this.standardname = standardname;
    }

    public SelektionGeschlecht getGeschlecht() {
        return geschlecht;
    }

    public void setGeschlecht(SelektionGeschlecht geschlecht) {
        this.geschlecht = geschlecht;
    }

    public SelektionJaNein getFiktiv() {
        return fiktiv;
    }

    public void setFiktiv(SelektionJaNein fiktiv) {
        this.fiktiv = fiktiv;
    }

    public SelektionBearbeitungsstatus getBearbeitungsstatus() {
        return bearbeitungsstatus;
    }

    public void setBearbeitungsstatus(SelektionBearbeitungsstatus bearbeitungsstatus) {
        this.bearbeitungsstatus = bearbeitungsstatus;
    }

    public String getKommentarEthnie() {
        return kommentarEthnie;
    }

    public void setKommentarEthnie(String kommentarEthnie) {
        this.kommentarEthnie = kommentarEthnie;
    }

    public String getKommentarAreal() {
        return kommentarAreal;
    }

    public void setKommentarAreal(String kommentarAreal) {
        this.kommentarAreal = kommentarAreal;
    }

    public String getIdentifizierungsproblem() {
        return identifizierungsproblem;
    }

    public void setIdentifizierungsproblem(String identifizierungsproblem) {
        this.identifizierungsproblem = identifizierungsproblem;
    }

    public String getOrt() {
        return ort;
    }

    public void setOrt(String ort) {
        this.ort = ort;
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

    public Set<SelektionStand> getStand() {
        return stand;
    }

    public Set<SelektionAmtWeihe> getAmtWeihe() {
        return amtWeihe;
    }

    public Set<SelektionAreal> getAreal() {
        return areal;
    }

     public Set<SelektionAreal> getArealGruppe() {
        return arealGruppe;
    }

    public List<PersonQuiet> getQuiet() {
        return quiet;
    }

    public List<PersonVariante> getVariante() {
        return variante;
    }

    public Set<SelektionEthnie> getEthnie() {
        return ethnie;
    }

    public Set<SelektionEthnienErhalt> getEthnieErhalt() {
        return ethnieErhalt;
    }

    public Set<Einzelbeleg> getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Set<Einzelbeleg> einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }

    public void addStand(SelektionStand s) {
        this.getStand().add(s);
    }

    public void removeStand(int id) {
        this.getStand().removeIf(e -> e.getId() == id);
    }

    public void addAmtWeihe(SelektionAmtWeihe s) {
        this.getAmtWeihe().add(s);
    }

    public void removeAmtWeihe(int id) {
        this.getAmtWeihe().removeIf(e -> e.getId() == id);
    }

    public void addQuiet(PersonQuiet p) {
        this.getQuiet().add(p);
    }

    public void removeQuiet(int id) {
        for (int i = 0; i < this.getQuiet().size();) {
            PersonQuiet s = this.getQuiet().get(i);
            if (s.getId() != null && s.getId() == id) {
                this.getQuiet().remove(i);
            } else {
                i++;
            }
        }
    }

    public void addAreal(SelektionAreal selA) {
        this.getAreal().add(selA);
    }

    public void removeAreal(int id) {
        this.getAreal().removeIf(e -> e.getId() == id);
    }

    public void addVariante(PersonVariante pV) {
        this.getVariante().add(pV);
    }

    public void removeVariante(int id) {
        for (int i = 0; i < this.getVariante().size();) {
            PersonVariante s = this.getVariante().get(i);
            if (s.getId() != null && s.getId() == id) {
                this.getVariante().remove(i);
            } else {
                i++;
            }
        }
    }

    public void addEthnie(SelektionEthnie ethnie) {
        this.getEthnie().add(ethnie);
    }

    public void removeEthnie(int id) {
        this.getEthnie().removeIf(e -> e.getId() == id);
    }

    public void addEthnieErhalt(SelektionEthnienErhalt ethnieErhalt) {
        this.getEthnieErhalt().add(ethnieErhalt);
    }

    public void removeEthnieErhalt(int id) {
        this.getEthnieErhalt().removeIf(e -> e.getId() == id);
    }

    public void addEinzelbeleg(Einzelbeleg beleg) {
        this.getEinzelbeleg().add(beleg);
    }

    public void removeEinzelbeleg(int id) {
        this.getEinzelbeleg().removeIf(e -> e.getId() == id);
    }
}