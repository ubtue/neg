<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp"%>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%

  int id = -1;
    String formular = request.getParameter("formular"); 
 
  String title = request.getParameter("title");
  String guest = "";
  if (title.contains("gast_")) {
    title = title.substring(5);
    guest = "gast_";
  }
  String bez = "Belegform";
  if(title.toLowerCase().equals("person")) bez = "Standardname";
  else if(title.toLowerCase().equals("namenkommentar")) bez = "PLemma";
  else if(title.toLowerCase().equals("quelle")) bez = "Bezeichnung";
  else if(title.toLowerCase().equals("edition")) bez = "Titel";
  else if(title.toLowerCase().equals("handschrift")) bez = "Bibliothekssignatur";
  else if(title.toLowerCase().equals("literatur")) bez = "Kurzzitierweise";
  else if(title.toLowerCase().equals("mgh_lemma")) bez = "MGHLemma";
  int filter = 0;
  String filterParameter = null;
  try {
    id = Integer.parseInt(request.getParameter("ID"));
    filter = ((Integer)session.getAttribute(formular+"filter")).intValue();
    filterParameter = (String)(session.getAttribute(formular+"filterParameter"));
  } catch (Exception e) {}

  int newid = id;
  String label = "";

  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;

  try {
    String sql = "SELECT * FROM "+title;

    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();

    rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='"+guest+title+"' AND Nummer='"+filter+"';");
    if (rs.next()) {
      sql = rs.getString("SQLString");
    }
      sql = sql.replace("*", bez + ", " + title+".ID");
    if (filterParameter != null){
      sql = sql.replace("###", filterParameter);
    }

      String sql1 = sql +  (sql.contains("WHERE")?" AND":" WHERE")+" "+title+".ID < "+id+" ORDER BY ID DESC LIMIT 0,5;";
      String sql2 = sql +  (sql.contains("WHERE")?" AND":" WHERE")+" "+title+".ID = "+id+" ORDER BY ID DESC LIMIT 0,1;";
      String sql3 = sql +  (sql.contains("WHERE")?" AND":" WHERE")+" "+title+".ID > "+id+" ORDER BY ID ASC LIMIT 0,5;";
 
    rs = st.executeQuery(sql1);
    int count = 0;
    String res = "";
    while (count <5 && rs.next()) {
      count++;
      String value = format(rs.getString(bez),bez);
      int max = Math.min(7,value.length());
      if(bez.equals("PLemma")){
      int posAmph = value.substring(0,max).lastIndexOf("&");
      int posSem = value.substring(0,max).lastIndexOf(";");
      if(posAmph>posSem){ 
         posSem = value.indexOf(";", posAmph);
         max = value.indexOf(";", posAmph)+1;
      }}
      value = value.substring(0,max);
      value = "<a style='color:#ffffff;' href='?ID="+rs.getString("ID")+"'>"+value+"..."+"</a>";
      res = value + "\t" + res;
    }
    out.println(res);
        rs = st.executeQuery(sql2);
    if (rs.next()) {
      String value = format(rs.getString(bez),bez);
      int max = Math.min(10,value.length());
      if(bez.equals("PLemma")){
      int posAmph = value.substring(0,max).lastIndexOf("&");
      int posSem = value.substring(0,max).lastIndexOf(";");
      if(posAmph>posSem){ 
         posSem = value.indexOf(";", posAmph);
         max = value.indexOf(";", posAmph)+1;
      }}
      value = value.substring(0,max);
      out.println("<span style=\"color:white;\"><b>"+value + "...</b></span>\t");
    }    rs = st.executeQuery(sql3);
    count = 0;
    while (count <5 && rs.next()) {
      count++;
      String value = format(rs.getString(bez),bez);
      int max = Math.min(7,value.length());
      if(bez.equals("PLemma")){
      int posAmph = value.substring(0,max).lastIndexOf("&");
      int posSem = value.substring(0,max).lastIndexOf(";");
      if(posAmph>posSem){ 
         posSem = value.indexOf(";", posAmph);
         max = value.indexOf(";", posAmph)+1;
      }}
      value = value.substring(0,max);
      value = "<a style='color:#ffffff;' href='?ID="+rs.getString("ID")+"'>"+value+"..."+"</a>";
      out.println(value + "\t");
    }
  } catch (Exception e) {
    out.println(e);
  } finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
//  out.println("<a style='color:#ffffff;' href='?ID="+(request.getParameter("Command").equals("new")?"-1":newid)+"'>"+label+"</a>");
%>
