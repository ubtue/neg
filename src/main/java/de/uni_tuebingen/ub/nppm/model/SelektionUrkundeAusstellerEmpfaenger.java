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
    private List<Urkunde> urkundeEmpfaenger = new ArrayList<Urkunde>();
    
    @ManyToMany(mappedBy = "aussteller")
    private List<Urkunde> urkundeAussteller = new ArrayList<Urkunde>();;
    
    public List<Urkunde> getUrkundeEmpfaenger() {
        return this.urkundeEmpfaenger;
    }
    
    public void addUrkundeEmpfaenger(Urkunde uk){
        this.getUrkundeEmpfaenger().add(uk);
    }
      
    public void removeUrkundeEmpfaenger(int id){
        for (int i = 0; i < this.getUrkundeEmpfaenger().size(); ) {
            Urkunde uk = this.getUrkundeEmpfaenger().get(i);
            if(uk.getId() != null && uk.getId() == id){
                this.getUrkundeEmpfaenger().remove(i);
            }else{
                i++;
            }
        }
    }
    
    public List<Urkunde> getUrkundeAussteller() {
        return this.urkundeAussteller;
    }
    
    public void addUrkundeAussteller(Urkunde uk){
        this.getUrkundeAussteller().add(uk);
    }
      
    public void removeUrkundeAussteller(int id){
        for (int i = 0; i < this.getUrkundeAussteller().size(); ) {
            Urkunde uk = this.getUrkundeAussteller().get(i);
            if(uk.getId() != null && uk.getId() == id){
                this.getUrkundeAussteller().remove(i);
            }else{
                i++;
            }
        }
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