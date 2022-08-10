package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface QuelleService {

    public void addQuelle(Quelle q);

    public void updateQuelle(Quelle q);

    public List<Quelle> listQuellen();

    public Quelle getQuelleById(int id);

    public void removeQuelle(int id);
}
