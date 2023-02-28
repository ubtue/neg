package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import static de.uni_tuebingen.ub.nppm.util.Utils.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Root;
import javax.persistence.Tuple;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import org.hibernate.Criteria;
import org.hibernate.query.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;


public class SucheDB extends AbstractBase {

    public static List getFavoriten() throws Exception {
        return getList(SucheFavoriten.class);
    }

    public static List<String> getCountryText(String country, String form, String query) throws Exception {
        String sql = "SELECT DISTINCT " + country + " FROM " + form;
        if (!query.equals("?")) {
            sql += " WHERE " + country + " LIKE '%" + query + "%' ";
        }
        sql += " ORDER BY " + country;

        Session session = getSession();
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sql);
            List<String> rows = sqlQuery.getResultList();
            return rows;
        } finally {
            session.close();
        }
    }

    public static Map<Integer, String> getAttributes(HttpServletRequest request) throws Exception {
        String dbForm = request.getParameter("dbForm");
        String tabelle = request.getParameter("zwischentabelle");
        String zwAttribut = request.getParameter("zwAttribut");
        String attribut = request.getParameter("attribut");

        Map<Integer, String> ret = new HashMap<Integer, String>();
        Session session = getSession();
        try {
            Transaction tx = session.beginTransaction();
            String sql = "SELECT ID, " + attribut + " FROM " + dbForm + " e WHERE NOT EXISTS (SELECT * FROM " + tabelle + " eh WHERE e.ID=eh." + zwAttribut + ") ORDER BY " + attribut;
            SQLQuery query = session.createSQLQuery(sql);
            List<Object[]> rows = query.list();

            for (Object[] row : rows) {
                if (row[0] != null && row[1] != null) {
                    ret.put(Integer.valueOf(row[0].toString()), row[1].toString());
                }
            }

            return ret;
        } finally {
            session.close();
        }
    }

    public static List getFields(String fields , String tablesString, String conditionsString, String export, Integer pageoffset, Integer pageLimit) throws Exception {
        String sql = "SELECT "+fields+" FROM "+tablesString+" WHERE ("+conditionsString+")";
        if (export != null && (export.equals("liste") || export.equals("browse")) && pageoffset != null && pageLimit != null)
            sql += " LIMIT "+(pageoffset*pageLimit)+", "+pageLimit;
        Session session = getSession();
        try {
            NativeQuery sqlQuery = session.createSQLQuery(sql);

            sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);

            return sqlQuery.getResultList();
        } finally {
            session.close();
        }
    }

    public static List<Map<String, String>> getSearchResult(String fieldsString, String tablesString, String conditionsString, String orderString, String order, String[] fields) throws Exception {
        String sql = "SELECT DISTINCT " + fieldsString + " FROM " + tablesString + " WHERE (" + conditionsString + ") " + order;
        if (order.equals("")) {
            sql += orderString;
        }
        Session session = getSession();
        try {
            NativeQuery sqlQuery = session.createSQLQuery(sql);
            List<Object[]> rows = sqlQuery.getResultList();
            //return var
            List<Map<String, String>> ret = new ArrayList<Map<String, String>>();
            //loop over the rows
            for (Object[] row : rows) {
                //convert the fields from the row to a map
                Map<String, String> fieldVal = new HashMap<String, String>();
                for (int i = 0; i < fields.length; i++) {
                    String[] name = fields[i].split(" AS ");
                    if (name.length == 2) {
                        fields[i] = name[1];
                    }
                    if (row[i] != null) {
                        fieldVal.put(fields[i].trim(), row[i].toString());
                    }
                }
                ret.add(fieldVal);
            }

            return ret;
        } finally {
            session.close();
        }
    }

    public static List<Object[]> getSearchCount(String conditionsString, String countString, String tablesString) throws Exception {
        List<Object[]> ret = new ArrayList<>();
        String sql = "SELECT " + countString + " FROM " + tablesString + " WHERE (" + conditionsString + ")";
        Session session = getSession();
        try {
            NativeQuery sqlQuery = session.createSQLQuery(sql);
            List rows = sqlQuery.list();

            for (Object object : rows) {
                //if object is not an array, cast it to a one dim array
                if (!object.getClass().isArray()) {
                    Object[] arr = new Object[1];
                    arr[0] = object;
                    ret.add(arr);
                    return ret;
                } else {
                    ret.add((Object[]) object);
                }
            }
            return ret;
        } finally {
            session.close();
        }
    }

    public static List<SucheErgebnis> getExtended(SucheOptionen suchoptionen) throws Exception {
        Session session = getSession();

        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Tuple> query = builder.createTupleQuery();

            Root rootEinzelbeleg = query.from(Einzelbeleg.class);
            Join<Einzelbeleg, Quelle> joinQuelle = rootEinzelbeleg.join(Einzelbeleg_.QUELLE, JoinType.LEFT);
            Join<Einzelbeleg, Person> joinPerson = rootEinzelbeleg.join(Einzelbeleg_.PERSON);

            // If you add / change the parameters here, make sure to also change the calls for tuple.get() below
            query.multiselect(rootEinzelbeleg, joinQuelle, joinPerson);

            if (suchoptionen.quelleZuVeroeffentlichen) {
                query.where(builder.equal(joinQuelle.get(Quelle_.zuVeroeffentlichen), 1));
            }
            if (suchoptionen.einzelbelegBelegform != null) {
                query.where(builder.equal(rootEinzelbeleg.get(Einzelbeleg_.BELEGFORM), suchoptionen.einzelbelegBelegform));
            }

            Query preparedQuery = session.createQuery(query);
            if (suchoptionen.limit > 0) {
                preparedQuery.setMaxResults(suchoptionen.limit);
            }

            // Convert result into structured data
            List<Tuple> resultList = preparedQuery.getResultList();
            List<SucheErgebnis> endResultList = new ArrayList<>();
            for (Tuple tuple : resultList) {
                SucheErgebnis endResult = new SucheErgebnis();

                // The order of objects for tuple.get() must be similar to query.multiselect()
                endResult.einzelbeleg = tuple.get(0, Einzelbeleg.class);
                endResult.quelle = tuple.get(1, Quelle.class);
                endResult.person = tuple.get(2, Person.class);

                endResultList.add(endResult);
            }
            return endResultList;
        } finally {
            session.close();
        }
    }

    public static List<Map> getEinfacheSucheResult(String sql) throws Exception {
        return getMappedList(sql);
    }

    public static void simpleSearch(JspWriter out, Vector<String> headlines, Vector<String> fieldNames, List<Map> rsMap, String orderV[], String order, String open, boolean countTables) throws IOException {

        int topCount = 0;
        try {
            String header = "";
            int orderSize = orderV.length;
            boolean[] first = {true, true, true, true, true, true, true, true, true, true, true, true, true, true, true};  //kann mann vielleicht löschen ?!
            String oldValue[] = new String[15];
            String export = "browse";
            header += "<tr>";
            for (int i = 0; i < headlines.size(); i++) {
                if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                    header += "<th width=\"" + (100 / headlines.size()) + "%\" class=\"resultlist\">";
                    header += headlines.get(i);
                    header += "</th>";
                }
            }//end for
            boolean even = false;
            header += "</tr>";

            if (orderSize == 0) {
                out.print("<table class=\"resultlist\" width=\"100%\">" + header + "<tr>");
            }

            for (Map rs : rsMap) {
                for (int z = 0; z < orderSize; z++) {
                    int jahr = 0;
                    int zeitraum = 0;
                    String jahrV = "";
                    if (rs.get(orderV[z]) == null) {
                        jahrV = "";
                        jahr = 0;
                    } else {
                        jahrV = rs.get(orderV[z]).toString();

                        if (orderV[z].endsWith("Jahr")) {
                            zeitraum = 25;
                            jahr = Integer.parseInt(jahrV);
                            jahr = jahr / zeitraum;
                            jahrV = "" + jahr;
                        }//end if

                    }//end else

                    if (first[z] || rs.get(orderV[z]) != null && !jahrV.equalsIgnoreCase(oldValue[z])) {
                        oldValue[z] = jahrV;
                        if (!first[z]) {
                            out.print("</table>");
                            for (int z2 = z; z2 < orderSize; z2++) {
                                out.print("</ul></li>");
                            }

                        }//end if
                        first[z] = false;
                        for (int z2 = z + 1; z2 < orderSize; z2++) {
                            first[z2] = true;
                        }

                        if (z > 0) {
                            out.print("<li class=\"liClosed\" style=\"font-size:medium\">");
                        } else {
                            out.print("<li class=\"liOpen\" style=\"font-size:large\">");
                        }

                        String text = "";
                        if (rs.get(orderV[z]) == null) {
                            text = "-";
                        } else {
                            text = rs.get(orderV[z]).toString();
                        }

                        if (orderV[z].startsWith("einzelbelegID")) {
                            text = rs.get("Belegform").toString();
                        }

                        String titel = orderV[z];

                        if (orderV[z].startsWith("einzelbelegID")) {
                            titel = "Belegform";
                        }

                        titel = headlines.get(fieldNames.indexOf(titel));

                        out.print(titel + ": ");
                        boolean link = false;

                        if (!text.equals("-")) {
                            if (orderV[z].equals("einzelbelegID") && rs.get("einzelbelegID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("einzelbelegID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("e2ID") && rs.get("e2ID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("e2ID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("Standardname") && rs.get("personID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("personID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("perszuStandardname") && rs.get("perszuID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("perszuID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("PLemma") && rs.get("namenkommentarID") != null) {
                                out.print("<a href=\"namenkommentar?ID=" + (int) rs.get("namenkommentarID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("MGHLemma") && rs.get("mgh_lemmaID") != null) {
                                out.print("<a href=\"mghlemma?ID=" + (int) rs.get("mgh_lemmaID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("Bezeichnung") && rs.get("quelleID") != null) {                              // ?
                                out.print("<a href=\"quelle?ID=" + (int) rs.get("quelleID") + "\">");
                                link = true;
                            }
                            /*else if (orderV[z].equals("editionTitel") && rs.get("editionID") != null) {  //vielleicht löschen
                                try {
                                    out.print("<a href=\"edition?ID=" + (int) rs.get("editionID") + "\">");
                                    link = true;
                                } catch (Exception e) {
                                    link = false;
                                }
                            } */

                        }

                        if (orderV[z].startsWith("einzelbelegID")) {
                            out.print(format(DBtoHTML(text), "Belegform"));
                        } else if (orderV[z].endsWith("Jahr")) {
                            int ja = Integer.parseInt(oldValue[z]);
                            out.print("" + (ja * zeitraum) + "-" + ((ja + 1) * zeitraum - 1));
                        } else {

                            String format = orderV[z];
                            if (orderV[z].equals("Erstglied") || orderV[z].equals("Zweitglied")) {
                                format = "PLemma";
                            }
                            out.print(format(DBtoHTML(text), format));
                        }
                        if (link) {
                            out.print("</a> ");
                        } else {
                            out.print(" ");
                        }

                        if (z == orderSize - 1) {
                            out.print("<ul><table class=\"resultlist\" width=\"100%\">" + header + "<tr>");
                        } else {
                            out.print("<ul>");
                        }

                    }
                }

                out.print("<tr class=\"" + (even ? "" : "un") + "even\">");

                for (int i = 0; i < fieldNames.size(); i++) {
                    if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                        out.print("<td class=\"resultlist\" valign=\"top\">");

                        if (rs.get(fieldNames.get(i)) != null && !DBtoHTML(rs.get(fieldNames.get(i)).toString()).equals("")) {
                            String cell = DBtoHTML(rs.get(fieldNames.get(i)).toString());
                            boolean link = false;

                            if (fieldNames.get(i).contains("Belegform") && rs.get("einzelbelegID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("einzelbelegID") + "\">");
                                link = true;
                            }
                            if (fieldNames.get(i).contains("Belegform") && rs.get("e2ID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("e2ID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("Standardname") && rs.get("personID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("personID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("perszuStandardname") && rs.get("perszuID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("perszuID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("PLemma") && rs.get("namenkommentarID") != null) {
                                out.print("<a href=\"namenkommentar?ID=" + (int) rs.get("namenkommentarID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("MGHLemma") && rs.get("mgh_lemmaID") != null) {
                                out.print("<a href=\"mghlemma?ID=" + (int) rs.get("mgh_lemmaID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("Bezeichnung") && rs.get("quelleID") != null) {        //?
                                out.print("<a href=\"quelle?ID=" + (int) rs.get("quelleID") + "\">");
                                link = true;
                            }
                            /*
                            else if (fieldNames.get(i).contains("editionTitel")) { //vielleicht löschen
                                try {
                                    out.print("<a href=\"edition?ID=" + (int) rs.get("editionID") + "\">");
                                    link = true;
                                } catch (Exception e) {
                                    link = false;
                                }
                            }
                            */

                            if (fieldNames.get(i).endsWith("PLemma") || fieldNames.get(i).equals("Erstglied") || fieldNames.get(i).equals("Zweitglied")) {
                                cell = format(cell, "PLemma");
                            }
                            out.print(cell);
                            if (link) {
                                out.print("</a> ");
                            }
                        }//end if
                        else {
                            out.print("&nbsp;");
                        }
                        out.print("</td>");
                    }

                }

                out.print("</tr>");
                even = !even;
            }

            //abschliesendes ...
            out.print("</tr>");
            out.print("</table>");

            for (int z = orderSize - 2; z >= 0; z--) {
                out.print("</ul></li>");
            }

            out.print("</ul>");
        } catch (Exception e) {
            StringWriter writer = new StringWriter();
            PrintWriter printWriter = new PrintWriter(writer);
            e.printStackTrace(printWriter);
            printWriter.flush();

            String stackTrace = writer.toString();
            out.println(stackTrace);
        }

    }//end function


}
