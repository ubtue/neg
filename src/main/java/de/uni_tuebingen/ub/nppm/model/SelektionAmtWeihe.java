package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_amtweihe")
public class SelektionAmtWeihe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length = 255)
    private String bezeichnung;

    @ManyToMany(mappedBy = "amtStandWeihe")
    private List<Person> personen = new ArrayList<>();

    @ManyToMany(mappedBy = "amtStandWeihe")
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

    public List<Einzelbeleg> getEinzelbeleg() {
        return this.einzelbeleg;
    }

    public List<Person> getPersonen() {
        return this.personen;
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
    
    public void addEinzelbeleg(Einzelbeleg person) {
        this.getEinzelbeleg().add(person);
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
