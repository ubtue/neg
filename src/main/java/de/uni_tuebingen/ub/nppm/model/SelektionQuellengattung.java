package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "selektion_quellengattung")
public class SelektionQuellengattung extends SelektionHierarchy {

    @OneToOne(targetEntity = SelektionQuellengattung.class)
    @JoinColumn(name = "parentId", referencedColumnName = "ID")
    private SelektionQuellengattung parent;

    @OneToMany(mappedBy = "parent", fetch = FetchType.EAGER)
    @OrderBy("Bezeichnung")
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
