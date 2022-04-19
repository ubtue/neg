import java.sql.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

import java.io.*;

import java.util.*;

public class Import_SW {
	
	static String DBtoDB(String s) {
		  if (s!=null) {
		    s = s.replace("\'", "\\'");
		    s = s.replace("\"", "\\\"");
		  }
		  return s;
		}
	
	   public static void main(String args[])
	   {
try{
	

	       /*
	        * Ab hier folgt der Zugriff auf die Datenbank, hier könnte man auch einfach eine
	        * konkrete Datenbank einfügen
	        */

	       Class c = Class.forName("com.mysql.jdbc.Driver");
	       final Connection con = DriverManager.getConnection("jdbc:mysql://131.234.65.21:3306/neg_final","root","rsah9871");

	       final Statement stmt = con.createStatement();
	       
	       String file =  "C:\\namen.txt";
	       String tabelle = "selektion_sw_namenelemente";
	       
	       BufferedReader br = new BufferedReader(new FileReader(file));
	       
	       String s="";
	       while((s=br.readLine())!=null){
	       

           ResultSet rs = stmt.executeQuery("select * from "+tabelle+" where Bezeichnung='"+DBtoDB(s)+"'");
           if(!rs.next()){
        	   stmt.executeUpdate("insert into "+ tabelle + " (Bezeichnung) values ('"+DBtoDB(s)+"')");
        	   System.out.println(s);
           }
	       }
}catch(Exception ex){ex.printStackTrace();}
}
	   
//	   ALTER TABLE `neg_final`.`literatur` ADD COLUMN `inLitID` INTEGER UNSIGNED AFTER `GehoertGruppe`,
//	   ADD COLUMN `inBand` VARCHAR(45) AFTER `inLitID`;
}
