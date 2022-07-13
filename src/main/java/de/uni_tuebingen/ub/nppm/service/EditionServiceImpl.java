package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.db.EditionDAO;
import de.uni_tuebingen.ub.nppm.model.Edition;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class EditionServiceImpl implements EditionService {
    
    @Autowired
    private EditionDAO editionDB;

    @Override
    @Transactional
    public void addEdition(Edition p) {
        editionDB.addEdition(p);
    }

    @Override
    @Transactional
    public void updateEdition(Edition p) {
        editionDB.updateEdition(p);
    }

    @Override
    @Transactional
    public List<Edition> listEditions() {
        return editionDB.listEditions();
    }

    @Override
    @Transactional
    public Edition getEditionById(int id) {
        return editionDB.getEditionById(id);
    }

    @Override
    @Transactional
    public void removeEdition(int id) {
        editionDB.removeEdition(id);
    }
}
