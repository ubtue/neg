<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp"%>

<%    int id = -1;
    String formular = request.getParameter("formular");

    String title = request.getParameter("title");
    String guest = "";
    if (title.contains("gast_")) {
        title = title.substring(5);
        guest = "gast_";
    }
    String bez = "Belegform";
    if (title.toLowerCase().equals("person")) {
        bez = "Standardname";
    } else if (title.toLowerCase().equals("namenkommentar")) {
        bez = "PLemma";
    } else if (title.toLowerCase().equals("quelle")) {
        bez = "Bezeichnung";
    } else if (title.toLowerCase().equals("edition")) {
        bez = "Titel";
    } else if (title.toLowerCase().equals("handschrift")) {
        bez = "Bibliothekssignatur";
    } else if (title.toLowerCase().equals("literatur")) {
        bez = "Kurzzitierweise";
    } else if (title.toLowerCase().equals("mgh_lemma")) {
        bez = "MGHLemma";
    }
    int filter = 0;
    String filterParameter = null;
    try {
        id = Integer.parseInt(request.getParameter("ID"));
        filter = ((Integer) session.getAttribute(formular + "filter")).intValue();
        filterParameter = (String) (session.getAttribute(formular + "filterParameter"));
    } catch (Exception e) {
    }

    int newid = id;
    String label = "";


    String sql = DatenbankDB.getFilterSql(guest + title, filter);
    sql = sql.replace("*", bez + ", " + title + ".ID");
    if (filterParameter != null) {
        sql = sql.replace("###", filterParameter);
    }

    String sql1 = sql + (sql.contains("WHERE") ? " AND" : " WHERE") + " " + title + ".ID < " + id + " ORDER BY ID DESC LIMIT 0,5";
    String sql2 = sql + (sql.contains("WHERE") ? " AND" : " WHERE") + " " + title + ".ID = " + id + " ORDER BY ID DESC";
    String sql3 = sql + (sql.contains("WHERE") ? " AND" : " WHERE") + " " + title + ".ID > " + id + " ORDER BY ID ASC LIMIT 0,5";

   List<Map> rowlist = AbstractBase.getMappedList(sql1);
    int count = 0;
    String res = "";
    for (Map row : rowlist) {
        count++;
        if (count >= 5) {
            break;
        }

        Object valueObj = row.get(bez);
        if (valueObj != null && !valueObj.toString().equals("")) {
            String value = format(valueObj.toString(), bez);
            if (value != null) {
                int max = Math.min(7, value.length());
                if (bez.equals("PLemma")) {
                    int posAmph = value.substring(0, max).lastIndexOf("&");
                    int posSem = value.substring(0, max).lastIndexOf(";");
                    if (posAmph > posSem) {
                        posSem = value.indexOf(";", posAmph);
                        max = value.indexOf(";", posAmph) + 1;
                    }
                }
                value = value.substring(0, max);
                value = "<a style='color:#ffffff;' href='?ID=" + row.get("ID").toString() + "'>" + value + "..." + "</a>";
                res = value + "\t" + res;
            }
        }
    }
    out.println(res);

    Map row = AbstractBase.getMappedRow(sql2);
    if (row != null) {
        String value = format(row.get(bez).toString(), bez);
        if (value != null) {
            int max = Math.min(10, value.length());
            if (bez.equals("PLemma")) {
                int posAmph = value.substring(0, max).lastIndexOf("&");
                int posSem = value.substring(0, max).lastIndexOf(";");
                if (posAmph > posSem) {
                    posSem = value.indexOf(";", posAmph);
                    max = value.indexOf(";", posAmph) + 1;
                }
            }
            value = value.substring(0, max);
            out.println("<span style=\"color:white;\"><b>" + value + "...</b></span>\t");
        }
    }

    List<Map> rowlist3 = AbstractBase.getMappedList(sql3);
    count = 0;
    for (Map row3 : rowlist3) {
        count++;
        if (count >= 5)
            break;

        String value = format(row3.get(bez).toString(), bez);
        if (value != null) {
            int max = Math.min(7, value.length());
            if (bez.equals("PLemma")) {
                int posAmph = value.substring(0, max).lastIndexOf("&");
                int posSem = value.substring(0, max).lastIndexOf(";");
                if (posAmph > posSem) {
                    posSem = value.indexOf(";", posAmph);
                    max = value.indexOf(";", posAmph) + 1;
                }
            }
            value = value.substring(0, max);
            value = "<a style='color:#ffffff;' href='?ID=" + row3.get("ID").toString() + "'>" + value + "..." + "</a>";
            out.println(value + "\t");
        }
    }

//  out.println("<a style='color:#ffffff;' href='?ID="+(request.getParameter("Command").equals("new")?"-1":newid)+"'>"+label+"</a>");
%>
