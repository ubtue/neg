package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_ethnienerhalt")
public class SelektionEthnienErhalt extends SelektionBezeichnung {
    @ManyToMany(mappedBy = "ethnieErhalt")
    private Set<Person> personen = new HashSet<>();

    public Set<Person> getPersonen() {
        return this.personen;
    }

    public void addPerson(Person person) {
        this.getPersonen().add(person);
    }

    public void removePerson(int id) {
        this.getPersonen().removeIf(e -> e.getId() == id);
    }
}
