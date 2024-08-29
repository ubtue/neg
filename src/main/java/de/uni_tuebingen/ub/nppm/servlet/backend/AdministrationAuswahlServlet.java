package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.AbstractBase;
import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;
import de.uni_tuebingen.ub.nppm.db.SelektionDB;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.EinzelbelegHatFunktion_MM;
import de.uni_tuebingen.ub.nppm.model.SelektionFunktion;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.resource.transaction.spi.TransactionStatus;

public class AdministrationAuswahlServlet extends AbstractBackendServlet {

    String editMessage = "";
    String moveMessage = "";

    @Override
    protected String getTitle() {
        return "administration";
    }

    @Override
    protected boolean isAdminRequired() {
        return true;
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {

        if (request.getParameter("action") != null && request.getParameter("action").equals("neu")) {
            newFunction(request, response);
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("umbenennen")) {
            renameFunction(request, response);
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("verschieben")) {
            moveFunction(request, response);
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("aufteilen")) {
            divideFunction(request, response);
        }
        // Weiterleiten an die JSP
        RequestDispatcher rd = request.getRequestDispatcher("admin.auswahlfelder.jsp");
        rd.include(request, response);

    }

    private void newFunction(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung").equals("")) {
            editMessage = "blankLabel";
        } else {
            int id = 1;
            if (SelektionDB.hasBezeichnung(request.getParameter("Tabelle"), request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung"))) {
                editMessage = "alreadyExists";

            } else {
                SelektionDB.insertBezeichnung(request.getParameter("Tabelle"), request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung"));
                Integer maxId = DatenbankDB.getMaxId(request.getParameter("Tabelle"));
                if (maxId != null) {
                    id = maxId;
                    editMessage = "success";
                }
            }
        }
        request.setAttribute("editMessage", editMessage);
    }

    private void renameFunction(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung").equals("")) {
            editMessage = "blankLabel";
        } else {
            List<Object> result = SelektionDB.getBezeichnung(request.getParameter("Tabelle"), request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung"));
            if (!result.isEmpty() && result.get(0).toString().equals(request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung"))) {
                editMessage = "alreadyExists";
            } else {
                SelektionDB.updateBezeichnung(request.getParameter("Tabelle"),
                        request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung"),
                        request.getParameter(request.getParameter("Tabelle"))
                );
                editMessage = "success";
            }
        }
        request.setAttribute("editMessage", editMessage);
    }

    private void moveFunction(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("Feld_neu").equals(request.getParameter("Feld_alt"))) {
            moveMessage = "sameSelection";
        } else {
            DatenbankDB.updateAuswahlfelder(request.getParameter("Tabelle"), request.getParameter("Feld_alt"), request.getParameter("Feld_neu"));
            DatenbankDB.deleteAuswahlfeld(request.getParameter("Tabelle"), request.getParameter("Feld_alt"));
            moveMessage = "success";
        }
        request.setAttribute("moveMessage", moveMessage);
    }

    private void divideFunction(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Session session = null;
        Transaction transaction = null;
        try {
            // Holen der ID und Bezeichnung von selektion_funktion
            String funktionIdStr = request.getParameter("Feld_selektionFunktion");

            int funktionId = Integer.parseInt(funktionIdStr);
            SelektionFunktion f_temp = SelektionDB.getById(funktionId, SelektionFunktion.class);
            String funktionSelektionBezeichnung = f_temp.getBezeichnung();

            boolean sameFunktion = false;
            String StringfunktionId = "";
            String einzelbelegId = "";

            // Verarbeitung der dynamischen Felder
            List<Integer> aufteilenIds = new ArrayList<>();
            Map<String, String[]> parameterMap = request.getParameterMap();

            //   int aufteilen_1Id = 0;  //Erstes Aufteilen feld, dies soll nun in einzelbeleg_hatfunktion die FunktionID ersetzen
            for (String key : parameterMap.keySet()) {
                if (key.startsWith("Aufteilen[")) {
                    String[] values = request.getParameterValues(key);
                    if (values != null && values.length > 0) {
                        int id = Integer.parseInt(values[0]); // Annahme: Ein Wert pro Parameter

                        // Extrahiere den Index aus dem Schlüssel
                        String indexString = key.substring("Aufteilen[".length(), key.length() - 1);
                        int index = Integer.parseInt(indexString);

                        if (index >= 0) {
                            // -1 ist - in selektion_funktion und soll nicht in die Liste aufgenommen werden
                            if (id != -1) {
                                aufteilenIds.add(id);
                            }

                            if (id == funktionId) {
                                sameFunktion = true;
                                break;
                            }
                        }
                    }
                }
            }

            //Feld 1 Aufteilen Lade die SelektionFunktion, die die neue ID repräsentiert (ersetzen)
            if (aufteilenIds.isEmpty()) {
                request.setAttribute("funktionSelektionBezeichnung", "noDivideSelektionFunktion");
            } else {

                SelektionFunktion neueFunktion = SelektionDB.getById(aufteilenIds.get(0), SelektionFunktion.class);

                if (sameFunktion) {
                    request.setAttribute("funktionSelektionBezeichnung", "sameSelektionFunktion");
                } else {
                    //Liste von EinzelbelgHatFunktionen die aus der ausgangs selektion_funktion beinhlaten FunktionIDs hat
                    List<EinzelbelegHatFunktion_MM> einzelbelgFunktionList = EinzelbelegDB.getListEinzelbelegHatFunktion(funktionId);

                    session = AbstractBase.getSession();
                    transaction = session.beginTransaction();

                    for (EinzelbelegHatFunktion_MM ef : einzelbelgFunktionList) {

                        ef.setFunktion(neueFunktion); // hier wird die neue funktion ersetzt, also FunktionID in der tabelle geändert
                        session.update(ef);
                    }
                    transaction.commit();

                    // Ab Feld 2 wird ein Insert in einzelbeleg_hatfunktion durchgeführt
                    if (aufteilenIds.size() >= 1) {
                        aufteilenIds.remove(0);  //wurde bereits verarbeitet als update, nun aus der liste löschen
                        session = AbstractBase.getSession();
                        transaction = session.beginTransaction();

                        for (EinzelbelegHatFunktion_MM ef : einzelbelgFunktionList) {

                            Einzelbeleg eb = ef.getEinzelbeleg();

                            einzelbelegId = String.valueOf(eb.getId()); // EinzelbelegID aus der List

                            for (int funktionIdToInsert : aufteilenIds) {

                                // Umwandeln der Integer ID in String für die Methode insertFunktion
                                StringfunktionId = String.valueOf(funktionIdToInsert);
                                // Einfügen in die Datenbank
                                EinzelbelegDB.insertFunktion(einzelbelegId, StringfunktionId);
                            }
                        }
                        transaction.commit();
                    }

                    //Lösche die Bezeichnung die aufgeteilt wurde aus der tabelle selektion_funktion
                    EinzelbelegDB.remove(SelektionFunktion.class, funktionId);
                    request.setAttribute("funktionSelektionBezeichnung", "success");
                }
            }

        } catch (Exception e) {
            e.printStackTrace(); // Fehlerprotokollierung
            if (transaction != null && transaction.getStatus() != TransactionStatus.COMMITTED) {
                transaction.rollback(); // Rollback nur wenn nicht bereits committet
            }
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred: " + e.getMessage());
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }
}
