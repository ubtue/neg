package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@MappedSuperclass
public abstract class Selektion {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    public Integer getId() {
        return id;
    }
}
