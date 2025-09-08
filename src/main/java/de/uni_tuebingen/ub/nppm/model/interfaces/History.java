package de.uni_tuebingen.ub.nppm.model.interfaces;

import de.uni_tuebingen.ub.nppm.model.Benutzer;
import java.util.Date;

public interface History {
    Date getErstellt();
    void setErstellt(Date erstellt);

    Benutzer getErstelltVon();
    void setErstelltVon(Benutzer erstelltVon);

    Date getLetzteAenderung();
    void setLetzteAenderung(Date letzteAenderung);

    Benutzer getLetzteAenderungVon();
    void setLetzteAenderungVon(Benutzer letzteAenderungVon);
}
