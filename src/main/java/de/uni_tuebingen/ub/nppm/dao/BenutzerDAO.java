package de.uni_tuebingen.ub.nppm.dao;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface BenutzerDAO {
    public void addBenutzer(Benutzer b);

    public void updateBenutzer(Benutzer b);

    public List<Benutzer> listBenutzer();
    
    public List<Benutzer> listBenutzerAktiv();
    
    public List<Benutzer> listBenutzerInaktiv();

    public Benutzer getBenutzerById(int id);

    public void removeBenutzer(int id); 
}