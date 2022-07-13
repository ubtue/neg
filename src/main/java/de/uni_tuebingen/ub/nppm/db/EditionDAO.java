package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface EditionDAO {
    public void addEdition(Edition p);

    public void updateEdition(Edition p);

    public List<Edition> listEditions();

    public Edition getEditionById(int id);

    public void removeEdition(int id); 
}