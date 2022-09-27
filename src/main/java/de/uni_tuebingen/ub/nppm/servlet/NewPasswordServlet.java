package de.uni_tuebingen.ub.nppm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import de.uni_tuebingen.ub.nppm.db.BenutzerDB;
import de.uni_tuebingen.ub.nppm.model.Benutzer;
import de.uni_tuebingen.ub.nppm.util.MailSender;
import de.uni_tuebingen.ub.nppm.util.SaltHash;


public class NewPasswordServlet extends HttpServlet {

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

    private void renewPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String URLuuid = request.getParameter("url_uuid"); //<input type hidden >---> form -->forgotPassword
        String URLemail = request.getParameter("url_email"); //<input type hidden >---> form -->forgotPassword
        String password = request.getParameter("newPassword");
        String repeatPassword = request.getParameter("repeatPassword");
        //check if email exist in database

        boolean emailIsRegistered = BenutzerDB.hasEmail(URLemail);
        if (!emailIsRegistered) {
            String[] message = new String[1];
            message[0] = "<h1 style=\"text-align: center;\">Fehler, E-mail Adresse ist nicht registriert versuchen sie einen Link mit einer anderen EMail Adresse zugenerieren</h1>";
            writeHTMLMessage(request, response, message);
        } else {
            Benutzer benutzer = BenutzerDB.getByMail(URLemail);
            if (password != null && !password.equals("") && repeatPassword.equals(password) && password.length() >= 6) {
                String databaseUUID = "";

                LocalDateTime pastDateTime = benutzer.getResetTokenValidUntil();
                LocalDateTime nowDateTime = LocalDateTime.now();
                long timeBetween = ChronoUnit.HOURS.between(pastDateTime, nowDateTime);

                //Get uuid from database
                databaseUUID = benutzer.getResetToken();

                if (emailIsRegistered == true && timeBetween < 24 && databaseUUID.equals(URLuuid)) {

                    SaltHash saltHash = new SaltHash();
                    String algorithm = "MD5";
                    byte[] salt = saltHash.createSalt();
                    String passHash = saltHash.generateHash(password, algorithm, salt);

                    benutzer.setSalt(saltHash.getSaltString());
                    benutzer.setPassword(passHash);
                    BenutzerDB.saveOrUpdate(benutzer);

                    String[] message = new String[2];
                    message[0] = "<h1 style=\"text-align: center;\">Passwort wurde neu gesetzt</h1>";
                    message[1] = "<h1 style=\"text-align: center;\"><a href=\"http://localhost:8080/neg/index1.jsp\">Zum Login</a></h1>";
                    writeHTMLMessage(request, response, message);

                } else { //User should generate a new Link
                    String[] message = new String[2];
                    message[0] = "<h1 style=\"text-align: center;\">Link ist nicht mehr gültig, bitte einen neuen Link generieren.</h1>";
                    message[1] = "<h1 style=\"text-align: center;\"><a href=\"http://localhost:8080/neg/forgotPassword\">Neuen Link generieren</a></h1>";
                    writeHTMLMessage(request, response, message);
                }

            } else if (!repeatPassword.equals(password)) {
                String[] message = new String[1];
                message[0] = "<h1 style=\"text-align: center;\">Passwort wiederholung stimmt nicht überein</h1>";
                writeHTMLMessage(request, response, message);
            }else if(password.length() < 6)
            {
                String[] message = new String[1];
                message[0] = "<h1 style=\"text-align: center;\">Passwort ist zu kurz, mindestlänge sind 6 Buchstaben</h1>";
                writeHTMLMessage(request, response, message);
            } else {
                LocalDateTime timeOfGeneratedUUID = benutzer.getResetTokenValidUntil();
                //resend link
                String myLinkString = "forgotPassword?varURLUUID=" + URLuuid + "&varURLEmail=" + URLemail + "&varURLTime=" + timeOfGeneratedUUID + "\"";
                RequestDispatcher dispatcher = request.getRequestDispatcher(myLinkString);
                dispatcher.forward(request, response);
            }
        }

    }//end sendLink()

    private void sendLink(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, Exception {
        LocalDateTime timeOfGeneratedUUID = LocalDateTime.now();
        //2. Generate UUID
        String uuid_content = String.valueOf(UUID.randomUUID());

        //1. take the e-mail Address from user
        String email = request.getParameter("email");
        //Check if E-Mail is reguistered in database
        boolean emailIsRegistered = BenutzerDB.hasEmail(email);

        if (email != null && !email.equals("") && emailIsRegistered == true) {

            response.setContentType("text/html");

            String myLinkString = "http://localhost:8080" + request.getContextPath() + "/forgotPassword?varURLUUID=" + URLEncoder.encode(uuid_content) + "&varURLEmail=" + URLEncoder.encode(email) + "&varURLTime=" + URLEncoder.encode(timeOfGeneratedUUID.toString());


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
            htmlMessage += "<a href=\"";
            htmlMessage += myLinkString;
            htmlMessage += "\">zurücksetzen</a>";
            htmlMessage += "</body>";
            htmlMessage += "</html>";

            // Get the session object
            MailSender sender = new MailSender();

            try {
                //write UUUID & timeOfGeneratedUUID in (database) table benutzer
                Benutzer benutzer = BenutzerDB.getByMail(email);
                benutzer.setResetToken(uuid_content);
                benutzer.setResetTokenValidUntil(timeOfGeneratedUUID);
                BenutzerDB.saveOrUpdate(benutzer);

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
            }
        } else if (emailIsRegistered != false) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("forgotPassword");
            dispatcher.forward(request, response);
        } else {
            String[] message = new String[1];
            message[0] = "<h1 style=\"text-align: center;\">Fehler, E-mail Adresse ist nicht registriert versuchen sie es mit einer anderen E-mail Adresse</h1>";
            writeHTMLMessage(request, response, message);
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSuchAlgorithmException, Exception {

        String URLuuid = request.getParameter("url_uuid"); //<input type hidden >---> form -->forgotPassword
        String URLemail = request.getParameter("url_email"); //<input type hidden >---> form -->forgotPassword

        if (URLuuid != null && !URLuuid.equals("") && URLemail != null && !URLemail.equals("")) {
            renewPassword(request, response);
        } else {
            sendLink(request, response);
        }
    }//end processRequest()

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
        } catch (Exception ex) {
            Logger.getLogger(de.uni_tuebingen.ub.nppm.servlet.NewPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(de.uni_tuebingen.ub.nppm.servlet.NewPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//end doPost()

}//end Class NewPasswordServlet
