package de.uni_tuebingen.ub.nppm.model.interfaces;

import de.uni_tuebingen.ub.nppm.model.Benutzer;
import java.util.Date;

public interface History {
    public Date getErstellt();
    public void setErstellt(Date erstellt);

    public Benutzer getErstelltVon();
    public void setErstelltVon(Benutzer erstelltVon);

    public Date getLetzteAenderung();
    public void setLetzteAenderung(Date letzteAenderung);

    public Benutzer getLetzteAenderungVon();
    public void setLetzteAenderungVon(Benutzer letzteAenderungVon);
}
