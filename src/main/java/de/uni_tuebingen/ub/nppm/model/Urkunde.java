package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "urkunde")
public class Urkunde {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;
    
    @OneToOne(targetEntity = Quelle.class)
    @JoinColumn(name = "QuelleID", referencedColumnName="ID")
    private Quelle quelle;

    @Column(name = "Actumort", length = 255)
    private String actumort;
    
    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
        name = "urkunde_hataussteller", 
        joinColumns = { @JoinColumn(name = "AusstellerID") }, 
        inverseJoinColumns = { @JoinColumn(name = "UrkundeID") }
    )
    private Set<SelektionUrkundeAusstellerEmpfaenger> aussteller = new HashSet<SelektionUrkundeAusstellerEmpfaenger>();;
    
    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
        name = "urkunde_hatempfaenger", 
        joinColumns = { @JoinColumn(name = "EmpfaengerID") }, 
        inverseJoinColumns = { @JoinColumn(name = "UrkundeID") }
    )
    private Set<SelektionUrkundeAusstellerEmpfaenger> empfaenger = new HashSet<SelektionUrkundeAusstellerEmpfaenger>();
    
    public Set<SelektionUrkundeAusstellerEmpfaenger> getEmpfaenger() {
        return this.empfaenger;
    }
    
    public void addEmpfaenger(SelektionUrkundeAusstellerEmpfaenger sel){
        this.getEmpfaenger().add(sel);
    }
      
    public void removeEmpfaenger(int id){
        this.getEmpfaenger().removeIf(e -> e.getId() == id);
    }
    
    public Set<SelektionUrkundeAusstellerEmpfaenger> getAussteller() {
        return this.aussteller;
    }
    
    public void addAussteller(SelektionUrkundeAusstellerEmpfaenger sel){
        this.getAussteller().add(sel);
    }
      
    public void removeAussteller(int id){
        this.getAussteller().removeIf(e -> e.getId() == id);
    }

    public Integer getId() {
        return id;
    }

    public Quelle getQuelle() {
        return quelle;
    }

    public void setQuelle(Quelle quelle) {
        this.quelle = quelle;
    }

    public String getActumort() {
        return actumort;
    }

    public void setActumort(String actumort) {
        this.actumort = actumort;
    }
}
