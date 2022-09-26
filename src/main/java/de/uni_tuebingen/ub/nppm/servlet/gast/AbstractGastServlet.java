package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.servlet.AbstractServlet;

public abstract class AbstractGastServlet extends AbstractServlet {
    @Override
    protected String getHeaderTemplate() {
        return "servlet/header.jsp";
    }

    @Override
    protected String getFooterTemplate() {
        return "servlet/footer.jsp";
    }
}
