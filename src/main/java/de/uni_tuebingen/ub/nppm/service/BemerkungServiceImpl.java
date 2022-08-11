package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.dao.BemerkungDAO;
import de.uni_tuebingen.ub.nppm.model.Bemerkung;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class BemerkungServiceImpl implements BemerkungService {
    
    @Autowired
    private BemerkungDAO dao;

    @Override
    @Transactional
    public void addBemerkung(Bemerkung b) {
        dao.addBemerkung(b);
    }

    @Override
    @Transactional
    public void updateBemerkung(Bemerkung b) {
        dao.updateBemerkung(b);
    }

    @Override
    @Transactional
    public List<Bemerkung> listBemerkungen() {
        return dao.listBemerkungen();
    }

    @Override
    @Transactional
    public Bemerkung getBemerkungById(int id) {
        return dao.getBemerkungById(id);
    }

    @Override
    @Transactional
    public void removeBemerkung(int id) {
        dao.removeBemerkung(id);
    }
}
