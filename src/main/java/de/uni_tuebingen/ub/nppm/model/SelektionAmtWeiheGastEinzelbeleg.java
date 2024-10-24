package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "gastselektion_amtweihe_einzelbeleg")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SelektionAmtWeiheGastEinzelbeleg extends SelektionHierarchy {
    @ManyToMany(mappedBy = "amtWeihe")
    private Set<Person> personen = new HashSet<>();

    @ManyToMany(mappedBy = "amtWeihe")
    private Set<Einzelbeleg> einzelbelege = new HashSet<>();

    public Set<Einzelbeleg> getEinzelbelege() {
        return this.einzelbelege;
    }

    public Set<Person> getPersonen() {
        return this.personen;
    }

    /* Hierarchy-related */
    @ManyToOne(targetEntity = SelektionAmtWeihe.class)
    @JoinColumn(name = "parentId", referencedColumnName = "ID")
    @org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private SelektionAmtWeihe parent;

    @OneToMany(mappedBy = "parent", fetch = FetchType.EAGER)
    @OrderBy("Bezeichnung")
    @org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private Set<SelektionAmtWeihe> children = new HashSet<>();

    @Override
    public SelektionHierarchy getParent() {
        return parent;
    }

    @Override
    public Set<? extends SelektionHierarchy> getChildren() {
        return children;
    }
}
