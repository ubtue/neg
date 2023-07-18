<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

﻿<%
    if (feldtyp.equals("textfield") && !array) {
        if (!isReadOnly) {
            out.print("<input name=\"" + datenfeld + "\" style=\"width: 250px\"");
            if (formular.endsWith("freie_suche")) {
                out.print(" placeholder=\"" + platzhalter + "\" ");
            }
        }

        if (Integer.parseInt(id) > 0) {
            String value_zielAttribut = AbstractBase.getStringNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");
            if (value_zielAttribut != null) {
                if (!isReadOnly) {
                    out.print("value=\"" + DBtoHTML(value_zielAttribut) + "\" ");
                } else {
                    String belegformHtml = DBtoHTML(format(value_zielAttribut, isKlarlemma ? "Klarlemma" : ""));
                    if (formular.equals("einzelbeleg") && datenfeld.equals("Belegform")) {
                        belegformHtml = getBelegformLinked(id, belegformHtml);
                    }
                    out.println(belegformHtml);
                }
            } else if (def != null) {
                if (!isReadOnly) {
                    out.print("value=\"" + def + "\" ");
                } else {
                    out.println(format(def, isKlarlemma ? "Klarlemma" : ""));
                }
            }
        }
        if (zielAttribut != null) {
            if (!isReadOnly) {
                out.println((size > 0 ? "size=\"" + size + "\" " : "")
                        + "maxlength=\"" + AbstractBase.getMaxCharacterLength(zielTabelle, zielAttribut) + "\" ");
            }
        }

        if (!isReadOnly) {
            out.println(">");
        }
        if (!tooltip.equals("")) {
            out.println("<a href=\"javascript:return false;\" style=\"text-decoration:none;color:gray;\" title=\"" + tooltip + "\"> ? </a>");
        }

    }
%>
