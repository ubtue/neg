package de.uni_tuebingen.ub.nppm.util;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.NamingException;

public class MailSender {
    protected Session mailSession;
    
    //Methoden
    static protected Session login() throws NamingException
    {
        javax.naming.InitialContext initialContext = new javax.naming.InitialContext();
        String smtpHost = (String)initialContext.lookup("java:comp/env/emailHost");
        String smtpPort = (String)initialContext.lookup("java:comp/env/emailPort");
        String smtpUser = (String)initialContext.lookup("java:comp/env/emailUser");
        String smtpPassword = (String)initialContext.lookup("java:comp/env/emailPassword");
        
        Properties props = new Properties();        
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.socketFactory.port", smtpPort);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.port", smtpPort);
        
        props.put("mail.smtp.auth","true");
        Authenticator auth = new Authenticator()
        {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPassword);
            }

        }; //end O

        return Session.getDefaultInstance(props, auth);
    }
    
    static public void send(String senderMail, String senderName, String receiverAddresses, String subject, String message) throws NamingException
    {
        Session session = login();
        
        MimeMessage msg = new MimeMessage(session);
        try{
            msg.addHeader("Content-type", "text/HTML); charset=UTF-8");
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.addHeader("format", "flowed");
            msg.addHeader("Content-Transfer-Encoding", "8bit");
        
            msg.setFrom(new InternetAddress(senderMail, senderName));
            msg.setReplyTo(InternetAddress.parse(senderMail, false));
            msg.setSubject(subject, "UTF-8");
            msg.setText(message, "UTF-8");
            msg.setSentDate(new Date());
            
            
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiverAddresses, false));
            
            System.out.println("Versende E-Mail...");
            Transport.send(msg);
            System.out.println("E-Mail versendet");
        }
        catch(Exception e)
        {
            System.out.println("Fehler beim senden der eMail");
        }
        
    }//end send
}
