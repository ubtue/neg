<%
  String sqlDriver  = "com.mysql.jdbc.Driver";

// Zugangsdaten f�r die NEUE Datenbank (nur f�r Import)
  String sqlURLNew  = "jdbc:mysql://localhost:3306/neg";
  String sqlUserNew = "";
  String sqlPasswordNew = "";

// Zugangsdaten f�r die ALTE Datenbank (nur f�r Import)
  String sqlURLOld  = "jdbc:mysql://localhost:3306/neg";
  String sqlUserOld = "";
  String sqlPasswordOld = ";

// Zugangsdaten f�r die Datenbank (nur f�r die Anwendung)
  String sqlURL  = "jdbc:mysql://localhost:3306/neg";
  String sqlUser = "";
  String sqlPassword = "";

// Speicherort der Datei "tabellen.txt" (nur f�r Import)
  String tblFile = "E:/tabellen.txt";

  int pageLimit = 30;		// Wichtig f�r Abfragen
  int sessionTimeout = 60*60;

  int numberSize = 5;		// Anzahl der Nummerierungsstellen in PKZ, Belegnummer, etc.

  String txt_search = "<img src=\"layout/icons/search2.gif\" border=\"0\" alt=\"suchen\" title=\"suchen\">";  // "suchen";
  String txt_delete = "<img src=\"layout/icons/delete2.gif\" border=\"0\" alt=\"l&ouml;schen\" title=\"l&ouml;schen\">";  // "l&ouml;schen";
  String txt_newentry = "<img src=\"layout/icons/newentry2.gif\" border=\"0\" alt=\"neuer Eintrag\" title=\"neuer Eintrag\">";  // "neuer Eintrag";

  String commentFolder_person = "personenkommentar";
  String commentFolder_namenkommentar = "namenkommentar";
    String path = "NeG";
%>