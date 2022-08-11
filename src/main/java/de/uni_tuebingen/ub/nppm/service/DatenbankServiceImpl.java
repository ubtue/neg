package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.db.DatenbankDAO;
import de.uni_tuebingen.ub.nppm.model.DatenbankFilter;
import de.uni_tuebingen.ub.nppm.model.DatenbankMapping;
import de.uni_tuebingen.ub.nppm.model.DatenbankSelektion;
import de.uni_tuebingen.ub.nppm.model.DatenbankSprache;
import de.uni_tuebingen.ub.nppm.model.DatenbankTexte;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class DatenbankServiceImpl implements DatenbankService {
    
    @Autowired
    private DatenbankDAO datenbankDAO;

    @Override
    @Transactional
    public List<DatenbankFilter> listDatenbankFilter() {
        return datenbankDAO.listDatenbankFilter();
    }

    @Override
    @Transactional
    public List<DatenbankMapping> listDatenbankMapping() {
        return datenbankDAO.listDatenbankMapping();
    }

    @Override
    @Transactional
    public List<DatenbankSelektion> listDatenbankSelektion() {
        return datenbankDAO.listDatenbankSelektion();
    }

    @Override
    @Transactional
    public List<DatenbankTexte> listDatenbankTexte() {
        return datenbankDAO.listDatenbankTexte();
    }

    @Override
    @Transactional
    public List<DatenbankSprache> listDatenbankSprachen() {
        return datenbankDAO.listDatenbankSprachen();
    }

    @Override
    @Transactional
    public DatenbankFilter getDatenbankFilterById(int id) {
        return datenbankDAO.getDatenbankFilterById(id);
    }

    @Override
    @Transactional
    public DatenbankMapping getDatenbankMappingById(int id) {
        return datenbankDAO.getDatenbankMappingById(id);
    }

    @Override
    @Transactional
    public DatenbankSelektion getDatenbankSelektionById(int id) {
        return datenbankDAO.getDatenbankSelektionById(id);
    }

    @Override
    @Transactional
    public DatenbankSprache getDatenbankSpracheById(int id) {
        return datenbankDAO.getDatenbankSpracheById(id);
    }

    @Override
    @Transactional
    public DatenbankTexte getDatenbankTexteById(int id) {
        return datenbankDAO.getDatenbankTexteById(id);
    }
}
