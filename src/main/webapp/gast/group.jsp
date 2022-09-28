<%@ page import="java.io.*" isThreadSafe="false" %>
<%@ page import="javax.servlet.jsp.*" isThreadSafe="false" %>
<%@ page import="java.sql.*" isThreadSafe="false" %>


<%!

String test(JspWriter out, Vector<String> headlines, Vector<String> fieldNames, ResultSet rs, String orderV [], String order, String open, boolean countTables){
  String ret = "";
  int topCount = 0;

  try{

  	String header = "";

    int orderSize = orderV.length;
    boolean [] first  = {true, true, true, true, true,true, true, true, true, true,true, true, true, true, true};
    String oldValue [] = new String [15];
    String export = "browse";


    header += "<tr>";
    for (int i=0; i<headlines.size(); i++) {
       if(fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") ||fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))){
          header += "<th width=\""+(100/headlines.size())+"%\" class=\"resultlist\">";
          header += headlines.get(i);
          header += "</th>";
       }
    }
    boolean even = false;
    header += "</tr>";

    if(orderSize == 0) out.print("<table class=\"resultlist\">"+header+"<tr>");

    while ( rs.next() ) {

       for(int z = 0; z<orderSize; z++){
           int jahr = 0;
           String jahrV = rs.getString(orderV[z]);
           int zeitraum = 0;
           if(orderV[z].endsWith("Jahr")){
               zeitraum = 25;
               if(jahrV==null) jahr = 0;
               else jahr = Integer.parseInt(jahrV);
               jahr = jahr / zeitraum;
               jahrV = "" +  jahr;
           }


           if(first[z] || rs.getString(orderV[z])!=null && !jahrV.equalsIgnoreCase(oldValue[z])) {
              oldValue[z] = jahrV;
           	  if(!first[z]){
                 out.print("</table>");
                 for(int z2=z; z2<orderSize; z2++)out.print("</ul></li>");
	          }
              first[z] = false;
              for(int z2=z+1; z2<orderSize; z2++) first[z2]=true;

              if(z>0)out.print("<li class=\"liClosed\" style=\"font-size:medium\">");
              else out.print("<li class=\"liOpen\" style=\"font-size:large\">");

              String text = rs.getString(orderV[z]);
              if(orderV[z].startsWith("einzelbeleg.ID"))text = rs.getString("einzelbeleg.Belegform");
              if(text==null) text="-";
              String titel=orderV[z];

              if(orderV[z].startsWith("einzelbeleg.ID")) titel="einzelbeleg.Belegform";
              titel = headlines.get(fieldNames.indexOf(titel));

              out.print(titel + ": aaa");
              boolean link = false;
              if(!text.equals("-"))
                if (orderV[z].equals("einzelbeleg.ID")) {
                  out.print("<a href=\"einzelbeleg.jsp?ID="+rs.getInt("einzelbeleg.ID")+"\">");
                  link = true;
                }
                else if (orderV[z].equals("e2.ID")) {
                  out.print("<a href=\"einzelbeleg.jsp?ID="+rs.getInt("e2.ID")+"\">");
                  link = true;
                }
                else if (orderV[z].equals("person.Standardname")) {
                  out.print("<a href=\"person.jsp?ID="+rs.getInt("person.ID")+"\">");
                  link = true;
                }
                else if (orderV[z].equals("perszu.Standardname")) {
                  out.print("<a href=\"person.jsp?ID="+rs.getInt("perszu.ID")+"\">");
                  link = true;
                }
                else if (orderV[z].equals("namenkommentar.PLemma")) {
                  out.print("<a href=\"namenkommentar.jsp?ID="+rs.getInt("namenkommentar.ID")+"\">");
                  link = true;
                }
                else if (orderV[z].equals("mgh_lemma.MGHLemma")) {
                    out.print("<a href=\"mghlemma?ID="+rs.getInt("mgh_lemma.ID")+"\">");
                    link = true;
                  }
                      else if (orderV[z].equals("quelle.Bezeichnung")) {
                  out.print("<a href=\"quelle.jsp?ID="+rs.getInt("quelle.ID")+"\">");
                  link = true;
                }
                else if (orderV[z].equals("edition.Titel")) {
                  try{
                  out.print("<a href=\"edition.jsp?ID="+rs.getInt("edition.ID")+"\">");
                  link = true;
                  }catch(Exception e){
                     link=false;
                  }
                }

                if(orderV[z].startsWith("einzelbeleg.ID"))           out.print(format(DBtoHTML(text), "einzelbeleg.Belegform"));
                else if(orderV[z].endsWith("Jahr")){
                   int ja = Integer.parseInt(oldValue[z]);
                   out.print("" + (ja* zeitraum) + "-" + ((ja+1)* zeitraum -1));
                }
                else {

                  String format = orderV[z];
                  if(orderV[z].equals("Erstglied") || orderV[z].equals("Zweitglied")) format = "PLemma";
                     out.print(format(DBtoHTML(text), format));
               }
               if (link) {
                 out.print("</a> ");
               }
               else out.print(" ");

              if(z==orderSize-1){
                 out.print("<ul><table class=\"resultlist\" width=\"100%\">"+header+"<tr>");
              }
              else out.print("<ul>");
           }
        }

        out.print("<tr class=\""+(even?"":"un")+"even\">");


        for(int i=0; i<fieldNames.size(); i++) {
          if(fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))){
            out.print("<td class=\"resultlist\" valign=\"top\">");
            if (rs.getString(fieldNames.get(i)) != null && !DBtoHTML(rs.getString(fieldNames.get(i))).equals("")) {
               String cell =  DBtoHTML(rs.getString(fieldNames.get(i))).substring(0,1);
               boolean link = false;
               if (fieldNames.get(i).contains("einzelbeleg.Belegform")) {
                  out.print("<a href=\"einzelbeleg.jsp?ID="+rs.getInt("einzelbeleg.ID")+"\">");
                  link = true;
               }
               if (fieldNames.get(i).contains("e2.Belegform")) {
                   out.print("<a href=\"einzelbeleg.jsp?ID="+rs.getInt("e2.ID")+"\">");
                  link = true;
               }
               else if (fieldNames.get(i).contains("person.Standardname")) {
                   out.print("<a href=\"person.jsp?ID="+rs.getInt("person.ID")+"\">");
                  link = true;
               }
               else if (fieldNames.get(i).contains("perszu.Standardname")) {
                   out.print("<a href=\"person.jsp?ID="+rs.getInt("perszu.ID")+"\">");
                  link = true;
               }
               else if (fieldNames.get(i).contains("namenkommentar.PLemma")) {
                   out.print("<a href=\"namenkommentar.jsp?ID="+rs.getInt("namenkommentar.ID")+"\">");
                  link = true;
               }
				else if (fieldNames.get(i).contains("mgh_lemma.MGHLemma")) {
                    out.print("<a href=\"mghlemma.jsp?ID="+rs.getInt("mgh_lemma.ID")+"\">");
                    link = true;
                  }
                     else if (fieldNames.get(i).contains("quelle.Bezeichnung")) {
                   out.print("<a href=\"quelle.jsp?ID="+rs.getInt("quelle.ID")+"\">");
                  link = true;
               }
               else if (fieldNames.get(i).contains("edition.Titel")) {
                  try{
                      out.print("<a href=\"edition.jsp?ID="+rs.getInt("edition.ID")+"\">");
                     link = true;
                  }catch(Exception e){
                     link=false;
                  }
               }
               if(fieldNames.get(i).endsWith("PLemma") || fieldNames.get(i).equals("Erstglied") || fieldNames.get(i).equals("Zweitglied"))
                  cell = format(cell, "PLemma");
               out.print(cell);
               if (link) {
                  out.print("</a> ");
               }
            }
            else
              out.print("&nbsp;");
           out.print("</td>");
         }
       }
       out.print("</tr>");
       even = !even;
    }
    out.print("</tr>");
    out.print("</table>");


    for(int z = orderSize-2; z>=0; z--)out.print("</ul></li>");

    out.print("</ul>");
 }catch(Exception ex){}

    return ret;
}

%>
