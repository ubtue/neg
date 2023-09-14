<%
  request.setCharacterEncoding("UTF-8");
  String sqlDriver  = "com.mysql.cj.jdbc.Driver";

  // Zugangsdaten für die Datenbank (nur für die Anwendung) => siehe tomcat
  javax.naming.InitialContext initialContext = new javax.naming.InitialContext();
  String sqlURL = (String)initialContext.lookup("java:comp/env/sqlURL");
  String sqlUser = (String)initialContext.lookup("java:comp/env/sqlUser");
  String sqlPassword = (String)initialContext.lookup("java:comp/env/sqlPassword");

  // Zugangsdaten für die NEUE Datenbank (nur für den Import)
  String sqlURLnew  = sqlURL;
  String sqlUserNew = sqlUser;
  String sqlPasswordNew = sqlPassword;

  // Zugangsdaten für die ALTE Datenbank (nur für den Import)
  String sqlURLold  = sqlURL;
  String sqlUserOld = sqlUser;
  String sqlPasswordOld = sqlPassword;

  // Speicherort der Datei "tabellen.txt" (nur für den Import)
  String tblFile = "E:/tabellen.txt";

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
