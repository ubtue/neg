/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package de.uni_tuebingen.ub.nppm.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author root
 */
@WebServlet(name = "NewPasswordServlet", urlPatterns = {"/neg/NewPasswordServlet"})
public class NewPasswordServlet extends HttpServlet {

    //Class variables
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    protected Connection getDbConnection() throws ClassNotFoundException, NamingException, SQLException {
        // Access to Database
        javax.naming.InitialContext initialContext = new javax.naming.InitialContext();
        String sqlURL = (String) initialContext.lookup("java:comp/env/sqlURL");
        String sqlUser = (String) initialContext.lookup("java:comp/env/sqlUser");
        String sqlPassword = (String) initialContext.lookup("java:comp/env/sqlPassword");

        String sqlDriver = "com.mysql.jdbc.Driver";
        Class.forName(sqlDriver);
        return DriverManager.getConnection(sqlURL, sqlUser, sqlPassword);  //retuns an Access Object to Database
    }

    private void closeDbConnection() {
        try {
            if (null != rs) {
                rs.close();
            }
        } catch (SQLException ex) {
        }
        try {
            if (null != st) {
                st.close();
            }
        } catch (SQLException ex) {
        }
        try {
            if (null != cn) {
                cn.close();
            }
        } catch (SQLException ex) {
        }
    }

    private void writeHTMLMessage(HttpServletRequest request, HttpServletResponse response, String[] message) throws IOException {
        PrintWriter pw = response.getWriter();
        pw.println("<!DOCTYPE html>");
        pw.println("<html>");
        pw.println("<head>");
        pw.println("<title>Nomen et Gens</title>");
        pw.println("</head>");
        pw.println("<body>");
        for (int i = 0; i < message.length; i++) {
            pw.println(message[i]);
        }
        pw.println("</body>");
        pw.println("</html>");
    }

    //if Email is registered in Database
    private boolean isEmailRegistered(HttpServletRequest request, HttpServletResponse response, String email) {
        try {
            cn = getDbConnection();
            st = cn.createStatement();
            String sqlQuery = "SELECT * FROM benutzer WHERE EMail= \"" + email + "\";";
            rs = st.executeQuery(sqlQuery);
            if (rs.next()) {
                return true;
            } else {
                String[] message = new String[1];
                message[0] = "<h1 style=\"text-align: center;\">Fehler, E-mail Adresse ist nicht registriert versuchen sie es mit einer anderen E-mail Adresse</h1>";
                writeHTMLMessage(request, response, message);
                return false;
            }
        } catch (Exception e) {
            Logger.getLogger(NewPasswordServlet.class.getName()).log(Level.SEVERE, null, e);

        } finally {
            closeDbConnection();
        }
        return true;
    }

    private LocalDateTime databaseTimeStamp(HttpServletRequest request, HttpServletResponse response) {
        String URLuuid = request.getParameter("url_uuid"); //<input type hidden >---> form -->forgotPassword
        String URLemail = request.getParameter("url_email"); //<input type hidden >---> form -->forgotPassword 
        String URLtime = request.getParameter("url_timeStamp");        // <input type='hidden' name='url_timeStamp'
        String databaseTimeStamp = "";

        try {
            //get the Timestamp out of database, when the link was generated --> 24 Hours valid
            cn = getDbConnection();
            st = cn.createStatement();
            String sqlQuery_Timestamp = "SELECT ResetTokenValidUntil FROM benutzer WHERE EMail = '" + URLemail + "'";
            rs = st.executeQuery(sqlQuery_Timestamp);

            while (rs.next()) {
                databaseTimeStamp = rs.getString("ResetTokenValidUntil");
            }

            int year = Integer.parseInt(databaseTimeStamp.substring(0, 4));
            int month = Integer.parseInt(databaseTimeStamp.substring(5, 7));
            int day = Integer.parseInt(databaseTimeStamp.substring(8, 10));
            int hour = Integer.parseInt(databaseTimeStamp.substring(11, 13));
            int minute = Integer.parseInt(databaseTimeStamp.substring(14, 16));
            int second = Integer.parseInt(databaseTimeStamp.substring(17, 19));

            LocalDateTime pastDateTime = LocalDateTime.of(year, month, day, hour, minute, second);
            return pastDateTime;
        } catch (Exception e) {

        } finally {
            closeDbConnection();
        }
        return null;
    }//end databaseTimeStamp()

    private void renewPassword(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, NoSuchAlgorithmException {
        RequestDispatcher dispatcher = null;

        String URLuuid = request.getParameter("url_uuid"); //<input type hidden >---> form -->forgotPassword
        String URLemail = request.getParameter("url_email"); //<input type hidden >---> form -->forgotPassword 
        String URLtime = request.getParameter("url_timeStamp");        // <input type='hidden' name='url_timeStamp'

        String password = request.getParameter("newPassword");
        String repeatPassword = request.getParameter("repeatPassword");

        // if (password != null && !password.equals("") && repeatPassword != null && !repeatPassword.equals(""))
        if (password != null && !password.equals("") && repeatPassword.equals(password)) {
            String databaseUUID = "";

            //check if email exist in database
            boolean emailIsRegistered = isEmailRegistered(request, response, URLemail);

            try {

                LocalDateTime pastDateTime = databaseTimeStamp(request, response);
                LocalDateTime nowDateTime = LocalDateTime.now();
                long timeBetween = ChronoUnit.HOURS.between(pastDateTime, nowDateTime);

                //Get uuid from database
                cn = getDbConnection();
                st = cn.createStatement();
                String sqlQuery_UUID = "SELECT ResetToken FROM benutzer WHERE EMail = '" + URLemail + "'";
                rs = st.executeQuery(sqlQuery_UUID);

                while (rs.next()) {
                    databaseUUID = rs.getString("ResetToken");
                }

                String temp_1 = String.valueOf(emailIsRegistered);
                String temp_2 = String.valueOf(timeBetween);
                //if email & timestamp & uuui  are valid, then do renew password
                if (emailIsRegistered == true && timeBetween < 24 && databaseUUID.equals(URLuuid)) {
                  
                    SaltHash saltHash = new SaltHash();
                    String algorithm = "MD5";                   
                    byte[] salt = saltHash.createSalt();
                    String passHash = saltHash.generateHash(password, algorithm, salt);

                    //To-Do: neues Passwort setzen in Database ---> einfach, dann mit md5 und dann mit Salt und vielleicht noch mit pepper !!!
                    st = null;
                    rs = null;
                    st = cn.createStatement();

                    String sqlQuery_WriteSalt = "UPDATE benutzer SET Salt = '" + saltHash.getSaltString() + "'" + " where EMail = '" + URLemail + "'";
                    st.executeUpdate(sqlQuery_WriteSalt);

                    String sqlQuery_WriteNewPasswordHash = "UPDATE benutzer SET Password = '" + passHash + "'" + " where EMail = '" + URLemail + "'";
                    //   String sqlQuery_WriteNewPassword = "UPDATE benutzer SET Password = '" + password + "'" + " where EMail = '" + URLemail + "'";
                    st.executeUpdate(sqlQuery_WriteNewPasswordHash);

                    String[] message = new String[2];
                    message[0] = "<h1 style=\"text-align: center;\">Passwort wurde neu gesetzt</h1>";
                    message[1] = "<h1 style=\"text-align: center;\"><a href=\"http://localhost:8080/neg/index1.jsp\">Zum Login</a></h1>";
                    writeHTMLMessage(request, response, message);

                } else { //User should generate a new Link
                    String[] message = new String[2];
                    message[0] = "<h1 style=\"text-align: center;\">Link ist nicht mehr gültig, bitte einen neuen Link generieren.</h1>";
                    message[1] = "<h1 style=\"text-align: center;\"><a href=\"http://localhost:8080/neg/forgotPassword.jsp\">Neuen Link generieren</a></h1>";
                    writeHTMLMessage(request, response, message);
                }

            }//end try
            catch (ClassNotFoundException | SQLException | NamingException e) {
                Logger.getLogger(NewPasswordServlet.class.getName()).log(Level.SEVERE, null, e);
            } finally {
                closeDbConnection();
            }
        } else if (!repeatPassword.equals(password)) {
            String[] message = new String[1];
            message[0] = "<h1 style=\"text-align: center;\">Passwort wiederholung stimmt nicht überein</h1>";
            writeHTMLMessage(request, response, message);
        } else {
            LocalDateTime timeOfGeneratedUUID = databaseTimeStamp(request, response);
            //resend link
            String myLinkString = "forgotPassword.jsp?varURLUUID=" + URLuuid + "&varURLEmail=" + URLemail + "&varURLTime=" + timeOfGeneratedUUID + "\"";
            dispatcher = request.getRequestDispatcher(myLinkString);
            dispatcher.forward(request, response);
        }
    }//end sendLink()

    private void sendLink(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = null;
        LocalDateTime timeOfGeneratedUUID = LocalDateTime.now();
        //2. Generate UUID  
        String uuid_content = String.valueOf(UUID.randomUUID());

        //1. take the e-mail Address from user
        String email = request.getParameter("email");
        //Check if E-Mail is reguistered in database   
        boolean emailIsRegistered = isEmailRegistered(request, response, email);

        if (email != null && !email.equals("") && emailIsRegistered == true) {

            response.setContentType("text/html");

            String myLinkString = "href=\"http://localhost:8080/neg/forgotPassword.jsp?varURLUUID=" + uuid_content + "&varURLEmail=" + email + "&varURLTime=" + timeOfGeneratedUUID + "\"";

            //Message in usesers email
            String htmlMessage = "<html>";
            htmlMessage += "<head>";
            htmlMessage += "<meta charset=\"UTF-8\">";
            htmlMessage += "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">";
            htmlMessage += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
            htmlMessage += "</head>";
            htmlMessage += "<body>";
            htmlMessage += "<h1>Passwort zurücksetzen?</h1>";
            htmlMessage += "<p>Um Ihr Passwort zurückzusetzen, klicken Sie auf den Link</p>";
            htmlMessage += "<p>Der Link ist 24 Stunden gültig</p>";
            htmlMessage += "<a ";
            htmlMessage += myLinkString;
            htmlMessage += " >zurücksetzen</a>";
            htmlMessage += "</body>";
            htmlMessage += "</html>";

            HttpSession mySession = request.getSession();
            // Get the session object
            MailSender sender = new MailSender();

            try {
                //write UUUID & timeOfGeneratedUUID in (database) table benutzer  
                cn = getDbConnection();
                st = cn.createStatement();
                String sqlQuery_1 = "UPDATE benutzer SET ResetToken = '" + uuid_content + "' WHERE EMail = '" + email + "'";
                st.executeUpdate(sqlQuery_1);

                String sqlQuery_2 = "UPDATE benutzer SET ResetTokenValidUntil = '" + timeOfGeneratedUUID + "' WHERE EMail = '" + email + "'";
                st.executeUpdate(sqlQuery_2);

                //write in Servlet Succesfull created for the user
                String[] message = new String[1];
                message[0] = "<h1 style=\"text-align: center;\">Erfolgreich, bitte gehen Sie zu Ihrer E-mail und benutzen Sie den link.</h1>";
                writeHTMLMessage(request, response, message);
                sender.send("no-reply@ub.uni-tuebingen.de", "NeG Mailer", email, "Neues Passwort für NEG Zugang", htmlMessage);  //send message         
            } catch (Exception ex) {
                String errorMessage = ex.toString();
                String[] message = new String[1];
                message[0] = "<h1" + errorMessage + "  </h1>";
                writeHTMLMessage(request, response, message);
                Logger.getLogger(NewPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
                throw new ServletException(ex);
            } finally {
                closeDbConnection();
            }
        }//end  if(email!=null || !email.equals(""))  
        else if (emailIsRegistered != false) {
            dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
            dispatcher.forward(request, response);
            closeDbConnection();
        }
    }//end renewPassword

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSuchAlgorithmException {

        String URLuuid = request.getParameter("url_uuid"); //<input type hidden >---> form -->forgotPassword
        String URLemail = request.getParameter("url_email"); //<input type hidden >---> form -->forgotPassword

        if (URLuuid != null && !URLuuid.equals("") && URLemail != null && !URLemail.equals("")) {
            renewPassword(request, response);
        } else {
            sendLink(request, response);
        }
    }//end processRequest()

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(NewPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }//end doGet()

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(NewPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//end doPost()

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}//end Class NewPasswordServlet
