package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "quelle")
public class Quelle {    
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length=255)
    private String bezeichnung;

    @Column(name = "Quellennummer", length=255)
    private String quellennummer;

    @Column(name = "QuellenKommentarDatei", length=255)
    private String quellenKommentarDatei;

    @Column(name = "UeberlieferungsKommentarDatei", length=255)
    private String ueberlieferungsKommentarDatei;
    
    @OneToOne(targetEntity = SelektionBearbeitungsstatus.class)
    @JoinColumn(name = "BearbeitungsstatusID", referencedColumnName="ID")
    private SelektionBearbeitungsstatus bearbeitungsstatus;
    
    @Column(name = "VonTag")
    private Integer vonTag;
    
    @Column(name = "VonMonat")
    private Integer vonMonat;
    
    @Column(name = "VonJahr")
    private Integer vonJahr;
    
    @Column(name = "VonJahrhundert", length=5)
    private String vonJahrhundert;
    
    @Column(name = "BisTag")
    private Integer bisTag;
    
    @Column(name = "BisMonat")
    private Integer bisMonat;
    
    @Column(name = "BisJahr")
    private Integer bisJahr;
    
    @Column(name = "BisJahrhundert", length=5)
    private String bisJahrhundert;
    
    @Column(name = "GenauigkeitVonTag")
    private Integer genauigkeitVonTag;
    
    @Column(name = "GenauigkeitVonMonat")
    private Integer genauigkeitVonMonat;
    
    @Column(name = "GenauigkeitVonJahr")
    private Integer genauigkeitVonJahr;
    
    @Column(name = "GenauigkeitVonJahrhundert")
    private Integer genauigkeitVonJahrhundert;
    
    @Column(name = "DatierungUngewiss" , columnDefinition="BIT DEFAULT NULL")
    private Boolean datierungUngewiss;
    
    @Column(name = "KommentarDatierung", length=255)
    private String kommentarDatierung;
    
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
    
    @Column(name = "GenauigkeitBisTag")
    private Integer genauigkeitBisTag;
    
    @Column(name = "GenauigkeitBisMonat")
    private Integer genauigkeitBisMonat;
    
    @Column(name = "GenauigkeitBisJahr")
    private Integer genauigkeitBisJahr;
    
    @Column(name = "GenauigkeitBisJahrhundert")
    private Integer genauigkeitBisJahrhundert;
    
    @Column(name = "ZuVeroeffentlichen" , columnDefinition="TINYINT(1) DEFAULT NULL")
    private Integer zuVeroeffentlichen;
    
    @Column(name = "CMRef", length=255)
    private String cmRef; 
    
    @ManyToMany(mappedBy = "quellen")
    private List<Edition> editions = new ArrayList<>();

    public Integer getId() {
        return id;
    }

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }

    public String getQuellennummer() {
        return quellennummer;
    }

    public void setQuellennummer(String quellennummer) {
        this.quellennummer = quellennummer;
    }

    public String getQuellenKommentarDatei() {
        return quellenKommentarDatei;
    }

    public void setQuellenKommentarDatei(String quellenKommentarDatei) {
        this.quellenKommentarDatei = quellenKommentarDatei;
    }

    public String getUeberlieferungsKommentarDatei() {
        return ueberlieferungsKommentarDatei;
    }

    public void setUeberlieferungsKommentarDatei(String ueberlieferungsKommentarDatei) {
        this.ueberlieferungsKommentarDatei = ueberlieferungsKommentarDatei;
    }

    public SelektionBearbeitungsstatus getBearbeitungsstatus() {
        return bearbeitungsstatus;
    }

    public void setBearbeitungsstatus(SelektionBearbeitungsstatus bearbeitungsstatus) {
        this.bearbeitungsstatus = bearbeitungsstatus;
    }

    public Integer getVonTag() {
        return vonTag;
    }

    public void setVonTag(Integer vonTag) {
        this.vonTag = vonTag;
    }

    public Integer getVonMonat() {
        return vonMonat;
    }

    public void setVonMonat(Integer vonMonat) {
        this.vonMonat = vonMonat;
    }

    public Integer getVonJahr() {
        return vonJahr;
    }

    public void setVonJahr(Integer vonJahr) {
        this.vonJahr = vonJahr;
    }

    public String getVonJahrhundert() {
        return vonJahrhundert;
    }

    public void setVonJahrhundert(String vonJahrhundert) {
        this.vonJahrhundert = vonJahrhundert;
    }

    public Integer getBisTag() {
        return bisTag;
    }

    public void setBisTag(Integer bisTag) {
        this.bisTag = bisTag;
    }

    public Integer getBisMonat() {
        return bisMonat;
    }

    public void setBisMonat(Integer bisMonat) {
        this.bisMonat = bisMonat;
    }

    public Integer getBisJahr() {
        return bisJahr;
    }

    public void setBisJahr(Integer bisJahr) {
        this.bisJahr = bisJahr;
    }

    public String getBisJahrhundert() {
        return bisJahrhundert;
    }

    public void setBisJahrhundert(String bisJahrhundert) {
        this.bisJahrhundert = bisJahrhundert;
    }

    public Integer getGenauigkeitVonTag() {
        return genauigkeitVonTag;
    }

    public void setGenauigkeitVonTag(Integer genauigkeitVonTag) {
        this.genauigkeitVonTag = genauigkeitVonTag;
    }

    public Integer getGenauigkeitVonMonat() {
        return genauigkeitVonMonat;
    }

    public void setGenauigkeitVonMonat(Integer genauigkeitVonMonat) {
        this.genauigkeitVonMonat = genauigkeitVonMonat;
    }

    public Integer getGenauigkeitVonJahr() {
        return genauigkeitVonJahr;
    }

    public void setGenauigkeitVonJahr(Integer genauigkeitVonJahr) {
        this.genauigkeitVonJahr = genauigkeitVonJahr;
    }

    public Integer getGenauigkeitVonJahrhundert() {
        return genauigkeitVonJahrhundert;
    }

    public void setGenauigkeitVonJahrhundert(Integer genauigkeitVonJahrhundert) {
        this.genauigkeitVonJahrhundert = genauigkeitVonJahrhundert;
    }

    public Boolean getDatierungUngewiss() {
        return datierungUngewiss;
    }

    public void setDatierungUngewiss(Boolean datierungUngewiss) {
        this.datierungUngewiss = datierungUngewiss;
    }

    public String getKommentarDatierung() {
        return kommentarDatierung;
    }

    public void setKommentarDatierung(String kommentarDatierung) {
        this.kommentarDatierung = kommentarDatierung;
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

    public Integer getGenauigkeitBisTag() {
        return genauigkeitBisTag;
    }

    public void setGenauigkeitBisTag(Integer genauigkeitBisTag) {
        this.genauigkeitBisTag = genauigkeitBisTag;
    }

    public Integer getGenauigkeitBisMonat() {
        return genauigkeitBisMonat;
    }

    public void setGenauigkeitBisMonat(Integer genauigkeitBisMonat) {
        this.genauigkeitBisMonat = genauigkeitBisMonat;
    }

    public Integer getGenauigkeitBisJahr() {
        return genauigkeitBisJahr;
    }

    public void setGenauigkeitBisJahr(Integer genauigkeitBisJahr) {
        this.genauigkeitBisJahr = genauigkeitBisJahr;
    }

    public Integer getGenauigkeitBisJahrhundert() {
        return genauigkeitBisJahrhundert;
    }

    public void setGenauigkeitBisJahrhundert(Integer genauigkeitBisJahrhundert) {
        this.genauigkeitBisJahrhundert = genauigkeitBisJahrhundert;
    }

    public Integer getZuVeroeffentlichen() {
        return zuVeroeffentlichen;
    }

    public void setZuVeroeffentlichen(Integer zuVeroeffentlichen) {
        this.zuVeroeffentlichen = zuVeroeffentlichen;
    }

    public String getCmRef() {
        return cmRef;
    }

    public void setCmRef(String cmRef) {
        this.cmRef = cmRef;
    }

    public List<Edition> getEditions() {
        return editions;
    }

    public void addEdition(Edition edition){
        this.getEditions().add(edition);
    }
      
    public void removeEdition(int id){
        for (int i = 0; i < this.getEditions().size(); ) {
            Edition edition = this.getEditions().get(i);
            if(edition.getId() != null && edition.getId() == id){
                this.getEditions().remove(i);
            }else{
                i++;
            }
        }
    }
    
}
