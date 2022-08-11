package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.dao.HandschriftDAO;
import de.uni_tuebingen.ub.nppm.model.Handschrift;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class HandschriftServiceImpl implements HandschriftService {
    
    @Autowired
    private HandschriftDAO handschriftDB;

    @Override
    @Transactional
    public void addHandschrift(Handschrift h) {
        handschriftDB.addHandschrift(h);
    }

    @Override
    @Transactional
    public void updateHandschrift(Handschrift h) {
        handschriftDB.updateHandschrift(h);
    }

    @Override
    @Transactional
    public List<Handschrift> listHandschriften() {
        return handschriftDB.listHandschriften();
    }

    @Override
    @Transactional
    public Handschrift getHandschriftById(int id) {
        return handschriftDB.getHandschriftById(id);
    }

    @Override
    @Transactional
    public void removeHandschrift(int id) {
        handschriftDB.removeHandschrift(id);
    }
}
