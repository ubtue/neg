package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface MghLemmaDAO {
    public void addMghLemma(MghLemma mghLemma);

    public void updateMghLemma(MghLemma mghLemma);

    public List<MghLemma> listMghLemma();

    public MghLemma getMghLemmaById(int id);

    public void removeMghLemma(int id); 
    
    public List<MghLemmaBearbeiter> listMghLemmaBearbeiter();
    
    public List<MghLemmaKorrektor> listMghLemmaKorrektor();
}