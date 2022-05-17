package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_editor")
public class SelektionEditor {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length = 255)
    private String bezeichnung;

    @Column(name = "Nachname", length = 50)
    private String nachname;
    
    @Column(name = "Vorname", length = 50)
    private String vorname;
    
    @ManyToMany(mappedBy = "editors")
    private List<Edition> editions = new ArrayList<>();

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
    
    public Integer getId() {
        return id;
    }

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
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
