package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface QuelleDAO {
    public void addQuelle(Quelle q);

    public void updateQuelle(Quelle q);

    public List<Quelle> listQuellen();

    public Quelle getQuelleById(int id);

    public void removeQuelle(int id); 
}