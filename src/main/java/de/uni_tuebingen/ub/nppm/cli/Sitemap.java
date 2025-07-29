package de.uni_tuebingen.ub.nppm.cli;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.ArrayList;
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
import de.uni_tuebingen.ub.nppm.model.interfaces.*;
import java.time.LocalDateTime;

public class Sitemap extends AbstractBase {

    private static DocumentBuilderFactory docFactory;
    private static DocumentBuilder docBuilder;
    private static String outputDirectory;
    private static boolean outputPretty = false;
    private static final String BASE_URL = "https://nppm.ub.uni-tuebingen.de/";
    private static final String BASE_URL_RESOLVER = "id/";
    private static final String BASE_URL_SITEMAPS = "sitemaps/";
    private static List<String> sitemaps = new ArrayList<>();

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
                outputDirectory = args[0];
                break;
            case 2:
                if (!args[0].equals("--pretty"))
                    Usage("When 2 parameters are given, the first one must be \"--pretty\"!");
                outputPretty = true;
                outputDirectory = args[1];
                break;
            default:
                Usage("Usage: Sitemap [--pretty] output_directory");
        }

        // create output directory if it does not exist
        File dir = new File(outputDirectory);
        if (!dir.exists()) {
            dir.mkdir();
        }

        // Load Properties (DB access credentials, etc.)
        LoadProperties();

        // Generate + write XML documents
        // Since bots will struggle with single files > 10MB, we need to generate an Index file and split into subfiles.
        GenerateBase();
        GenerateQuellen();
        GeneratePersons();
        GenerateNamen();
        GenerateEinzelbelege();
        GenerateIndex();

        // Exit successfully (we need this or the program will hang forever)
        System.exit(0);
    }

    private static Document InitDocument(String rootElementName) throws ParserConfigurationException {
        docFactory = DocumentBuilderFactory.newInstance();
        docBuilder = docFactory.newDocumentBuilder();
        Document document = docBuilder.newDocument();
        Element rootElement = document.createElement(rootElementName);
        rootElement.setAttribute("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9");
        document.appendChild(rootElement);
        return document;
    }

    private static Document InitSitemapIndexDocument() throws ParserConfigurationException {
        return InitDocument("sitemapindex");
    }

    private static Document InitSitemapDocument() throws ParserConfigurationException {
        return InitDocument("urlset");
    }

    private static void AddEntry(Document document, String url) throws Exception {
        AddEntry(document, url, null);
    }

    private static void AddEntry(Document document, String url, Date lastmodDate) throws Exception {
        Element urlElement = document.createElement("url");
        Element locElement = document.createElement("loc");
        locElement.setTextContent(BASE_URL + url);
        urlElement.appendChild(locElement);
        if (lastmodDate != null) {
            Element lastmodElement = document.createElement("lastmod");
            lastmodElement.setTextContent(lastmodDate.toString());
            urlElement.appendChild(lastmodElement);
        }
        document.getDocumentElement().appendChild(urlElement);
    }

    private static void AddEntryWithPersistentIdentifier(Document document, PersistentIdentifier persistentIdentifier, Date lastmodDate) throws Exception {
        AddEntry(document, BASE_URL_RESOLVER + persistentIdentifier.getPersistentIdentifier(), lastmodDate);
    }

    private static void AddSitemap(Document document, String filename) throws Exception {
        Element sitemapElement = document.createElement("sitemap");
        Element locElement = document.createElement("loc");
        locElement.setTextContent(BASE_URL + BASE_URL_SITEMAPS + filename);
        sitemapElement.appendChild(locElement);
        Element lastmodElement = document.createElement("lastmod");
        lastmodElement.setTextContent(LocalDateTime.now().toString());
        sitemapElement.appendChild(lastmodElement);
        document.getDocumentElement().appendChild(sitemapElement);
    }

    private static void WriteDocument(Document document, String outputPath) throws IOException, TransformerException {
        try (FileOutputStream output = new FileOutputStream(outputPath)) {
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();

            if (outputPretty)
                transformer.setOutputProperty(OutputKeys.INDENT, "yes");

            DOMSource source = new DOMSource(document);
            StreamResult result = new StreamResult(output);
            transformer.transform(source, result);
        }
    }

    private static void GenerateAndRegisterSitemap(Document document, String filename) throws Exception {
        sitemaps.add(filename);
        WriteDocument(document, outputDirectory + "/" + filename);
    }

    private static void GenerateBase() throws Exception {
        Document document = InitSitemapDocument();

        // The base sitemap should contain general static pages
        List<String> pages = Arrays.asList(
            // Startseite
            "gast/infos?sharedHtml=start&current=start",

            // Hilfe
            "gast/infos?sharedHtml=hilfe",

            // Footer-Einträge
            "gast/infos?sharedHtml=ziele",
            "gast/infos?sharedHtml=datenbank",
            "gast/infos?sharedHtml=quellenliste",
            "gast/infos?sharedHtml=tagungen",
            "gast/infos?sharedHtml=mitglieder",
            "gast/infos?sharedHtml=projekte",
            "gast/infos?sharedHtml=publikationen"

            // Intentionally ommitted pages:
            // - Datenschutzerklärung
            // - Impressum
        );

        for (String page : pages) {
            AddEntry(document, page);
        }
        GenerateAndRegisterSitemap(document, "sitemap-base.xml");
    }

    private static void GenerateEinzelbelege() throws Exception {
        Document document = InitSitemapDocument();
        List list = EinzelbelegDB.getList();
        for (Object object : list) {
            Einzelbeleg einzelbeleg = (Einzelbeleg) object;
            if (einzelbeleg.getQuelle() != null && einzelbeleg.getQuelle().getZuVeroeffentlichen() > 0) {
                Date lastmodDate = einzelbeleg.getLetzteAenderung();
                AddEntryWithPersistentIdentifier(document, einzelbeleg, lastmodDate);
            }
        }
        GenerateAndRegisterSitemap(document, "sitemap-einzelbelege.xml");
    }

    private static void GenerateNamen() throws Exception {
        Document document = InitSitemapDocument();
        List list = LemmaDB.getList();
        for (Object object: list) {
            MghLemma lemma = (MghLemma)object;
            Date lastmodDate = lemma.getLetzteAenderung();
            AddEntryWithPersistentIdentifier(document, lemma, lastmodDate);
        }
        GenerateAndRegisterSitemap(document, "sitemap-namen.xml");
    }

    private static void GeneratePersons() throws Exception {
        Document document = InitSitemapDocument();
        List list = PersonDB.getListPersonPublic();
        for (Object object : list) {
            Person person = (Person) object;
            Date lastmodDate = person.getLetzteAenderung();
            AddEntryWithPersistentIdentifier(document, person, lastmodDate);
        }
        GenerateAndRegisterSitemap(document, "sitemap-personen.xml");
    }

    private static void GenerateQuellen() throws Exception {
        Document document = InitSitemapDocument();
        List list = QuelleDB.getList();
        for (Object object : list) {
            Quelle quelle = (Quelle) object;
            if (quelle.getZuVeroeffentlichen() > 0) {
                Date lastmodDate = quelle.getLetzteAenderung();
                AddEntryWithPersistentIdentifier(document, quelle, lastmodDate);
            }
        }
        GenerateAndRegisterSitemap(document, "sitemap-quellen.xml");
    }

    private static void GenerateIndex() throws Exception {
        Document document = InitSitemapIndexDocument();
        for (String sitemap : sitemaps) {
            AddSitemap(document, sitemap);
        }
        WriteDocument(document, outputDirectory + "/sitemapIndex.xml");
    }
}
