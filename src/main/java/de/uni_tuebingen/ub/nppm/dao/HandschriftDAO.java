package de.uni_tuebingen.ub.nppm.dao;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

public interface HandschriftDAO {
    public void addHandschrift(Handschrift p);

    public void updateHandschrift(Handschrift p);

    public List<Handschrift> listHandschriften();

    public Handschrift getHandschriftById(int id);

    public void removeHandschrift(int id); 
}