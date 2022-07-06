package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_areal")
public class SelektionAreal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length = 255)
    private String bezeichnung;

    @ManyToMany(mappedBy = "areal")
    private List<Person> personen = new ArrayList<>();
    
    @ManyToMany(mappedBy = "areal")
    private List<Einzelbeleg> einzelbeleg = new ArrayList<>();

    public Integer getId() {
        return id;
    }

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }

    public List<Person> getPersonen() {
        return this.personen;
    }

    public List<Einzelbeleg> getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(List<Einzelbeleg> einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }

    public void addPerson(Person person) {
        this.getPersonen().add(person);
    }

    public void removePerson(int id) {
        for (int i = 0; i < this.getPersonen().size();) {
            Person person = this.getPersonen().get(i);
            if (person.getId() != null && person.getId() == id) {
                this.getPersonen().remove(i);
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
