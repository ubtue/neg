package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.ArrayList;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.HashMap;
import java.util.Map;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Root;
import javax.persistence.Tuple;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.query.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class SucheDB extends AbstractBase {

    public static List getFavoriten() throws Exception {
        return getList(SucheFavoriten.class);
    }

    public static Map<Integer, String> getAttributes(HttpServletRequest request) throws Exception{
        String dbForm=request.getParameter("dbForm");
        String tabelle=request.getParameter("zwischentabelle");
        String zwAttribut=request.getParameter("zwAttribut");
        String attribut=request.getParameter("attribut");

        Map<Integer, String> ret = new HashMap<Integer,String>();
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        String sql = "select ID, "+attribut+" from "+dbForm+" e where not exists (select * from "+tabelle+" eh where e.ID=eh."+zwAttribut+") order by " + attribut;
        SQLQuery query = session.createSQLQuery(sql);
        List<Object[]> rows = query.list();

        for(Object[] row : rows){
            if(row[0] != null && row[1] != null){
                ret.put(Integer.valueOf(row[0].toString()), row[1].toString());
            }
        }

        return ret;
    }

    public static List<SucheErgebnis> getExtended(SucheOptionen suchoptionen) throws Exception {
        Session session = getSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Tuple> query = builder.createTupleQuery();

        Root rootEinzelbeleg = query.from(Einzelbeleg.class);
        Join <Einzelbeleg, Quelle> joinQuelle = rootEinzelbeleg.join(Einzelbeleg_.QUELLE, JoinType.LEFT);
        Join <Einzelbeleg, Person> joinPerson = rootEinzelbeleg.join(Einzelbeleg_.PERSON);

        // If you add / change the parameters here, make sure to also change the calls for tuple.get() below
        query.multiselect(rootEinzelbeleg, joinQuelle, joinPerson);

        if (suchoptionen.quelleZuVeroeffentlichen) {
            query.where(builder.equal(joinQuelle.get(Quelle_.zuVeroeffentlichen), 1));
        }
        if (suchoptionen.einzelbelegBelegform != null) {
            query.where(builder.equal(rootEinzelbeleg.get(Einzelbeleg_.BELEGFORM), suchoptionen.einzelbelegBelegform));
        }

        Query preparedQuery = session.createQuery(query);
        if (suchoptionen.limit > 0) {
            preparedQuery.setMaxResults(suchoptionen.limit);
        }

        // Convert result into structured data
        List<Tuple> resultList = preparedQuery.getResultList();
        List<SucheErgebnis> endResultList = new ArrayList<>();
        for (Tuple tuple : resultList) {
            SucheErgebnis endResult = new SucheErgebnis();

            // The order of objects for tuple.get() must be similar to query.multiselect()
            endResult.einzelbeleg = tuple.get(0, Einzelbeleg.class);
            endResult.quelle = tuple.get(1, Quelle.class);
            endResult.person = tuple.get(2, Person.class);

            endResultList.add(endResult);
        }
        return endResultList;
    }
}
