package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface DatenbankService {

    public List<DatenbankFilter> listDatenbankFilter();
    
    public List<DatenbankMapping> listDatenbankMapping();
    
    public List<DatenbankSelektion> listDatenbankSelektion();
    
    public List<DatenbankTexte> listDatenbankTexte();
    
    public List<DatenbankSprache> listDatenbankSprachen();

    public DatenbankFilter getDatenbankFilterById(int id);
    
    public DatenbankMapping getDatenbankMappingById(int id);
    
    public DatenbankSelektion getDatenbankSelektionById(int id);
    
    public DatenbankSprache getDatenbankSpracheById(int id);
    
    public DatenbankTexte getDatenbankTexteById(int id);
}
