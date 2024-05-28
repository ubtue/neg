package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import de.uni_tuebingen.ub.nppm.model.Content.Context;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.Session;

public class ContentDB extends AbstractBase {

    public static void createHtmlFile(String fileName, Content.Context context, String language) throws Exception {
        String htmlTemplate = "<!DOCTYPE html><html><head><title>Empty HTML</title></head><body></body></html>";
        byte[] contentBytes = htmlTemplate.getBytes("UTF-8");
        Content content = new Content(fileName, "text/html", contentBytes, context, language);
        putToDatabase(content);

    }

    public static void updateHtmlFile(Content content, String newHtmlContent) throws Exception {
        String htmlTemplate = "<!DOCTYPE html><html><head><title>Updated HTML</title></head><body>" + newHtmlContent + "</body></html>";
        byte[] contentBytes = htmlTemplate.getBytes("UTF-8");
        content.setContent(contentBytes);
        saveOrUpdate(content);
    }

    public static void putToDatabase(Content dataContent) throws Exception {
        try ( Session session = getSession()) {
            session.beginTransaction();
            session.save(dataContent);
            session.getTransaction().commit();
        }
    }

    public static void saveFile(String path, String name, String content_Type, Context context) throws Exception {
        try ( Session session = getSession()) {
            byte[] contentBytes = readBytesFromFile(path);
            Content content = new Content(name, content_Type, contentBytes, context);
            putToDatabase(content);
        }
    }

    //überladet nur zur zeit
    public static void saveFile(String path, String name, String content_Type, Context context, String language) throws Exception {
        try ( Session session = getSession()) {
            byte[] contentBytes = readBytesFromFile(path);
            Content content = new Content(name, content_Type, contentBytes, context, language);
            putToDatabase(content);
        }
    }

    public static byte[] readBytesFromFile(String filePath) throws Exception {
        File inputFile = new File(filePath);
        try ( FileInputStream inputStream = new FileInputStream(inputFile)) {
            byte[] fileBytes = new byte[(int) inputFile.length()];
            inputStream.read(fileBytes);
            return fileBytes;
        }
    }

    public static Content getById(int id) throws Exception {
        return AbstractBase.getById(id, Content.class);
    }

    public static Content getByName(String name) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myContent = criteria.from(Content.class);
            criteria.select(myContent);
            criteria.where(builder.equal(myContent.get(Content_.NAME), name));
            Content content = session.createQuery(criteria).getSingleResult();
            return content;
        }
    }

    public static Content getFirstResultByName(String name) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root<Content> root = criteria.from(Content.class);
            criteria.select(root);
            criteria.where(builder.equal(root.get(Content_.NAME), name));

            List<Content> resultList = session.createQuery(criteria).getResultList();

            if (resultList.isEmpty()) {
                return null;
            } else if (resultList.size() > 1) {
                //Return first result
                return resultList.get(0);
            } else {
                return resultList.get(0);
            }
        }
    }

    public static Content getByNameAndLanguage(String name, String language) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myContent = criteria.from(Content.class);
            criteria.select(myContent);
            criteria.where(
                    builder.and(
                            builder.equal(myContent.get(Content_.NAME), name),
                            builder.equal(myContent.get(Content_.LANGUAGE), language)
                    )
            );

            Content content = session.createQuery(criteria).getSingleResult();
            return content;
        }
    }

    public static List<Content> getList() throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myContent = criteria.from(Content.class);
            criteria.getOrderList();
            List<Content> contents = (List<Content>) session.createQuery(criteria).list();
            return contents;
        }
    }

    public static List<Content> getList(String context) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root<Content> myContent = criteria.from(Content.class);
            criteria.select(myContent);

            // Filter hinzufügen basierend auf dem übergebenen Kontext
            if (context != null && !context.isEmpty()) {
                criteria.where(builder.equal(myContent.get("context"), Context.valueOf(context)));
            }

            List<Content> contents = session.createQuery(criteria).getResultList();
            return contents;
        }
    }

    // unused function for future use ...
    public static void copyPicturesFromDatabaseTableToTempFolder(String outputDirectory) throws Exception {
        List<Content> pictures = ContentDB.getList();
        for (Content ic : pictures) {
            String name = ic.getName();
            String filePathToSave = outputDirectory + name;
            byte[] photoBytes = ic.getContent();
            saveBytesToFile(filePathToSave, photoBytes);
        }
    }

    // unused function for future use ...
    public static void copyHTMLFromDatabaseTableToTempFolder(String outputDirectory, String name) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myContent = criteria.from(Content.class);
            criteria.select(myContent);
            criteria.where(builder.equal(myContent.get(Content_.NAME), name));
            Content content = session.createQuery(criteria).getSingleResult();
            String filePathToSave = outputDirectory + name;
            byte[] HtmlBytes = content.getContent();
            saveBytesToFile(filePathToSave, HtmlBytes);
        }
    }

    private static void saveBytesToFile(String filePath, byte[] fileBytes) throws Exception {
        try ( FileOutputStream outputStream = new FileOutputStream(filePath)) {
            outputStream.write(fileBytes);
        }
    }

    public static void deleteById(Integer id) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myImage = criteria.from(Content.class);
            criteria.select(myImage);
            criteria.where(builder.equal(myImage.get(Content_.ID), id));
            Content image = session.createQuery(criteria).getSingleResult();
            session.beginTransaction();
            session.delete(image);
            session.getTransaction().commit();
            session.close();
        }
    }

    public static void deleteByName(String name) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myImage = criteria.from(Content.class);
            criteria.select(myImage);
            criteria.where(builder.equal(myImage.get(Content_.NAME), name));
            Content image = session.createQuery(criteria).getSingleResult();
            session.beginTransaction();
            session.delete(image);
            session.getTransaction().commit();
        }
    }

    public static void deleteByNameAndLanguage(String name, String language) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myImage = criteria.from(Content.class);
            criteria.select(myImage);
            criteria.where(
                    builder.and(
                            builder.equal(myImage.get(Content_.NAME), name),
                            builder.equal(myImage.get(Content_.LANGUAGE), language)
                    )
            );
            Content image = session.createQuery(criteria).getSingleResult();
            session.beginTransaction();
            session.delete(image);
            session.getTransaction().commit();
        }
    }

    //Search if name exists in database
    public static boolean searchName(String name) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root picture = criteria.from(Content.class);
            criteria.select(picture);
            criteria.where(builder.equal(picture.get(Content_.NAME), name));
            List<Content> pictures = (List<Content>) session.createQuery(criteria).list();
            return !pictures.isEmpty();
        }
    }

    //Search if name and language exists in database
    public static boolean searchNameAndLanguage(String name, String language) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root<Content> picture = criteria.from(Content.class);
            criteria.select(picture);
            criteria.where(
                    builder.and(
                            builder.equal(picture.get(Content_.NAME), name),
                            builder.equal(picture.get(Content_.LANGUAGE), language)
                    )
            );
            List<Content> pictures = session.createQuery(criteria).getResultList();
            return !pictures.isEmpty();
        }
    }

    //Search if ID exists in database
    public static boolean searchId(int id) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root picture = criteria.from(Content.class);
            criteria.select(picture);
            criteria.where(builder.equal(picture.get(Content_.ID), id));
            List<Content> pictures = (List<Content>) session.createQuery(criteria).list();
            return !pictures.isEmpty();
        }
    }

    public static void saveOrUpdate(Content content) throws Exception {
        try ( Session session = getSession()) {
            session.getTransaction().begin();
            session.saveOrUpdate(content);
            session.getTransaction().commit();
        }
    }

    public static String getCookieLanguage(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        String selectedLanguage = "dontDelete";  // Standardwert, wenn kein Cookie gesetzt ist
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("selectedLanguage")) {
                    selectedLanguage = cookie.getValue();
                    break;
                }
            }
        }
        return selectedLanguage;
    }
}
