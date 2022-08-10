package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface BemerkungDAO {
    public void addBemerkung(Bemerkung b);

    public void updateBemerkung(Bemerkung b);

    public List<Bemerkung> listBemerkungen();

    public Bemerkung getBemerkungById(int id);

    public void removeBemerkung(int id); 
}