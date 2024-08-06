package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_arealtyp")
public class SelektionArealTyp extends SelektionBezeichnung {
    @ManyToMany(mappedBy = "arealTyp")
    private Set<Einzelbeleg> einzelbelege = new HashSet<>();

    public void addEinzelbeleg(Einzelbeleg beleg) {
        this.getEinzelbelege().add(beleg);
    }

    public void removeEinzelbeleg(int id) {
        this.getEinzelbelege().removeIf(e -> e.getId() == id);
    }

    public Set<Einzelbeleg> getEinzelbelege() {
        return einzelbelege;
    }
}
