package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Table(name = "datenbank_texte")
public class DatenbankTexte {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Textfeld", length = 50)
    private String textfeld;

    @Column(name = "Formular", length = 50)
    private String formular;

    @Column(name = "gb", length = 255)
    private String gb;

    @Column(name = "fr", length = 255)
    private String fr;

    @Column(name = "la", length = 255)
    private String la;

    @Column(name = "de", length = 255)
    private String de;

    public Integer getId() {
        return id;
    }

    public String getTextfeld() {
        return textfeld;
    }

    public void setTextfeld(String textfeld) {
        this.textfeld = textfeld;
    }

    public String getFormular() {
        return formular;
    }

    public void setFormular(String formular) {
        this.formular = formular;
    }

    public String get(String language) throws NoSuchFieldException, IllegalAccessException {
        return (String)DatenbankTexte.class.getDeclaredField(language.toLowerCase()).get(this);
    }

    public String getGb() {
        return gb;
    }

    public void setGb(String gb) {
        this.gb = gb;
    }

    public String getFr() {
        return fr;
    }

    public void setFr(String fr) {
        this.fr = fr;
    }

    public String getLa() {
        return la;
    }

    public void setLa(String la) {
        this.la = la;
    }

    public String getDe() {
        return de;
    }

    public void setDe(String de) {
        this.de = de;
    }
}
