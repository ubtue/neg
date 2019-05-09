<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>

<%@ page import="com.lowagie.text.Document" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.*" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false" %>
<%@ page import="java.io.*" isThreadSafe="false" %>


<%

//
// Template JSP file for iText
// by Tal Liron
//
// step 1: creation of a document-object
Document document = new Document();

// step 2:
// we create a writer that listens to the document
// and directs a PDF-stream to a temporary buffer

 int limit=0;
 int offset = 5;
  try{
      limit = Integer.parseInt(request.getParameter("limit"));
  }catch(Exception ex){;}

  String file = "/print/" +request.getParameter("form")+ request.getParameter("Belegform").replace('%','_').toLowerCase() + "download.rtf";

FileOutputStream buffer = new FileOutputStream(this.getServletContext().getRealPath("/") + file);
RtfWriter2.getInstance( document, buffer );

// step 3: we open the document
document.open();

  String formular = request.getParameter("form");

 /* out.println("<center>");
  out.println("<a href=\"?form="+formular+"&Belegform="+request.getParameter("Belegform")+"&limit="+(limit+5)+"\">Nächste "+offset+" Lemmata</a>");
  out.println("</center>");
*/
      out.println("<table class=\"date\">\n");
      out.println("<tr><th>Link</th><th>Beleg</th><th>Datierung</th><th>Sigle: Variante</th></tr>\n");
      Connection cn = null;
      Statement  st = null;
      ResultSet  rs = null;
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();


        rs = st.executeQuery("SELECT n.ID, n.PLemma"
                             +" FROM einzelbeleg_hatnamenkommentar eh2, einzelbeleg e2, namenkommentar n"
                             +" WHERE e2.Belegform LIKE '" +request.getParameter("Belegform")+"' AND eh2.EinzelbelegID=e2.ID AND n.ID=eh2.NamenkommentarID group by n.ID order by n.PLemma");// limit "+limit+"," + offset);
        while(rs.next()){
        // step 4: we add a paragraph to the document
                        document.add(new Paragraph(rs.getString("n.PLemma"), new Font(Font.TIMES_ROMAN, 28)));

         Table table = new Table(4);
         table.addCell(new Cell("Belegnummer"));
         table.addCell(new Cell("Belegform"));
         table.addCell(new Cell("Datierung"));
         table.addCell(new Cell("Sigle: Variante"));

           out.println("<tr><td colspan=4><a href=\"namenkommentar.jsp?ID="+rs.getString("n.ID")+"\"><h1>"+rs.getString("n.PLemma")+"</h1></a></td></tr>");
           int id = rs.getInt("n.ID");
         Statement st2 = cn.createStatement();
          ResultSet rs2 = st2.executeQuery("SELECT einzelbeleg.ID, einzelbeleg.Belegnummer, einzelbeleg.Belegform"
                             +", person.ID, person.Standardname"
                             +", einzelbeleg.VonTag, einzelbeleg.VonMonat, einzelbeleg.VonJahr, einzelbeleg.BisTag, einzelbeleg.BisMonat, einzelbeleg.BisJahr"
                             +" FROM einzelbeleg_hatnamenkommentar, (einzelbeleg LEFT JOIN einzelbeleg_hatperson ON einzelbeleg.ID = einzelbeleg_hatperson.EinzelbelegID) LEFT JOIN person ON einzelbeleg_hatperson.PersonID = person.ID"
                             +" WHERE einzelbeleg_hatnamenkommentar.NamenkommentarID = \""+id+"\""
                             +" AND einzelbeleg_hatnamenkommentar.EinzelbelegID = einzelbeleg.ID"
                             +" ORDER BY person.Standardname ASC");

         int count=0;
         String standardName = "";
        while ( rs2.next() ) {
        if(rs2.getString("person.Standardname")==null){
           if(!standardName.equals("-")){
             standardName = "-";
             out.println("<tr><td colspan=4><h2>"+DBtoHTML(standardName)+"</h1></td></tr>");

             document.add(table);
             document.add(new Paragraph("     " + standardName, new Font(Font.TIMES_ROMAN, 16)));

             table = new Table(4);
           }
        }
        else if(!rs2.getString("person.Standardname").equals(standardName)){
            standardName = rs2.getString("person.Standardname");
            out.println("<tr><td colspan=4><a href=\"person.jsp?ID="+rs2.getString("person.ID")+"\"><h2>"+DBtoHTML(standardName)+"</h2></a></td></tr>");
             document.add(table);
             document.add(new Paragraph("     " + standardName, new Font(Font.TIMES_ROMAN, 16)));
             table = new Table(4);
         }

        count++;
          if(count%2==0)out.println("<tr>");
          else out.println("<tr bgcolor='#AACCDD'>");

          out.println("<td><a href=\"einzelbeleg.jsp?ID="+rs2.getInt("einzelbeleg.ID")+"\">Beleg...</a></td>");
          out.println("<td>"+(rs2.getString("einzelbeleg.Belegform")==null?"&nbsp;":rs2.getString("einzelbeleg.Belegform"))+"</td>");
          out.println("<td> "+makeDate(rs2.getInt("einzelbeleg.VonTag"), rs2.getInt("einzelbeleg.VonMonat"), rs2.getInt("einzelbeleg.VonJahr"))+" - "+makeDate(rs2.getInt("einzelbeleg.BisTag"), rs2.getInt("einzelbeleg.BisMonat"), rs2.getInt("einzelbeleg.BisJahr"))+"</td>");

          Statement st3 = cn.createStatement();
          ResultSet rs3 = st3.executeQuery("Select e.Variante, u.Sigle from einzelbeleg_textkritik e, ueberlieferung_edition u where e.EinzelbelegID=" + rs2.getString("einzelbeleg.ID") +" and e.HandschriftID=u.UeberlieferungID");

          out.println("<td><ul>");
          String sigle = "";

          while(rs3.next()){
            out.println("<li>"+rs3.getString("u.Sigle") + ": " + rs3.getString("e.Variante")+"</li>");
            sigle += "\n"+rs3.getString("u.Sigle") + ": " + rs3.getString("e.Variante");
          }

          out.println("</ul></td></tr>");

                   table.addCell(new Cell(rs2.getString("einzelbeleg.ID")));
                   table.addCell(new Cell((rs2.getString("einzelbeleg.Belegform")==null?"&nbsp;":rs2.getString("einzelbeleg.Belegform"))));
         table.addCell(new Cell(makeDate(rs2.getInt("einzelbeleg.VonTag"), rs2.getInt("einzelbeleg.VonMonat"), rs2.getInt("einzelbeleg.VonJahr"))+" - "+makeDate(rs2.getInt("einzelbeleg.BisTag"), rs2.getInt("einzelbeleg.BisMonat"), rs2.getInt("einzelbeleg.BisJahr"))));
         table.addCell(new Cell(sigle));

        }
        document.add(table);
        }
      }
      catch (Exception e) {
        out.println(e);
      }
      out.println("</table>\n");

%>

<%

// step 5: we close the document
document.close();

// step 6: we output the writer as bytes to the response output
out.println("<a href='../.."+file+"'>Download</a>");
%>
