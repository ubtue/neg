package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.dao.SucheDAO;
import de.uni_tuebingen.ub.nppm.model.SucheFavoriten;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class SucheServiceImpl implements SucheService {
    @Autowired
    private SucheDAO sucheDB;

    @Override
    @Transactional
    public List<SucheFavoriten> listFavoriten() {
        return sucheDB.listFavoriten();
    }
}
