package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_arealtyp")
public class SelektionArealTyp extends SelektionBezeichnung {
    @ManyToMany(mappedBy = "arealTyp")
    private Set<Einzelbeleg> einzelbeleg = new HashSet<>();

    public void addEinzelbeleg(Einzelbeleg beleg) {
        this.getEinzelbeleg().add(beleg);
    }

    public void removeEinzelbeleg(int id) {
        this.getEinzelbeleg().removeIf(e -> e.getId() == id);
    }

    public Set<Einzelbeleg> getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Set<Einzelbeleg> einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }
}
