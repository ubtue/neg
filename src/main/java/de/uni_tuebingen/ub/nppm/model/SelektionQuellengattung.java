package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "selektion_quellengattung")
public class SelektionQuellengattung extends SelektionHierarchy {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length=50)
    private String bezeichnung;

    @Column(name = "parentId")
    private Integer parentId;

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
    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
}
