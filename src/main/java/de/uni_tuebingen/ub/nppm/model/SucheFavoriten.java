package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;

@Entity
@Table(name = "suche_favoriten")
public class SucheFavoriten {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "Bezeichnung", length = 255)
    private String bezeichnung;

    @Column(name = "SQL", columnDefinition = "MEDIUMTEXT")
    private String sql;

    @Column(name = "de_Ueberschriften", length = 255)
    private String deUeberschriften;

    public Integer getId() {
        return id;
    }

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getDeUeberschriften() {
        return deUeberschriften;
    }

    public void setDeUeberschriften(String deUeberschriften) {
        this.deUeberschriften = deUeberschriften;
    }
}
