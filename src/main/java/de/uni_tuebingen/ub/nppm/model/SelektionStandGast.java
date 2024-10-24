package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "gastselektion_stand")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SelektionStandGast extends SelektionHierarchy {
    @ManyToMany(mappedBy = "stand")
    private Set<Person> personen = new HashSet<>();

    @ManyToMany(mappedBy = "stand")
    private Set<Einzelbeleg> einzelbeleg = new HashSet<>();

    public Set<Person> getPersonen() {
        return this.personen;
    }

    public Set<Einzelbeleg> getEinzelbeleg() {
        return einzelbeleg;
    }

    /* Hierarchy-related */
    @ManyToOne(targetEntity = SelektionStand.class)
    @JoinColumn(name = "parentId", referencedColumnName = "ID")
    @org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private SelektionStand parent;

    @OneToMany(mappedBy = "parent", fetch = FetchType.EAGER)
    @OrderBy("Bezeichnung")
    @org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private Set<SelektionStand> children = new HashSet<>();

    @Override
    public SelektionHierarchy getParent() {
        return parent;
    }

    @Override
    public Set<? extends SelektionHierarchy> getChildren() {
        return children;
    }
}