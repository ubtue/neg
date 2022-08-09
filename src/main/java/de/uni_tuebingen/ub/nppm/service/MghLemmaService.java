package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface MghLemmaService {

    public void addMghLemma(MghLemma mghLemma);

    public void updateMghLemma(MghLemma mghLemma);

    public List<MghLemma> listMghLemma();

    public MghLemma getMghLemmaById(int id);

    public void removeMghLemma(int id);
    
    public List<MghLemmaBearbeiter> listMghLemmaBearbeiter();
    
    public List<MghLemmaKorrektor> listMghLemmaKorrektor();
}
