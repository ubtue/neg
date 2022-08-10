package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface BemerkungService {

    public void addBemerkung(Bemerkung b);

    public void updateBemerkung(Bemerkung b);

    public List<Bemerkung> listBemerkungen();

    public Bemerkung getBemerkungById(int id);

    public void removeBemerkung(int id);
}
