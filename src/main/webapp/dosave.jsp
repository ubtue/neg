<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.text.SimpleDateFormat" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%

  if (request.getParameter("speichern") != null && request.getParameter("speichern").equals("speichern")) {
    int id = -1;
    String form = request.getParameter("form");


    Connection cn = null;
    Statement st = null; // für Anfrage an Datenbank-Mapping
    ResultSet rs = null;

    Statement st2 = null; // für Anfrage an Datenbank
    ResultSet rs2 = null;

    Statement st3 = null; // für UPDATE / INSERT Anweisung

    String debug = "debug";

    try {
      Class.forName(sqlDriver);
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      st2 = cn.createStatement();
      st3 = cn.createStatement();

      try {
        if(request.getParameter("ID").equals("-1")){
           rs = st.executeQuery("SELECT max(ID) ID FROM "+form);
           rs.next();           
           id = rs.getInt("ID") + 1;
           id = DatenbankDB.getMaxId(form);
        }
        else id = Integer.parseInt(request.getParameter("ID"));
      }
      catch (Exception e) { out.println(e); }

      boolean exist = DatenbankDB.existForm(form, id);
      if (!form.equals("urkunde") && !exist) {
        DatenbankDB.insertMetaData(form, id, (int)session.getAttribute("BenutzerID"), (int)session.getAttribute("GruppeID"));
      }
      else if (!form.equals("urkunde")){
        DatenbankDB.updateMetaData(form, id, (int)session.getAttribute("BenutzerID"));
      }


      out.println("SELECT * FROM datenbank_mapping WHERE Formular='"+request.getParameter("form")+"' ORDER BY ID ASC;");
      rs = st.executeQuery("SELECT * FROM datenbank_mapping WHERE Formular='"+request.getParameter("form")+"' ORDER BY ID ASC;");
      List<DatenbankMapping> lst = DatenbankDB.getMapping(form);
      
      while (rs.next()) {
        // Textfield, Textarea, select, addselect
        if (rs.getString("Feldtyp").equals("textfield")
            || rs.getString("Feldtyp").equals("textarea")
            || rs.getString("Feldtyp").equals("select")
            || rs.getString("Feldtyp").equals("addselect")
            || rs.getString("Feldtyp").equals("addselectandtext")
            || rs.getString("Feldtyp").equals("sqlselect")
           ) {

          // KEIN ARRAY
          if(rs.getInt("array") == 0) {
            rs2 = st2.executeQuery("SELECT "+rs.getString("ZielAttribut")+" FROM "+rs.getString("Zieltabelle")+" WHERE ID='"+id+"';");

            // Datensatz ändern
            if (rs2.next() && (
                 (rs2.getString(rs.getString("Zielattribut")) != null && !rs2.getString(rs.getString("Zielattribut")).equals(DBtoDB(request.getParameter(rs.getString("Datenfeld")))))
                ||
                 (rs2.getString(rs.getString("Zielattribut")) == null && !request.getParameter(rs.getString("Datenfeld")).equals(""))
               )) {
               
                out.println("UPDATE "+rs.getString("Zieltabelle")
                +" SET "+rs.getString("Zielattribut")+"='"+DBtoDB(request.getParameter(rs.getString("Datenfeld")))+"'"
                +" WHERE ID='"+id+"';");
               st3.execute("UPDATE "+rs.getString("Zieltabelle")
                          +" SET "+rs.getString("Zielattribut")+"='"+DBtoDB(request.getParameter(rs.getString("Datenfeld")))+"'"
                          +" WHERE ID='"+id+"';");
                /*String prepSql = "UPDATE " + rs.getString("Zieltabelle") +
                        " SET " + rs.getString("Zielattribut") + " = ?" +
                		" WHERE ID = ?;";
                java.sql.PreparedStatement st4 = cn.prepareStatement(prepSql);
                st4.setString(1, request.getParameter(rs.getString("Datenfeld")));
                st4.setInt(2, id);
                st4.execute();
                System.out.println(prepSql);
				System.out.println("VALUE = " + request.getParameter(rs.getString("Datenfeld")));*/
            } // ENDE Datensatz ändern

          } // ENDE kein Array

          // ARRAY
          else if(rs.getInt("array") == 1) {
            for (int i=0; request.getParameter(rs.getString("Datenfeld")+"["+i+"]")!=null; i++) {
              // Prüfen, ob aktueller Eintrag bereits vorhanden
              if (request.getParameter(rs.getString("Datenfeld")+"["+i+"]_entryid") != null) {
                // Prüfen, ob Datensatz geändert wurde
                rs2 = st2.executeQuery("SELECT ID, "+rs.getString("ZielAttribut")
                                       +" FROM "+rs.getString("ZielTabelle")
                                       +" WHERE ID = "+request.getParameter(rs.getString("Datenfeld")+"["+i+"]_entryid")+";");

                if (rs2.next() && !rs2.getString(rs.getString("ZielAttribut")).equals(DBtoDB(request.getParameter(rs.getString("Datenfeld")+"["+i+"]")))) {
                  String sql = "UPDATE " + rs.getString("Zieltabelle")
                             + " SET "+rs.getString("ZielAttribut")+"='"+DBtoDB(request.getParameter(rs.getString("Datenfeld")+"["+i+"]"))+"'"
                             + " WHERE ID="+request.getParameter(rs.getString("Datenfeld")+"["+i+"]_entryid");
                  st3.execute(sql);
                 // out.println(sql);
                }
              }

              else {
                // Wenn etwas eingetragen ist, in die Datenbank einfügen
                if (request.getParameter(rs.getString("Datenfeld")+"["+i+"]") != null && !request.getParameter(rs.getString("Datenfeld")+"["+i+"]").equals("") && !request.getParameter(rs.getString("Datenfeld")+"["+i+"]").equals("-1")) {
                  String sql = "INSERT INTO "+rs.getString("Zieltabelle")
                               +" ("+rs.getString("FormularAttribut")+", "+rs.getString("Zielattribut")+")"
                               +" VALUES ("+id+", '"+DBtoDB(request.getParameter(rs.getString("Datenfeld")+"["+i+"]"))+"');";
                  st2.execute(sql);
                 // out.println(sql);
                }
              }
            }
          } // ENDE Array
        } //ENDE Textfield, Textarea, select, addselect

        // checkbox
        else if (rs.getString("Feldtyp").equals("checkbox")) {
          // KEIN ARRAY
          if(rs.getInt("array") == 0) {
            rs2 = st2.executeQuery("SELECT "+rs.getString("ZielAttribut")+" FROM "+rs.getString("Zieltabelle")+" WHERE ID='"+id+"';");
            int checkbox = 0;
            if (request.getParameter(rs.getString("Datenfeld")) != null && request.getParameter(rs.getString("Datenfeld")).equals("on")) {
              checkbox = 1;
            }
            if (rs2.next() && rs2.getInt(rs.getString("Zielattribut")) != checkbox ) {
              st3.execute("UPDATE "+rs.getString("Zieltabelle")
                          +" SET "+rs.getString("Zielattribut")+"='"+checkbox+"'"
                          +" WHERE ID='"+id+"';");
            } // ENDE Datensatz ändern
          } // ENDE kein Array
        } //ENDE checkbox

        // Datum
        else if (rs.getString("Feldtyp").equals("date")) {
       //  out.println("DATE");
          // Datensatz geändert?
          String[] zielattributArray = {""};
          String[] combinedFeldnamenArray = {""};

          if (rs.getString("Zielattribut").contains(";")) {
            zielattributArray = rs.getString("Zielattribut").split(";");
            for (int j=0; j<zielattributArray.length; j++) {
              zielattributArray[j] = zielattributArray[j].trim();
            //  out.println(zielattributArray[j]);
            }
          }
          String zielattribute = zielattributArray[0];
          for (int i=1; i<zielattributArray.length; i++) {
            zielattribute += ", "+zielattributArray[i];
          }

          if (rs.getString("combinedFeldnamen").contains(";")) {
            combinedFeldnamenArray = rs.getString("combinedFeldnamen").split(";");
            for (int j=0; j<combinedFeldnamenArray.length; j++) {
              combinedFeldnamenArray[j] = combinedFeldnamenArray[j].trim();
            }
          }

          String zielAttribut = "";
          for (int i=0; i<zielattributArray.length; i++) {
            if(i>0) zielAttribut +=", ";
            zielAttribut +=zielattributArray[i] + ", Genauigkeit" + zielattributArray[i];
          }
          rs2 = st2.executeQuery("SELECT "+zielAttribut+" FROM "+rs.getString("Zieltabelle")+" WHERE ID='"+id+"';");
          //out.println("SELECT "+zielAttribut+" FROM "+rs.getString("Zieltabelle")+" WHERE ID='"+id+"';");
          if (rs2.next()) {
            boolean changed = false;
            for (int i=0; i<zielattributArray.length; i++) {
              if (rs2.getString(zielattributArray[i])!= null)
                if( !rs2.getString(zielattributArray[i]).equals(request.getParameter(combinedFeldnamenArray[i]))) {

                changed = true;
              }
              else;
              else changed=true;
              if (rs2.getString("Genauigkeit" + zielattributArray[i])!= null)
                if( !rs2.getString("Genauigkeit" + zielattributArray[i]).equals(request.getParameter("Genauigkeit" + combinedFeldnamenArray[i]))) {

                changed = true;
              }
              else;
              else changed=true;
           }

            if (changed) {
              String sql = "UPDATE "+rs.getString("Zieltabelle")+" SET ";
              for (int i=0; i<zielattributArray.length; i++) {
                if (i>0) {
                  sql += ", ";
                }
                sql += zielattributArray[i] + "=\"" + ((!request.getParameter(combinedFeldnamenArray[i]).equals(""))?request.getParameter(combinedFeldnamenArray[i]):"0") +"\", ";
                sql += "Genauigkeit" + zielattributArray[i] + "=\"" + ((!request.getParameter("Genauigkeit" + combinedFeldnamenArray[i]).equals(""))?request.getParameter("Genauigkeit" + combinedFeldnamenArray[i]):"0") +"\"";                   }
              sql += " WHERE ID='"+id+"';";
              st3 = cn.createStatement();
           //   out.println(sql);
              st3.execute(sql);
            }
          }
        } // ENDE Datum

        // Bemerkungsfeld
        else if (rs.getString("Feldtyp").equals("note")) {
          String cond = "";
          if (rs.getString("Datenfeld").equals("BemerkungAlle")) {
            cond = " AND GruppeID IS NULL AND BenutzerID IS NULL;";
          }
          else if (rs.getString("Datenfeld").equals("BemerkungGruppe")) {
            cond = " AND GruppeID = "+session.getAttribute("GruppeID")+" AND BenutzerID IS NULL;";
          }
          else if (rs.getString("Datenfeld").equals("BemerkungPrivat")) {
            cond = " AND GruppeID IS NULL AND BenutzerID = "+session.getAttribute("BenutzerID")+";";
          }

          // Datensatz ändern
          rs2 = st2.executeQuery("SELECT "+rs.getString("ZielAttribut")+" FROM "+rs.getString("Zieltabelle")+" WHERE "+rs.getString("Formularattribut")+"='"+id+"'"+cond);
          if (rs2.next() && request.getParameter(rs.getString("Datenfeld")) != null) {
            if (request.getParameter(rs.getString("Datenfeld")).equals("")) {
              st3.execute("DELETE FROM "+rs.getString("Zieltabelle")+" WHERE "+rs.getString("Formularattribut")+"='"+id+"'"+cond);
            } // ENDE löschen
            else if(!request.getParameter(rs.getString("Datenfeld")).equals("") &&  !DBtoDB(request.getParameter(rs.getString("Datenfeld"))).equals(rs2.getString(rs.getString("ZielAttribut")))) {
              st3.execute ("UPDATE "+rs.getString("Zieltabelle")
                          +" SET "+rs.getString("Zielattribut")+"='"+DBtoDB(request.getParameter(rs.getString("Datenfeld")))+"'"
                          +" WHERE "+rs.getString("FormularAttribut")+"='"+id+"'"+cond);
            } // ENDE ändern
          } // ENDE Datensatz ändern

          // Datensatz neu
          else if (request.getParameter(rs.getString("Datenfeld")) != null && !request.getParameter(rs.getString("Datenfeld")).equals("")) {
            String field = "";
            String value = "";
            if (rs.getString("Datenfeld").equals("BemerkungGruppe")) {
              field = ", GruppeID";
              value = ", "+session.getAttribute("GruppeID");
            }
            else if (rs.getString("Datenfeld").equals("BemerkungPrivat")) {
              field = ", BenutzerID";
              value = ", "+session.getAttribute("BenutzerID");
            }
            st3.execute ("INSERT INTO "+rs.getString("Zieltabelle")
                        +" ("+rs.getString("Zielattribut")+", "+rs.getString("FormularAttribut")+field+")"
                        +" VALUES ('"+DBtoDB(request.getParameter(rs.getString("Datenfeld")))+"', "+id+value+");");
          } // ENDE Datensatz neu
        } // ENDE Bemerkungsfeld

        // Namenkommentar Editor
        else if (rs.getString("Feldtyp").equals("nkeditor")) {
          if( request.getParameter(rs.getString("Datenfeld")) != null && request.getParameter(rs.getString("Datenfeld")).equals("on")) {
            Date d = new Date();
            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
            String sql = "INSERT INTO "+rs.getString("ZielTabelle")+" ("+(rs.getString("ZielTabelle").equals("namenkommentar")?"NamenkommentarID":"MGHLemmaID")+", BenutzerID, Zeitstempel) VALUES ";
            sql += "("+ id +", "+ session.getAttribute("BenutzerID") +", "+sf.format(d)+")";
            st2.execute(sql);
                         //     out.println(sql);

          }
        } // ENDE NamenkommentarEditor

        // combined
        else if (rs.getString("Feldtyp").equals("combined")) {
          String[] zielattributArray = rs.getString("ZielAttribut").split(";");
          for (int i=0; i<zielattributArray.length; i++) {
            zielattributArray[i] = zielattributArray[i].trim();
          }

          String[] combinedFeldnamenArray = rs.getString("combinedFeldnamen").split(";");
          for (int i=0; i<combinedFeldnamenArray.length; i++) {
            combinedFeldnamenArray[i] = combinedFeldnamenArray[i].trim();
          }

          String[] combinedFeldtypenArray = rs.getString("combinedFeldtypen").split(";");
          for (int i=0; i<combinedFeldtypenArray.length; i++) {
            combinedFeldtypenArray[i] = combinedFeldtypenArray[i].trim();
          }

          for (int i=0; request.getParameter(combinedFeldnamenArray[0]+"["+i+"]")!=null; i++) {

            // Datensatz ändern
            if (request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid") != null) {
              boolean aenderung = false;
                        			out.println("Überprüfe Zeile "+i+" (text/select)");
 
              rs2 = st2.executeQuery("SELECT * FROM "+rs.getString("Zieltabelle")+" WHERE ID='"+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")+"';");
              if (rs2.next()) {
                for (int j=0; j<combinedFeldnamenArray.length; j++) {
                  if (combinedFeldtypenArray[j].equals("subtable")){
               //    out.println("SUBTABLE");
                    for(int j2=0; request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"+"["+j2+"]")!=null; j2++) {
                      if(request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")!=null) {
                        Statement st4 = cn.createStatement();
                        ResultSet rs4 = st4.executeQuery("select * from ueberlieferung_edition where editionID="+request.getParameter(combinedFeldnamenArray[j]+"_ed["+i+"]"+"["+j2+"]")+" and ueberlieferungID="+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid"));

                        if(rs4.next()) {
                          st4.execute("UPDATE ueberlieferung_edition SET sigle='" +request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"+"["+j2+"]")+"' WHERE  editionID="+request.getParameter(combinedFeldnamenArray[j]+"_ed["+i+"]"+"["+j2+"]")+" and ueberlieferungID="+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid"));
                        }
                        else
                          st4.execute("INSERT into ueberlieferung_edition (UeberlieferungID, EditionID, Sigle) VALUES ('"+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")+"','"+request.getParameter(combinedFeldnamenArray[j]+"_ed["+i+"]"+"["+j2+"]")+"','" +request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"+"["+j2+"]")+"')");
                      }
                    }
                  }
                  else if (combinedFeldtypenArray[j].equals("textfield")
                      || combinedFeldtypenArray[j].equals("textarea")
                      || combinedFeldtypenArray[j].equals("select")
                      || combinedFeldtypenArray[j].equals("sqlselect")
                      || combinedFeldtypenArray[j].equals("addselect") || combinedFeldtypenArray[j].equals("addselectandtext")) {
                    if (request.getParameter(combinedFeldnamenArray[j]+"["+i+"]") != null &&
                       (
                        (!request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals("") && rs2.getString(zielattributArray[j])== null)
                       ||
                        (!request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals(rs2.getString(zielattributArray[j])))
                       )
                       ) 
                       
                        
                       {
						out.println("Änderung in Zeile "+i+" (text/select)");
                      aenderung = true;
                    }
                  }
                  else if (combinedFeldtypenArray[j].equals("checkbox")) {
                    if (request.getParameter(combinedFeldnamenArray[j]+"["+i+"]") != null
                       && request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals("on")
                       && (rs2.getString(zielattributArray[j]) == null || rs2.getString(zielattributArray[j]).equals("0"))) {
                      aenderung = true;
                    }
                    else if (request.getParameter(combinedFeldnamenArray[j]+"["+i+"]") == null
                            && (rs2.getString(zielattributArray[j]) != null && rs2.getString(zielattributArray[j]).equals("1"))) {
                      aenderung = true;
                    }
                  }
                }
              }
              if (aenderung) {
                
              
              
                String sql = "UPDATE "+rs.getString("ZielTabelle")+" SET ";
                String ed = "";
                for (int j=0; j<combinedFeldnamenArray.length; j++) {
                  if (combinedFeldtypenArray[j].equals("textfield")
                      || combinedFeldtypenArray[j].equals("textarea")
                      || combinedFeldtypenArray[j].equals("select")
                      || combinedFeldtypenArray[j].equals("sqlselect")
                      || combinedFeldtypenArray[j].equals("addselect") || combinedFeldtypenArray[j].equals("addselectandtext")) {
                    sql += zielattributArray[j] + " = '"+DBtoDB(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"))+"', ";
                    if(rs.getString("ZielTabelle").equals("quelle_inedition") && zielattributArray[j].equals("EditionID")){
                       cn.setAutoCommit(false);
                       ed = DBtoDB(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"));
               //        out.println("ED: " + ed);
                    }
                  }
                  else if (combinedFeldtypenArray[j].equals("checkbox")) {
                    sql += zielattributArray[j] + " = '"+(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]")!=null && request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals("on")?"1":"0")+"', ";
                  }
                }
                sql = sql.substring(0, sql.length()-2);
                sql += " WHERE ID='"+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")+"';";
                String old_ed = "";
                 if(!ed.equals("")){
                    ResultSet rs3 = st3.executeQuery("select EditionID from quelle_inedition WHERE ID='"+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")+"';");
                    while(rs3.next())old_ed = rs3.getString("EditionID");
                    out.println(old_ed);
                 }
                st3.execute(sql);
                if(!ed.equals("")){
                   st3.execute("Update ueberlieferung_edition set EditionID='"+ed+"' where EditionID="+old_ed+" and UeberlieferungID in (select h_u.ID from handschrift_ueberlieferung h_u, quelle_inedition q_i where q_i.ID="+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")+" and q_i.QuelleID=h_u.QuelleID)");
                   st3.execute("Update einzelbeleg_textkritik set EditionID='"+ed+"' where EditionID="+old_ed+" and HandschriftID in (select h_u.ID from handschrift_ueberlieferung h_u, quelle_inedition q_i where q_i.ID="+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")+" and q_i.QuelleID=h_u.QuelleID)");
                   st3.execute(" Update einzelbeleg set EditionID ='"+ed+"' where EditionID="+old_ed+" and ID in (select e_t.EinzelbelegID from handschrift_ueberlieferung h_u, quelle_inedition q_i, einzelbeleg_textkritik e_t where e_t.HandschriftID=h_u.ID and q_i.ID="+request.getParameter(rs.getString("Datenfeld").toLowerCase()+"["+i+"]_entryid")+" and q_i.QuelleID=h_u.QuelleID)");
 

 				  cn.commit();
 				  cn.setAutoCommit(true);
                }
              //out.println(sql);

              }
            }

            // Datensatz neu
            else {
              boolean aenderung = false;
              for (int j=0; j<combinedFeldnamenArray.length; j++) {
                if (request.getParameter(combinedFeldnamenArray[j]+"["+i+"]") != null
                    && !request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals("")
                    && !request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals("-1")) {
                  aenderung = true;
                }
              }
              if (aenderung) {
                String sql = "INSERT INTO "+rs.getString("Zieltabelle")+" SET "+rs.getString("FormularAttribut")+" = '"+id+"'";
                for (int j=0; j<combinedFeldnamenArray.length; j++) {
                  if (!combinedFeldnamenArray[j].equals("")) {
                    if (combinedFeldtypenArray[j].equals("textfield")
                        || combinedFeldtypenArray[j].equals("textarea")
                        || combinedFeldtypenArray[j].equals("select")
                        || combinedFeldtypenArray[j].equals("sqlselect")
                        || combinedFeldtypenArray[j].equals("addselect") || combinedFeldtypenArray[j].equals("addselectandtext")) {
                      sql += ", "+zielattributArray[j] + " = '"+DBtoDB(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"))+"'";
                    }
                    else if (combinedFeldtypenArray[j].equals("checkbox")) {
                      sql += ", "+zielattributArray[j] + " = '"+(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]")!=null && request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals("on")?"1":"0")+"'";
                    }
                  }
                }
                st2.execute(sql);
                out.println(sql);
              }
            }
          }
        } // ENDE combined
      } // ENDE while

    if(request.getParameter("ID").equals("-1") && !form.equals("urkunde")){
 %>
    <script language="JavaScript">
<!--
   location.replace('?ID=<%= id %>');
//-->
</script>
<noscript></noscript>
 <%
    }
    } // ENDE try...catch

    catch (Exception e) {
      out.println(e);
    }
    finally {
      try { if( null != st3 ) st3.close(); } catch( Exception ex ) {}
      try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE if (speichern)
%>
