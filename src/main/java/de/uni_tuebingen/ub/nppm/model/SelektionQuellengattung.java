package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "selektion_quellengattung")
public class SelektionQuellengattung extends SelektionHierarchy {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length=50)
    private String bezeichnung;

    @OneToOne(targetEntity = SelektionQuellengattung.class)
    @JoinColumn(name = "parentId", referencedColumnName = "ID")
    private SelektionQuellengattung parent;

    @OneToMany(mappedBy = "parent")
    private Set<SelektionQuellengattung> children = new HashSet<>();

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }

    @Override
    public SelektionHierarchy getParent() {
        return parent;
    }

    @Override
    public Set<? extends SelektionHierarchy> getChildren() {
        return children;
    }
}
