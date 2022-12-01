<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.text.SimpleDateFormat" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%

  if (request.getParameter("speichern") != null && request.getParameter("speichern").equals("speichern")) {
    int id = -1;
    String form = request.getParameter("form");


    Connection cn = null;

    Statement st2 = null; // für Anfrage an Datenbank
    ResultSet rs2 = null;

    Statement st3 = null; // für UPDATE / INSERT Anweisung

    String debug = "debug";

    try {
      Class.forName(sqlDriver);
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );

      st2 = cn.createStatement();
      st3 = cn.createStatement();

      try {
        if(request.getParameter("ID").equals("-1")){
           id = SaveHelper.getMaxId(form)+1;
        }
        else id = Integer.parseInt(request.getParameter("ID"));
      }
      catch (Exception e) { out.println(e); }

      boolean exist = SaveHelper.existForm(form, id);
      if (!form.equals("urkunde") && !exist) {
        SaveHelper.insertMetaData(form, id, (int)session.getAttribute("BenutzerID"), (int)session.getAttribute("GruppeID"));
      }
      else if (!form.equals("urkunde")){
        SaveHelper.updateMetaData(form, id, (int)session.getAttribute("BenutzerID"));
      }

      List<DatenbankMapping> lst = SaveHelper.getMapping(form);
      
      for (DatenbankMapping mapping : lst) {
        //out.println("ID"+mapping.getId());
        // Textfield, Textarea, select, addselect
        String feldtyp = mapping.getFeldtyp();
        Boolean isArray = mapping.getArray();
        String zielAttribut = mapping.getZielAttribut();
        String zieltabelle = mapping.getZielTabelle();
        String datenfeld = mapping.getDatenfeld();
        String formularAttribut = mapping.getFormularAttribut();
        String combFeldnamen = mapping.getCombinedFeldnamen();
        String combFeldtyp = mapping.getCombinedFeldtypen();
        //out.println("HELLO"+zielAttribut);
        /*out.println(feldtyp);
        out.println(isArray);
        out.println(zielAttribut);
        out.println(zieltabelle);
        out.println(datenfeld);
        out.println(formularAttribut);
        out.println(combFeldnamen);
        out.println(combFeldtyp);*/
        if (feldtyp.equals("textfield")
            || feldtyp.equals("textarea")
            || feldtyp.equals("select")
            || feldtyp.equals("addselect")
            || feldtyp.equals("addselectandtext")
            || feldtyp.equals("sqlselect")
           ) {
          // KEIN ARRAY
          if(!isArray) {
            rs2 = st2.executeQuery("SELECT "+zielAttribut+" FROM "+zieltabelle+" WHERE ID='"+id+"';");            
            // Datensatz ändern
            if (rs2.next() && (
                 (request.getParameter(datenfeld) != null && rs2.getString(zielAttribut) != null && !rs2.getString(zielAttribut).equals(DBtoDB(request.getParameter(datenfeld))))
                ||
                 (request.getParameter(datenfeld) != null && rs2.getString(zielAttribut) == null && !request.getParameter(datenfeld).equals(""))
               )) {
               st3.execute("UPDATE "+zieltabelle
                          +" SET "+zielAttribut+"='"+DBtoDB(request.getParameter(datenfeld))+"'"
                          +" WHERE ID='"+id+"';");
            } // ENDE Datensatz ändern

          } // ENDE kein Array

          // ARRAY
          else if(isArray) {
            for (int i=0; request.getParameter(datenfeld+"["+i+"]")!=null; i++) {
              // Prüfen, ob aktueller Eintrag bereits vorhanden
              if (request.getParameter(datenfeld+"["+i+"]_entryid") != null) {
                // Prüfen, ob Datensatz geändert wurde
                rs2 = st2.executeQuery("SELECT ID, "+zielAttribut
                                       +" FROM "+zieltabelle
                                       +" WHERE ID = "+request.getParameter(datenfeld+"["+i+"]_entryid")+";");

                if (rs2.next() && !rs2.getString(zielAttribut).equals(DBtoDB(request.getParameter(datenfeld+"["+i+"]")))) {
                  String sql = "UPDATE " + zieltabelle
                             + " SET "+zielAttribut+"='"+DBtoDB(request.getParameter(datenfeld+"["+i+"]"))+"'"
                             + " WHERE ID="+request.getParameter(datenfeld+"["+i+"]_entryid");
                  st3.execute(sql);
                 // out.println(sql);
                }
              }

              else {
                // Wenn etwas eingetragen ist, in die Datenbank einfügen
                if (request.getParameter(datenfeld+"["+i+"]") != null && !request.getParameter(datenfeld+"["+i+"]").equals("") && !request.getParameter(datenfeld+"["+i+"]").equals("-1")) {
                  String sql = "INSERT INTO "+zieltabelle
                               +" ("+formularAttribut+", "+zielAttribut+")"
                               +" VALUES ("+id+", '"+DBtoDB(request.getParameter(datenfeld+"["+i+"]"))+"');";
                  if(formularAttribut != null)
                    st2.execute(sql);                                    
                 // out.println(sql);
                }
              }
            }
          } // ENDE Array
        } //ENDE Textfield, Textarea, select, addselect

        // checkbox
        else if (feldtyp.equals("checkbox")) {
          // KEIN ARRAY
          if(!isArray) {
            rs2 = st2.executeQuery("SELECT "+zielAttribut+" FROM "+zieltabelle+" WHERE ID='"+id+"';");
            int checkbox = 0;
            if (request.getParameter(datenfeld) != null && request.getParameter(datenfeld).equals("on")) {
              checkbox = 1;
            }
            if (rs2.next() && rs2.getInt(zielAttribut) != checkbox ) {
              st3.execute("UPDATE "+zieltabelle
                          +" SET "+zielAttribut+"='"+checkbox+"'"
                          +" WHERE ID='"+id+"';");
            } // ENDE Datensatz ändern
          } // ENDE kein Array
        } //ENDE checkbox

        // Datum
        else if (feldtyp.equals("date")) {
       //  out.println("DATE");
          // Datensatz geändert?
          String[] zielattributArray = {""};
          String[] combinedFeldnamenArray = {""};

          if (zielAttribut.contains(";")) {
            zielattributArray = zielAttribut.split(";");
            for (int j=0; j<zielattributArray.length; j++) {
              zielattributArray[j] = zielattributArray[j].trim();
            //  out.println(zielattributArray[j]);
            }
          }
          String zielattribute = zielattributArray[0];
          for (int i=1; i<zielattributArray.length; i++) {
            zielattribute += ", "+zielattributArray[i];
          }

          if (combFeldnamen.contains(";")) {
            combinedFeldnamenArray = combFeldnamen.split(";");
            for (int j=0; j<combinedFeldnamenArray.length; j++) {
              combinedFeldnamenArray[j] = combinedFeldnamenArray[j].trim();
            }
          }

          String zielAttributStr = "";
          for (int i=0; i<zielattributArray.length; i++) {
            if(i>0) zielAttributStr +=", ";
            zielAttributStr +=zielattributArray[i] + ", Genauigkeit" + zielattributArray[i];
          }
          rs2 = st2.executeQuery("SELECT "+zielAttributStr+" FROM "+zieltabelle+" WHERE ID='"+id+"';");
          //out.println("SELECT "+zielAttributStr+" FROM "+zieltabelle+" WHERE ID='"+id+"';");
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
              String sql = "UPDATE "+zieltabelle+" SET ";
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
        else if (feldtyp.equals("note")) {
          String cond = "";
          if (datenfeld.equals("BemerkungAlle")) {
            cond = " AND GruppeID IS NULL AND BenutzerID IS NULL;";
          }
          else if (datenfeld.equals("BemerkungGruppe")) {
            cond = " AND GruppeID = "+session.getAttribute("GruppeID")+" AND BenutzerID IS NULL;";
          }
          else if (datenfeld.equals("BemerkungPrivat")) {
            cond = " AND GruppeID IS NULL AND BenutzerID = "+session.getAttribute("BenutzerID")+";";
          }

          // Datensatz ändern
          if(formularAttribut != null){
            rs2 = st2.executeQuery("SELECT "+zielAttribut+" FROM "+zieltabelle+" WHERE "+formularAttribut+"='"+id+"'"+cond);
            if (rs2.next() && request.getParameter(datenfeld) != null) {
              if (request.getParameter(datenfeld).equals("")) {
                st3.execute("DELETE FROM "+zieltabelle+" WHERE "+formularAttribut+"='"+id+"'"+cond);
              } // ENDE löschen
              else if(!request.getParameter(datenfeld).equals("") &&  !DBtoDB(request.getParameter(datenfeld)).equals(rs2.getString(zielAttribut))) {
                st3.execute ("UPDATE "+zieltabelle
                            +" SET "+zielAttribut+"='"+DBtoDB(request.getParameter(datenfeld))+"'"
                            +" WHERE "+formularAttribut+"='"+id+"'"+cond);
              } // ENDE ändern
            } // ENDE Datensatz ändern
          }
          // Datensatz neu
          else if (request.getParameter(datenfeld) != null && !request.getParameter(datenfeld).equals("")) {
            String field = "";
            String value = "";
            if (datenfeld.equals("BemerkungGruppe")) {
              field = ", GruppeID";
              value = ", "+session.getAttribute("GruppeID");
            }
            else if (datenfeld.equals("BemerkungPrivat")) {
              field = ", BenutzerID";
              value = ", "+session.getAttribute("BenutzerID");
            }
            if(formularAttribut != null){
                st3.execute ("INSERT INTO "+zieltabelle
                            +" ("+zielAttribut+", "+formularAttribut+field+")"
                            +" VALUES ('"+DBtoDB(request.getParameter(datenfeld))+"', "+id+value+");");
            }
          } // ENDE Datensatz neu
        } // ENDE Bemerkungsfeld

        // Namenkommentar Editor
        else if (feldtyp.equals("nkeditor")) {
          if( request.getParameter(datenfeld) != null && request.getParameter(datenfeld).equals("on")) {
            Date d = new Date();
            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
            String sql = "INSERT INTO "+zieltabelle+" ("+(zieltabelle.equals("namenkommentar")?"NamenkommentarID":"MGHLemmaID")+", BenutzerID, Zeitstempel) VALUES ";
            sql += "("+ id +", "+ session.getAttribute("BenutzerID") +", "+sf.format(d)+")";
            st2.execute(sql);
                         //     out.println(sql);

          }
        } // ENDE NamenkommentarEditor

        // combined
        else if (feldtyp.equals("combined")) {
          String[] zielattributArray = zielAttribut.split(";");
          for (int i=0; i<zielattributArray.length; i++) {
            zielattributArray[i] = zielattributArray[i].trim();
          }

          String[] combinedFeldnamenArray = combFeldnamen.split(";");
          for (int i=0; i<combinedFeldnamenArray.length; i++) {
            combinedFeldnamenArray[i] = combinedFeldnamenArray[i].trim();
          }

          String[] combinedFeldtypenArray = combFeldtyp.split(";");
          for (int i=0; i<combinedFeldtypenArray.length; i++) {
            combinedFeldtypenArray[i] = combinedFeldtypenArray[i].trim();
          }

          for (int i=0; request.getParameter(combinedFeldnamenArray[0]+"["+i+"]")!=null; i++) {

            // Datensatz ändern
            if (request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid") != null) {
              boolean aenderung = false;
 
              rs2 = st2.executeQuery("SELECT * FROM "+zieltabelle+" WHERE ID='"+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")+"';");
              if (rs2.next()) {
                for (int j=0; j<combinedFeldnamenArray.length; j++) {
                  if (combinedFeldtypenArray[j].equals("subtable")){
               //    out.println("SUBTABLE");
                    for(int j2=0; request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"+"["+j2+"]")!=null; j2++) {
                      if(request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")!=null) {
                        Statement st4 = cn.createStatement();
                        ResultSet rs4 = st4.executeQuery("select * from ueberlieferung_edition where editionID="+request.getParameter(combinedFeldnamenArray[j]+"_ed["+i+"]"+"["+j2+"]")+" and ueberlieferungID="+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid"));

                        if(rs4.next()) {
                          st4.execute("UPDATE ueberlieferung_edition SET sigle='" +request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"+"["+j2+"]")+"' WHERE  editionID="+request.getParameter(combinedFeldnamenArray[j]+"_ed["+i+"]"+"["+j2+"]")+" and ueberlieferungID="+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid"));
                        }
                        else
                          st4.execute("INSERT into ueberlieferung_edition (UeberlieferungID, EditionID, Sigle) VALUES ('"+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")+"','"+request.getParameter(combinedFeldnamenArray[j]+"_ed["+i+"]"+"["+j2+"]")+"','" +request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"+"["+j2+"]")+"')");
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
                
              
              
                String sql = "UPDATE "+zieltabelle+" SET ";
                String ed = "";
                for (int j=0; j<combinedFeldnamenArray.length; j++) {
                  if (combinedFeldtypenArray[j].equals("textfield")
                      || combinedFeldtypenArray[j].equals("textarea")
                      || combinedFeldtypenArray[j].equals("select")
                      || combinedFeldtypenArray[j].equals("sqlselect")
                      || combinedFeldtypenArray[j].equals("addselect") || combinedFeldtypenArray[j].equals("addselectandtext")) {
                    sql += zielattributArray[j] + " = '"+DBtoDB(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"))+"', ";
                    if(zieltabelle.equals("quelle_inedition") && zielattributArray[j].equals("EditionID")){
                       cn.setAutoCommit(false);
                       ed = DBtoDB(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]"));
                    }
                  }
                  else if (combinedFeldtypenArray[j].equals("checkbox")) {
                    sql += zielattributArray[j] + " = '"+(request.getParameter(combinedFeldnamenArray[j]+"["+i+"]")!=null && request.getParameter(combinedFeldnamenArray[j]+"["+i+"]").equals("on")?"1":"0")+"', ";
                  }
                }
                sql = sql.substring(0, sql.length()-2);
                sql += " WHERE ID='"+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")+"';";
                String old_ed = "";
                 if(!ed.equals("")){
                    ResultSet rs3 = st3.executeQuery("select EditionID from quelle_inedition WHERE ID='"+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")+"';");
                    while(rs3.next())old_ed = rs3.getString("EditionID");
                 }
                st3.execute(sql);
                if(!ed.equals("")){
                   st3.execute("Update ueberlieferung_edition set EditionID='"+ed+"' where EditionID="+old_ed+" and UeberlieferungID in (select h_u.ID from handschrift_ueberlieferung h_u, quelle_inedition q_i where q_i.ID="+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")+" and q_i.QuelleID=h_u.QuelleID)");
                   st3.execute("Update einzelbeleg_textkritik set EditionID='"+ed+"' where EditionID="+old_ed+" and HandschriftID in (select h_u.ID from handschrift_ueberlieferung h_u, quelle_inedition q_i where q_i.ID="+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")+" and q_i.QuelleID=h_u.QuelleID)");
                   st3.execute(" Update einzelbeleg set EditionID ='"+ed+"' where EditionID="+old_ed+" and ID in (select e_t.EinzelbelegID from handschrift_ueberlieferung h_u, quelle_inedition q_i, einzelbeleg_textkritik e_t where e_t.HandschriftID=h_u.ID and q_i.ID="+request.getParameter(datenfeld.toLowerCase()+"["+i+"]_entryid")+" and q_i.QuelleID=h_u.QuelleID)");
 

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
                String sql = "INSERT INTO "+zieltabelle+" SET "+formularAttribut+" = '"+id+"'";
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
                if(formularAttribut != null){
                    st2.execute(sql);
                }
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
        out.println(Arrays.toString(Thread.currentThread().getStackTrace()).replace( ',', '\n' ));
    }
    finally {
      try { if( null != st3 ) st3.close(); } catch( Exception ex ) {}
      try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE if (speichern)
%>
