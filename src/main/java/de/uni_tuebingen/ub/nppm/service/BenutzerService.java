package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface BenutzerService {

    public void addBenutzer(Benutzer b);

    public void updateBenutzer(Benutzer b);

    public List<Benutzer> listBenutzer();
    
    public List<Benutzer> listBenutzerAktiv();
    
    public List<Benutzer> listBenutzerInaktiv();

    public Benutzer getBenutzerById(int id);

    public void removeBenutzer(int id);
}
