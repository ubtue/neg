package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "einzelbeleg")
public class Einzelbeleg {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Belegnummer", length = 10)
    private String belegnummer;

    @Column(name = "Kontext", columnDefinition = "TEXT")
    private String kontext;

    @OneToOne(targetEntity = SelektionGeschlecht.class)
    @JoinColumn(name = "GeschlechtID", referencedColumnName = "ID")
    private SelektionGeschlecht geschlecht;

    @OneToOne(targetEntity = SelektionLebendVerstorben.class)
    @JoinColumn(name = "LebendVerstorbenID", referencedColumnName = "ID")
    private SelektionLebendVerstorben lebendVerstorben;

    @OneToOne(targetEntity = Edition.class)
    @JoinColumn(name = "EditionID", referencedColumnName = "ID")
    private Edition edition;

    @OneToOne(targetEntity = Quelle.class)
    @JoinColumn(name = "QuelleID", referencedColumnName = "ID")
    private Quelle quelle;

    @OneToOne(targetEntity = Handschrift.class)
    @JoinColumn(name = "HandschriftID", referencedColumnName = "ID")
    private Handschrift handschrift;

    @Column(name = "EditionKapitel", length = 255)
    private String editionKapitel;

    @Column(name = "EditionSeite", length = 255)
    private String editionSeite;

    @OneToOne(targetEntity = SelektionQuellengattung.class)
    @JoinColumn(name = "QuelleGattungID", referencedColumnName = "ID")
    private SelektionQuellengattung quelleGattung;

    @OneToOne(targetEntity = SelektionEchtheit.class)
    @JoinColumn(name = "QuelleEchtheitID", referencedColumnName = "ID")
    private SelektionEchtheit quelleEchtheit;

    @Column(name = "QuelleDatierung", length = 255)
    private String quelleDatierung;

    @Column(name = "UeberlieferungDatierung", length = 255)
    private String ueberlieferungDatierung;

    @Column(name = "Belegform", length = 255)
    private String belegform;

    @Column(name = "Griechisch", length = 255)
    private String griechisch;

    @Column(name = "Diakritisch", length = 255)
    private String diakritisch;

    @OneToOne(targetEntity = SelektionKasus.class)
    @JoinColumn(name = "KasusID", referencedColumnName = "ID")
    private SelektionKasus kasus;

    @OneToOne(targetEntity = SelektionGrammatikgeschlecht.class)
    @JoinColumn(name = "GrammatikGeschlechtID", referencedColumnName = "ID")
    private SelektionGrammatikgeschlecht grammatikGeschlecht;

    @Column(name = "ASWQuellenzitat", columnDefinition = "TEXT")
    private String aswQuellenzitat;

    @Column(name = "Bemerkung", columnDefinition = "TEXT")
    private String bemerkung;

    @OneToOne(targetEntity = SelektionBearbeitungsstatus.class)
    @JoinColumn(name = "BearbeitungsstatusID", referencedColumnName = "ID")
    private SelektionBearbeitungsstatus bearbeitungsstatus;

    @Column(name = "KommentarEthnie", columnDefinition = "TEXT")
    private String kommentarEthnie;

    @Column(name = "KommentarAreal", columnDefinition = "TEXT")
    private String kommentarAreal;

    @Column(name = "KommentarVerwandtschaft", columnDefinition = "TEXT")
    private String kommentarVerwandtschaft;

    @Column(name = "Eindeutig", columnDefinition = "BIT DEFAULT NULL")
    private Boolean eindeutig;

    @Column(name = "VonTag")
    private Integer vonTag;

    @Column(name = "VonMonat")
    private Integer vonMonat;

    @Column(name = "VonJahr")
    private Integer vonJahr;

    @Column(name = "VonJahrhundert", length = 5)
    private String vonJahrhundert;

    @Column(name = "BisTag")
    private Integer bisTag;

    @Column(name = "BisMonat")
    private Integer bisMonat;

    @Column(name = "BisJahr")
    private Integer bisJahr;

    @Column(name = "BisJahrhundert", length = 5)
    private String bisJahrhundert;

    @Column(name = "DatierungUngewiss", columnDefinition = "TINYINT(1)")
    private Boolean datierungUngewiss;

    @Column(name = "KommentarDatierung", length = 255)
    private String kommentarDatierung;

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

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitBisTag", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitBisTag;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitBisMonat", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitBisMonat;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitBisJahr", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitBisJahr;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitBisJahrhundert", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitBisJahrhundert;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitVonTag", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitVonTag;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitVonMonat", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitVonMonat;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitVonJahr", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitVonJahr;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitVonJahrhundert", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitVonJahrhundert;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleBisTag", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleBisTag;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleBisMonat", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleBisMonat;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleBisJahr", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleBisJahr;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleBisJahrhundert", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleBisJahrhundert;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleVonTag", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleVonTag;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleVonMonat", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleVonMonat;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleVonJahr", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleVonJahr;

    @OneToOne(targetEntity = SelektionDatGenauigkeit.class)
    @JoinColumn(name = "GenauigkeitQuelleVonJahrhundert", referencedColumnName = "ID")
    private SelektionDatGenauigkeit genauigkeitQuelleVonJahrhundert;

    @Column(name = "QuelleBisTag")
    private Integer quelleBisTag;

    @Column(name = "QuelleBisMonat")
    private Integer quelleBisMonat;

    @Column(name = "QuelleBisJahr")
    private Integer quelleBisJahr;

    @Column(name = "QuelleBisJahrhundert", length = 5)
    private String quelleBisJahrhundert;

    @Column(name = "QuelleVonTag")
    private Integer quelleVonTag;

    @Column(name = "QuelleVonMonat")
    private Integer quelleVonMonat;

    @Column(name = "QuelleVonJahr")
    private Integer quelleVonJahr;

    @Column(name = "QuelleVonJahrhundert", length = 5)
    private String quelleVonJahrhundert;

    @Column(name = "KommentarPerson", columnDefinition = "TEXT")
    private String kommentarPerson;

    @Column(name = "MGHLemmaKorrigiert", columnDefinition = "BIT DEFAULT NULL")
    private Boolean mghLemmaKorrigiert;

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "einzelbeleg_hatamtweihe",
            joinColumns = {
                @JoinColumn(name = "EinzelbelegID")},
            inverseJoinColumns = {
                @JoinColumn(name = "AmtWeiheID")}
    )
    List<SelektionAmtWeihe> amtWeihe = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "einzelbeleg_hatareal",
            joinColumns = {
                @JoinColumn(name = "EinzelbelegID")},
            inverseJoinColumns = {
                @JoinColumn(name = "ArealID")}
    )
    List<SelektionAreal> areal = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "einzelbeleg_hatfunktion",
            joinColumns = {
                @JoinColumn(name = "EinzelbelegID")},
            inverseJoinColumns = {
                @JoinColumn(name = "FunktionID")}
    )
    List<SelektionFunktion> funktion = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "einzelbeleg_hatmghlemma",
            joinColumns = {
                @JoinColumn(name = "EinzelbelegID")},
            inverseJoinColumns = {
                @JoinColumn(name = "MGHLemmaID")}
    )
    List<MghLemma> mghLemma = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "einzelbeleg_hatnamenkommentar",
            joinColumns = {
                @JoinColumn(name = "EinzelbelegID")},
            inverseJoinColumns = {
                @JoinColumn(name = "NamenkommentarID")}
    )
    List<NamenKommentar> namenKommentar = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "einzelbeleg_hatperson",
            joinColumns = {
                @JoinColumn(name = "EinzelbelegID")},
            inverseJoinColumns = {
                @JoinColumn(name = "PersonID")}
    )
    List<Person> person = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
            name = "einzelbeleg_hatstand",
            joinColumns = {
                @JoinColumn(name = "EinzelbelegID")},
            inverseJoinColumns = {
                @JoinColumn(name = "StandID")}
    )
    List<SelektionStand> stand = new ArrayList<>();

    public Integer getId() {
        return id;
    }

    public String getBelegnummer() {
        return belegnummer;
    }

    public String getKontext() {
        return kontext;
    }

    public SelektionGeschlecht getGeschlecht() {
        return geschlecht;
    }

    public SelektionLebendVerstorben getLebendVerstorben() {
        return lebendVerstorben;
    }

    public Edition getEdition() {
        return edition;
    }

    public Quelle getQuelle() {
        return quelle;
    }

    public Handschrift getHandschrift() {
        return handschrift;
    }

    public String getEditionKapitel() {
        return editionKapitel;
    }

    public String getEditionSeite() {
        return editionSeite;
    }

    public SelektionQuellengattung getQuelleGattung() {
        return quelleGattung;
    }

    public SelektionEchtheit getQuelleEchtheit() {
        return quelleEchtheit;
    }

    public String getQuelleDatierung() {
        return quelleDatierung;
    }

    public String getUeberlieferungDatierung() {
        return ueberlieferungDatierung;
    }

    public String getBelegform() {
        return belegform;
    }

    public String getGriechisch() {
        return griechisch;
    }

    public String getDiakritisch() {
        return diakritisch;
    }

    public SelektionKasus getKasus() {
        return kasus;
    }

    public SelektionGrammatikgeschlecht getGrammatikGeschlecht() {
        return grammatikGeschlecht;
    }

    public String getAswQuellenzitat() {
        return aswQuellenzitat;
    }

    public String getBemerkung() {
        return bemerkung;
    }

    public SelektionBearbeitungsstatus getBearbeitungsstatus() {
        return bearbeitungsstatus;
    }

    public String getKommentarEthnie() {
        return kommentarEthnie;
    }

    public String getKommentarAreal() {
        return kommentarAreal;
    }

    public String getKommentarVerwandtschaft() {
        return kommentarVerwandtschaft;
    }

    public Boolean getEindeutig() {
        return eindeutig;
    }

    public Integer getVonTag() {
        return vonTag;
    }

    public Integer getVonMonat() {
        return vonMonat;
    }

    public Integer getVonJahr() {
        return vonJahr;
    }

    public String getVonJahrhundert() {
        return vonJahrhundert;
    }

    public Integer getBisTag() {
        return bisTag;
    }

    public Integer getBisMonat() {
        return bisMonat;
    }

    public Integer getBisJahr() {
        return bisJahr;
    }

    public String getBisJahrhundert() {
        return bisJahrhundert;
    }

    public Boolean getDatierungUngewiss() {
        return datierungUngewiss;
    }

    public String getKommentarDatierung() {
        return kommentarDatierung;
    }

    public Date getLetzteAenderung() {
        return letzteAenderung;
    }

    public Benutzer getLetzteAenderungVon() {
        return letzteAenderungVon;
    }

    public Date getErstellt() {
        return erstellt;
    }

    public Benutzer getErstelltVon() {
        return erstelltVon;
    }

    public BenutzerGruppe getGehoertGruppe() {
        return gehoertGruppe;
    }

    public SelektionDatGenauigkeit getGenauigkeitBisTag() {
        return genauigkeitBisTag;
    }

    public SelektionDatGenauigkeit getGenauigkeitBisMonat() {
        return genauigkeitBisMonat;
    }

    public SelektionDatGenauigkeit getGenauigkeitBisJahr() {
        return genauigkeitBisJahr;
    }

    public SelektionDatGenauigkeit getGenauigkeitBisJahrhundert() {
        return genauigkeitBisJahrhundert;
    }

    public SelektionDatGenauigkeit getGenauigkeitVonTag() {
        return genauigkeitVonTag;
    }

    public SelektionDatGenauigkeit getGenauigkeitVonMonat() {
        return genauigkeitVonMonat;
    }

    public SelektionDatGenauigkeit getGenauigkeitVonJahr() {
        return genauigkeitVonJahr;
    }

    public SelektionDatGenauigkeit getGenauigkeitVonJahrhundert() {
        return genauigkeitVonJahrhundert;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleBisTag() {
        return genauigkeitQuelleBisTag;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleBisMonat() {
        return genauigkeitQuelleBisMonat;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleBisJahr() {
        return genauigkeitQuelleBisJahr;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleBisJahrhundert() {
        return genauigkeitQuelleBisJahrhundert;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleVonTag() {
        return genauigkeitQuelleVonTag;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleVonMonat() {
        return genauigkeitQuelleVonMonat;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleVonJahr() {
        return genauigkeitQuelleVonJahr;
    }

    public SelektionDatGenauigkeit getGenauigkeitQuelleVonJahrhundert() {
        return genauigkeitQuelleVonJahrhundert;
    }

    public Integer getQuelleBisTag() {
        return quelleBisTag;
    }

    public Integer getQuelleBisMonat() {
        return quelleBisMonat;
    }

    public Integer getQuelleBisJahr() {
        return quelleBisJahr;
    }

    public String getQuelleBisJahrhundert() {
        return quelleBisJahrhundert;
    }

    public Integer getQuelleVonTag() {
        return quelleVonTag;
    }

    public Integer getQuelleVonMonat() {
        return quelleVonMonat;
    }

    public Integer getQuelleVonJahr() {
        return quelleVonJahr;
    }

    public String getQuelleVonJahrhundert() {
        return quelleVonJahrhundert;
    }

    public String getKommentarPerson() {
        return kommentarPerson;
    }

    public Boolean getMghLemmaKorrigiert() {
        return mghLemmaKorrigiert;
    }

    public List<SelektionAmtWeihe> getAmtWeihe() {
        return amtWeihe;
    }

    public List<SelektionAreal> getAreal() {
        return areal;
    }

    public List<SelektionFunktion> getFunktion() {
        return funktion;
    }

    public List<MghLemma> getMghLemma() {
        return mghLemma;
    }

    public List<NamenKommentar> getNamenKommentar() {
        return namenKommentar;
    }

    public List<Person> getPerson() {
        return person;
    }

    public List<SelektionStand> getStand() {
        return stand;
    }

    public void setBelegnummer(String belegnummer) {
        this.belegnummer = belegnummer;
    }

    public void setKontext(String kontext) {
        this.kontext = kontext;
    }

    public void setGeschlecht(SelektionGeschlecht geschlecht) {
        this.geschlecht = geschlecht;
    }

    public void setLebendVerstorben(SelektionLebendVerstorben lebendVerstorben) {
        this.lebendVerstorben = lebendVerstorben;
    }

    public void setEdition(Edition edition) {
        this.edition = edition;
    }

    public void setQuelle(Quelle quelle) {
        this.quelle = quelle;
    }

    public void setHandschrift(Handschrift handschrift) {
        this.handschrift = handschrift;
    }

    public void setEditionKapitel(String editionKapitel) {
        this.editionKapitel = editionKapitel;
    }

    public void setEditionSeite(String editionSeite) {
        this.editionSeite = editionSeite;
    }

    public void setQuelleGattung(SelektionQuellengattung quelleGattung) {
        this.quelleGattung = quelleGattung;
    }

    public void setQuelleEchtheit(SelektionEchtheit quelleEchtheit) {
        this.quelleEchtheit = quelleEchtheit;
    }

    public void setQuelleDatierung(String quelleDatierung) {
        this.quelleDatierung = quelleDatierung;
    }

    public void setUeberlieferungDatierung(String ueberlieferungDatierung) {
        this.ueberlieferungDatierung = ueberlieferungDatierung;
    }

    public void setBelegform(String belegform) {
        this.belegform = belegform;
    }

    public void setGriechisch(String griechisch) {
        this.griechisch = griechisch;
    }

    public void setDiakritisch(String diakritisch) {
        this.diakritisch = diakritisch;
    }

    public void setKasus(SelektionKasus kasus) {
        this.kasus = kasus;
    }

    public void setGrammatikGeschlecht(SelektionGrammatikgeschlecht grammatikGeschlecht) {
        this.grammatikGeschlecht = grammatikGeschlecht;
    }

    public void setAswQuellenzitat(String aswQuellenzitat) {
        this.aswQuellenzitat = aswQuellenzitat;
    }

    public void setBemerkung(String bemerkung) {
        this.bemerkung = bemerkung;
    }

    public void setBearbeitungsstatus(SelektionBearbeitungsstatus bearbeitungsstatus) {
        this.bearbeitungsstatus = bearbeitungsstatus;
    }

    public void setKommentarEthnie(String kommentarEthnie) {
        this.kommentarEthnie = kommentarEthnie;
    }

    public void setKommentarAreal(String kommentarAreal) {
        this.kommentarAreal = kommentarAreal;
    }

    public void setKommentarVerwandtschaft(String kommentarVerwandtschaft) {
        this.kommentarVerwandtschaft = kommentarVerwandtschaft;
    }

    public void setEindeutig(Boolean eindeutig) {
        this.eindeutig = eindeutig;
    }

    public void setVonTag(Integer vonTag) {
        this.vonTag = vonTag;
    }

    public void setVonMonat(Integer vonMonat) {
        this.vonMonat = vonMonat;
    }

    public void setVonJahr(Integer vonJahr) {
        this.vonJahr = vonJahr;
    }

    public void setVonJahrhundert(String vonJahrhundert) {
        this.vonJahrhundert = vonJahrhundert;
    }

    public void setBisTag(Integer bisTag) {
        this.bisTag = bisTag;
    }

    public void setBisMonat(Integer bisMonat) {
        this.bisMonat = bisMonat;
    }

    public void setBisJahr(Integer bisJahr) {
        this.bisJahr = bisJahr;
    }

    public void setBisJahrhundert(String bisJahrhundert) {
        this.bisJahrhundert = bisJahrhundert;
    }

    public void setDatierungUngewiss(Boolean datierungUngewiss) {
        this.datierungUngewiss = datierungUngewiss;
    }

    public void setKommentarDatierung(String kommentarDatierung) {
        this.kommentarDatierung = kommentarDatierung;
    }

    public void setLetzteAenderung(Date letzteAenderung) {
        this.letzteAenderung = letzteAenderung;
    }

    public void setLetzteAenderungVon(Benutzer letzteAenderungVon) {
        this.letzteAenderungVon = letzteAenderungVon;
    }

    public void setErstellt(Date erstellt) {
        this.erstellt = erstellt;
    }

    public void setErstelltVon(Benutzer erstelltVon) {
        this.erstelltVon = erstelltVon;
    }

    public void setGehoertGruppe(BenutzerGruppe gehoertGruppe) {
        this.gehoertGruppe = gehoertGruppe;
    }

    public void setGenauigkeitBisTag(SelektionDatGenauigkeit genauigkeitBisTag) {
        this.genauigkeitBisTag = genauigkeitBisTag;
    }

    public void setGenauigkeitBisMonat(SelektionDatGenauigkeit genauigkeitBisMonat) {
        this.genauigkeitBisMonat = genauigkeitBisMonat;
    }

    public void setGenauigkeitBisJahr(SelektionDatGenauigkeit genauigkeitBisJahr) {
        this.genauigkeitBisJahr = genauigkeitBisJahr;
    }

    public void setGenauigkeitBisJahrhundert(SelektionDatGenauigkeit genauigkeitBisJahrhundert) {
        this.genauigkeitBisJahrhundert = genauigkeitBisJahrhundert;
    }

    public void setGenauigkeitVonTag(SelektionDatGenauigkeit genauigkeitVonTag) {
        this.genauigkeitVonTag = genauigkeitVonTag;
    }

    public void setGenauigkeitVonMonat(SelektionDatGenauigkeit genauigkeitVonMonat) {
        this.genauigkeitVonMonat = genauigkeitVonMonat;
    }

    public void setGenauigkeitVonJahr(SelektionDatGenauigkeit genauigkeitVonJahr) {
        this.genauigkeitVonJahr = genauigkeitVonJahr;
    }

    public void setGenauigkeitVonJahrhundert(SelektionDatGenauigkeit genauigkeitVonJahrhundert) {
        this.genauigkeitVonJahrhundert = genauigkeitVonJahrhundert;
    }

    public void setGenauigkeitQuelleBisTag(SelektionDatGenauigkeit genauigkeitQuelleBisTag) {
        this.genauigkeitQuelleBisTag = genauigkeitQuelleBisTag;
    }

    public void setGenauigkeitQuelleBisMonat(SelektionDatGenauigkeit genauigkeitQuelleBisMonat) {
        this.genauigkeitQuelleBisMonat = genauigkeitQuelleBisMonat;
    }

    public void setGenauigkeitQuelleBisJahr(SelektionDatGenauigkeit genauigkeitQuelleBisJahr) {
        this.genauigkeitQuelleBisJahr = genauigkeitQuelleBisJahr;
    }

    public void setGenauigkeitQuelleBisJahrhundert(SelektionDatGenauigkeit genauigkeitQuelleBisJahrhundert) {
        this.genauigkeitQuelleBisJahrhundert = genauigkeitQuelleBisJahrhundert;
    }

    public void setGenauigkeitQuelleVonTag(SelektionDatGenauigkeit genauigkeitQuelleVonTag) {
        this.genauigkeitQuelleVonTag = genauigkeitQuelleVonTag;
    }

    public void setGenauigkeitQuelleVonMonat(SelektionDatGenauigkeit genauigkeitQuelleVonMonat) {
        this.genauigkeitQuelleVonMonat = genauigkeitQuelleVonMonat;
    }

    public void setGenauigkeitQuelleVonJahr(SelektionDatGenauigkeit genauigkeitQuelleVonJahr) {
        this.genauigkeitQuelleVonJahr = genauigkeitQuelleVonJahr;
    }

    public void setGenauigkeitQuelleVonJahrhundert(SelektionDatGenauigkeit genauigkeitQuelleVonJahrhundert) {
        this.genauigkeitQuelleVonJahrhundert = genauigkeitQuelleVonJahrhundert;
    }

    public void setQuelleBisTag(Integer quelleBisTag) {
        this.quelleBisTag = quelleBisTag;
    }

    public void setQuelleBisMonat(Integer quelleBisMonat) {
        this.quelleBisMonat = quelleBisMonat;
    }

    public void setQuelleBisJahr(Integer quelleBisJahr) {
        this.quelleBisJahr = quelleBisJahr;
    }

    public void setQuelleBisJahrhundert(String quelleBisJahrhundert) {
        this.quelleBisJahrhundert = quelleBisJahrhundert;
    }

    public void setQuelleVonTag(Integer quelleVonTag) {
        this.quelleVonTag = quelleVonTag;
    }

    public void setQuelleVonMonat(Integer quelleVonMonat) {
        this.quelleVonMonat = quelleVonMonat;
    }

    public void setQuelleVonJahr(Integer quelleVonJahr) {
        this.quelleVonJahr = quelleVonJahr;
    }

    public void setQuelleVonJahrhundert(String quelleVonJahrhundert) {
        this.quelleVonJahrhundert = quelleVonJahrhundert;
    }

    public void setKommentarPerson(String kommentarPerson) {
        this.kommentarPerson = kommentarPerson;
    }

    public void setMghLemmaKorrigiert(Boolean mghLemmaKorrigiert) {
        this.mghLemmaKorrigiert = mghLemmaKorrigiert;
    }

    public void setMghLemma(List<MghLemma> mghLemma) {
        this.mghLemma = mghLemma;
    }
}
