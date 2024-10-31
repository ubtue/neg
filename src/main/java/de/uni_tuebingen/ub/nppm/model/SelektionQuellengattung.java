package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "selektion_quellengattung")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SelektionQuellengattung extends SelektionHierarchy {

    @ManyToOne(targetEntity = SelektionQuellengattung.class)
    @JoinColumn(name = "parentId", referencedColumnName = "ID")
    @org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private SelektionQuellengattung parent;

    @OneToMany(mappedBy = "parent", fetch = FetchType.EAGER)
    @OrderBy("Bezeichnung")
    @org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private Set<SelektionQuellengattung> children = new HashSet<>();

    @Override
    public SelektionHierarchy getParent() {
        return parent;
    }

    @Override
    public Set<? extends SelektionHierarchy> getChildren() {
        return children;
    }
}
