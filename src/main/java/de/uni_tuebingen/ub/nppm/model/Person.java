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

    @Column(name = "PersonenkommentarDatei", length = 255)
    private String personenkommentarDatei;

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

    @Column(name = "CMRef", length = 255)
    private String cmRef;

    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(
            name = "person_hatstand",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "StandID")}
    )
    List<SelektionStand> stand = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(
            name = "person_hatamtstandweihe",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "AmtWeiheID")}
    )
    List<SelektionAmtStandWeihe> amtStandWeihe = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(
            name = "person_hatareal",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "ArealID")}
    )
    List<SelektionAreal> areal = new ArrayList<>();

    @OneToMany(mappedBy = "person", cascade = CascadeType.ALL)
    private List<PersonQuiet> quiet = new ArrayList<>();

    @OneToMany(mappedBy = "person", cascade = CascadeType.ALL)
    private List<PersonVariante> variante = new ArrayList<>();
    
    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(
            name = "person_hatethnie",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "EthnieID")}
    )
    List<SelektionEthnie> ethnie = new ArrayList<>();
    
    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(
            name = "person_hatethnie",
            joinColumns = {
                @JoinColumn(name = "PersonID")},
            inverseJoinColumns = {
                @JoinColumn(name = "EthnienerhaltID")}
    )
    List<SelektionEthnienErhalt> ethnieErhalt = new ArrayList<>();
    
    @ManyToMany(mappedBy = "person")
    private List<Einzelbeleg> einzelbeleg = new ArrayList<>();

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

    public String getPersonenkommentarDatei() {
        return personenkommentarDatei;
    }

    public void setPersonenkommentarDatei(String personenkommentarDatei) {
        this.personenkommentarDatei = personenkommentarDatei;
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

    public String getCmRef() {
        return cmRef;
    }

    public void setCmRef(String cmRef) {
        this.cmRef = cmRef;
    }

    public List<SelektionStand> getStand() {
        return stand;
    }

    public List<SelektionAmtStandWeihe> getAmtStandWeihe() {
        return amtStandWeihe;
    }

    public List<SelektionAreal> getAreal() {
        return areal;
    }

    public List<PersonQuiet> getQuiet() {
        return quiet;
    }

    public List<PersonVariante> getVariante() {
        return variante;
    }

    public List<SelektionEthnie> getEthnie() {
        return ethnie;
    }

    public List<SelektionEthnienErhalt> getEthnieErhalt() {
        return ethnieErhalt;
    }
    
    public List<Einzelbeleg> getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(List<Einzelbeleg> einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }
    
    public void addStand(SelektionStand s) {
        this.getStand().add(s);
    }

    public void removeStand(int id) {
        for (int i = 0; i < this.getStand().size();) {
            SelektionStand s = this.getStand().get(i);
            if (s.getId() != null && s.getId() == id) {
                this.getStand().remove(i);
            } else {
                i++;
            }
        }
    }

    public void addAmtStandWeihe(SelektionAmtStandWeihe s) {
        this.getAmtStandWeihe().add(s);
    }

    public void removeAmtStandWeihe(int id) {
        for (int i = 0; i < this.getAmtStandWeihe().size();) {
            SelektionAmtStandWeihe s = this.getAmtStandWeihe().get(i);
            if (s.getId() != null && s.getId() == id) {
                this.getAmtStandWeihe().remove(i);
            } else {
                i++;
            }
        }
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
        for (int i = 0; i < this.getAreal().size();) {
            SelektionAreal s = this.getAreal().get(i);
            if (s.getId() != null && s.getId() == id) {
                this.getAreal().remove(i);
            } else {
                i++;
            }
        }
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
        for (int i = 0; i < this.getEthnie().size();) {
            SelektionEthnie s = this.getEthnie().get(i);
            if (s.getId() != null && s.getId() == id) {
                this.getEthnie().remove(i);
            } else {
                i++;
            }
        }
    }
    
    public void addEthnieErhalt(SelektionEthnienErhalt ethnieErhalt) {
        this.getEthnieErhalt().add(ethnieErhalt);
    }

    public void removeEthnieErhalt(int id) {
        for (int i = 0; i < this.getEthnieErhalt().size();) {
            SelektionEthnienErhalt s = this.getEthnieErhalt().get(i);
            if (s.getId() != null && s.getId() == id) {
                this.getEthnieErhalt().remove(i);
            } else {
                i++;
            }
        }
    }
    
    public void addEinzelbeleg(Einzelbeleg beleg) {
        this.getEinzelbeleg().add(beleg);
    }

    public void removeEinzelbeleg(int id) {
        for (int i = 0; i < this.getEinzelbeleg().size();) {
            Einzelbeleg beleg = this.getEinzelbeleg().get(i);
            if (beleg.getId() != null && beleg.getId() == id) {
                this.getEinzelbeleg().remove(i);
            } else {
                i++;
            }
        }
    }
}
