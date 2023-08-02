package de.uni_tuebingen.ub.nppm.db;

class SqlInjectionException extends Exception {
    public SqlInjectionException(String errorMessage) {
        super(errorMessage);
    }
}
