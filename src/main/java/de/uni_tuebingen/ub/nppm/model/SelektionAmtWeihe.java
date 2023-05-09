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

    @ManyToMany(mappedBy = "amtWeihe")
    private Set<Person> personen = new HashSet<>();

    @ManyToMany(mappedBy = "amtWeihe")
    private Set<Einzelbeleg> einzelbelege = new HashSet<>();

    public Integer getId() {
        return id;
    }

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }

    public Set<Einzelbeleg> getEinzelbelege() {
        return this.einzelbelege;
    }

    public Set<Person> getPersonen() {
        return this.personen;
    }

    public void addPerson(Person person) {
        this.getPersonen().add(person);
    }

    public void removePerson(int id) {
        this.getPersonen().removeIf(e -> e.getId() == id);
    }
    
    public void addEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.getEinzelbelege().add(einzelbeleg);
    }

    public void removeEinzelbeleg(int id) {
        this.getEinzelbelege().removeIf(e -> e.getId() == id);
    }
}
