package de.uni_tuebingen.ub.nppm.mocks;

import javax.naming.*;
import java.util.*;

public class CustomInitialContext extends InitialContext {

    Hashtable<String, Object> ic = new Hashtable<>();

    public CustomInitialContext() throws NamingException {
        super(true);
    }

    public void bind(String name, Object object) {
        ic.put(name, object);
    }

    public Object lookup(String name) throws NamingException {
        return ic.get(name);
    }
}
