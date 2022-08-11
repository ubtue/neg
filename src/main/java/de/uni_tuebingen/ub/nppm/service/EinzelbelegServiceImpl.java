package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.dao.EinzelbelegDAO;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.EinzelbelegHatFunktion_MM;
import de.uni_tuebingen.ub.nppm.model.EinzelbelegTextkritik;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class EinzelbelegServiceImpl implements EinzelbelegService {
    
    @Autowired
    private EinzelbelegDAO einzelbelegDB;

    @Override
    @Transactional
    public void addEinzelbeleg(Einzelbeleg p) {
        einzelbelegDB.addEinzelbeleg(p);
    }

    @Override
    @Transactional
    public void updateEinzelbeleg(Einzelbeleg p) {
        einzelbelegDB.updateEinzelbeleg(p);
    }

    @Override
    @Transactional
    public List<Einzelbeleg> listEinzelbelege() {
        return einzelbelegDB.listEinzelbelege();
    }

    @Override
    @Transactional
    public Einzelbeleg getEinzelbelegById(int id) {
        return einzelbelegDB.getEinzelbelegById(id);
    }

    @Override
    @Transactional
    public void removeEinzelbeleg(int id) {
        einzelbelegDB.removeEinzelbeleg(id);
    }

    @Override
    @Transactional
    public List<EinzelbelegHatFunktion_MM> listFunktionen() {
        return einzelbelegDB.listFunktionen();
    }

    @Override
    @Transactional
    public List<EinzelbelegTextkritik> listTextKritiken() {
        return einzelbelegDB.listTextKritiken();
    }
}
