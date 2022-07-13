package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface EditionService {

    public void addEdition(Edition p);

    public void updateEdition(Edition p);

    public List<Edition> listEditions();

    public Edition getEditionById(int id);

    public void removeEdition(int id);
}
