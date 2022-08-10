package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
public class SucheDAOImpl extends AbstractBase implements SucheDAO {
    @Override
    public List<SucheFavoriten> listFavoriten() {
        return getList(SucheFavoriten.class);
    }
}
