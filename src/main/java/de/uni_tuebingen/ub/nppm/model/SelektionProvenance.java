package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@MappedSuperclass
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public abstract class SelektionProvenance extends SelektionBezeichnung {
    @Column(name = "provenance_source")
    private String provenanceSource;

    @Column(name = "provenance_id")
    private String provenanceID;

    public String getProvenanceSource() {
        return provenanceSource;
    }

    public void setProvenanceSource(String provenanceSource) {
        this.provenanceSource = provenanceSource;
    }

    public String getProvenanceID() {
        return provenanceID;
    }

    public void setProvenanceID(String provenanceID) {
        this.provenanceID = provenanceID;
    }
}
