package de.uni_tuebingen.ub.nppm.model.interfaces;

import de.uni_tuebingen.ub.nppm.model.Benutzer;
import java.util.Date;

public interface LetzteAenderung {
    public Date getLetzteAenderung();
    public void setLetzteAenderung(Date letzteAenderung);

    public Benutzer getLetzteAenderungVon();
    public void setLetzteAenderungVon(Benutzer letzteAenderungVon);
}
