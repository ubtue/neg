package de.uni_tuebingen.ub.nppm.db;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface NamenKommentarDAO {
    public void addNamenKommentar(NamenKommentar n);

    public void updateNamenKommentar(NamenKommentar n);

    public List<NamenKommentar> listNamenKommentars();

    public NamenKommentar getNamenKommentarById(int id);

    public void removeNamenKommentar(int id); 
    
    public List<NamenKommentarBearbeiter> listBearbeiter();
    
    public List<NamenKommentarKorrektor> listKorrektor();
}