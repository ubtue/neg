package de.uni_tuebingen.ub.nppm.controller.test.base;

import de.uni_tuebingen.ub.nppm.mocks.CustomInitialContext;
import org.w3c.dom.*;
import java.io.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

public abstract class DBTest {
    public static final String PATH = "/var/lib/tomcat9/conf/Catalina/localhost/neg.xml"; 
    //Return Custom Context for Testing Environment
    protected javax.naming.InitialContext getTestContext() throws Exception {
        
        CustomInitialContext ctx = new CustomInitialContext();
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new File(PATH));
        XPath xPath = XPathFactory.newInstance().newXPath();

        Node valUrl = (Node) xPath.compile("//Environment[@name='sqlURL']").evaluate(document, XPathConstants.NODE);
        Node valUser = (Node) xPath.compile("//Environment[@name='sqlUser']").evaluate(document, XPathConstants.NODE);
        Node valPassword = (Node) xPath.compile("//Environment[@name='sqlPassword']").evaluate(document, XPathConstants.NODE);
        
        ctx.bind("java:comp/env/sqlURL", valUrl.getAttributes().getNamedItem("value").getNodeValue());
        ctx.bind("java:comp/env/sqlUser", valUser.getAttributes().getNamedItem("value").getNodeValue());
        ctx.bind("java:comp/env/sqlPassword", valPassword.getAttributes().getNamedItem("value").getNodeValue());
        
        return ctx;
    }
}
