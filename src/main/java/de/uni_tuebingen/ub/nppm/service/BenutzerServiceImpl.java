package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.dao.BenutzerDAO;
import de.uni_tuebingen.ub.nppm.model.Benutzer;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class BenutzerServiceImpl implements BenutzerService {

    @Autowired
    private BenutzerDAO editionDB;

    @Override
    @Transactional
    public void addBenutzer(Benutzer b) {
        editionDB.addBenutzer(b);
    }

    @Override
    @Transactional
    public void updateBenutzer(Benutzer b) {
        editionDB.updateBenutzer(b);
    }

    @Override
    @Transactional
    public List<Benutzer> listBenutzer() {
        return editionDB.listBenutzer();
    }

    @Override
    @Transactional
    public List<Benutzer> listBenutzerAktiv() {
        return editionDB.listBenutzerAktiv();
    }

    @Override
    @Transactional
    public List<Benutzer> listBenutzerInaktiv() {
        return editionDB.listBenutzerInaktiv();
    }

    @Override
    @Transactional
    public Benutzer getBenutzerById(int id) {
        return editionDB.getBenutzerById(id);
    }

    @Override
    @Transactional
    public void removeBenutzer(int id) {
        editionDB.removeBenutzer(id);
    }
}
