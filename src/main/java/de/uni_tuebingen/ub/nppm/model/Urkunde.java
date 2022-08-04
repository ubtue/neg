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
    private List<SelektionUrkundeAusstellerEmpfaenger> aussteller = new ArrayList<SelektionUrkundeAusstellerEmpfaenger>();;
    
    @ManyToMany(cascade = {CascadeType.REFRESH,CascadeType.MERGE,CascadeType.REFRESH,CascadeType.DETACH})
    @JoinTable(
        name = "urkunde_hatempfaenger", 
        joinColumns = { @JoinColumn(name = "EmpfaengerID") }, 
        inverseJoinColumns = { @JoinColumn(name = "UrkundeID") }
    )
    private List<SelektionUrkundeAusstellerEmpfaenger> empfaenger = new ArrayList<SelektionUrkundeAusstellerEmpfaenger>();
    
    public List<SelektionUrkundeAusstellerEmpfaenger> getEmpfaenger() {
        return this.empfaenger;
    }
    
    public void addEmpfaenger(SelektionUrkundeAusstellerEmpfaenger sel){
        this.getEmpfaenger().add(sel);
    }
      
    public void removeEmpfaenger(int id){
        for (int i = 0; i < this.getEmpfaenger().size(); ) {
            SelektionUrkundeAusstellerEmpfaenger sel = this.getEmpfaenger().get(i);
            if(sel.getId() != null && sel.getId() == id){
                this.getEmpfaenger().remove(i);
            }else{
                i++;
            }
        }
    }
    
    public List<SelektionUrkundeAusstellerEmpfaenger> getAussteller() {
        return this.aussteller;
    }
    
    public void addAussteller(SelektionUrkundeAusstellerEmpfaenger sel){
        this.getAussteller().add(sel);
    }
      
    public void removeAussteller(int id){
        for (int i = 0; i < this.getAussteller().size(); ) {
            SelektionUrkundeAusstellerEmpfaenger sel = this.getAussteller().get(i);
            if(sel.getId() != null && sel.getId() == id){
                this.getAussteller().remove(i);
            }else{
                i++;
            }
        }
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
