package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.dao.MghLemmaDAO;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class MghLemmaServiceImpl implements MghLemmaService {
    
    @Autowired
    private MghLemmaDAO mghLemmaDB;

    @Override
    @Transactional
    public void addMghLemma(MghLemma mghLemma) {
        mghLemmaDB.addMghLemma(mghLemma);
    }

    @Override
    @Transactional
    public void updateMghLemma(MghLemma mghLemma) {
        mghLemmaDB.updateMghLemma(mghLemma);
    }

    @Override
    @Transactional
    public List<MghLemma> listMghLemma() {
        return mghLemmaDB.listMghLemma();
    }

    @Override
    @Transactional
    public MghLemma getMghLemmaById(int id) {
        return mghLemmaDB.getMghLemmaById(id);
    }

    @Override
    @Transactional
    public void removeMghLemma(int id) {
        mghLemmaDB.removeMghLemma(id);
    }
    
    @Override
    @Transactional
    public List<MghLemmaBearbeiter> listMghLemmaBearbeiter() {
        return mghLemmaDB.listMghLemmaBearbeiter();
    }
    
    @Override
    @Transactional
    public List<MghLemmaKorrektor> listMghLemmaKorrektor() {
        return mghLemmaDB.listMghLemmaKorrektor();
    }
}
