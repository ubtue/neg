package de.uni_tuebingen.ub.nppm.dao;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface EinzelbelegDAO {
    
    public void addEinzelbeleg(Einzelbeleg p);

    public void updateEinzelbeleg(Einzelbeleg p);

    public List<Einzelbeleg> listEinzelbelege();

    public Einzelbeleg getEinzelbelegById(int id);

    public void removeEinzelbeleg(int id); 
    
    public List<EinzelbelegHatFunktion_MM> listFunktionen();
    
    public List<EinzelbelegTextkritik> listTextKritiken();
}