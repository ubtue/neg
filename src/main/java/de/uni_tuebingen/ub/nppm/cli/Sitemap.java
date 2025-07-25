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
import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;

public class Sitemap extends AbstractBase {

    private static DocumentBuilderFactory docFactory;
    private static DocumentBuilder docBuilder;
    private static Document doc;
    private static Element rootElement;
    private static String outputPath;
    private static boolean outputPretty = false;
    private static String resolverBaseUrl = "https://nppm.ub.uni-tuebingen.de/id/";

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
        InitDocument();
        AddQuellen();
        AddPersons();
        AddEinzelbelege();
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

    private static void AddEntry(String persistentIdentifier, Date lastmodDate) throws Exception {
        Element urlElement = doc.createElement("url");
        Element locElement = doc.createElement("loc");
        locElement.setTextContent(resolverBaseUrl + persistentIdentifier);
        urlElement.appendChild(locElement);
        if (lastmodDate != null) {
            Element lastmodElement = doc.createElement("lastmod");
            lastmodElement.setTextContent(lastmodDate.toString());
            urlElement.appendChild(lastmodElement);
        }
        rootElement.appendChild(urlElement);
    }

    private static void AddEinzelbelege() throws Exception {
        List list = EinzelbelegDB.getList();
        for (Object object : list) {
            Einzelbeleg einzelbeleg = (Einzelbeleg) object;
            if (einzelbeleg.getQuelle() != null && einzelbeleg.getQuelle().getZuVeroeffentlichen() > 0) {
                String persistentIdentifier = "B" + einzelbeleg.getId().toString();
                Date lastmodDate = einzelbeleg.getLetzteAenderung();
                AddEntry(persistentIdentifier, lastmodDate);
            }
        }
    }

    private static void AddNamen() throws Exception {
        List list = LemmaDB.getList();
        for (Object object: list) {
            MghLemma lemma = (MghLemma)object;
            String persistentIdentifier = "M" + lemma.getId();
            Date lastmodDate = lemma.getLetzteAenderung();
            AddEntry(persistentIdentifier, lastmodDate);
        }
    }

    private static void AddPersons() throws Exception {
        List list = PersonDB.getListPersonPublic();
        for (Object object : list) {
            Person person = (Person) object;

            String persistentIdentifier = "P" + person.getId().toString();
            Date lastmodDate = person.getLetzteAenderung();
            AddEntry(persistentIdentifier, lastmodDate);
        }
    }

    private static void AddQuellen() throws Exception {
        List list = QuelleDB.getList();
        for (Object object : list) {
            Quelle quelle = (Quelle) object;
            if (quelle.getZuVeroeffentlichen() > 0) {
                String persistentIdentifier = "Q" + quelle.getId().toString();
                Date lastmodDate = quelle.getLetzteAenderung();
                AddEntry(persistentIdentifier, lastmodDate);
            }
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
