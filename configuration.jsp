<%
  String sqlDriver  = "com.mysql.jdbc.Driver";

  String sqlURL  = "jdbc:mysql://localhost:3306/neg_final";
  String sqlUser = "neg";
  String sqlPassword = "pcqXCB!)763";

  String sqlURLnew  = sqlURL  ;
  String sqlUserNew = sqlUser ;
  String sqlPasswordNew = sqlPassword ;

  String sqlURLold  = sqlURL  ;
  String sqlUserOld = sqlUser ;
  String sqlPasswordOld = sqlPassword ;



  int pageLimit = 30;		// Wichtig für Abfragen
  int sessionTimeout = 60*60;

  int numberSize = 5;		// Anzahl der Nummerierungsstellen in PKZ, Belegnummer, etc.

  String txt_search = "<img src=\"layout/icons/search2.gif\" border=\"0\" alt=\"suchen\" title=\"suchen\">";  // "suchen";
  String txt_delete = "<img src=\"layout/icons/delete2.gif\" border=\"0\" alt=\"l&ouml;schen\" title=\"l&ouml;schen\">";  // "l&ouml;schen";
  String txt_newentry = "<img src=\"layout/icons/newentry2.gif\" border=\"0\" alt=\"neuer Eintrag\" title=\"neuer Eintrag\">";  // "neuer Eintrag";

  String commentFolder_personenkommentar = "personenkommentar";
  String commentFolder_namenkommentar = "namenkommentar";
  String path = "neg";
%>