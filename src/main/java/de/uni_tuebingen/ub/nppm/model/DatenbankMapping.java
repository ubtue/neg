package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Table(name = "datenbank_mapping")
public class DatenbankMapping {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    // As soon as this class is used everywhere, we can normalize the columns.
    // Right now, we have de_Beschriftung, but fr_beschriftung and so on.
    @Column(name = "de_Beschriftung", length = 255)
    private String deBeschriftung;

    @Column(name = "Formular", length = 50)
    private String formular;

    @Column(name = "Datenfeld", length = 50)
    private String datenfeld;

    @Column(name = "Feldtyp", length = 255)
    private String feldtyp;

    @Column(name = "Array", columnDefinition = "BIT")
    private Boolean array;

    @Column(name = "ZielTabelle", length = 50)
    private String zielTabelle;

    @Column(name = "ZielAttribut", length = 255)
    private String zielAttribut;

    @Column(name = "FormularAttribut", length = 255)
    private String formularAttribut;

    @Column(name = "Auswahlherkunft", length = 50)
    private String auswahlherkunft;

    @Column(name = "Auswahlherkunft_Filter", length = 255)
    private String auswahlherkunftFilter;

    @Column(name = "Filter", length = 255)
    private String filter;

    @Column(name = "combinedFeldnamen", length = 255)
    private String combinedFeldnamen;

    @Column(name = "combinedFeldtypen", length = 255)
    private String combinedFeldtypen;

    @Column(name = "de_combinedAnzeigenamen", length = 255)
    private String deCombinedAnzeigenamen;

    @Column(name = "buttonAktion", length = 255)
    private String buttonAktion;

    @Column(name = "Seite", length = 255)
    private String seite;

    @Column(name = "default", length = 255)
    private String alt;

    @Column(name = "schema_org_property", length = 255)
    private String schemaOrgProperty;

    @Column(name = "gb_beschriftung", length = 255)
    private String gbBeschriftung;

    @Column(name = "fr_beschriftung", length = 255)
    private String frBeschriftung;

    @Column(name = "gb_combinedAnzeigenamen", length = 255)
    private String gbCombinedAnzeigenamen;

    @Column(name = "fr_combinedAnzeigenamen", length = 255)
    private String frCombinedAnzeigenamen;

    @Column(name = "la_beschriftung", length = 255)
    private String laBeschriftung;

    @Column(name = "la_combinedAnzeigenamen", length = 255)
    private String laCombinedAnzeigenamen;

    @Column(name = "de_Platzhalter", length = 255)
    private String dePlatzhalter;

    @Column(name = "fr_Platzhalter", length = 255)
    private String frPlatzhalter;

    @Column(name = "gb_Platzhalter", length = 255)
    private String gbPlatzhalter;

    @Column(name = "la_Platzhalter", length = 255)
    private String laPlatzhalter;

    @Column(name = "de_Tooltip", columnDefinition = "MEDIUMTEXT")
    private String deTooltip;

    @Column(name = "fr_Tooltip", columnDefinition = "MEDIUMTEXT")
    private String frTooltip;

    @Column(name = "gb_Tooltip", columnDefinition = "MEDIUMTEXT")
    private String gbTooltip;

    @Column(name = "la_Tooltip", columnDefinition = "MEDIUMTEXT")
    private String laTooltip;

    public Integer getId() {
        return id;
    }

    public String getBeschriftung(String language) throws NoSuchFieldException, IllegalAccessException {
        return (String)DatenbankMapping.class.getDeclaredField(language.toLowerCase() + "Beschriftung").get(this);
    }

    public String getDeBeschriftung() {
        return deBeschriftung;
    }

    public void setDeBeschriftung(String deBeschriftung) {
        this.deBeschriftung = deBeschriftung;
    }

    public String getFormular() {
        return formular;
    }

    public void setFormular(String formular) {
        this.formular = formular;
    }

    public String getDatenfeld() {
        return datenfeld;
    }

    public void setDatenfeld(String datenfeld) {
        this.datenfeld = datenfeld;
    }

    public String getFeldtyp() {
        return feldtyp;
    }

    public void setFeldtyp(String feldtyp) {
        this.feldtyp = feldtyp;
    }

    public Boolean getArray() {
        return array;
    }

    public void setArray(Boolean array) {
        this.array = array;
    }

    public String getZielTabelle() {
        return zielTabelle;
    }

    public void setZielTabelle(String zielTabelle) {
        this.zielTabelle = zielTabelle;
    }

    public String getZielAttribut() {
        return zielAttribut;
    }

    public void setZielAttribut(String zielAttribut) {
        this.zielAttribut = zielAttribut;
    }

    public String getFormularAttribut() {
        return formularAttribut;
    }

    public void setFormularAttribut(String formularAttribut) {
        this.formularAttribut = formularAttribut;
    }

    public String getAuswahlherkunft() {
        return auswahlherkunft;
    }

    public void setAuswahlherkunft(String auswahlherkunft) {
        this.auswahlherkunft = auswahlherkunft;
    }

    public String getAuswahlherkunftFilter() {
        return auswahlherkunftFilter;
    }

    public void setAuswahlherkunftFilter(String auswahlherkunftFilter) {
        this.auswahlherkunftFilter = auswahlherkunftFilter;
    }

    public String getFilter() {
        return filter;
    }

    public void setFilter(String filter) {
        this.filter = filter;
    }

    public String getCombinedFeldnamen() {
        return combinedFeldnamen;
    }

    public void setCombinedFeldnamen(String combinedFeldnamen) {
        this.combinedFeldnamen = combinedFeldnamen;
    }

    public String getCombinedFeldtypen() {
        return combinedFeldtypen;
    }

    public void setCombinedFeldtypen(String combinedFeldtypen) {
        this.combinedFeldtypen = combinedFeldtypen;
    }

    public String getCombinedAnzeigenamen(String language) throws NoSuchFieldException, IllegalAccessException {
        return (String)DatenbankMapping.class.getDeclaredField(language.toLowerCase() + "CombinedAnzeigenamen").get(this);
    }

    public String getDeCombinedAnzeigenamen() {
        return deCombinedAnzeigenamen;
    }

    public void setDeCombinedAnzeigenamen(String deCombinedAnzeigenamen) {
        this.deCombinedAnzeigenamen = deCombinedAnzeigenamen;
    }

    public String getButtonAktion() {
        return buttonAktion;
    }

    public void setButtonAktion(String buttonAktion) {
        this.buttonAktion = buttonAktion;
    }

    public String getSeite() {
        return seite;
    }

    public void setSeite(String seite) {
        this.seite = seite;
    }

    public String getAlt() {
        return alt;
    }

    public void setAlt(String alt) {
        this.alt = alt;
    }

    public String getSchemaOrgProperty() {
        return schemaOrgProperty;
    }

    public void setSchemaOrg(String schemaOrgProperty) {
        this.schemaOrgProperty = schemaOrgProperty;
    }

    public String getGbBeschriftung() {
        return gbBeschriftung;
    }

    public void setGbBeschriftung(String gbBeschriftung) {
        this.gbBeschriftung = gbBeschriftung;
    }

    public String getFrBeschriftung() {
        return frBeschriftung;
    }

    public void setFrBeschriftung(String frBeschriftung) {
        this.frBeschriftung = frBeschriftung;
    }

    public String getGbCombinedAnzeigenamen() {
        return gbCombinedAnzeigenamen;
    }

    public void setGbCombinedAnzeigenamen(String gbCombinedAnzeigenamen) {
        this.gbCombinedAnzeigenamen = gbCombinedAnzeigenamen;
    }

    public String getFrCombinedAnzeigenamen() {
        return frCombinedAnzeigenamen;
    }

    public void setFrCombinedAnzeigenamen(String frCombinedAnzeigenamen) {
        this.frCombinedAnzeigenamen = frCombinedAnzeigenamen;
    }

    public String getLaBeschriftung() {
        return laBeschriftung;
    }

    public void setLaBeschriftung(String laBeschriftung) {
        this.laBeschriftung = laBeschriftung;
    }

    public String getLaCombinedAnzeigenamen() {
        return laCombinedAnzeigenamen;
    }

    public void setLaCombinedAnzeigenamen(String laCombinedAnzeigenamen) {
        this.laCombinedAnzeigenamen = laCombinedAnzeigenamen;
    }

    public String getPlatzhalter(String language) throws NoSuchFieldException, IllegalAccessException {
        return (String)DatenbankMapping.class.getDeclaredField(language.toLowerCase() + "Platzhalter").get(this);
    }

    public String getDePlatzhalter() {
        return dePlatzhalter;
    }

    public void setDePlatzhalter(String dePlatzhalter) {
        this.dePlatzhalter = dePlatzhalter;
    }

    public String getFrPlatzhalter() {
        return frPlatzhalter;
    }

    public void setFrPlatzhalter(String frPlatzhalter) {
        this.frPlatzhalter = frPlatzhalter;
    }

    public String getGbPlatzhalter() {
        return gbPlatzhalter;
    }

    public void setGbPlatzhalter(String gbPlatzhalter) {
        this.gbPlatzhalter = gbPlatzhalter;
    }

    public String getLaPlatzhalter() {
        return laPlatzhalter;
    }

    public void setLaPlatzhalter(String laPlatzhalter) {
        this.laPlatzhalter = laPlatzhalter;
    }

    public String getTooltip(String language) throws NoSuchFieldException, IllegalAccessException {
        return (String)DatenbankMapping.class.getDeclaredField(language.toLowerCase() + "Tooltip").get(this);
    }

    public String getDeTooltip() {
        return deTooltip;
    }

    public void setDeTooltip(String deTooltip) {
        this.deTooltip = deTooltip;
    }

    public String getFrTooltip() {
        return frTooltip;
    }

    public void setFrTooltip(String frTooltip) {
        this.frTooltip = frTooltip;
    }

    public String getGbTooltip() {
        return gbTooltip;
    }

    public void setGbTooltip(String gbTooltip) {
        this.gbTooltip = gbTooltip;
    }

    public String getLaTooltip() {
        return laTooltip;
    }

    public void setLaTooltip(String laTooltip) {
        this.laTooltip = laTooltip;
    }

    private String[] getValueAsArray(String value) {
        String[] result = {};
        if (value != null && !value.isEmpty()) {
            result = value.split(";");
        }
        //trim result
        for (int i = 0; i < result.length; i++)
            result[i] = result[i].trim();
        return result;
    }

    public String[] getAltAsArray() {
        return getValueAsArray(getAlt());
    }

    public String[] getCombinedFeldnamenAsArray() {
        return getValueAsArray(getCombinedFeldnamen());
    }

    public String[] getCombinedFeldtypenAsArray() {
        return getValueAsArray(getCombinedFeldtypen());
    }

    public String[] getCombinedAnzeigenamenAsArray(String sprache) throws NoSuchFieldException, IllegalAccessException {
        return getValueAsArray(getCombinedAnzeigenamen(sprache));
    }
}
