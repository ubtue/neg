package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface HandschriftService {

    public void addHandschrift(Handschrift h);

    public void updateHandschrift(Handschrift h);

    public List<Handschrift> listHandschriften();

    public Handschrift getHandschriftById(int id);

    public void removeHandschrift(int id);
}
