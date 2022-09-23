package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.util.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

public abstract class AbstractServlet extends HttpServlet {
    public void initRequest(HttpServletRequest request) {
        Language.setLanguage(request);
    }
}
