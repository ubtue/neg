package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.dao.NamenKommentarDAO;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import de.uni_tuebingen.ub.nppm.model.NamenKommentarBearbeiter;
import de.uni_tuebingen.ub.nppm.model.NamenKommentarKorrektor;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class NamenKommentarServiceImpl implements NamenKommentarService {
    
    @Autowired
    private NamenKommentarDAO namenkommentarDB;

    @Override
    @Transactional
    public void addNamenKommentar(NamenKommentar n) {
        namenkommentarDB.addNamenKommentar(n);
    }

    @Override
    @Transactional
    public void updateNamenKommentar(NamenKommentar n) {
        namenkommentarDB.updateNamenKommentar(n);
    }

    @Override
    @Transactional
    public List<NamenKommentar> listNamenKommentare() {
        return namenkommentarDB.listNamenKommentars();
    }

    @Override
    @Transactional
    public NamenKommentar getNamenKommentarById(int id) {
        return namenkommentarDB.getNamenKommentarById(id);
    }

    @Override
    @Transactional
    public void removeNamenKommentar(int id) {
        namenkommentarDB.removeNamenKommentar(id);
    }

    @Override
    @Transactional
    public List<NamenKommentarBearbeiter> listBearbeiter() {
        return namenkommentarDB.listBearbeiter();
    }

    @Override
    @Transactional
    public List<NamenKommentarKorrektor> listKorrektor() {
        return namenkommentarDB.listKorrektor();
    }
}
