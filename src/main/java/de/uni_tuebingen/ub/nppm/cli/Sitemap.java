package de.uni_tuebingen.ub.nppm.cli;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import de.uni_tuebingen.ub.nppm.db.PersonDB;
import de.uni_tuebingen.ub.nppm.model.Person;

public class Sitemap extends AbstractBase {

    private static DocumentBuilderFactory docFactory;
    private static DocumentBuilder docBuilder;
    private static Document doc;
    private static Element rootElement;
    private static String outputPath;
    private static boolean outputPretty = false;

    /**
     * Generate XML Sitemap
     *
     * For Example + Format Description, see:
     * https://www.sitemaps.org/de/protocol.html
     */
    public static void main (String[] args) throws Exception {
        // Process args
        switch (args.length) {
            case 1:
                outputPath = args[0];
                break;
            case 2:
                if (!args[0].equals("--pretty"))
                    Usage("When 2 parameters are given, the first one must be \"--pretty\"!");
                outputPretty = true;
                outputPath = args[1];
                break;
            default:
                Usage("Usage: Sitemap [--pretty] xml_output_path");
        }

        // Load Properties (DB access credentials, etc.)
        LoadProperties();

        // Generate + write XML document
        // So far we only add public persons since this is a first sample.
        // Other public pages (Einzelbeleg, Namen, Quellen, News pages etc.) can be added later.
        InitDocument();
        AddPersons();
        WriteOutput();

        // Exit successfully (we need this or the program will hang forever)
        System.exit(0);
    }

    private static void InitDocument() throws ParserConfigurationException {
        docFactory = DocumentBuilderFactory.newInstance();
        docBuilder = docFactory.newDocumentBuilder();
        doc = docBuilder.newDocument();
        rootElement = doc.createElement("urlset");
        rootElement.setAttribute("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9");
        doc.appendChild(rootElement);
    }

    private static void AddPersons() throws Exception {
        List list = PersonDB.getListPersonPublic();
        for (Object object : list) {
            Person person = (Person) object;
            person.getStandardname();

            Element urlElement = doc.createElement("url");
            Element locElement = doc.createElement("loc");
            // Note: The following URL should be changed as soon as we have
            //       a redirect page for persistent identifiers
            locElement.setTextContent("https://neg.ub.uni-tuebingen.de/gast/person?ID=" + person.getId().toString());
            urlElement.appendChild(locElement);

            Date lastmodDate = person.getLetzteAenderung();
            if (lastmodDate != null) {
                Element lastmodElement = doc.createElement("lastmod");
                lastmodElement.setTextContent(lastmodDate.toString());
                urlElement.appendChild(lastmodElement);
            }

            rootElement.appendChild(urlElement);
        }
    }

    private static void WriteOutput() throws IOException, TransformerException {
        try (FileOutputStream output = new FileOutputStream(outputPath)) {
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();

            if (outputPretty)
                transformer.setOutputProperty(OutputKeys.INDENT, "yes");

            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(output);
            transformer.transform(source, result);
        }
    }
}
