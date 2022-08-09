package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface NamenKommentarService {

    public void addNamenKommentar(NamenKommentar n);

    public void updateNamenKommentar(NamenKommentar n);

    public List<NamenKommentar> listNamenKommentare();

    public NamenKommentar getNamenKommentarById(int id);

    public void removeNamenKommentar(int id);
    
    public List<NamenKommentarBearbeiter> listBearbeiter();
    
    public List<NamenKommentarKorrektor> listKorrektor();
}
