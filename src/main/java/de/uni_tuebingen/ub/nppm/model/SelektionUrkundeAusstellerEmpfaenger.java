package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_urkundeausstellerempfaenger")
public class SelektionUrkundeAusstellerEmpfaenger {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length=255)
    private String bezeichnung;

    @ManyToMany(mappedBy = "empfaenger")
    private Set<Urkunde> urkundeEmpfaenger = new HashSet<Urkunde>();
    
    @ManyToMany(mappedBy = "aussteller")
    private Set<Urkunde> urkundeAussteller = new HashSet<Urkunde>();;
    
    public Set<Urkunde> getUrkundeEmpfaenger() {
        return this.urkundeEmpfaenger;
    }
    
    public void addUrkundeEmpfaenger(Urkunde uk){
        this.getUrkundeEmpfaenger().add(uk);
    }
      
    public void removeUrkundeEmpfaenger(int id){
        this.getUrkundeEmpfaenger().removeIf(e -> e.getId() == id);
    }
    
    public Set<Urkunde> getUrkundeAussteller() {
        return this.urkundeAussteller;
    }
    
    public void addUrkundeAussteller(Urkunde uk){
        this.getUrkundeAussteller().add(uk);
    }
      
    public void removeUrkundeAussteller(int id){
        this.getUrkundeAussteller().removeIf(e -> e.getId() == id);
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
}