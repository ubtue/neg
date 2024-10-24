package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "selektion_grammatikgeschlecht")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SelektionGrammatikgeschlecht extends SelektionAbstractProvenance {

}
