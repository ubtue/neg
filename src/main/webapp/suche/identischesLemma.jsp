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

Document document = new Document();

 int limit=0;
 int offset = 5;
  try{
      limit = Integer.parseInt(request.getParameter("limit"));
  }catch(Exception ex){;}

  String file = "/print/" +request.getParameter("form")+ request.getParameter("Belegform").replace('%','_') + "download.rtf";

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
        Statement st2 = cn.createStatement();

        if(request.getParameter("Belegform").equals("")){
        
          ResultSet rs2 = st2.executeQuery("SELECT einzelbeleg.ID, einzelbeleg.Belegnummer, einzelbeleg.Belegform"
                              +", einzelbeleg.VonTag, einzelbeleg.VonMonat, einzelbeleg.VonJahr, einzelbeleg.BisTag, einzelbeleg.BisMonat, einzelbeleg.BisJahr"
                             +" FROM einzelbeleg"
                             +" WHERE not exists (select eh.EinzelbelegID from neg_final.einzelbeleg_hatnamenkommentar eh where einzelbeleg.ID=eh.EinzelbelegID) ORDER BY einzelbeleg.ID");

         int count=0;
         String standardName = "";
        while ( rs2.next() ) {

        count++;
          if(count%2==0)out.println("<tr>");
          else out.println("<tr bgcolor='#AACCDD'>");

          out.println("<td><a href=\"einzelbeleg.jsp?ID="+rs2.getInt("einzelbeleg.ID")+"\">Beleg...</a></td>");
          out.println("<td>"+(rs2.getString("einzelbeleg.Belegform")==null?"&nbsp;":rs2.getString("einzelbeleg.Belegform"))+"</td>");
          out.println("<td> "+makeDate(rs2.getInt("einzelbeleg.VonTag"), rs2.getInt("einzelbeleg.VonMonat"), rs2.getInt("einzelbeleg.VonJahr"))+" - "+makeDate(rs2.getInt("einzelbeleg.BisTag"), rs2.getInt("einzelbeleg.BisMonat"), rs2.getInt("einzelbeleg.BisJahr"))+"</td>");

		out.println("</tr>");

          }


      out.println("</table>\n");
        
        }else 
        {
        rs = st.executeQuery("SELECT n.ID, n.PLemma"
                             +" FROM einzelbeleg_hatnamenkommentar eh2, einzelbeleg e2, namenkommentar n"
                             +" WHERE e2.Belegform LIKE '" +request.getParameter("Belegform")+"' AND eh2.EinzelbelegID=e2.ID AND n.ID=eh2.NamenkommentarID group by n.ID order by n.PLemma");// limit "+limit+"," + offset);
        while(rs.next()){
        // step 4: we add a paragraph to the document
                        document.add(new Paragraph(rs.getString("n.PLemma"), new Font(Font.TIMES_ROMAN, 28)));

        float [] widths = {0.1f,0.1f,0.1f,0.1f,0.2f,0.1f,0.1f,0.1f};

         Table table = new Table(widths.length);
         table.setWidths(widths);
   //      table.addCell(new Cell("Belegnummer"));
         table.addCell(new Cell(new Paragraph("Belegform", new Font(Font.TIMES_ROMAN, 8))));
         table.addCell(new Cell(new Paragraph("Datierung", new Font(Font.TIMES_ROMAN, 8))));
            table.addCell(new Cell(new Paragraph("Sigle", new Font(Font.TIMES_ROMAN, 8))));
            table.addCell(new Cell(new Paragraph("Variante", new Font(Font.TIMES_ROMAN, 8))));
            table.addCell(new Cell(new Paragraph("Textzeuge", new Font(Font.TIMES_ROMAN, 8))));
            table.addCell(new Cell(new Paragraph("Schriftheimat", new Font(Font.TIMES_ROMAN, 8))));
            table.addCell(new Cell(new Paragraph("Bib.heimat", new Font(Font.TIMES_ROMAN, 8))));
            table.addCell(new Cell(new Paragraph("Datierung", new Font(Font.TIMES_ROMAN, 8))));


           out.println("<tr><td colspan=4><a href=\"namenkommentar.jsp?ID="+rs.getString("n.ID")+"\"><h1>"+rs.getString("n.PLemma")+"</h1></a></td></tr>");
           int id = rs.getInt("n.ID");
       //  Statement st2 = cn.createStatement();
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

             table = new Table(widths.length);
         table.setWidths(widths);
           }
        }
        else if(!rs2.getString("person.Standardname").equals(standardName)){
            standardName = rs2.getString("person.Standardname");
            out.println("<tr><td colspan=4><a href=\"person.jsp?ID="+rs2.getString("person.ID")+"\"><h2>"+DBtoHTML(standardName)+"</h2></a></td></tr>");
             document.add(table);
             document.add(new Paragraph("     " + standardName, new Font(Font.TIMES_ROMAN, 16)));
             table = new Table(widths.length);
         table.setWidths(widths);
         }

        count++;
          if(count%2==0)out.println("<tr>");
          else out.println("<tr bgcolor='#AACCDD'>");

          out.println("<td><a href=\"einzelbeleg.jsp?ID="+rs2.getInt("einzelbeleg.ID")+"\">Beleg...</a></td>");
          out.println("<td>"+(rs2.getString("einzelbeleg.Belegform")==null?"&nbsp;":rs2.getString("einzelbeleg.Belegform"))+"</td>");
          out.println("<td> "+makeDate(rs2.getInt("einzelbeleg.VonTag"), rs2.getInt("einzelbeleg.VonMonat"), rs2.getInt("einzelbeleg.VonJahr"))+" - "+makeDate(rs2.getInt("einzelbeleg.BisTag"), rs2.getInt("einzelbeleg.BisMonat"), rs2.getInt("einzelbeleg.BisJahr"))+"</td>");

            Cell eb = new Cell(new Paragraph((rs2.getString("einzelbeleg.Belegform")==null?"&nbsp;":rs2.getString("einzelbeleg.Belegform")), new Font(Font.TIMES_ROMAN, 8)));
            table.addCell(eb);

             Cell dat = new Cell(new Paragraph(makeDate(rs2.getInt("einzelbeleg.VonTag"), rs2.getInt("einzelbeleg.VonMonat"), rs2.getInt("einzelbeleg.VonJahr"))+" - "+makeDate(rs2.getInt("einzelbeleg.BisTag"), rs2.getInt("einzelbeleg.BisMonat"), rs2.getInt("einzelbeleg.BisJahr")), new Font(Font.TIMES_ROMAN, 8)));
             table.addCell(dat);


          Statement st3 = cn.createStatement();

          ResultSet rs3 = st3.executeQuery("Select u.Sigle, e.Variante, h.Bibliothekssignatur, e.handschriftID, h.ID, hu.VonTag, hu.VonMonat, hu.VonJahr, hu.BisTag, hu.BisMonat, hu.BisJahr, s1.Bezeichnung, s2.Bezeichnung  from einzelbeleg_textkritik e, ueberlieferung_edition u, handschrift h, handschrift_ueberlieferung hu, selektion_ort s1, selektion_ort s2 where e.EinzelbelegID=" + rs2.getString("einzelbeleg.ID") +" and hu.ID=e.handschriftID and hu.handschriftID=h.ID and e.handschriftID=u.ueberlieferungID and e.editionID=u.editionID and s1.ID=hu.Bibliotheksheimat AND s2.ID=hu.Schriftheimat");

          out.println("<td><table cellpadding=2 style=\"font-size:8pt\">");
          String sigle = "";
          boolean first=true;

          int belegCount =0;


          while(rs3.next()){
          belegCount++;
            if(first){
            first=false;
            out.println("<tr><th><b>Sigle</b></th>");
            out.println("<th><b>Variante</b></th>");
            out.println("<th><b>Textzeuge</b></th>");
            out.println("<th><b>Schriftheimat</b></th>");
            out.println("<th><b>Bib.heimat</b></th>");
          out.println("<th><b>Datierung</b></th></tr>");


            }
            else          {
            table.addCell("");
                    table.addCell("");
            }

            out.println("<tr><td>"+rs3.getString("u.Sigle") + "</td>");
            out.println("<td>" + rs3.getString("e.Variante")+"</td>");
            out.println("<td><a href=\"handschrift.jsp?ID="+rs3.getString("h.ID")+"\"/><div style=\"font-size:8pt\">" + rs3.getString("h.Bibliothekssignatur")+"</div></a></td>");
            out.println("<td>" + rs3.getString("s2.Bezeichnung")+"</td>");
            out.println("<td>" + rs3.getString("s1.Bezeichnung")+"</td>");
            String date =  makeDate(rs3.getInt("hu.VonTag"), rs3.getInt("hu.VonMonat"), rs3.getInt("hu.VonJahr"))+" - "+makeDate(rs3.getInt("hu.BisTag"), rs3.getInt("hu.BisMonat"), rs3.getInt("hu.BisJahr"));
          out.println("<td> "+date+"</td></tr>");

                       table.addCell(new Cell(new Paragraph(rs3.getString("u.Sigle"), new Font(Font.TIMES_ROMAN, 8))));
         table.addCell(new Cell(new Paragraph(rs3.getString("e.Variante"), new Font(Font.TIMES_ROMAN, 8))));
       table.addCell(new Cell(new Paragraph(rs3.getString("h.Bibliothekssignatur"), new Font(Font.TIMES_ROMAN, 8))));
     table.addCell(new Cell(new Paragraph(rs3.getString("s2.Bezeichnung"), new Font(Font.TIMES_ROMAN, 8))));
     table.addCell(new Cell(new Paragraph(rs3.getString("s1.Bezeichnung"), new Font(Font.TIMES_ROMAN, 8))));
      table.addCell(new Cell(new Paragraph(date, new Font(Font.TIMES_ROMAN, 8))));

          }
          if(belegCount==0){
                                  table.addCell("");
         table.addCell("");
       table.addCell("");
     table.addCell("");
     table.addCell("");
      table.addCell("");

          }
          else{
            eb.setRowspan(belegCount);
            dat.setRowspan(belegCount);
          }

          out.println("</table></td></tr>");


        }
        document.add(table);
        }}
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
