<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.util.ArrayList" isThreadSafe="false"%>
<%@ page import="java.util.List" isThreadSafe="false"%>
<%@ page import="java.util.StringTokenizer" isThreadSafe="false"%>


<%!

String chop (String text, int letters) {
  if (text.length() < letters)
    return text;
  return text.substring(0, letters)+"...";
}

boolean isSet(String zielTabelle, String zielAttribut, int id , Statement st){
	  String sql = "SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"";
	  

	  
	  ResultSet  rs = null;
	  try {
	    rs = st.executeQuery(sql);
	    if ( rs.next() && rs.getString(zielAttribut) != null && rs.getInt(zielAttribut) == 1) 
            {
            	      return true;
	        }
	  }
	  catch (Exception e) {

	  }
	  return false;

}

String DBtoDB(String s) {
  if (s!=null) {
    s = s.replace("\'", "\\'");
    s = s.replace("\"", "\\\"");
  }
  return s;
}

String DBtoJS(String s) {
  if (s!=null) {
    s = s.replace("\'", "\\&#039;");
    s = s.replace("\"", "\\&quot");
  }
  return s;
}

Vector calcCenturies(int von, int bis){
   Vector ret = new Vector();

   int vonCent = von / 100;
   if(!(von % 100 == 0))vonCent++;
   
   int bisCent = bis / 100;
   if(!(bis % 100 == 0))bisCent++;
   
   for(int i=vonCent; i<=bisCent; i++){
      ret.add(i + "");
      ret.add(i + "Jh");
      for(int j=1; j<2; j++){
         ret.add(i + "Jh" + j);
      }
   }
   return ret;
}

String DBtoHTML(String s) {
  if(s==null) return s;
 // s = s.replace("&", "&amp;");
  s = s.replace("<", "&lt;");
  s = s.replace(">", "&gt;");
  s = s.replace("\"", "&quot;");
  s = s.replace("\'", "&#039;");
 
  s = s.replace("ä", "&auml;");
  s = s.replace("ö", "&ouml;");
  s = s.replace("ü", "&uuml;");
  s = s.replace("Ä", "&Auml;");
  s = s.replace("Ö", "&Ouml;");
  s = s.replace("Ü", "&Uuml;");
  s = s.replace("ß", "&szlig;");

  s = s.replace("°", "&deg;");

  s = s.replace("´", "&acute;");
  s = s.replace("`", "&grave;");
  s = s.replace("^", "&circ;");

  s = s.replace("á", "&aacute;");
  s = s.replace("é", "&eacute;");
  s = s.replace("í", "&iacute;");
  s = s.replace("ó", "&oacute;");
  s = s.replace("ú", "&uacute;");

  s = s.replace("à", "&agrave;");
  s = s.replace("è", "&egrave;");
  s = s.replace("ì", "&igrave;");
  s = s.replace("ò", "&ograve;");
  s = s.replace("ù", "&ugrave;");

  s = s.replace("â", "&acirc;");
  s = s.replace("ê", "&ecirc;");
  s = s.replace("î", "&icirc;");
  s = s.replace("ô", "&ocirc;");
  s = s.replace("û", "&ucirc;");

  return s;
}

String HTMLtoDB(String s) {
  if(s==null) return s;
  s = s.replace("&lt;", "<");
  s = s.replace("&gt;", ">");
  s = s.replace("&quot;", "\"");
  s = s.replace("&#039;", "\'");
 
  s = s.replace("&auml;", "ä");
  s = s.replace("&ouml;", "ö");
  s = s.replace("&uuml;", "ü");
  s = s.replace("&Auml;", "Ä");
  s = s.replace("&Ouml;", "Ö");
  s = s.replace("&Uuml;", "Ü");
  s = s.replace("&szlig;", "ß");

  s = s.replace("&deg;", "°");

  s = s.replace("&acute;", "´");
  s = s.replace("&grave;", "`");
  s = s.replace("&circ;", "^");

  s = s.replace("&aacute;", "á");
  s = s.replace("&eacute;", "é");
  s = s.replace("&iacute;", "í");
  s = s.replace("&oacute;", "ó");
  s = s.replace("&uacute;", "ú");

  s = s.replace("&agrave;", "à");
  s = s.replace("&egrave;", "è");
  s = s.replace("&igrave;", "ì");
  s = s.replace("&ograve;", "ò");
  s = s.replace("&ugrave;", "ù");

  s = s.replace("&acirc;", "â");
  s = s.replace("&ecirc;", "ê");
  s = s.replace("&icirc;", "î");
  s = s.replace("&ocirc;", "ô");
  s = s.replace("&ucirc;", "û");

  return s;
}

String makeDate (int tag, int monat, int jahr) {
  String ret = ""+(tag>0?tag:"o")+"."+(monat>0?monat:"o")+"."+(jahr>0?jahr:"o");
  if(!ret.equals("o.o.o")) return ret;
  return "";
}

String numberResize(int value, int positions) {
  String tmp = ""+value;
  while (tmp.length() < positions)
    tmp = "0"+tmp;
  return tmp;
}

String urlEncode (String s) {

  s = s.replace("%", "%25");

  s = s.replace("!", "%21");
  s = s.replace("#", "%23");
  s = s.replace("$", "%24");
  s = s.replace("&", "%26");
  s = s.replace("'", "%27");
  s = s.replace("(", "%28");
  s = s.replace(")", "%29");
  s = s.replace("*", "%2A");
  s = s.replace("+", "%2B");
  s = s.replace(",", "%2C");
  s = s.replace("/", "%2F");

  s = s.replace(":", "%3A");
  s = s.replace(";", "%3B");
  s = s.replace("=", "%3D");
  s = s.replace("?", "%3F");

  s = s.replace("@", "%40");

  s = s.replace("[", "%5B");
  s = s.replace("]", "%5D");

  return s;
}

String md5(String input) {
  try {
    MessageDigest m = MessageDigest.getInstance("MD5");
    m.update(input.getBytes(), 0, input.length());
    String output = new BigInteger(1, m.digest()).toString(16);
    return output;
  }
  catch (Exception e) {}
  return "";
}

Vector removeDuplicates(Vector vector) {
  for (int i=0; i<vector.size()-1; i++) {
    for (int j=i+1; j<vector.size(); j++) {
      if (vector.get(i).equals(vector.get(j))) {
        vector.removeElementAt(j);
      }
    }
  }
  vector.trimToSize();
  return vector;
}

int min(int a, int b) {
  return (a<b?a:b);
}

int max(int a, int b) {
  return (a>b?a:b);
}


String getLabel(String formular, String datenfeld, String textfeld, Statement st, String sprache){
	  String sql = "";
	  
	  if (datenfeld == null && textfeld != null) {
	    sql = "SELECT "+sprache+" Beschriftung FROM datenbank_texte WHERE Formular=\""+formular+"\" AND Textfeld=\""+textfeld+"\";";
	  }
	  else if (datenfeld != null && textfeld == null) {
	    sql = "SELECT "+sprache+"_Beschriftung Beschriftung FROM datenbank_mapping WHERE Formular=\""+formular+"\" AND datenfeld=\""+datenfeld+"\";";
	  }
	  
	  ResultSet  rs = null;
	  try {
	    rs = st.executeQuery(sql);
	    if ( rs.next() ) {
	      return DBtoHTML(rs.getString("Beschriftung"));

	    }
	  }
	  catch (Exception e) {

	  }
	  return "";
	
}

String format(String text, String feld){
	if(!feld.endsWith("PLemma")) return text;
	
	String lemma = text;
	lemma = lemma.replaceAll("@-e1", "&#x01E3;");
	lemma = lemma.replaceAll("@-E1", "&#x01E2;");
	lemma = lemma.replaceAll("@!d", "&thorn;");
	lemma = lemma.replaceAll("@-I", "&#x012A;");
	lemma = lemma.replaceAll("@-i", "&#x012B;");
	lemma = lemma.replaceAll("@-A", "&#x0100;");
	lemma = lemma.replaceAll("@-a", "&#x0101;");
	lemma = lemma.replaceAll("@-O", "&#x014C;");
	lemma = lemma.replaceAll("@-o", "&#x014D;");
	lemma = lemma.replaceAll("@-E2", "&#x0112;");
	lemma = lemma.replaceAll("@-e2", "&#x0113;");
	lemma = lemma.replaceAll("@-E", "&#x0112;");
	lemma = lemma.replaceAll("@-e", "&#x0113;");
	lemma = lemma.replaceAll("@-U", "&#x016A;");
	lemma = lemma.replaceAll("@-u", "&#x016B;");
	if(!lemma.equals("-"))lemma = lemma.replace("-", "");
	lemma = lemma.replaceAll("~", "");
	lemma = lemma.replaceAll("\\.", "");


	if(lemma.length()>1)lemma = lemma.substring(0, 1).toUpperCase()
			+ lemma.substring(1);
	else if(lemma.length()>0)lemma = lemma.substring(0, 1).toUpperCase();

	
	if(lemma.startsWith("&#x01E3;")) lemma = "&#x01E2;"+ lemma.substring(8); 
	if(lemma.startsWith("&#x012B;")) lemma = "&#x012A;"+ lemma.substring(8); 
	if(lemma.startsWith("&thorn;")) lemma = "&THORN;"+ lemma.substring(7); 
	if(lemma.startsWith("&#x0101;")) lemma = "&#x0100;"+ lemma.substring(8); 
	if(lemma.startsWith("&#x014D;")) lemma = "&#x014C;"+ lemma.substring(8); 
	if(lemma.startsWith("&#x0113;")) lemma = "&#x0112;"+ lemma.substring(8); 
	if(lemma.startsWith("&#x016B;")) lemma = "&#x016A;"+ lemma.substring(8); 
	
	return lemma;
}
%>