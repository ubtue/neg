<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Filter" isThreadSafe="false" %>
<%@ page import="java.text.SimpleDateFormat" isThreadSafe="false"%>
<%@ page import="java.util.Date" isThreadSafe="false"%>
<%@ include file="configuration.jsp"%>
<%@ include file="functions.jsp"%>

<%    int id = -1;
    String title = request.getParameter("form");

    if (request.getParameter("jumpID") != null && (request.getParameter("jumpID").equals("los") || request.getParameter("jumpID").equals(">"))) {
        String newID = request.getParameter("jumpValueID");
        String newForm = "";
        if (newID.startsWith("B") || newID.startsWith("b")) {
            newForm = "einzelbeleg";
        } else if (newID.startsWith("P") || newID.startsWith("p")) {
            newForm = "person";
        } else if (newID.startsWith("N") || newID.startsWith("n")) {
            newForm = "namenkommentar";
        } else if (newID.startsWith("Q") || newID.startsWith("q")) {
            newForm = "quelle";
        } else if (newID.startsWith("E") || newID.startsWith("e")) {
            newForm = "edition";
        } else if (newID.startsWith("T") || newID.startsWith("t")) {
            newForm = "handschrift";
        } else if (newID.startsWith("M") || newID.startsWith("m")) {
            newForm = "mghlemma";
        } else {
            out.println("<script type=\"text/javascript\">");
            String url = request.getRequestURL().toString();
            url = url.substring(0, url.lastIndexOf('/') + 1);
            out.println("window.stop();");
            out.println("location.replace('" + url + "error.jsp');");
            out.println("</script>");
        }
        out.println("<script type=\"text/javascript\">");
        String url = request.getRequestURL().toString();
        out.println(url);
        session.setAttribute(title + "filter", 0);
        session.setAttribute(title + "filterParameter", "");
        url = url.substring(0, url.lastIndexOf('/') + 1);

        if (url.endsWith("gast/") && (newForm.equals("edition") || newForm.equals("handschrift"))) {
            out.println("window.stop();");
            out.println("location.replace('" + url + "error.jsp');");
        } else {
            out.println("location.replace('" + url + newForm + "?ID='+" + newID.substring(1) + ");");
        }
        out.println("</script>");

    } else if (request.getParameter("jump") != null && request.getParameter("jump").equals("los")) {
        //  out.println("JUMP: " + request.getParameter("jumpType") + "::" + request.getParameter("jumpValue") + "__" + request.getParameter("akt"));

        String form = request.getParameter("jumpTable");

        String guest = "";
        if (title.contains("gast_")) {
            title = title.substring(5);
            guest = "gast_";
        }

        int akt = -1;

        String debug = "debug";

        int filter = 0;

        if (session.getAttribute(title + "filter") != null) {
            filter = ((Integer) session.getAttribute(title + "filter")).intValue();
        }

        //get the filter sql string
        String sql = Filter.getFilterSql(request, guest + title);
        if (sql == null) {
            sql = "SELECT * FROM " + title;
        }
        //modify sql string
        sql = sql.replace("*", "count(*) c");
        akt = AbstractBase.getIntNative(sql + (sql.contains("WHERE") ? " AND " : " WHERE ") + title + ".ID < " + request.getParameter("akt")) + 1;

        if (akt > 0) {
            if (request.getParameter("jumpType").equals("-1")) {
                try {
                    akt -= Integer.parseInt(request.getParameter("jumpValue"));
                } catch (Exception ex) {
                    ;
                }
            } else if (request.getParameter("jumpType").equals("1")) {
                try {
                    akt += Integer.parseInt(request.getParameter("jumpValue"));
                } catch (Exception ex) {
                    ;
                }
            } else if (request.getParameter("jumpType").equals("0")) {
                try {
                    akt = Integer.parseInt(request.getParameter("jumpValue"));
                } catch (Exception ex) {
                    ;
                }
            }
            akt--;

            sql = Filter.getFilterSql(request, guest + title);
            if (sql == null) {
                sql = "SELECT " + title + ".ID FROM " + title;
            }

            sql = sql.replace("*", title + ".ID");
            id = AbstractBase.getIntNative(sql + " ORDER BY " + title + ".ID LIMIT " + akt + ", 1");

            out.println("<script type=\"text/javascript\">");
            out.println(
                    "location.replace(window.location.protocol+'//'+window.location.hostname+':'+window.location.port+window.location.pathname+'?ID='+"
                    + id + ");");
            out.println("</script>");
        }
    } // ENDE if (springen)
%>
