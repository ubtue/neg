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
    static protected Session Login() throws NamingException {
        javax.naming.InitialContext initialContext = new javax.naming.InitialContext();
        String smtpHost = (String) initialContext.lookup("java:comp/env/smtpHost");
        String smtpPort = (String) initialContext.lookup("java:comp/env/smtpPort");
        String smtpUser = (String) initialContext.lookup("java:comp/env/smtpUser");
        String smtpPassword = (String) initialContext.lookup("java:comp/env/smtpPassword");

        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.socketFactory.port", smtpPort);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPassword);
            }
        };
        return Session.getDefaultInstance(props, auth);
    }

    static public void Send(String senderMail, String senderName, String receiverAddresses, String subject, String message) throws NamingException {
        Session session = Login();

        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-Type", "text/html; charset=UTF-8");
            msg.addHeader("format", "flowed");
            msg.addHeader("Content-Transfer-Encoding", "8bit");

            msg.setFrom(new InternetAddress(senderMail, senderName));
            msg.setReplyTo(InternetAddress.parse(senderMail, false));
            msg.setSubject(subject);
            msg.setText(message);
            msg.setContent(message, "text/html; charset=UTF-8");
            msg.setSentDate(new Date());

            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiverAddresses, false));
            Transport.send(msg);
        } catch (Exception e) {
            System.out.println("Fehler beim senden der eMail");
        }
    }//end Send
}
