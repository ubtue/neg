package de.uni_tuebingen.ub.nppm.dao;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.springframework.stereotype.Repository;
import org.hibernate.Session;
import org.springframework.stereotype.Component;

@Repository
@Component
public class DatenbankDAOImpl extends AbstractBase implements DatenbankDAO  {

    @Override
    public List<DatenbankFilter> listDatenbankFilter() {
        return getList(DatenbankFilter.class);
    }

    @Override
    public List<DatenbankMapping> listDatenbankMapping() {
        return getList(DatenbankMapping.class);
    }

    @Override
    public List<DatenbankSelektion> listDatenbankSelektion() {
        return getList(DatenbankSelektion.class);
    }

    @Override
    public List<DatenbankTexte> listDatenbankTexte() {
        return getList(DatenbankTexte.class);
    }

    @Override
    public List<DatenbankSprache> listDatenbankSprachen() {
        return getList(DatenbankSprache.class);
    }

    @Override
    public DatenbankFilter getDatenbankFilterById(int id) {
        Session s = getSession();
        DatenbankFilter df = (DatenbankFilter) s.load(DatenbankFilter.class, id);
        return df;
    }

    @Override
    public DatenbankMapping getDatenbankMappingById(int id) {
        Session s = getSession();
        DatenbankMapping dm = (DatenbankMapping) s.load(DatenbankMapping.class, id);
        return dm;
    }

    @Override
    public DatenbankSelektion getDatenbankSelektionById(int id) {
        Session s = getSession();
        DatenbankSelektion ds = (DatenbankSelektion) s.load(DatenbankSelektion.class, id);
        return ds;
    }

    @Override
    public DatenbankSprache getDatenbankSpracheById(int id) {
        Session s = getSession();
        DatenbankSprache ds = (DatenbankSprache) s.load(DatenbankSprache.class, id);
        return ds;
    }

    @Override
    public DatenbankTexte getDatenbankTexteById(int id) {
        Session s = getSession();
        DatenbankTexte dt = (DatenbankTexte) s.load(DatenbankTexte.class, id);
        return dt;
    }
}