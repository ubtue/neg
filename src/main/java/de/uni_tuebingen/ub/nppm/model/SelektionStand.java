package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_stand")
public class SelektionStand extends SelektionBezeichnung {
    @ManyToMany(mappedBy = "stand")
    private Set<Person> personen = new HashSet<>();

    @ManyToMany(mappedBy = "stand")
    private Set<Einzelbeleg> einzelbeleg = new HashSet<>();

    public Set<Person> getPersonen() {
        return this.personen;
    }

    public Set<Einzelbeleg> getEinzelbeleg() {
        return einzelbeleg;
    }

    public void addPerson(Person person) {
        this.getPersonen().add(person);
    }

    public void removePerson(int id) {
        this.getPersonen().removeIf(e -> e.getId() == id);
    }

    public void addEinzelbeleg(Einzelbeleg beleg) {
        this.getEinzelbeleg().add(beleg);
    }

    public void removeEinzelbeleg(int id) {
        this.getEinzelbeleg().removeIf(e -> e.getId() == id);
    }
}