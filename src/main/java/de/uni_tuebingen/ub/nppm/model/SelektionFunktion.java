package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_funktion")
public class SelektionFunktion {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length=255)
    private String bezeichnung;

    @ManyToMany(mappedBy = "funktion")
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

    public List<Einzelbeleg> getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(List<Einzelbeleg> einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }
}
