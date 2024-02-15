package de.uni_tuebingen.ub.nppm.cli;

import java.util.Properties;
import java.io.FileInputStream;

public class AbstractBase {
    protected static String propertiesPath = "/root/.neg.properties";

    /**
     * Load Properties File (e.g. DB access credentials)
     */
    protected static void LoadProperties() throws Exception {
        Properties props = new Properties();
        props.load(new FileInputStream(propertiesPath));
        de.uni_tuebingen.ub.nppm.db.AbstractBase.setCliProperties(props);
    }
}
