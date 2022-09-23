package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.servlet.AbstractServlet;

public abstract class AbstractBackendServlet extends AbstractServlet {
    @Override
    protected String getHeaderTemplate() {
        return "servlet/header.jsp";
    }

    @Override
    protected String getFooterTemplate() {
        return "servlet/footer.jsp";
    }
}
