<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>
<%
    if (feldtyp.startsWith("link") && array) {
        String[] fields = feldtyp.substring(feldtyp.lastIndexOf('(') + 1, feldtyp.lastIndexOf(')')).split(",");
        List<Map> rowlist = AbstractBase.getMappedList(
            "SELECT * FROM " + zielTabelle + " WHERE " + formularAttribut + "=\"" + id + "\""
        );

        Set<String> alreadyPrinted = "EinzelbelegRODistinct".equals(datenfeld)
            ? new HashSet<>() : null;

        List<String> links = new ArrayList<>();

        for (Map row : rowlist) {
            Map row2 = AbstractBase.getMappedRow(
                "SELECT " + fields[2] + " FROM " + fields[0] + " WHERE tab.ID=" + String.valueOf(row.get(fields[1]))
            );

            if (row2 != null) {
                String bez = "Zum Datensatz";
                if (row2.get(fields[2]) != null) {
                    bez = format(String.valueOf(row2.get(fields[2])), fields[2]);
                    if (!fields[2].startsWith("PLemma")) {
                        bez = DBtoHTML(bez);
                    }
                }

                if (alreadyPrinted != null) {
                    if (alreadyPrinted.contains(bez)) continue;
                    alreadyPrinted.add(bez);
                }

                String add = fields[3];
                String link = "<a class=\"ut-link\" href=\"" + add + "?ID=" + String.valueOf(row.get(fields[1])) + "\">" + bez + "</a><br>";
                links.add(link);
            }
        }

        // Sortiere die Links alphabetisch anhand des sichtbaren Texts (bez)
        Collections.sort(links, new Comparator<String>() {
            public int compare(String a, String b) {
                return a.replaceAll("<[^>]+>", "").compareToIgnoreCase(b.replaceAll("<[^>]+>", ""));
            }
        });

        for (String link : links) {
            out.println(link);
        }
    }
%>
