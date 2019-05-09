<%@ page import="java.sql.Blob" isThreadSafe="false" %>
<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSetMetaData" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Scanner" isThreadSafe="false" %>
<%@ page import="java.io.File" isThreadSafe="false" %>
<%@ page import="java.io.FileNotFoundException" isThreadSafe="false" %>
<%@ page import="java.io.FileWriter" isThreadSafe="false" %>
<%@ page import="java.io.PrintWriter" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  String operation = request.getParameter("operation");
  String tabelle = request.getParameter("tabelle");

// Tabelle erstellen
  if (operation.equals("create")) {
    
  }


// Tabelle importieren
  if (operation.equals("import")) {
%>
    <%@ include file="import/edition.jsp" %>
    <%@ include file="import/einzelbeleg.jsp" %>
    <%@ include file="import/handschrift.jsp" %>
    <%@ include file="import/literatur.jsp" %>
    <%@ include file="import/namenkommentar.jsp" %>
    <%@ include file="import/person.jsp" %>
    <%@ include file="import/quelle.jsp" %>

    <%@ include file="import/schlagwort.jsp" %>
    <%@ include file="import/selektion.jsp" %>
    <%@ include file="import/selektion_amtweihe.jsp" %>
    <%@ include file="import/selektion_areal.jsp" %>
    <%@ include file="import/selektion_editor.jsp" %>
    <%@ include file="import/selektion_funktion.jsp" %>
    <%@ include file="import/selektion_literaturtyp.jsp" %>
    <%@ include file="import/selektion_urkundeausstellerempfaenger.jsp" %>

    <%@ include file="import/ueberlieferung.jsp" %>
    <%@ include file="import/urkunde.jsp" %>
<%
  }

// Tabelle leeren
  else if (operation.equals("empty")) {
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
      st = cn.createStatement();
      st.execute("TRUNCATE TABLE "+tabelle);
      out.println("<p>Tabelle \""+tabelle+"\" erfolgreich geleert.</p>");
      
    } finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }

// Bemerkungen importieren
  else if (operation.equals("importcomment")) {
%>
    <%@ include file="import/bemerkung.jsp" %>
<%
  }


// null zu NULL
  else if (operation.equals("nulltonull") || operation.equals("emptytonull")) {

    String needle = "";
    if (operation.startsWith("null")) needle = "null";
  
    Scanner sc = null;
    Connection cn = null;
    Statement  st = null;
    Statement st2 = null;
    ResultSet  rs = null;

    int counter = 0;
    try {
      sc = new Scanner(new File("E:/tabellen.txt"));

      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      for (String tbl=sc.nextLine(); sc.hasNextLine(); tbl=sc.nextLine()) {
        out.println("<b>"+tbl+"</b><br>");
        try {
          st = cn.createStatement();
          rs = st.executeQuery("SELECT * FROM "+tbl+" LIMIT 0, 1");
          ResultSetMetaData rsmd = rs.getMetaData();
          int n = rsmd.getColumnCount();
          for( int i=1; i<=n; i++ ) {
            if (rsmd.isNullable(i) == rsmd.columnNullable) {
                st2 = cn.createStatement();
                st2.execute("UPDATE "+tbl+" SET "+rsmd.getColumnName(i)+"=NULL WHERE "+rsmd.getColumnName(i)+"='"+needle+"';");
                counter++;
            } //if
          } // for
        } // try
        catch (SQLException e) {
          out.println(e+"<br>");
        }
      } // while
      out.println("<p>"+counter+" Spalten ge&auml;ndert.</p>");
    } // try
    catch (FileNotFoundException e) {
      out.println("Datei nicht gefunden!<br>"+e);
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    } // finally
  }

  else if (operation.equals("adddefaults")) {
    String[] tabellen = {"amtweihe", "areal", "echtheit", "ethnie", "funktion", "kasus", "literaturtyp", "ort", "quellengattung", "stand", "urkundeausstellerempfaenger", "verwandtschaftsgrad"};
    Connection cn = null;
    Statement st = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew);
      st = cn.createStatement();
      for (int i=0; i<tabellen.length; i++) {
        st.execute("INSERT INTO selektion_"+tabellen[i]+" (ID, Bezeichnung) VALUES ('-1', 'nicht bearbeitet');");
        st.execute("INSERT INTO selektion_"+tabellen[i]+" (ID, Bezeichnung) VALUES ('0', 'unklar');");
      }
      out.println("<p>Defaultwerte erfolgreich eingef&uuml;gt.</p>");
    }
    catch (SQLException e) {out.println(e);}  
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }

  else if (operation.equals("userlinks")) {
    String[] tbl   = {"einzelbeleg", "person", "quelle", "edition", "handschrift", "namenkommentar", "literatur"};
    int[][]  links = {{ 402,  9}, { 403,  5}, { 406, 33}, { 407, 34}, { 497,  3}, { 498,  2}, { 499,  1}, { 597, 26},
                      { 602, 30}, { 603, 32}, { 605, 36}, { 702, 40}, { 802,  8}, { 901, 13},
                      {1301, 29}, {1302, 28}, {1401, 14}, {1501, 15}, {1502, 16}};
    Connection cn = null;
    Statement st = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew);
      st = cn.createStatement();
      for (int i=0; i<tbl.length; i++) {
        for (int j=0; j<links.length; j++) {
          st.addBatch("UPDATE "+tbl[i]+" SET LetzteAenderungVon="+links[j][1]+" WHERE LetzteAenderungVon="+links[j][0]+";");
          st.addBatch("UPDATE "+tbl[i]+" SET ErstelltVon="+links[j][1]+" WHERE ErstelltVon="+links[j][0]+";");
        }
      }
      st.executeBatch();
      out.println("<p>Benutzerverkn&uuml;pfungen erfolgreich aktualisiert!</p>");
    }
    catch (SQLException e) {out.println(e);}  
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE userlinks

  else if (operation.equals("boundtogroups")) {
    String[] tbl   = {"einzelbeleg", "person", "quelle", "edition", "handschrift", "namenkommentar", "literatur"};
    Connection cn = null;
    Statement st = null;
    Statement st2 = null;
    ResultSet rs = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew);
      st = cn.createStatement();
      st2 = cn.createStatement();
      rs = st.executeQuery("SELECT ID, GruppeID FROM benutzer");
      while (rs.next()) {
        for (int i=0; i<tbl.length; i++) {
          st.addBatch("UPDATE "+tbl[i]+" SET GehoertGruppe="+rs.getInt("GruppeID")+" WHERE ErstelltVon="+rs.getInt("ID")+";");
        }
      }
      st.executeBatch();
      out.println("<p>Gruppenbeschr&auml;nkungen erfolgreich aktualisiert</p>");
    }
    catch (SQLException e) {out.println(e);}  
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE boundtogroups

  else if (operation.equals("editions")) {
    Connection cn = null;
    Statement st = null;
    Statement st2 = null;
    ResultSet rs = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew);
      st = cn.createStatement();
      st2 = cn.createStatement();
      st.execute("UPDATE einzelbeleg SET EditionID = (SELECT EditionID FROM quelle_inedition WHERE quelle_inedition.QuelleID=einzelbeleg.QuelleID LIMIT 0,1)");
      rs = st.executeQuery("SELECT QuelleID FROM quelle_inedition GROUP BY QuelleID HAVING count(EditionID) > 1");
      while (rs.next()) {
        String sql = "UPDATE einzelbeleg SET EditionID = -1 WHERE QuelleID="+rs.getInt("QuelleID")+";";
        out.println(sql+"<br>");
        st2.addBatch(sql);
      }
      st2.executeBatch();
      out.println("<p>verwendete Editionen erfolgreich aktualisiert</p>");
    }
    catch (SQLException e) {out.println(e);}  
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE editions

  else if (operation.equals("exportnamenkommentar")) {
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT Nk_FileName, NK_File FROM tbl_namenkommentar");

      try {
        while (rs.next()) {
          if (rs.getString("Nk_FileName")!=null) {
            Blob blob = rs.getBlob("NK_File");
            String filename = this.getServletContext().getRealPath("/")+"NeG\\namenkommentar\\"+rs.getString("Nk_FileName");
            java.io.File f = new File(filename);
            f.createNewFile();
            java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
            fos.write(blob.getBytes(1, (int)blob.length()));
            fos.flush();
            fos.close();
            out.println("<b>OK</b>&nbsp;"+rs.getString("Nk_FileName")+"<br>");
          }
        }
      }
      catch (Exception e) { out.println(e); }
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE exportnamenkommentar

  else if (operation.equals("generatejahrhundert")) {
    Connection cn = null;
    Statement st = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
      st = cn.createStatement();
      for (int i=0; i<2000; i+=50) {
        st.addBatch("UPDATE einzelbeleg SET VonJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE VonJahr >= "+i+" AND VonJahr <= "+(i+50)+" AND VonJahrhundert IS NULL");
        st.addBatch("UPDATE einzelbeleg SET BisJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE BisJahr >= "+i+" AND BisJahr <= "+(i+50)+" AND BisJahrhundert IS NULL");
        st.addBatch("UPDATE einzelbeleg SET QuelleVonJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE QuelleVonJahr >= "+i+" AND QuelleVonJahr <= "+(i+50)+" AND QuelleVonJahrhundert IS NULL");
        st.addBatch("UPDATE einzelbeleg SET QuelleBisJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE QuelleBisJahr >= "+i+" AND QuelleBisJahr <= "+(i+50)+" AND QuelleBisJahrhundert IS NULL");
        st.addBatch("UPDATE quelle SET VonJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE VonJahr >= "+i+" AND VonJahr <= "+(i+50)+" AND VonJahrhundert IS NULL");
        st.addBatch("UPDATE quelle SET BisJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE BisJahr >= "+i+" AND BisJahr <= "+(i+50)+" AND BisJahrhundert IS NULL");
        st.addBatch("UPDATE handschrift_ueberlieferung SET VonJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE VonJahr >= "+i+" AND VonJahr <= "+(i+50)+" AND VonJahrhundert IS NULL");
        st.addBatch("UPDATE handschrift_ueberlieferung SET BisJahrhundert='"+((i/100)+1)+"Jh"+(i%100==0?1:2)+"' WHERE BisJahr >= "+i+" AND BisJahr <= "+(i+50)+" AND BisJahrhundert IS NULL");
        st.executeBatch();
      }
      out.println("<p>Jahrhunderte erfolgreich erzeugt</p>");
    }
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE generatejahrhundert
  out.println("<p align=center><a href=\"importscript.jsp\">zur&uuml;ck zur &Uuml;bersicht</a></p>");
%>
