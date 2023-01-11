package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "urkunde_hatempfaenger")
public class UrkundeEmpfaenger {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;
    
    @OneToOne(targetEntity = Urkunde.class)
    @JoinColumn(name = "UrkundeID", referencedColumnName="ID")
    private Urkunde urkunde;

    @OneToOne(targetEntity = SelektionUrkundeAusstellerEmpfaenger.class)
    @JoinColumn(name = "EmpfaengerID", referencedColumnName="ID")
    private SelektionUrkundeAusstellerEmpfaenger empfaenger;

    public Integer getId() {
        return id;
    }

    public Urkunde getUrkunde() {
        return urkunde;
    }

    public void setUrkunde(Urkunde urkunde) {
        this.urkunde = urkunde;
    }

    public SelektionUrkundeAusstellerEmpfaenger getEmpfaenger() {
        return empfaenger;
    }

    public void setEmpfaenger(SelektionUrkundeAusstellerEmpfaenger empfaenger) {
        this.empfaenger = empfaenger;
    }
}
