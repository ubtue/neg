import java.sql.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

import java.io.*;

import java.util.*;

public class Import_LitFK {
	   public static void main(String args[])throws Exception
	   {

	       /*
	        * Ab hier folgt der Zugriff auf die Datenbank, hier könnte man auch einfach eine
	        * konkrete Datenbank einfügen
	        */

	       Class c = Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	       final Connection con = DriverManager.getConnection("jdbc:odbc:neg_db");

	       final Statement stmt = con.createStatement();

           ResultSet rs = stmt.executeQuery("select * from tbl_literatur where not FK_Lit_ID is null");
           FileWriter fw = new FileWriter("neg_lit.sql");
           
           while(rs.next()){
        	   fw.write("Update Literatur set inLitID="+rs.getString("FK_Lit_ID")+", inBand='"+rs.getString("Lit_AufsatzBand")+"' where ID="+rs.getString("Lit_ID")+ ";");
           }
           fw.close();
	   }
	   
//	   ALTER TABLE `neg_final`.`literatur` ADD COLUMN `inLitID` INTEGER UNSIGNED AFTER `GehoertGruppe`,
//	   ADD COLUMN `inBand` VARCHAR(45) AFTER `inLitID`;
}
