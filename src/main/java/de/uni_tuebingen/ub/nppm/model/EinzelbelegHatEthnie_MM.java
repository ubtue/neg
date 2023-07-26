package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "einzelbeleg_hatethnie")
public class EinzelbelegHatEthnie_MM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @ManyToOne(targetEntity = SelektionEthnie.class)
    @JoinColumn(name = "EthnieID", referencedColumnName = "ID")
    private SelektionEthnie ethnie;

    @ManyToOne(targetEntity = Einzelbeleg.class)
    @JoinColumn(name = "EinzelbelegID", referencedColumnName = "ID")
    private Einzelbeleg einzelbeleg;

    public Integer getId() {
        return id;
    }

    public SelektionEthnie getEthnie() {
        return ethnie;
    }

    public void setEthnie(SelektionEthnie ethnie) {
        this.ethnie = ethnie;
    }

    public Einzelbeleg getEinzelbeleg() {
        return einzelbeleg;
    }

    public void setEinzelbeleg(Einzelbeleg einzelbeleg) {
        this.einzelbeleg = einzelbeleg;
    }


}
