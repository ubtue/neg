package de.uni_tuebingen.ub.nppm.util.statistic.pagination;

import de.uni_tuebingen.ub.nppm.util.Language;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

public class PaginationRenderer {

    public static void printPagination(JspWriter out, int nOfPages, PaginationParams params, HttpSession session, HttpServletRequest request) throws Exception {
        out.println("<div class=\"statistica\">");
        out.println("<nav aria-label=\"Navigation for rows\">");
        out.println("<ul class=\"ut-nav__list\">");

        out.println(htmlFirstButton(params, request));

        if (params.getCurrentPage() > 1) {
            out.println(htmlPrevButton(params, request));
        }

        for (int i = 1; i <= nOfPages; i++) {
            if (params.getCurrentPage() == i) {
                out.println(htmlPageItemCurrent(i));
            } else {
                out.println(htmlPageItem(i, params, request));
            }
        }

        if (params.getCurrentPage() < nOfPages) {
            out.println(htmlNextButton(params, request));
        }

        out.println(htmlLastButton(params, nOfPages, request));
        
        out.println("</ul>");
        out.println("</nav>");
        out.println("</div>");
    }

    private static String htmlPrevButton(PaginationParams params, HttpServletRequest request) throws Exception {
        String url = params.buildUrl(request,"quelle", params.getCurrentPage() - 1, null);
        String prev = Language.getTextfield(request.getSession(), "pagination", "Prev");
        return "<li class=\"ut-nav__item\">"
             + "<button class=\"ut-btn ut-btn--color-primary-3 prev-button\" onclick=\"window.location.href='" + url + "';\">"+prev+"</button>"
             + "<a class=\"ut-link page-link prev-link\" href=\"" + url + "\" style=\"display: none;\"><</a>"
             + "</li>"
             + responsiveScript("prev");
    }

    private static String htmlNextButton(PaginationParams params, HttpServletRequest request) throws Exception {
        String url = params.buildUrl(request,"quelle", params.getCurrentPage() + 1, null);
        String next = Language.getTextfield(request.getSession(), "pagination", "Next");
        return "<li class=\"ut-nav__item\">"
             + "<button class=\"ut-btn ut-btn--color-primary-3 next-button\" onclick=\"window.location.href='" + url + "';\">"+next+"</button>"
             + "<a class=\"ut-link page-link next-link\" href=\"" + url + "\" style=\"display: none;\">></a>"
             + "</li>"
             + responsiveScript("next");
    }

    private static String htmlPageItemCurrent(int page) {
        return "<li class=\"ut-nav__item\">"
             + "<button class=\"ut-btn ut-btn--color-primary-1 current-button\">" + page + "</button>"
             + "<a class=\"ut-link page-link active current-link\" href=\"?page=" + page + "\" style=\"display: none;\">" + page + "</a>"
             + "</li>"
             + responsiveScript("current");
    }

    private static String htmlPageItem(int page, PaginationParams params, HttpServletRequest request) {
        String url = params.buildUrl(request,"quelle", page, null);

        return "<li class=\"ut-nav__item statistica\">"
             + "<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + url + "';\">" + page + "</button>"
             + "<a class=\"ut-link page-link\" href=\"" + url + "\" style=\"display: none;\">" + page + "</a>"
             + "</li>"
             + responsiveScript("page");
    }

    public static String htmlSortTitleUp(PaginationParams params, HttpSession session, HttpServletRequest request) throws Exception {
        String url = params.buildUrl(request,"quelle", params.getCurrentPage(), "titleUp");

        return "<a class=\"ut-link sort-link\" href=\"" + url + "\">"
                + Language.getTextfield(session, "pagination", "SortAZ")
                + "</a>";
    }

    public static String htmlSortTitleDown(PaginationParams params, HttpSession session, HttpServletRequest request) throws Exception {
        String url = params.buildUrl(request,"quelle", params.getCurrentPage(), "titleDown");

        return "<a class=\"ut-link sort-link\" href=\"" + url + "\">"
                + Language.getTextfield(session, "pagination", "SortZA")
                + "</a>";
    }

    public static String htmlSortBelegeUp(PaginationParams params, HttpSession session, HttpServletRequest request) throws Exception {
        String url = params.buildUrl(request, "quelle", params.getCurrentPage(), "belegeUp");

        return "<a class=\"ut-link sort-link\" href=\"" + url + "\">"
                + Language.getTextfield(session, "pagination", "SortUp")
                + "</a>";
    }

    public static String htmlSortBelegeDown(PaginationParams params, HttpSession session, HttpServletRequest request) throws Exception {
        String url = params.buildUrl(request,"quelle", params.getCurrentPage(), "belegeDown");

        return "<a class=\"ut-link sort-link\" href=\"" + url + "\">"
                + Language.getTextfield(session, "pagination", "SortDown")
                + "</a>";
    }

    public static String htmlFirstButton(PaginationParams params, HttpServletRequest request) throws Exception {
        if (params.getCurrentPage() <= 1) {
            return "";
        }

        String url = params.buildUrl(request, "quelle", 1, null);
        String first = Language.getTextfield(request.getSession(), "pagination", "First");
        return "<li class=\"ut-nav__item\">"
                + "<button class=\"ut-btn ut-btn--color-primary-3 first-button\" onclick=\"window.location.href='" + url + "';\">"+first+"</button>"
                + "<a class=\"ut-link page-link first-link\" href=\"" + url + "\" style=\"display: none;\">|&lt;</a>"
                + "</li>"
                + responsiveScript("first");
    }

    public static String htmlLastButton(PaginationParams params, int nOfPages, HttpServletRequest request) throws Exception {
        if (params.getCurrentPage() >= nOfPages) {
            return "";
        }

        String url = params.buildUrl(request, "quelle", nOfPages, null);
        String last = Language.getTextfield(request.getSession(), "pagination", "Last");
        return "<li class=\"ut-nav__item\">"
                + "<button class=\"ut-btn ut-btn--color-primary-3 last-button\" onclick=\"window.location.href='" + url + "';\">"+last+"</button>"
                + "<a class=\"ut-link page-link last-link\" href=\"" + url + "\" style=\"display: none;\">&gt;|</a>"
                + "</li>"
                + responsiveScript("last");
    }

    private static String responsiveScript(String type) {
        return "<script>"
             + "function toggle" + capitalize(type) + "Button() {"
             + "    var btn = document.querySelector('." + type + "-button');"
             + "    var link = document.querySelector('." + type + "-link');"
             + "    if (!btn || !link) return;"
             + "    if (window.innerWidth <= 650) {"
             + "        btn.style.display = 'none';"
             + "        link.style.display = 'inline-block';"
             + "    } else {"
             + "        btn.style.display = 'inline-block';"
             + "        link.style.display = 'none';"
             + "    }"
             + "}"
             + "toggle" + capitalize(type) + "Button();"
             + "window.addEventListener('resize', toggle" + capitalize(type) + "Button);"
             + "</script>";
    }

    private static String capitalize(String input) {
        return input.substring(0, 1).toUpperCase() + input.substring(1);
    }
}
