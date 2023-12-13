<%@page import="java.math.BigInteger"%>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*"%>

<%@ page import="java.io.*" isThreadSafe="false" %>
<%@ page import="java.awt.Color" isThreadSafe="false" %>
<%@ page import="java.util.ArrayList" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%@ page import="com.lowagie.text.Document" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.*" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false" %>

<%@ page import="org.apache.commons.lang3.StringUtils" isThreadSafe="false" %>

<%
    int limit = 0;
    int offset = 5;
    try {
        limit = Integer.parseInt(request.getParameter("limit"));
    } catch (Exception ex) {
    }

    String formular = request.getParameter("form");
    String tableString = "";

    List<String> conditions = new ArrayList<>();

    List<String> fields = new ArrayList<>();
    List<String> fieldNames = new ArrayList<>();
    List<String> count = new ArrayList<>();

    List<String> tables = new ArrayList<>();
    List<String> joins = new ArrayList<>();

    List<String> headlines = new ArrayList<>();

    // Welche Grund-Tabellen (Einzelbeleg / Person / Namenkommentar) werden benötigt...
    boolean einzelbeleg = false;
    boolean person = false;
    boolean namenkommentar = false;
    boolean mghlemma = false;

//NeG-ID
    if (!request.getParameter("NeGID").trim().equals("")) {
        String newID = request.getParameter("NeGID");
        String newForm = newID.substring(1);
        if (newID.startsWith("B") || newID.startsWith("b")) {
            conditions.add("einzelbeleg.ID='" + newForm + "'");
            einzelbeleg = true;
        } else if (newID.startsWith("P") || newID.startsWith("p")) {
            conditions.add("person.ID='" + newForm + "'");
            person = true;
        } else if (newID.startsWith("N") || newID.startsWith("n")) {
            conditions.add("namenkommentar.ID='" + newForm + "'");
            namenkommentar = true;
        } else if (newID.startsWith("Q") || newID.startsWith("q")) {
            conditions.add("quelle.ID='" + newForm + "'");
            if (!tableString.contains("quelle")) {
                tableString += " INNER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID";
            }
        }

    }

    // ######### SUCHANFRAGE ##########
    // ### ZUM NAMEN ###
    if (!request.getParameter("Namenkommentar2").equals("-1") && request.getParameter("Namenkommentar").equals("-1")) {
        conditions.add("namenkommentar.ID=" + request.getParameter("Namenkommentar2"));
        namenkommentar = true;
    }
    if (!request.getParameter("Namenkommentar").equals("-1")) {
        conditions.add("namenkommentar.ID=" + request.getParameter("Namenkommentar"));
        namenkommentar = true;
    }
    if (!request.getParameter("MGHLemma").trim().equals("")) {
        conditions.add("mgh_lemma.MGHLemma LIKE '" + request.getParameter("MGHLemma").trim() + "'");
        mghlemma = true;
    }
    // ### ZUR PERSON ###
    if (!request.getParameter("Personenname").trim().equals("")) {
        conditions.add("(person.Standardname LIKE '" + request.getParameter("Personenname").trim() + "' OR person_variante.Variante LIKE '" + request.getParameter("Personenname").trim() + "')");
        tableString += " LEFT OUTER JOIN person_variante ON person.ID=person_variante.personID";
        person = true;
    }
    if (Integer.parseInt(request.getParameter("Geschlecht")) > -1) {
        conditions.add("person.Geschlecht = '" + request.getParameter("Geschlecht") + "'");
        person = true;
    }
    if (Integer.parseInt(request.getParameter("AmtWeihePerson")) > -1) {
        tableString += " INNER JOIN person_hatamtstandweihe ON person.ID=person_hatamtstandweihe.PersonID";
        List<Integer> hierarchyIds = SelektionDB.getById(Integer.parseInt(request.getParameter("AmtWeihePerson")), SelektionAmtWeihe.class).getSubtreeIdsRecursive();
        conditions.add("person_hatamtstandweihe.AmtWeiheID IN (" + StringUtils.join(hierarchyIds, ",") + ")");
        person = true;
    }
    if (Integer.parseInt(request.getParameter("StandPerson")) > -1) {
        tableString += " INNER JOIN person_hatstand ON person.ID=person_hatstand.PersonID";
        List<Integer> hierarchyIds = SelektionDB.getById(Integer.parseInt(request.getParameter("StandPerson")), SelektionStand.class).getSubtreeIdsRecursive();
        conditions.add("person_hatstand.StandID IN (" + StringUtils.join(hierarchyIds, ",") + ")");
        person = true;
    }
    if (Integer.parseInt(request.getParameter("EthniePerson")) > -1) {
        tableString += " INNER JOIN person_hatethnie ON person.ID=person_hatethnie.PersonID";
        conditions.add("person_hatethnie.EthnieID = '" + request.getParameter("EthniePerson") + "'");
        person = true;
    }
    if (request.getParameter("Verwandtschaftsgrad") != null && Integer.parseInt(request.getParameter("Verwandtschaftsgrad")) > -1) {
        tableString += " INNER JOIN person_verwandtmit ON person.ID=person_verwandtmit.PersonIDvon";
        conditions.add("person_verwandtmit.VerwandtschaftsgradID = '" + request.getParameter("Verwandtschaftsgrad") + "'");
        person = true;
    }

    // ### ZUM EINZELBELEG ###
    if (!request.getParameter("Belegform").trim().equals("")) {
        conditions.add("einzelbeleg.Belegform LIKE '" + request.getParameter("Belegform").trim() + "'");
        einzelbeleg = true;
    }
    if (!request.getParameter("Kontext").trim().equals("")) {
        conditions.add("einzelbeleg.Kontext LIKE '" + request.getParameter("Kontext").trim() + "'");
        einzelbeleg = true;
    }
    if (Integer.parseInt(request.getParameter("AmtWeiheEinzelbeleg")) > -1) {
        tableString += " INNER JOIN einzelbeleg_hatamtweihe ON einzelbeleg.ID=einzelbeleg_hatamtweihe.EinzelbelegID";
        List<Integer> hierarchyIds = SelektionDB.getById(Integer.parseInt(request.getParameter("AmtWeiheEinzelbeleg")), SelektionAmtWeihe.class).getSubtreeIdsRecursive();
        conditions.add("einzelbeleg_hatamtweihe.AmtWeiheID IN (" + StringUtils.join(hierarchyIds, ",") + ")");
        einzelbeleg = true;
    }
    if (request.getParameter("EthnieEinzelbeleg") != null && Integer.parseInt(request.getParameter("EthnieEinzelbeleg")) > -1) {
        tableString += " INNER JOIN einzelbeleg_hatethnie ON einzelbeleg.ID=einzelbeleg_hatethnie.EinzelbelegID";
        conditions.add("einzelbeleg_hatethnie.EthnieID = '" + request.getParameter("EthnieEinzelbeleg") + "'");
        einzelbeleg = true;
    }
    if (request.getParameter("Funktion") != null && Integer.parseInt(request.getParameter("Funktion")) > -1) {
        tableString += " INNER JOIN einzelbeleg_hatfunktion ON einzelbeleg.ID=einzelbeleg_hatfunktion.EinzelbelegID";
        conditions.add("einzelbeleg_hatfunktion.FunktionID = '" + request.getParameter("Funktion") + "'");
        einzelbeleg = true;
    }
    if (request.getParameter("QuelleGattung") != null && Integer.parseInt(request.getParameter("QuelleGattung")) > 0) {
        List<Integer> hierarchyIds = SelektionDB.getById(Integer.parseInt(request.getParameter("QuelleGattung")), SelektionQuellengattung.class).getSubtreeIdsRecursive();
        conditions.add("einzelbeleg.QuelleGattungID IN (" + StringUtils.join(hierarchyIds, ",") + ")");
    }
    if (!request.getParameter("PersonZeitraum").trim().equals("")) {
        int vonNum = 0;
        int bisNum = 0;
        if (request.getParameter("PersonZeitraum").contains("-")) {
            // Zeitraum
            String von = request.getParameter("PersonZeitraum").substring(0, request.getParameter("PersonZeitraum").indexOf("-")).trim();
            String bis = request.getParameter("PersonZeitraum").substring(request.getParameter("PersonZeitraum").indexOf("-") + 1).trim();
            if (von.toLowerCase().contains("jh")) {
                try {
                    vonNum = (Integer.parseInt(von.substring(0, von.toLowerCase().indexOf("j"))) - 1) * 100;
                    if (von.endsWith("2")) {
                        vonNum += 51;
                    } else {
                        vonNum += 1;
                    }
                } catch (NumberFormatException e) {;
                }
            } else if (von.toLowerCase().contains(".")) {

            } else {
                try {
                    vonNum = Integer.parseInt(von);
                } catch (NumberFormatException e) {;
                }
            }

            if (bis.toLowerCase().contains("jh")) {
                try {
                    bisNum = (Integer.parseInt(bis.substring(0, bis.toLowerCase().indexOf("j"))) - 1) * 100;
                    if (bis.endsWith("1")) {
                        bisNum += 50;
                    } else {
                        bisNum += 100;
                    }
                } catch (NumberFormatException e) {;
                }
            } else if (bis.toLowerCase().contains(".")) {

            } else {

                try {
                    bisNum = Integer.parseInt(bis);
                } catch (NumberFormatException e) {;
                }
            }
        } else if (request.getParameter("PersonZeitraum").toLowerCase().contains("jh")) {

            String von = request.getParameter("PersonZeitraum").trim();
            try {
                vonNum = (Integer.parseInt(von.substring(0, von.toLowerCase().indexOf("j"))) - 1) * 100;
                bisNum = vonNum;
                if (von.endsWith("1")) {
                    bisNum += 50;
                } else {
                    bisNum += 100;
                }
                if (von.endsWith("2")) {
                    vonNum += 51;
                } else {
                    vonNum += 1;
                }
            } catch (NumberFormatException e) {;
            }

            // Einzelnes Jahrhundert
        } else if (request.getParameter("PersonZeitraum").toLowerCase().contains(".")) {
            // Einzelnes Datum
        } else {
            // Einzelne Jahreszahl
            String von = request.getParameter("PersonZeitraum").trim();
            try {
                vonNum = Integer.parseInt(von);
                bisNum = vonNum;
            } catch (NumberFormatException e) {;
            }

        }

        conditions.add("(VON_JAHR_JHDT(einzelbeleg.vonJahr, einzelbeleg.vonJahrhundert, einzelbeleg.bisJahrhundert)<99999 and BIS_JAHR_JHDT(einzelbeleg.bisJahr, einzelbeleg.bisJahrhundert, einzelbeleg.vonJahrhundert)>-99999 and (VON_JAHR_JHDT(einzelbeleg.vonJahr, einzelbeleg.vonJahrhundert, einzelbeleg.bisJahrhundert)>=" + vonNum + " and BIS_JAHR_JHDT(einzelbeleg.bisJahr, einzelbeleg.bisJahrhundert, einzelbeleg.vonJahrhundert)<=" + bisNum + ") OR"
                + "(VON_JAHR_JHDT(einzelbeleg.vonJahr, einzelbeleg.vonJahrhundert, einzelbeleg.bisJahrhundert)<=" + vonNum + " and BIS_JAHR_JHDT(einzelbeleg.bisJahr, einzelbeleg.bisJahrhundert, einzelbeleg.vonJahrhundert)>=" + bisNum + "))");
        einzelbeleg = true;
    }

    // ### ZUR QUELLE ###
    if (!tableString.contains(" quelle ")) {
        tableString += " INNER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID";
    }
    conditions.add("quelle.zuVeroeffentlichen=1");
    einzelbeleg = true;
    if (!request.getParameter("Quelle").trim().equals("") && request.getParameter("Quellenliste").equals("-1")) {
        conditions.add("quelle.Bezeichnung LIKE '" + request.getParameter("Quelle").trim() + "'");
        namenkommentar = true;
    }
    if (!request.getParameter("Quellenliste").equals("-1")) {
        conditions.add("quelle.ID=" + request.getParameter("Quellenliste"));
        einzelbeleg = true;
    }
    if (request.getParameter("Quellengattung") != null && Integer.parseInt(request.getParameter("Quellengattung")) > -1) {
        conditions.add("einzelbeleg.QuelleGattungID = '" + request.getParameter("Quellengattung") + "'");
        einzelbeleg = true;
    }
    if (!request.getParameter("QuelleZeitraum").trim().equals("")) {
        int vonNum = 0;
        int bisNum = 0;
        if (request.getParameter("QuelleZeitraum").contains("-")) {
            // Zeitraum
            String von = request.getParameter("QuelleZeitraum").substring(0, request.getParameter("QuelleZeitraum").indexOf("-")).trim();
            String bis = request.getParameter("QuelleZeitraum").substring(request.getParameter("QuelleZeitraum").indexOf("-") + 1).trim();
            if (von.toLowerCase().contains("jh")) {
                try {
                    vonNum = (Integer.parseInt(von.substring(0, von.toLowerCase().indexOf("j"))) - 1) * 100;
                    if (von.endsWith("2")) {
                        vonNum += 51;
                    } else {
                        vonNum += 1;
                    }
                } catch (NumberFormatException e) {;
                }
            } else if (von.toLowerCase().contains(".")) {

            } else {
                try {
                    vonNum = Integer.parseInt(von);
                } catch (NumberFormatException e) {;
                }
            }

            if (bis.toLowerCase().contains("jh")) {
                try {
                    bisNum = (Integer.parseInt(bis.substring(0, bis.toLowerCase().indexOf("j"))) - 1) * 100;
                    if (bis.endsWith("1")) {
                        bisNum += 50;
                    } else {
                        bisNum += 100;
                    }
                } catch (NumberFormatException e) {;
                }
            } else if (bis.toLowerCase().contains(".")) {

            } else {

                try {
                    bisNum = Integer.parseInt(bis);
                } catch (NumberFormatException e) {;
                }
            }
        } else if (request.getParameter("QuelleZeitraum").toLowerCase().contains("jh")) {

            String von = request.getParameter("QuelleZeitraum").trim();
            try {
                vonNum = (Integer.parseInt(von.substring(0, von.toLowerCase().indexOf("j"))) - 1) * 100;
                bisNum = vonNum;
                if (von.endsWith("1")) {
                    bisNum += 50;
                } else {
                    bisNum += 100;
                }
                if (von.endsWith("2")) {
                    vonNum += 51;
                } else {
                    vonNum += 1;
                }
            } catch (NumberFormatException e) {;
            }

            // Einzelnes Jahrhundert
        } else if (request.getParameter("QuelleZeitraum").toLowerCase().contains(".")) {
            // Einzelnes Datum
        } else {
            // Einzelne Jahreszahl
            String von = request.getParameter("QuelleZeitraum").trim();
            try {
                vonNum = Integer.parseInt(von);
                bisNum = vonNum;
            } catch (NumberFormatException e) {;
            }

        }

        conditions.add("(VON_JAHR_JHDT(quelle.vonJahr, quelle.vonJahrhundert, quelle.bisJahrhundert)<99999 and BIS_JAHR_JHDT(quelle.bisJahr, quelle.bisJahrhundert, quelle.vonJahrhundert)>-99999 and (VON_JAHR_JHDT(quelle.vonJahr, quelle.vonJahrhundert, quelle.bisJahrhundert)>=" + vonNum + " and BIS_JAHR_JHDT(quelle.bisJahr, quelle.bisJahrhundert, quelle.vonJahrhundert)<=" + bisNum + ") OR"
                + "(VON_JAHR_JHDT(quelle.vonJahr, quelle.vonJahrhundert, quelle.bisJahrhundert)<=" + vonNum + " and BIS_JAHR_JHDT(quelle.bisJahr, quelle.bisJahrhundert, quelle.vonJahrhundert)>=" + bisNum + "))");
        einzelbeleg = true;
    }

    String pageString = request.getParameter("Seite");
    if (pageString != null && !pageString.isEmpty()) {
            conditions.add("einzelbeleg.EditionSeite = '" + request.getParameter("Seite") + "'");
            einzelbeleg = true;
    }

    // ######### SUCHANFRAGE ##########
    String sprache = "de";
    if (session != null && session.getAttribute("Sprache") != null) {
        sprache = (String) session.getAttribute("Sprache");
    }

    // ######### AUSGABEFELDER ##########
    // ### Zum Namen ###
    if (request.getParameter("Ausgabe_Namenlemma") != null && request.getParameter("Ausgabe_Namenlemma").equals("on")) {
        fields.add("namenkommentar.PLemma");
        fields.add("namenkommentar.ID AS namenkommentarID");
        fieldNames.add("namenkommentar.PLemma");
        count.add("namenkommentar.ID");
        tables.add("namenkommentar");
        // headlines.add("Namenlemma");
        headlines.add(DatenbankDB.getMapping(sprache, "namenkommentar", "PLemma"));
        namenkommentar = true;
    }
    if (request.getParameter("Ausgabe_MGHLemma") != null && request.getParameter("Ausgabe_MGHLemma").equals("on")) {
        fields.add("mgh_lemma.MGHLemma");
        fields.add("mgh_lemma.ID AS mgh_lemmaID");
        fieldNames.add("mgh_lemma.MGHLemma");
        count.add("mgh_lemma.ID");
        tables.add("mgh_lemma");
        // headlines.add("Namenlemma");
        headlines.add(DatenbankDB.getMapping(sprache, "mgh_lemma", "MGHLemma"));
        mghlemma = true;
    }
    // ### Zur Person ###
    if (request.getParameter("Ausgabe_Person_Standardname") != null && request.getParameter("Ausgabe_Person_Standardname").equals("on")) {
        fields.add("person.Standardname");
        fields.add("person.ID AS personID");
        count.add("person.ID");
        fieldNames.add("person.Standardname");
        tables.add("person");
        //   headlines.add("Standardname");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Standardname"));
        person = true;
    }
    if (request.getParameter("Ausgabe_Person_AmtWeihe") != null && request.getParameter("Ausgabe_Person_AmtWeihe").equals("on")) {
        fields.add("selektion_amtweihe.Bezeichnung");
        fieldNames.add("selektion_amtweihe.Bezeichnung");
        if (!tableString.contains("person_hatamtstandweihe")) {
            tableString += " LEFT OUTER JOIN person_hatamtstandweihe ON person.ID=person_hatamtstandweihe.PersonID";
        }
        if (!tableString.contains("selektion_amtweihe")) {
            tableString += " LEFT OUTER JOIN selektion_amtweihe ON person_hatamtstandweihe.AmtWeiheID=selektion_amtweihe.ID";
        }
        //   headlines.add("Amt / Weihe");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_AmtWeihe"));

        person = true;
    }
    if (request.getParameter("Ausgabe_Person_AmtWeiheZeitraum") != null && request.getParameter("Ausgabe_Person_AmtWeiheZeitraum").equals("on")) {
        fields.add("person_hatamtstandweihe.Zeitraum");
        fieldNames.add("person_hatamtstandweihe.Zeitraum");
        if (!tableString.contains("person_hatamtstandweihe")) {
            tableString += " LEFT OUTER JOIN person_hatamtstandweihe ON person.ID=person_hatamtstandweihe.PersonID";
        }
        //   headlines.add("Zeitraum Amt/Weihe");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_AmtWeiheZeitraum"));
        person = true;
    }
    if (request.getParameter("Ausgabe_Stand") != null && request.getParameter("Ausgabe_Stand").equals("on")) {
        fields.add("selektion_stand.Bezeichnung");
        fieldNames.add("selektion_stand.Bezeichnung");
        if (!tableString.contains("person_hatstand")) {
            tableString += " LEFT OUTER JOIN person_hatstand ON person.ID=person_hatstand.PersonID";
        }
        if (!tableString.contains("selektion_stand")) {
            tableString += " LEFT OUTER JOIN selektion_stand ON person_hatstand.StandID=selektion_stand.ID";
        }
        //   headlines.add("Stand");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Stand"));
        person = true;
    }
    if (request.getParameter("Ausgabe_Person_Ethnie") != null && request.getParameter("Ausgabe_Person_Ethnie").equals("on")) {
        fields.add("selektion_ethnie.Bezeichnung");
        fieldNames.add("selektion_ethnie.Bezeichnung");
        if (!tableString.contains("person_hatethnie")) {
            tableString += " LEFT OUTER JOIN person_hatethnie ON person.ID=person_hatethnie.PersonID";
        }
        if (!tableString.contains("selektion_ethnie")) {
            tableString += " LEFT OUTER JOIN selektion_ethnie ON person_hatethnie.EthnieID=selektion_ethnie.ID";
        }
        //   headlines.add("Ethnie(n)");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Ethnie"));
        person = true;
    }
    if (request.getParameter("Ausgabe_Geschlecht") != null && request.getParameter("Ausgabe_Geschlecht").equals("on")) {
        fields.add("selektion_geschlecht.Bezeichnung");
        fieldNames.add("selektion_geschlecht.Bezeichnung");
        if (!tableString.contains("selektion_geschlecht")) {
            tableString += " LEFT OUTER JOIN selektion_geschlecht ON person.Geschlecht=selektion_geschlecht.ID";
        }
        //   headlines.add("Geschlecht");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Geschlecht"));
        person = true;
    }
    if (request.getParameter("Ausgabe_Person_Verwandte") != null && request.getParameter("Ausgabe_Person_Verwandte").equals("on")) {
        fields.add("selektion_verwandtschaftsgrad.Bezeichnung");
        fields.add("perszu.Standardname");
        fields.add("perszu.ID AS perszuID");
        fieldNames.add("selektion_verwandtschaftsgrad.Bezeichnung");
        fieldNames.add("perszu.Standardname");
        if (!tableString.contains("person_verwandtmit")) {
            tableString += " LEFT OUTER JOIN person_verwandtmit ON person.ID=person_verwandtmit.PersonIDvon";
        }
        if (!tableString.contains("selektion_verwandtschafsgrad")) {
            tableString += " LEFT OUTER JOIN selektion_verwandtschaftsgrad ON person_verwandtmit.VerwandtschaftsgradID=selektion_verwandtschaftsgrad.ID";
        }
        tableString += " LEFT OUTER JOIN person perszu ON person_verwandtmit.PersonIDzu = perszu.ID";
        //headlines.add("Verwandtschaftsgrad");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Verwandtschaftsgrad"));

        //  headlines.add("Verwandte(r)");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Verwandte"));

        person = true;
    }
    if (request.getParameter("Ausgabe_Person_Areal") != null && request.getParameter("Ausgabe_Person_Areal").equals("on")) {
        fields.add("selektion_areal.Bezeichnung");
        fieldNames.add("selektion_areal.Bezeichnung");
        if (!tableString.contains("person_hatareal")) {
            tableString += " LEFT OUTER JOIN person_hatareal ON person.ID=person_hatareal.PersonID";
        }
        if (!tableString.contains("selektion_areal")) {
            tableString += " LEFT OUTER JOIN selektion_areal ON person_hatareal.ArealID=selektion_areal.ID";
        }
        // headlines.add("Areal");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Areal"));

        person = true;
    }

    // ### Zum Einzelbeleg ###
    if (request.getParameter("Ausgabe_Einzelbeleg_Belegstelle") != null && request.getParameter("Ausgabe_Einzelbeleg_Belegstelle").equals("on")) {
        fields.add("quelle.Bezeichnung");
        fields.add("quelle.ID AS quelleID");
        count.add("quelle.ID");
        fieldNames.add("quelle.Bezeichnung");
        if (!tableString.contains("quelle")) {
            tableString += " LEFT OUTER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID";
        }
        //headlines.add("Quelle");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Quelle"));

        fields.add("edition.Titel");
        //fields.add("edition.ID");
        fieldNames.add("edition.Titel");
        if (!tableString.contains("edition")) {
            tableString += " LEFT OUTER JOIN edition ON einzelbeleg.EditionID=edition.ID";
        }
        //headlines.add("Edition");
        headlines.add(DatenbankDB.getMapping(sprache, "quelle", "Edition"));

        fields.add("einzelbeleg.EditionKapitel");
        fieldNames.add("einzelbeleg.EditionKapitel");
        //headlines.add("Kapitel");
        headlines.add(DatenbankDB.getMapping(sprache, "einzelbeleg", "EditionKapitel"));

        fields.add("einzelbeleg.EditionSeite");
        fieldNames.add("einzelbeleg.EditionSeite");
        // headlines.add("Seite");
        headlines.add(DatenbankDB.getMapping(sprache, "einzelbeleg", "EditionSeite"));

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Quellengattung") != null && request.getParameter("Ausgabe_Einzelbeleg_Quellengattung").equals("on")) {
        fields.add("selektion_quellengattung.Bezeichnung");
        fieldNames.add("selektion_quellengattung.Bezeichnung");
        if (!tableString.contains("selektion_quellengattung")) {
            tableString += " LEFT OUTER JOIN selektion_quellengattung ON einzelbeleg.QuelleGattungID=selektion_quellengattung.ID";
    }

    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "QuelleGattung"));

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Belegform") != null && request.getParameter("Ausgabe_Einzelbeleg_Belegform").equals("on")) {
        fields.add("einzelbeleg.Belegform");
        fields.add("einzelbeleg.ID AS einzelbelegID");
        count.add("einzelbeleg.ID");
        fieldNames.add("einzelbeleg.Belegform");
        //headlines.add("Belegform");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Belegform"));

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Kontext") != null && request.getParameter("Ausgabe_Einzelbeleg_Kontext").equals("on")) {
        fields.add("einzelbeleg.Kontext");
        fieldNames.add("einzelbeleg.Kontext");
        // headlines.add("Kontext");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Kontext"));

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Datierung") != null && request.getParameter("Ausgabe_Einzelbeleg_Datierung").equals("on")) {
        fields.add("einzelbeleg.VonTag");
        fields.add("einzelbeleg.VonMonat");
        fields.add("einzelbeleg.VonJahr");
        fields.add("einzelbeleg.VonJahrhundert");
        fields.add("einzelbeleg.BisTag");
        fields.add("einzelbeleg.BisMonat");
        fields.add("einzelbeleg.BisJahr");
        fields.add("einzelbeleg.BisJahrhundert");
        fieldNames.add("einzelbeleg.VonTag");
        fieldNames.add("einzelbeleg.VonMonat");
        fieldNames.add("einzelbeleg.VonJahr");
        fieldNames.add("einzelbeleg.VonJahrhundert");
        fieldNames.add("einzelbeleg.BisTag");
        fieldNames.add("einzelbeleg.BisMonat");
        fieldNames.add("einzelbeleg.BisJahr");
        fieldNames.add("einzelbeleg.BisJahrhundert");
        headlines.add("von T.");
        headlines.add("von M.");
        headlines.add("von J.");
        headlines.add("von Jh.");
        headlines.add("bis T.");
        headlines.add("bis M.");
        headlines.add("bis J.");
        headlines.add("bis Jh.");
        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_lebend") != null && request.getParameter("Ausgabe_Einzelbeleg_lebend").equals("on")) {
        fields.add("selektion_lebendverstorben.Bezeichnung");
        fieldNames.add("selektion_lebendverstorben.Bezeichnung");
        if (!tableString.contains("selektion_lebendverstorben")) {
            tableString += " LEFT OUTER JOIN selektion_lebendverstorben ON einzelbeleg.LebendVerstorbenID=selektion_lebendverstorben.ID";
        }
        //headlines.add("lebend / verstorben");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Lebend"));

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Funktion") != null && request.getParameter("Ausgabe_Einzelbeleg_Funktion").equals("on")) {
        fields.add("selektion_funktion.Bezeichnung");
        fieldNames.add("selektion_funktion.Bezeichnung");
        if (!tableString.contains("einzelbeleg_hatfunktion")) {
            tableString += " LEFT OUTER JOIN einzelbeleg_hatfunktion ON einzelbeleg.ID=einzelbeleg_hatfunktion.EinzelbelegID";
        }
        if (!tableString.contains("selektion_funktion")) {
            tableString += " LEFT OUTER JOIN selektion_funktion ON einzelbeleg_hatfunktion.FunktionID=selektion_funktion.ID";
        }
        // headlines.add("Funktion");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Funktion"));

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Areal") != null && request.getParameter("Ausgabe_Einzelbeleg_Areal").equals("on")) {
        fields.add("selektion_areal.Bezeichnung");
        fieldNames.add("selektion_areal.Bezeichnung");
        if (!tableString.contains("einzelbeleg_hatareal")) {
            tableString += " LEFT OUTER JOIN einzelbeleg_hatareal ON einzelbeleg.ID=einzelbeleg_hatareal.EinzelbelegID";
        }
        if (!tableString.contains("selektion_areal")) {
            tableString += " LEFT OUTER JOIN selektion_areal ON einzelbeleg_hatareal.ArealID=selektion_areal.ID";
        }
        //headlines.add("Areal");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Areal"));

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Varianten") != null && request.getParameter("Ausgabe_Einzelbeleg_Varianten").equals("on")) {
        fields.add("einzelbeleg_textkritik.Variante");
        fields.add("handschrift.Bibliothekssignatur");
        fields.add("handschrift_ueberlieferung.VonJahrhundert");
        fields.add("handschrift_ueberlieferung.BisJahrhundert");
        fieldNames.add("einzelbeleg_textkritik.Variante");
        fieldNames.add("handschrift.Bibliothekssignatur");
        fieldNames.add("handschrift_ueberlieferung.VonJahrhundert");
        fieldNames.add("handschrift_ueberlieferung.BisJahrhundert");
        if (!tableString.contains("einzelbeleg_textkritik")) {
            tableString += " LEFT OUTER JOIN einzelbeleg_textkritik ON einzelbeleg.ID=einzelbeleg_textkritik.EinzelbelegID LEFT OUTER JOIN ueberlieferung_edition ON (einzelbeleg_textkritik.EditionID=ueberlieferung_edition.EditionID AND einzelbeleg_textkritik.HandschriftID=ueberlieferung_edition.UeberlieferungID) LEFT OUTER JOIN handschrift_ueberlieferung ON handschrift_ueberlieferung.ID=ueberlieferung_edition.UeberlieferungID LEFT OUTER JOIN handschrift ON handschrift_ueberlieferung.HandschriftID=handschrift.ID ";
        }
        // headlines.add("Variante");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Varianten"));
        headlines.add("Bib.Sig.");
        headlines.add("TZ v. J.");
        headlines.add("TZ b. J.");

        einzelbeleg = true;
    }
    if (request.getParameter("Ausgabe_Einzelbeleg_Textzeuge_Schriftheimat") != null && request.getParameter("Ausgabe_Einzelbeleg_Textzeuge_Schriftheimat").equals("on")) {
        fields.add("handschrift_ueberlieferung.Schriftheimat");
        fieldNames.add("handschrift_ueberlieferung.Schriftheimat");
        if (!tableString.contains("handschrift")) {
            tableString += " LEFT OUTER JOIN handschrift ON handschrift.ID = einzelbeleg.HandschriftID";
        }
        if (!tableString.contains("handschrift_ueberlieferung")) {
            tableString += " LEFT OUTER JOIN handschrift_ueberlieferung ON handschrift.ID=handschrift_ueberlieferung.HandschriftID";
        }
        //headlines.add("Schriftheimat d. Textzeugen");
        headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Textzeuge_Schriftheimat"));

        einzelbeleg = true;
    }
    // ######### AUSGABEFELDER ##########

    // ######### ORDER BY ##########
    String orderV[] = new String[15];
    String order = "";
    if (request.getParameter("neworder") != null) {
        order = "ORDER BY " + request.getParameter("neworder") + " ";
        if (request.getParameter("newdirection") != null) {
            order += request.getParameter("newdirection");
        } else {
            order += "ASC";
        }
    }

    for (int i = 1; i < orderV.length; i++) {
        if (request.getParameter("order" + i) != null && !request.getParameter("order" + i).equals("-1")) {
            if (i == 1 && request.getParameter("neworder") == null) {
                order = "ORDER BY";
            } else {
                order += ", ";
            }
            if (request.getParameter("order" + i).equals("OrderNamen")) {
                order += " namenkommentar.PLemma";
                orderV[i - 1] = "namenkommentar.PLemma";
                namenkommentar = true;

                if (request.getParameter("Ausgabe_Namenlemma") == null || !request.getParameter("Ausgabe_Namenlemma").equals("on")) {
                    fields.add("namenkommentar.PLemma");
                    fields.add("namenkommentar.ID");
                    fieldNames.add("namenkommentar.PLemma");
                    count.add("namenkommentar.ID");
                    tables.add("namenkommentar");
                    // headlines.add("Namenlemma");
                    headlines.add(DatenbankDB.getMapping(sprache, "namenkommentar", "PLemma"));
                    namenkommentar = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderMGH")) {
                order += " mgh_lemma.MGHLemma";
                orderV[i - 1] = "mgh_lemma.MGHLemma";
                mghlemma = true;

                if (request.getParameter("Ausgabe_MGHLemma") == null || !request.getParameter("Ausgabe_MGHLemma").equals("on")) {
                    fields.add("mgh_lemma.MGHLemma");
                    fields.add("mgh_lemma.ID");
                    fieldNames.add("mgh_lemma.MGHLemma");
                    count.add("mgh_lemma.ID");
                    tables.add("mgh_lemma");
                    // headlines.add("Namenlemma");
                    headlines.add(DatenbankDB.getMapping(sprache, "mgh_lemma", "MGHLemma"));
                    mghlemma = true;
                }

            } else if (request.getParameter("order" + i).equals("OrderErstglied")) {
                order += " Erstglied";
                orderV[i - 1] = "Erstglied";
                namenkommentar = true;

                if (request.getParameter("Ausgabe_Erstglied") == null || !request.getParameter("Ausgabe_Erstglied").equals("on")) {
                    fields.add("substring_index(`namenkommentar`.`PLemma`,_utf8'~',1) AS `Erstglied`");
                    fieldNames.add("Erstglied");
                    tables.add("namenkommentar");
                    headlines.add("Erstglied");
                    namenkommentar = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderZweitglied")) {
                order += " Zweitglied";
                orderV[i - 1] = "Zweitglied";
                namenkommentar = true;

                if (request.getParameter("Ausgabe_Zweitglied") == null || !request.getParameter("Ausgabe_Zweitglied").equals("on")) {
                    fields.add("substring_index(`namenkommentar`.`PLemma`,_utf8'~',-(1)) AS `Zweitglied`");
                    fieldNames.add("Zweitglied");
                    tables.add("namenkommentar");
                    headlines.add("Zweitglied");
                    namenkommentar = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderPersonen")) {
                order += " person.Standardname";
                orderV[i - 1] = "person.ID";
                person = true;

                if (request.getParameter("Ausgabe_Person_Standardname") == null || !request.getParameter("Ausgabe_Person_Standardname").equals("on")) {
                    fields.add("person.Standardname");
                    fields.add("person.ID");
                    count.add("person.ID");
                    fieldNames.add("person.Standardname");
                    tables.add("person");
                    //   		headlines.add("Standardname");
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Standardname"));
                    person = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderGeschlecht")) {
                order += " selektion_geschlecht.Bezeichnung";
                orderV[i - 1] = "selektion_geschlecht.Bezeichnung";
                person = true;

                if (request.getParameter("Ausgabe_Geschlecht") == null || !request.getParameter("Ausgabe_Geschlecht").equals("on")) {
                    fields.add("selektion_geschlecht.Bezeichnung");
                    fieldNames.add("selektion_geschlecht.Bezeichnung");
                    if (!tableString.contains("selektion_geschlecht")) {
                        tableString += " LEFT OUTER JOIN selektion_geschlecht ON person.Geschlecht=selektion_geschlecht.ID";
                    }
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Geschlecht"));
                    person = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderAmtWeihe")) {
                order += " selektion_amtweihe.Bezeichnung";
                orderV[i - 1] = "selektion_amtweihe.Bezeichnung";
                person = true;

                if (request.getParameter("Ausgabe_Person_AmtWeihe") == null || !request.getParameter("Ausgabe_Person_AmtWeihe").equals("on")) {
                    fields.add("selektion_amtweihe.Bezeichnung");
                    fieldNames.add("selektion_amtweihe.Bezeichnung");
                    if (!tableString.contains("person_hatamtstandweihe")) {
                        tableString += " LEFT OUTER JOIN person_hatamtstandweihe ON person.ID=person_hatamtstandweihe.PersonID";
                    }
                    if (!tableString.contains("selektion_amtweihe")) {
                        tableString += " LEFT OUTER JOIN selektion_amtweihe ON person_hatamtstandweihe.AmtWeiheID=selektion_amtweihe.ID";
                    }
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_AmtWeihe"));

                    person = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderStand")) {
                order += " selektion_stand.Bezeichnung";
                orderV[i - 1] = "selektion_stand.Bezeichnung";
                person = true;

                if (request.getParameter("Ausgabe_Stand") == null || !request.getParameter("Ausgabe_Stand").equals("on")) {
                    fields.add("selektion_stand.Bezeichnung");
                    fieldNames.add("selektion_stand.Bezeichnung");
                    if (!tableString.contains("person_hatstand")) {
                        tableString += " LEFT OUTER JOIN person_hatstand ON person.ID=person_hatstand.PersonID";
                    }
                    if (!tableString.contains("selektion_stand")) {
                        tableString += " LEFT OUTER JOIN selektion_stand ON person_hatstand.StandID=selektion_stand.ID";
                    }
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Stand"));

                    person = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderEthnie")) {
                order += " selektion_ethnie.Bezeichnung";
                orderV[i - 1] = "selektion_ethnie.Bezeichnung";
                person = true;

                if (request.getParameter("Ausgabe_Person_Ethnie") == null || !request.getParameter("Ausgabe_Person_Ethnie").equals("on")) {
                    fields.add("selektion_ethnie.Bezeichnung");
                    fieldNames.add("selektion_ethnie.Bezeichnung");
                    if (!tableString.contains("person_hatethnie")) {
                        tableString += " LEFT OUTER JOIN person_hatethnie ON person.ID=person_hatethnie.PersonID";
                    }
                    if (!tableString.contains("selektion_ethnie")) {
                        tableString += " LEFT OUTER JOIN selektion_ethnie ON person_hatethnie.EthnieID=selektion_ethnie.ID";
                    }
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Ethnie"));
                    person = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderBelege")) {
                order += " einzelbeleg.Belegform";
                orderV[i - 1] = "einzelbeleg.ID";
                einzelbeleg = true;

                if (request.getParameter("Ausgabe_Einzelbeleg_Belegform") == null || !request.getParameter("Ausgabe_Einzelbeleg_Belegform").equals("on")) {
                    fields.add("einzelbeleg.Belegform");
                    fields.add("einzelbeleg.ID");
                    count.add("einzelbeleg.ID");
                    fieldNames.add("einzelbeleg.Belegform");
                    //		headlines.add("Belegform");
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Belegform"));

                    einzelbeleg = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderQuellen")) {
                order += " quelle.Bezeichnung";
                orderV[i - 1] = "quelle.Bezeichnung";
                einzelbeleg = true;

                if (request.getParameter("Ausgabe_Einzelbeleg_Belegstelle") == null || !request.getParameter("Ausgabe_Einzelbeleg_Belegstelle").equals("on")) {
                    fields.add("quelle.Bezeichnung");
                    fields.add("quelle.ID");
                    count.add("quelle.ID");
                    fieldNames.add("quelle.Bezeichnung");
                    if (!tableString.contains("quelle")) {
                        tableString += " LEFT OUTER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID";
                    }
                    //		headlines.add("Quelle");
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Quelle"));

                    einzelbeleg = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderQuellengattung")) {
                order += " selektion_quellengattung.Bezeichnung";
                orderV[i - 1] = "selektion_quellengattung.Bezeichnung";
                einzelbeleg = true;

                if (request.getParameter("Ausgabe_Einzelbeleg_Quellengattung") == null || !request.getParameter("Ausgabe_Einzelbeleg_Quellengattung").equals("on")) {
                    fields.add("selektion_quellengattung.Bezeichnung");
                    fieldNames.add("selektion_quellengattung.Bezeichnung");
                    if (!tableString.contains("selektion_quellengattung")) {
                        tableString += " LEFT OUTER JOIN selektion_quellengattung ON einzelbeleg.QuelleGattungID=selektion_quellengattung.ID";
                    }
                    //		headlines.add("Quellengattung");
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Quellengattung"));

                    einzelbeleg = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderVariante")) {
                order += " einzelbeleg_textkritik.Variante";
                orderV[i - 1] = "einzelbeleg_textkritik.Variante";
                einzelbeleg = true;

                if (request.getParameter("Ausgabe_Einzelbeleg_Varianten") == null || !request.getParameter("Ausgabe_Einzelbeleg_Varianten").equals("on")) {
                    fields.add("einzelbeleg_textkritik.Variante");
                    fields.add("handschrift.Bibliothekssignatur");
                    fields.add("handschrift_ueberlieferung.VonJahrhundert");
                    fields.add("handschrift_ueberlieferung.BisJahrhundert");
                    fieldNames.add("einzelbeleg_textkritik.Variante");
                    fieldNames.add("handschrift.Bibliothekssignatur");
                    fieldNames.add("handschrift_ueberlieferung.VonJahrhundert");
                    fieldNames.add("handschrift_ueberlieferung.BisJahrhundert");
                    if (!tableString.contains("einzelbeleg_textkritik")) {
                        tableString += " LEFT OUTER JOIN einzelbeleg_textkritik ON einzelbeleg.ID=einzelbeleg_textkritik.EinzelbelegID LEFT OUTER JOIN ueberlieferung_edition ON (einzelbeleg_textkritik.EditionID=ueberlieferung_edition.EditionID AND einzelbeleg_textkritik.HandschriftID=ueberlieferung_edition.UeberlieferungID) LEFT OUTER JOIN handschrift_ueberlieferung ON handschrift_ueberlieferung.ID=ueberlieferung_edition.UeberlieferungID LEFT OUTER JOIN handschrift ON handschrift_ueberlieferung.HandschriftID=handschrift.ID ";
                    }
                    // headlines.add("Variante");
                    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Varianten"));
                    headlines.add("Bib.Sig.");
                    headlines.add("TZ v. J.");
                    headlines.add("TZ b. J.");

                    einzelbeleg = true;
                }
            } else if (request.getParameter("order" + i).equals("OrderTextzeugen")) {

            } else if (request.getParameter("order" + i).equals("OrderDatEinzelbeleg")) {
                orderV[i - 1] = "einzelbelegBerJahr";
                int zeitraum = 25;
                try {
                    zeitraum = Integer.parseInt(request.getParameter("order" + i + "zeit"));
                } catch (Exception ex) {
                }
                order += " (VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert) DIV " + zeitraum + "), VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert)"; // Richtung wird spÃ¤ter angefÃ¼gt
                einzelbeleg = true;

                //  if (request.getParameter("Ausgabe_Einzelbeleg_Datierung") == null || !request.getParameter("Ausgabe_Einzelbeleg_Datierung").equals("on")) {
                fields.add("VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert) AS einzelbelegBerJahr");
                fieldNames.add("einzelbelegBerJahr");
                headlines.add("EB von J.");
                einzelbeleg = true;
                //	}
            } else if (request.getParameter("order" + i).equals("OrderDatQuelle")) {
                orderV[i - 1] = "quelleBerJahr";
                int zeitraum = 25;
                try {
                    zeitraum = Integer.parseInt(request.getParameter("order" + i + "zeit"));
                } catch (Exception ex) {
                }
                order += " (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) DIV " + zeitraum + "), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert)"; // Richtung wird spÃ¤ter angefÃ¼gt
                einzelbeleg = true;

                //   if (request.getParameter("Ausgabe_Quelle_Datierung") == null || !request.getParameter("Ausgabe_Quelle_Datierung").equals("on")) {
                fields.add("VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) AS quelleBerJahr");
                fieldNames.add("quelleBerJahr");
                if (!tableString.contains("quelle")) {
                    tableString += " LEFT OUTER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID";
                }

                headlines.add("Q von J.");
                einzelbeleg = true;
                //	}
            } else if (request.getParameter("order" + i).equals("OrderAemter")) {

            }
            if (request.getParameter("order" + i + "ASCDESC") != null) {
                order += " " + request.getParameter("order" + i + "ASCDESC");
            } else {
                order += " ASC";
            }
        } else {
            orderV[i] = "-";
        }

        //  out.println(order);
        // end if
    } // end for
    // ######### ORDER BY ##########

    // ######### EXPORT ##########
    String export = "browse";
    if (request.getParameter("export") != null) {
        export = request.getParameter("export");
    }
    // ######### EXPORT ##########

    // ######### Grundtabellen ##########
    String tablePreString = "";
    if (einzelbeleg || (person && namenkommentar) || (person && mghlemma) || (namenkommentar && mghlemma)) {
        tablePreString = "einzelbeleg";
        if (person) {
            tablePreString += " LEFT OUTER JOIN einzelbeleg_hatperson ON einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID";
            tablePreString += " LEFT OUTER JOIN person ON einzelbeleg_hatperson.PersonID=person.ID";
        }
        if (namenkommentar) {
            tablePreString += " LEFT OUTER JOIN einzelbeleg_hatnamenkommentar ON einzelbeleg_hatnamenkommentar.EinzelbelegID=einzelbeleg.ID";
            tablePreString += " LEFT OUTER JOIN namenkommentar ON namenkommentar.ID=einzelbeleg_hatnamenkommentar.NamenkommentarID";
        }
        if (mghlemma) {
            tablePreString += " LEFT OUTER JOIN einzelbeleg_hatmghlemma ON einzelbeleg_hatmghlemma.EinzelbelegID=einzelbeleg.ID";
            tablePreString += " LEFT OUTER JOIN mgh_lemma ON mgh_lemma.ID=einzelbeleg_hatmghlemma.MGHLemmaID";
        }

    } else if (person) {
        tablePreString = "person";
    } else if (namenkommentar) {
        tablePreString = "namenkommentar";
    } else if (mghlemma) {
        tablePreString = "mgh_lemma";
    }
    tableString = tablePreString + tableString;
    // ######### Grundtabellen ##########

    if (true) {
        conditions = removeDuplicates(conditions);
        fields = removeDuplicates(fields);
        tables = removeDuplicates(tables);

        joins = removeDuplicates(joins);

        // Bedingungen
        String conditionsString = "";
        if (conditions.size() > 0) {
            conditionsString += conditions.get(0);
            for (int i = 1; i < conditions.size(); i++) {
                conditionsString += " AND " + conditions.get(i);
            }
        } else {
            conditionsString += "1";
        }

        // Ausgabefelder
        String fieldsString = "";
        if (fields.size() > 0) {
            fieldsString += fields.get(0);
            for (int i = 1; i < fields.size(); i++) {
                if (fields.get(i).contains(" AS ")) {
                    fieldsString += ", " + fields.get(i);
                } else {
                    fieldsString += ", " + QueryHelper.getFieldAliasSelect(fields.get(i));
                }
            }
        }

        // ZÃ¤hlfelder
        String countString = "";
        if (count.size() > 0) {
            countString += "count(DISTINCT " + count.get(0) + ")";
            for (int i = 1; i < count.size(); i++) {
                countString += ", count(DISTINCT " + count.get(i) + ")";
            }
        }

        // Tabellen
        String tablesString = "";
        if (tables.size() > 0) {
            tablesString += tables.get(0);
            for (int i = 1; i < tables.size(); i++) {
                tablesString += ", " + tables.get(i);
            }
        }

        // Joins
        String joinsString = "";
        if (joins.size() > 0) {
            joinsString += joins.get(0);
            for (int i = 1; i < joins.size(); i++) {
                joinsString += " " + joins.get(i);
            }
        }

        tablesString = tableString;

        int pageoffset = 0;
        if (request.getParameter("pageoffset") != null) {
            pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
        }

        if (fields.size() == 0) {
            out.println("Bitte w&auml;hlen Sie mind. ein Ausgabefeld aus (Schritt 2).");
            return;
        }

        String sql = "SELECT " + countString + " FROM " + tablesString + " WHERE (" + conditionsString + ")"; // GROUP BY "+fieldsString;

    if (!countString.equals("")) {
        java.util.List<Object[]> resultList = DatenbankDB.getListNative(sql);

        if (!resultList.isEmpty()) {
            Object firstResult = resultList.get(0); // Erstes Element aus der Ergebnisliste abrufen

            if (firstResult instanceof Object[]) {
                Object[] innerArray = (Object[]) firstResult;
                StringBuilder output = new StringBuilder();

                for (int i = 0; i < count.size(); i++) {
                    if (innerArray[i] instanceof Number) {
                        int countValue = ((Number) innerArray[i]).intValue();  //Zählererbnis

                        if (countValue >= 0) {
                            output.append("Insgesamt ");
                            output.append(countValue).append(" ");

                            // Spezifische Ausgabe basierend auf dem Titel
                            if (count.get(i).startsWith("namenkommentar")) {
                                if (countValue > 1 || countValue == 0) {
                                    output.append("Namenkommentare");
                                } else {
                                    output.append("Namenkommentar");
                                }
                            } else if (count.get(i).startsWith("mgh_lemma")) {
                                output.append("MGH-Lemma");
                            } else if (count.get(i).startsWith("person")) {
                                if (countValue > 1 || countValue == 0) {
                                    output.append("Personen");
                                } else {
                                    output.append("Person");
                                }
                            } else if (count.get(i).startsWith("quelle")) {
                                if (countValue > 1 || countValue == 0) {
                                    output.append("Quellen");
                                } else {
                                    output.append("Quelle");
                                }
                            } else if (count.get(i).startsWith("einzelbeleg")) {
                                if (countValue > 1 || countValue == 0) {
                                    output.append("Belege");
                                } else {
                                    output.append("Beleg");
                                }
                            }

                            output.append(", ");
                        }
                    }
                }

                // Ausgabe der Gesamtanzahl und Entfernen des letzten Kommas
                String totalCountOutput = output.toString();
                if (!totalCountOutput.isEmpty()) {
                    totalCountOutput = totalCountOutput.substring(0, totalCountOutput.length() - 2); // Letztes Komma entfernen
                    out.println(totalCountOutput);
                }
            } else {

                int countValue = ((Number) firstResult).intValue();
                if (countValue > 0) {
                    // Erstelle eine Ausgabe für das einzelne Ergebnis
                    StringBuilder output = new StringBuilder("Insgesamt ");
                    output.append(countValue).append(" ");

                    if (count.get(0).startsWith("namenkommentar")) {
                        if (countValue > 1 || countValue == 0) {
                            output.append("Namenkommentare");
                        } else {
                            output.append("Namenkommentar");
                        }
                    } else if (count.get(0).startsWith("mgh_lemma")) {
                        output.append("MGH-Lemma");
                    } else if (count.get(0).startsWith("person")) {
                        if (countValue > 1 || countValue == 0) {
                            output.append("Personen");
                        } else {
                            output.append("Person");
                        }
                    } else if (count.get(0).startsWith("quelle")) {
                        if (countValue > 1 || countValue == 0) {
                            output.append("Quellen");
                        } else {
                            output.append("Quelle");
                        }
                    } else if (count.get(0).startsWith("einzelbeleg")) {
                        if (countValue > 1 || countValue == 0) {
                            output.append("Belege");
                        } else {
                            output.append("Beleg");
                        }
                    }

                    output.append(", ");

                    // Ausgabe der Gesamtanzahl
                    String totalCountOutput = output.toString();
                    totalCountOutput = totalCountOutput.substring(0, totalCountOutput.length() - 2); // Letztes Komma entfernen
                    out.println(totalCountOutput);
                }
            }
        }
    }

    sql = "SELECT DISTINCT " + fieldsString + " FROM " + tablesString + " WHERE (" + conditionsString + ") " + order; //GROUP BY "+fieldsString+"
    //     if (export.equals("liste") || export.equals("browse"))
    //       sql += " LIMIT "+(pageoffset*pageLimit)+", "+pageLimit;

//out.println(sql);
    List<Map> rowlist = SucheDB.getMappedList(sql);

    //    out.println("<p><i>insgesamt <b>"+linecount+"</b> Treffer</i></p>");
    int orderSize = 0;
    for (int z = 0; z < orderV.length; z++) {
        if (orderV[z] != null && !orderV[z].equals("-")) {
            orderSize++;
        }
    }
    boolean[] first = {true, true, true, true, true, true, true, true, true, true, true, true, true, true, true};
    String oldValue[] = new String[15];

    // ########## LISTE/BROWSE ##########
    if (export.equals("liste") || export.equals("browse")) {

        String header = "";

        out.print("<div id=\"level-functions\"><div class=\"open_next_level\" onClick=\"expandNextLevel('complete')\" >Weitere Ebene aufklappen</div>");
        out.print("<div class=\"close_prev_level\" onClick=\"collapseNextLevel('complete')\">Weitere Ebene zuklappen</div></div>");

        //      out.println("<table class=\"resultlist\">");
        header += "<tr>";
        for (int i = 0; i < headlines.size(); i++) {
            if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                header += "<th>";
                // Link für Seite erzeugen
                String direction = "";
                if (order.contains(fieldNames.get(i))) {
                    direction = order.substring(order.indexOf(fieldNames.get(i) + " ") + fieldNames.get(i).length() + 1, min(order.length(), order.indexOf(fieldNames.get(i) + " ") + fieldNames.get(i).length() + 5));
                    if (direction.contains("DESC")) {
                        direction = "DESC";
                    } else {
                        direction = "ASC";
                    }
                }

                String parameter = "?neworder=" + fieldNames.get(i);
                if (direction.equals("ASC")) {
                    parameter += "&newdirection=DESC";
                } else {
                    parameter += "&newdirection=ASC";
                }

                for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                    String paramName = e.nextElement();
                    if (!paramName.contains("order") && !paramName.equals("newdirection")) {
                        parameter += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                    }
                }

                header += headlines.get(i);

                header += "</th>";
            }
        }
        boolean even = false;
        header += "</tr>";
        out.print("<p id='result-loading'>Suchergebnis l\u00E4dt...</p>");
        out.print("<ul class=\"mktree\" id=\"complete\" style='display:none'>");

        if (orderSize == 0) {
            out.print("<table class=\"resultlist\">" + header + "<tr>");
        }

        boolean found = false;

        java.util.List<java.util.Map<String, String>> searchRes = FrontendExtendedSearch.getSearchResult(fieldsString, tablesString, conditionsString, order, fields.toArray(new String[fields.size()]));

        for (java.util.Map row : searchRes) {
            found = true;

            for (int z = 0; z < orderSize; z++) {
                int jahr = 0;
                String jahrV = "";
                Object value = row.get(orderV[z]);
                if (value != null) {
                    jahrV = value.toString();
                }

                int zeitraum = 0;
                if (orderV[z].endsWith("Jahr")) {
                    try {
                        zeitraum = Integer.parseInt(request.getParameter("order" + (z + 1) + "zeit"));
                    } catch (Exception ex) {
                        zeitraum = 25;
                    }
                    if (jahrV == null || jahrV.isEmpty()) {
                        jahr = 0;
                    } else {
                        jahr = Integer.parseInt(jahrV);
                    }
                    if (zeitraum != 0) {
                        jahr = jahr / zeitraum;
                    }
                    jahrV = String.valueOf(jahr);
                }

                if (first[z] || row.get(orderV[z]) != null && !jahrV.equalsIgnoreCase(oldValue[z])) {
                    oldValue[z] = jahrV;
                    if (!first[z]) {
                        out.print("</table>");
                        for (int z2 = z; z2 < orderSize; z2++) {
                            out.print("</ul></li>");
                        }
                    }
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
                    Object value_2 = row.get(orderV[z]);

                    if (value_2 != null) {
                        text = value_2.toString();
                    }
                    if (orderV[z].startsWith("einzelbeleg.ID")) {
                        text = row.get("einzelbeleg.Belegform").toString();
                    }
                    if (orderV[z].startsWith("person.ID")) {
                        text = row.get("person.Standardname").toString();
                    }
                    if (text == null) {
                        text = "-";
                    }
                    String titel = orderV[z];

                    if (orderV[z].startsWith("einzelbeleg.ID")) {
                        titel = "einzelbeleg.Belegform";
                    }
                    if (orderV[z].startsWith("person.ID")) {
                        titel = "person.Standardname";
                    }
                    titel = headlines.get(fieldNames.indexOf(titel));

                    out.print(titel + ":");
                    boolean link = false;
                    if (export.equals("browse") && !text.equals("-")) {
                        if (orderV[z].equals("einzelbeleg.ID")) {
                            out.print("<a href=\"einzelbeleg?ID=" + row.get("einzelbelegID") + "\">");
                            link = true;
                        } else if (orderV[z].equals("person.ID")) {
                            out.print("<a href=\"person?ID=" + row.get("personID") + "\">");
                            link = true;
                        } else if (orderV[z].equals("perszu.Standardname")) {
                            out.print("<a href=\"person?ID=" + row.get("perszuID") + "\">");
                            link = true;
                        } else if (orderV[z].equals("namenkommentar.PLemma")) {
                            out.print("<a href=\"namenkommentar?ID=" + row.get("namenkommentarID") + "\">");
                            link = true;
                        } else if (orderV[z].equals("mgh_lemma.MGHLemma")) {
                            out.print("<a href=\"mghlemma?ID=" + row.get("mgh_lemmaID") + "\">");
                            link = true;
                        } else if (orderV[z].equals("quelle.Bezeichnung")) {
                            out.print("<a href=\"quelle?ID=" + row.get("quelleID") + "\">");
                            link = true;
                        } else if (orderV[z].equals("edition.Titel")) {
                            try {
                                out.print("<a href=\"edition?ID=" + row.get("edition.ID") + "\">");
                                link = true;
                            } catch (Exception e) {
                                link = false;
                            }
                        } else if (orderV[z].contains("ID")) {
                            out.print("<a href=\"" + formular + "?ID=" + row.get(formular + ".ID") + "\">Gehe zu: ");
                            link = true;
                        }
                    }

                    if (orderV[z].startsWith("einzelbeleg.ID")) {
                        out.print(format(DBtoHTML(text), "einzelbeleg.Belegform"));
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
                        out.print("</a>&nbsp;");
                    }

                    if (z == orderSize - 1) {
                        out.print("<ul><table class=\"resultlist\">" + header + "<tr>");
                    } else {
                        out.print("<ul>");
                    }
                }
            }

            out.print("<tr class=\"" + (even ? "" : "un") + "even\">");
            if (!formular.equals("favorit") && !formular.equals("freie_suche") && !formular.equals("namenkommentar") && !formular.equals("literatur")) {
                out.print("<td valign=\"top\" align=\"center\"><a href=\"" + formular + "?ID=" + row.get(formular + ".ID") + "\">Gehe zu</a></td>");
            }

            for (int i = 0; i < fieldNames.size(); i++) {
                if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                    out.print("<td class=\"resultlist\" valign=\"top\">");
                    if (row.get(fieldNames.get(i)) != null && !DBtoHTML(row.get(fieldNames.get(i))).equals("")) {
                        String cell = DBtoHTML(row.get(fieldNames.get(i)));
                        if (export.equals("browse")) {
                            boolean link = false;
                            if (fieldNames.get(i).contains("einzelbeleg.Belegform")) {
                                out.print("<a href=\"einzelbeleg?ID=" + row.get("einzelbelegID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("person.Standardname")) {
                                out.print("<a href=\"person?ID=" + row.get("personID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("perszu.Standardname")) {
                                out.print("<a href=\"person?ID=" + row.get("perszuID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("namenkommentar.PLemma")) {
                                out.print("<a href=\"namenkommentar?ID=" + row.get("namenkommentarID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("mgh_lemma.MGHLemma")) {
                                out.print("<a href=\"mghlemma?ID=" + row.get("mgh_lemmaID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("quelle.Bezeichnung")) {
                                out.print("<a href=\"quelle?ID=" + row.get("quelleID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("edition.Titel")) {
                                link = false;
                            } else if (fieldNames.get(i).contains("ID")) {
                                out.print("<a href=\"" + formular + "?ID=" + row.get(formular + ".ID") + "\">Gehe zu: ");
                                link = true;
                            }
                            if (fieldNames.get(i).endsWith("PLemma") || fieldNames.get(i).equals("Erstglied") || fieldNames.get(i).equals("Zweitglied")) {
                                cell = format(cell, "PLemma");
                            }
                            out.print(cell);
                            if (link) {
                                out.print("</a>");
                            }
                        } else {
                            if (fieldNames.get(i).endsWith("PLemma") || fieldNames.get(i).equals("Erstglied") || fieldNames.get(i).equals("Zweitglied")) {
                                cell = format(cell, "PLemma");
                            }

                            out.print(cell);
                        }
                    } else {
                        out.print("&nbsp;");
                    }
                    out.print("</td>");
                }
            }
            out.print("</tr>");
            even = !even;
        }

        out.print("</tr>");
        out.print("</table>");
        for (int z = orderSize - 1; z >= 0; z--) {
            out.print("</ul></li>");
        }

        if (!found) {
            out.println("Kein Eintrag vorhanden, der dem Suchkriterium entspricht.");
        }

        out.print("</ul>");

%>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function (e) {
        var result_list = document.getElementById("complete");
        try {
            var array = result_list.getElementsByTagName("li");
            for (var j = 0; j < array.length; j++) {
                var ul = array[j].getElementsByTagName("ul")[0].previousSibling;
                var li = array[j].getElementsByTagName("li");
                var count = 0;
                if (li.length < 1)
                    count = (array[j].getElementsByTagName("table")[0].rows.length - 2);
                else
                    count = ul.nextSibling.childNodes.length;
                if (count == 1)
                    ul.data = ul.data + "(" + count + " Eintrag)";
                else
                    ul.data = ul.data + "(" + count + " Eintr\u00E4ge)";
            }
        } catch (ex) {
        } finally {
            result_list.style.display = "block";
            document.getElementById("result-loading").style.display = "none";
        }
    });
</script>
<%                }
        // ########## LISTE/BROWSE #########

        // ########## EXCEL #########
        if (export.equals("excel")) {
            PrintWriter excel = new PrintWriter(new FileWriter(this.getServletContext().getRealPath("/") + "print\\output_" + session.getAttribute("Benutzername") + ".csv"));
            for (int z = 0; z < orderSize; z++) {
                String titel = orderV[z];
                if (orderV[z].startsWith("einzelbeleg.ID")) {
                    titel = "einzelbeleg.Belegform";
                }
                titel = headlines.get(fieldNames.indexOf(titel));
                excel.print("\"" + titel + "\";");
            }

            for (int i = 0; i < headlines.size(); i++) {
                if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                    excel.print("\"" + headlines.get(i) + "\";");
                }
            }
            excel.println();

            for (Map row : rowlist) {
                for (int z = 0; z < orderSize; z++) {
                    int jahr = 0;
                    String jahrV = row.get(orderV[z]).toString();
                    int zeitraum = 0;
                    if (orderV[z].endsWith("Jahr")) {
                        zeitraum = Integer.parseInt(request.getParameter("order" + (z + 1) + "zeit"));
                        if (jahrV == null) {
                            jahr = 0;
                        } else {
                            jahr = Integer.parseInt(jahrV);
                        }
                        jahr = jahr / zeitraum;
                        jahrV = "" + jahr;
                    }

                    if (first[z] || row.get(orderV[z]) != null && !jahrV.equals(oldValue[z])) {
                        oldValue[z] = jahrV;
                        if (!first[z]) {
                            excel.println();
                        }
                        first[z] = false;
                        for (int z2 = z + 1; z2 < orderSize; z2++) {
                            first[z2] = true;
                        }
                        for (int z2 = 0; z2 < z; z2++) {
                            excel.print(";");
                        }

                        String text = row.get(orderV[z]).toString();
                        if (orderV[z].startsWith("einzelbeleg.ID")) {
                            text = row.get("einzelbeleg.Belegform").toString();
                        }
                        if (text == null) {
                            text = "-";
                        }
                        String titel = orderV[z];

                        if (orderV[z].startsWith("einzelbeleg.ID")) {
                            titel = "einzelbeleg.Belegform";
                        }

                        if (orderV[z].endsWith("Jahr")) {
                            int ja = Integer.parseInt(oldValue[z]);
                            excel.println("\"" + (ja * zeitraum) + "-" + ((ja + 1) * zeitraum - 1) + "\";");
                        } else {
                            String format = orderV[z];
                            if (orderV[z].equals("Erstglied") || orderV[z].equals("Zweitglied")) {
                                format = "PLemma";
                            }
                            excel.println("\"" + text + "\";");
                        }
                    }
                }

                for (int z2 = 0; z2 < orderSize; z2++) {
                    excel.print(";");
                }

                for (String fieldName : fieldNames) {

                    if (fieldName.endsWith("Jahrhundert") || fieldName.endsWith("Jahr") || fieldName.endsWith("Monat") || fieldName.endsWith("Tag") || !order.contains(fieldName)) {

                        if (row.get(fieldName) == null || row.get(fieldName).toString().equals("null")) {
                            excel.print("\"-\";");
                        } else {
                            excel.print("\"" + row.get(fieldName) + "\";");
                        }
                    }
                }
                excel.println();
            }
            excel.close();
            out.println("<a href='../../print/output_" + session.getAttribute("Benutzername") + ".csv'>herunterladen</a>");
        }
        // ########## EXCEL #########

        // ########## RTF #########
        if (export.equals("rtf")) {
            Document document = new Document(PageSize.A4.rotate());

            // step 2:
            // we create a writer that listens to the document
            // and directs a RTF-stream to a file
            RtfWriter2.getInstance(document, new FileOutputStream(this.getServletContext().getRealPath("/") + "print/output_" + session.getAttribute("Benutzername") + ".rtf"));

            // step 3: we open the document
            document.open();

            int tabSize = 0;

            for (int i = 0; i < headlines.size(); i++) {
                if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                    tabSize++;
                }
            }

            Table tab = new Table(tabSize);
            for (int i = 0; i < headlines.size(); i++) {
                if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                    tab.addCell(new Cell(new Paragraph(headlines.get(i), new Font(Font.TIMES_ROMAN, 10, Font.BOLD, new Color(0, 0, 0)))));
                }
            }

            for (Map row : rowlist) {
                for (int z = 0; z < orderSize; z++) {
                    int jahr = 0;
                    String jahrV = row.get(orderV[z]).toString();
                    int zeitraum = 0;
                    if (orderV[z].endsWith("Jahr")) {
                        zeitraum = Integer.parseInt(request.getParameter("order" + (z + 1) + "zeit"));
                        if (jahrV == null) {
                            jahr = 0;
                        } else {
                            jahr = Integer.parseInt(jahrV);
                        }
                        jahr = jahr / zeitraum;
                        jahrV = "" + jahr;
                    }

                    if (first[z] || row.get(orderV[z]) != null && !jahrV.equals(oldValue[z])) {
                        oldValue[z] = jahrV;
                        String t = "";
                        if (!first[z]) {
                            document.add(tab);
                            tab = new Table(tabSize);

                            for (int i = 0; i < headlines.size(); i++) {
                                if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                                    tab.addCell(new Cell(new Paragraph(headlines.get(i), new Font(Font.TIMES_ROMAN, 10, Font.BOLD, new Color(0, 0, 0)))));
                                }
                            }

                        }
                        first[z] = false;
                        for (int z2 = z + 1; z2 < orderSize; z2++) {
                            first[z2] = true;
                        }
                        for (int z2 = 0; z2 < z; z2++) {
                            t += "\t";
                        }

                        String text = row.get(orderV[z]).toString();
                        if (orderV[z].startsWith("einzelbeleg.ID")) {
                            text = row.get("einzelbeleg.Belegform").toString();
                        }
                        if (text == null) {
                            text = "-";
                        }
                        String titel = orderV[z];
                        //     out.println(z + "::" + orderV[z]);

                        if (orderV[z].startsWith("einzelbeleg.ID")) {
                            titel = "einzelbeleg.Belegform";
                        }
                        titel = headlines.get(fieldNames.indexOf(titel));

                        int fontsize = 16 - 2 * z;
                        if (fontsize < 10) {
                            fontsize = 10;
                        }

                        if (orderV[z].endsWith("Jahr")) {
                            int ja = Integer.parseInt(oldValue[z]);
                            document.add(new Paragraph(t + titel + ":" + (ja * zeitraum) + "-" + ((ja + 1) * zeitraum - 1), new Font(Font.TIMES_ROMAN, fontsize, Font.NORMAL, new Color(0, 0, 0))));
                        } else {
                            String format = orderV[z];
                            if (orderV[z].equals("Erstglied") || orderV[z].equals("Zweitglied")) {
                                format = "PLemma";
                            }
                            document.add(new Paragraph(t + titel + ":" + text, new Font(Font.TIMES_ROMAN, fontsize, Font.NORMAL, new Color(0, 0, 0))));
                        }
                    }
                }

                for (int i = 0; i < fieldNames.size(); i++) {

                    if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {

                        if (row.get(fieldNames.get(i)) == null || row.get(fieldNames.get(i)).equals("null")) {
                            tab.addCell(new Cell(new Paragraph("-", new Font(Font.TIMES_ROMAN, 8, Font.NORMAL, new Color(0, 0, 0)))));
                        } else {
                            tab.addCell(new Cell(new Paragraph(row.get(fieldNames.get(i)).toString(), new Font(Font.TIMES_ROMAN, 8, Font.NORMAL, new Color(0, 0, 0)))));
                        }
                    }
                }
            }
            document.add(tab);
            document.close();

            out.println("<a href='../../print/output_" + session.getAttribute("Benutzername") + ".rtf'>herunterladen</a>");
        }
        // ########## rtf #########

        // ########## SEITENNAVIGATION #########
        /*    if (export.equals("liste") || export.equals("browse")) {
out.println("<p class=\"resultlistnavigation\" align=\"center\">");
int pages = (linecount / pageLimit)+1;
for (int i=0; i< pages; i++) {
  // Link fÃ¼r Seite erzeugen
  String parameter = "?pageoffset="+i;
  for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements(); ) {
    String paramName = e.nextElement();
    if (!paramName.equals("pageoffset"))
      parameter += "&"+paramName+"="+urlEncode(request.getParameter(paramName));
  }

  // Link zur ersten Seite anzeigen falls nÃ¶tig
  if (i ==  0 && i <= pageoffset - 10) {
    out.println("<a href=\""+parameter+"\">"+(i+1)+"</a>&nbsp;...&nbsp;");
  }

  // gelinkte Seitennummer anzeigen
  if (i < pageoffset + 10 && i > pageoffset - 10) {
    if (i==pageoffset) {
      out.println("<b>");
    }
    out.println("<a href=\""+parameter+"\">"+(i+1)+"</a>&nbsp;");
    if (i==pageoffset) {
      out.println("</b>");
    }
  }
  // Link zur letzten Seite anzeigen falls nÃ¶tig
  if (i ==  pages-1 && i >= pageoffset + 10) {
    out.println("...&nbsp;<a href=\""+parameter+"\">"+(i+1)+"</a>&nbsp;");
  }
}
out.println("</p>");
}*/
        // ########## SEITENNAVIGATION #########
    }
%>