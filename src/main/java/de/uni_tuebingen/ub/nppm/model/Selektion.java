package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@MappedSuperclass
public abstract class Selektion {
    abstract public Integer getId();
    abstract public String getBezeichnung();
}
