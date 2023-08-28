package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "selektion_autor")
public class SelektionAutor extends Selektion {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Nachname", length=255)
    private String nachname;

    @Column(name = "Vorname", length=255)
    private String vorname;

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public String getBezeichnung() {
        return getVorname() + " " + getNachname();
    }

    public String getNachname() {
        return nachname;
    }

    public void setNachname(String nachname) {
        this.nachname = nachname;
    }

    public String getVorname() {
        return vorname;
    }

    public void setVorname(String vorname) {
        this.vorname = vorname;
    }

}
