package de.uni_tuebingen.ub.nppm.util.suche.pagination;

import de.uni_tuebingen.ub.nppm.util.Language;
import static de.uni_tuebingen.ub.nppm.util.Utils.urlEncode;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;

public class PrintPagination {

    public static void printPageNavigation(JspWriter out, HttpServletRequest request, int pageoffset, int pageLimit, int linecount, String export) throws Exception {
        if (!"liste".equals(export) && !"browse".equals(export)) {
            return;
        }

        out.println("<div class=\"resultlistnavigation\" align=\"center\">");

        int pages = (linecount + pageLimit - 1) / pageLimit;

        // --- First Button ---
        if (pageoffset > 0) {
            String firstUrl = "?pageoffset=0";
            for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                String paramName = e.nextElement();
                if (!paramName.equals("pageoffset")) {
                    firstUrl += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                }
            }
            String first = Language.getTextfield(request.getSession(), "pagination", "First");
            out.print("<button class=\"ut-btn ut-btn--color-primary-3 first-button\" "
                    + "onclick=\"window.location.href='" + firstUrl + "';\">"
                    + first + "</button>&nbsp;");
        }
        // Previous Button
        if (pageoffset > 0) {
            String prevUrl = "?pageoffset=" + (pageoffset - 1);
            for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                String paramName = e.nextElement();
                if (!paramName.equals("pageoffset")) {
                    prevUrl += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                }
            }
            String prev = Language.getTextfield(request.getSession(), "pagination", "Prev");
            out.print("<button class=\"ut-btn ut-btn--color-primary-3 prev-button\" onclick=\"window.location.href='" + prevUrl + "';\">" + prev + "</button>&nbsp;");
        }

        // Page Number Buttons
        for (int i = 0; i < pages; i++) {
            if (i == 0 && i <= pageoffset - 10) {
                String pageUrl = "?pageoffset=" + i;
                for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                    String paramName = e.nextElement();
                    if (!paramName.equals("pageoffset")) {
                        pageUrl += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                    }
                }
                out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + pageUrl + "';\">1</button>&nbsp;...&nbsp;");
            }

            if (i < pageoffset + 10 && i > pageoffset - 10) {
                if (i == pageoffset) {
                    out.print("<button class=\"ut-btn ut-btn--color-primary-1 current-button\" disabled>");
                    out.print((i + 1));
                    out.print("</button>&nbsp;");
                } else {
                    String pageUrl = "?pageoffset=" + i;
                    for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                        String paramName = e.nextElement();
                        if (!paramName.equals("pageoffset")) {
                            pageUrl += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                        }
                    }
                    out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + pageUrl + "';\">");
                    out.print((i + 1));
                    out.print("</button>&nbsp;");
                }
            }

            if (i == pages - 1 && i >= pageoffset + 10) {
                String pageUrl = "?pageoffset=" + i;
                for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                    String paramName = e.nextElement();
                    if (!paramName.equals("pageoffset")) {
                        pageUrl += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                    }
                }
                out.print("...&nbsp;<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + pageUrl + "';\">");
                out.print((i + 1));
                out.print("</button>&nbsp;");
            }
        }

        // Next Button
        if (pageoffset < pages - 1) {
            String nextUrl = "?pageoffset=" + (pageoffset + 1);
            for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                String paramName = e.nextElement();
                if (!paramName.equals("pageoffset")) {
                    nextUrl += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                }
            }
            String next = Language.getTextfield(request.getSession(), "pagination", "Next");
            out.print("<button class=\"ut-btn ut-btn--color-primary-3 next-button\" onclick=\"window.location.href='" + nextUrl + "';\">" + next + "</button>");
        }

        // --- Last Button ---
        if (pageoffset < pages - 1) {
            String lastUrl = "?pageoffset=" + (pages - 1);
            for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                String paramName = e.nextElement();
                if (!paramName.equals("pageoffset")) {
                    lastUrl += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                }
            }
            String last = Language.getTextfield(request.getSession(), "pagination", "Last");
            out.print("&nbsp;<button class=\"ut-btn ut-btn--color-primary-3 last-button\" "
                    + "onclick=\"window.location.href='" + lastUrl + "';\">"
                    + last + "</button>");
        }

        out.println("</div>");
    }
}
