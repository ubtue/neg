package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.db.QuelleDAO;
import de.uni_tuebingen.ub.nppm.model.Quelle;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class QuelleServiceImpl implements QuelleService {
    
    @Autowired
    private QuelleDAO quelleDB;

    @Override
    @Transactional
    public void addQuelle(Quelle p) {
        quelleDB.addQuelle(p);
    }

    @Override
    @Transactional
    public void updateQuelle(Quelle p) {
        quelleDB.updateQuelle(p);
    }

    @Override
    @Transactional
    public List<Quelle> listQuellen() {
        return quelleDB.listQuellen();
    }

    @Override
    @Transactional
    public Quelle getQuelleById(int id) {
        return quelleDB.getQuelleById(id);
    }

    @Override
    @Transactional
    public void removeQuelle(int id) {
        quelleDB.removeQuelle(id);
    }
}
