<%
  boolean andereSelektion = false;
  String quelltabelle = "";
  String zieltabelle = "";
  String id = "";
  String bezeichnung = "";

  if (tabelle.startsWith("selektion")) {

    if (tabelle.endsWith("_bkz")) {
      quelltabelle = "tbl_selbkz";
      zieltabelle = "selektion_bkz";
      id = "BKZ_ID";
      bezeichnung = "BKZ";
    } 

    else if (tabelle.endsWith("datgenauigkeit")) {
      quelltabelle = "tbl_seldatgenauigkeit";
      zieltabelle = "selektion_datgenauigkeit";
      id = "DatGenauigkeitWert";
      bezeichnung = "DatGenauigkeit";
    } 

    else if (tabelle.endsWith("ethnie")) {
      quelltabelle = "tbl_selethnie";
      zieltabelle = "selektion_ethnie";
      id = "Et_ID";
      bezeichnung = "Ethnie";
    } 

    else if (tabelle.endsWith("echtheit")) {
      quelltabelle = "tbl_selechtheit";
      zieltabelle = "selektion_echtheit";
      id = "EID";
      bezeichnung = "Status";
    } 

    else if (tabelle.endsWith("_geschlecht")) {
      quelltabelle = "tblddlgender";
      zieltabelle = "selektion_geschlecht";
      id = "G_ID";
      bezeichnung = "Gender";
    } 

    else if (tabelle.endsWith("_grammatikgeschlecht")) {
      quelltabelle = "tblddlgramgeschlecht";
      zieltabelle = "selektion_grammatikgeschlecht";
      id = "G_ID";
      bezeichnung = "Geschlecht";
    } 

    else if (tabelle.endsWith("janein")) {
      quelltabelle = "tblddlyesno";
      zieltabelle = "selektion_janein";
      id = "YN_ID";
      bezeichnung = "YesNo";
    } 

    else if (tabelle.endsWith("kasus")) {
      quelltabelle = "tbl_selkasus";
      zieltabelle = "selektion_kasus";
      id = "KID";
      bezeichnung = "Kasus";
    } 

    else if (tabelle.endsWith("lebendverstorben")) {
      quelltabelle = "tblddllebendverstorben";
      zieltabelle = "selektion_lebendverstorben";
      id = "LV_ID";
      bezeichnung = "LV_Wert";
    } 

    else if (tabelle.endsWith("_ort")) {
      quelltabelle = "tbl_selort";
      zieltabelle = "selektion_ort";
      id = "Ort_ID";
      bezeichnung = "Ort";
    } 

    else if (tabelle.endsWith("quellengattung")) {
      quelltabelle = "tbl_selquellengattung";
      zieltabelle = "selektion_quellengattung";
      id = "QGID";
      bezeichnung = "Quellengattung";
    } 

    else if (tabelle.endsWith("_reihe")) {
      quelltabelle = "tbl_selreihe";
      zieltabelle = "selektion_reihe";
      id = "Rei_ID";
      bezeichnung = "Reihe";
    } 

    else if (tabelle.endsWith("_sammelband")) {
      quelltabelle = "tbl_selsammelband";
      zieltabelle = "selektion_sammelband";
      id = "SammelBandID";
      bezeichnung = "SammelBand";
    } 

    else if (tabelle.endsWith("stand")) {
      quelltabelle = "tbl_selamtpersonen";
      zieltabelle = "selektion_stand";
      id = "AmtID";
      bezeichnung = "Amt";
    } 

    else if (tabelle.endsWith("_sw_arealgens")) {
      quelltabelle = "tblcboarealgens";
      zieltabelle = "selektion_sw_arealgens";
      id = "ID";
      bezeichnung = "ArealGensSW";
    } 

    else if (tabelle.endsWith("_sw_morphologie")) {
      quelltabelle = "tblcbomorphologie";
      zieltabelle = "selektion_sw_morphologie";
      id = "ID";
      bezeichnung = "MorphologieSW";
    } 

    else if (tabelle.endsWith("_sw_motivation")) {
      quelltabelle = "tblcbomotivation";
      zieltabelle = "selektion_sw_motivation";
      id = "ID";
      bezeichnung = "MotivationSW";
    } 

    else if (tabelle.endsWith("_sw_namenelemente")) {
      quelltabelle = "tblcbonamenelemente";
      zieltabelle = "selektion_sw_namenelemente";
      id = "ID";
      bezeichnung = "NamenElementSW";
    } 

    else if (tabelle.endsWith("_sw_namenlexikon")) {
      quelltabelle = "tblcbonamenlexik";
      zieltabelle = "selektion_sw_namenlexikon";
      id = "ID";
      bezeichnung = "NamenlexikSW";
    } 

    else if (tabelle.endsWith("_sw_phongraph")) {
      quelltabelle = "tblcbophonograph";
      zieltabelle = "selektion_sw_phongraph";
      id = "ID";
      bezeichnung = "PhonoGraphSW";
    } 

    else if (tabelle.endsWith("_sw_sprachherkunft")) {
      quelltabelle = "tblcbosprachlherkunft";
      zieltabelle = "selektion_sw_sprachherkunft";
      id = "ID";
      bezeichnung = "SprachlHerkunftSW";
    } 

    else if (tabelle.endsWith("verwandtschaftsgrad")) {
      quelltabelle = "tbl_selverwandtschaftsgrad";
      zieltabelle = "selektion_verwandtschaftsgrad";
      id = "VG_ID";
      bezeichnung = "Verwandtschaftsgrad";
    } 

    else {
      andereSelektion = true;
    }
  }

  if (tabelle.startsWith("selektion") && !andereSelektion) {
    Connection cn = null;
    Connection cn2 = null;

    Statement st = null;
    Statement st2 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;  

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      st = cn.createStatement();
      st2 = cn2.createStatement();

      rs = st.executeQuery("SELECT * FROM "+quelltabelle);
      while (rs.next()) {
        try {
          st2.addBatch("INSERT INTO "+tabelle+" (ID, Bezeichnung) VALUES ('"+rs.getInt(id)+"', '"+rs.getString(bezeichnung).replace("\'", "\\\'")+"');\n");
        }
        catch (SQLException e) {
          out.println(e);
        }
      }
      st2.executeBatch();
    }
    finally {
      try { if( null != rs  ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st  ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
      try { if( null != cn  ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>