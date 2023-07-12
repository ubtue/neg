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
import org.hibernate.Session;

public class ContentDB extends AbstractBase {

    public static void putToDatabase(Content imageContent) throws Exception {
        Session session = getSession();
        session.beginTransaction();
        session.save(imageContent);
        session.getTransaction().commit();
        session.close();
    }//end function

    public static void saveFile(String path, String name, String content_Type, Context context) throws Exception {
        Session session = getSession();
        byte[] contentBytes = readBytesFromFile(path);
        Content content = new Content(name, content_Type, contentBytes, context);
        putToDatabase(content);
        session.close();
    }//end function

    public static byte[] readBytesFromFile(String filePath) throws Exception {
        File inputFile = new File(filePath);
        FileInputStream inputStream = new FileInputStream(inputFile);
        byte[] fileBytes = new byte[(int) inputFile.length()];
        inputStream.read(fileBytes);
        inputStream.close();
        return fileBytes;
    }//end function

    public static Content getById(int id) throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
        Root myImage = criteria.from(Content.class);
        criteria.select(myImage);
        criteria.where(builder.equal(myImage.get(Content_.ID), id));
        Content content = session.createQuery(criteria).getSingleResult();
        session.close();
        return content;
    }//end function

    public static Content getByName(String name) throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
        Root myImage = criteria.from(Content.class);
        criteria.select(myImage);
        criteria.where(builder.equal(myImage.get(Content_.NAME), name));
        Content content = session.createQuery(criteria).getSingleResult();
        session.close();
        return content;
    }//end function

    public static List<Content> getList() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
        Root myImage = criteria.from(Content.class);
        criteria.getOrderList();
        List<Content> images = (List<Content>) session.createQuery(criteria).list();
        session.close();
        return images;
    }//end function

    public static List<Content> getList(String context) throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
        Root<Content> myImage = criteria.from(Content.class);
        criteria.select(myImage);

        // Filter hinzufügen basierend auf dem übergebenen Kontext
        if (context != null && !context.isEmpty()) {
            criteria.where(builder.equal(myImage.get("context"), Context.valueOf(context)));
        }

        List<Content> images = session.createQuery(criteria).getResultList();
        session.close();
        return images;
    }

    public static void copyPicturesFromDatabaseTableToTempFolder(String outputDirectory) throws Exception {
        Session session = getSession();
        List<Content> pictures = ContentDB.getList();
        for (Content ic : pictures) {
            String name = ic.getName();
            String filePathToSave = outputDirectory + name;
            byte[] photoBytes = ic.getContent();
            saveBytesToFile(filePathToSave, photoBytes);
        }
        session.close();
    }//end function

    // unused function for future use ...
    public static void copyHTMLFromDatabaseTableToTempFolder(String outputDirectory, String name) throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
        Root myImage = criteria.from(Content.class);
        criteria.select(myImage);
        criteria.where(builder.equal(myImage.get(Content_.NAME), name));
        Content content = session.createQuery(criteria).getSingleResult();
        String filePathToSave = outputDirectory + name;
        byte[] HtmlBytes = content.getContent();
        saveBytesToFile(filePathToSave, HtmlBytes);
        session.close();
    }//end function

    private static void saveBytesToFile(String filePath, byte[] fileBytes) throws Exception {
        FileOutputStream outputStream = new FileOutputStream(filePath);
        outputStream.write(fileBytes);
        outputStream.close();
    }//end function

    public static void deleteById(Integer id) throws Exception {
        Session session = getSession();
        try {
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
        } catch (Exception e) {
            session.close();
        }
    }//end function

    public static void deleteByName(String name) throws Exception {
        Session session = getSession();
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
            Root myImage = criteria.from(Content.class);
            criteria.select(myImage);
            criteria.where(builder.equal(myImage.get(Content_.NAME), name));
            Content image = session.createQuery(criteria).getSingleResult();
            session.beginTransaction();
            session.delete(image);
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            session.close();
        }
    }//end function

    //Search if name exists in database
    public static boolean searchName(String name) throws Exception {
        boolean available = false;
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
        Root picture = criteria.from(Content.class);
        criteria.select(picture);
        criteria.where(builder.equal(picture.get(Content_.NAME), name));
        List<Content> pictures = (List<Content>) session.createQuery(criteria).list();
        if (!pictures.isEmpty()) {
            available = true;
        } else {
            available = false;
        }
        session.close();
        return available;
    }//end fuction

    //Search if ID exists in database
    public static boolean searchId(int id) throws Exception {
        boolean available = false;
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Content> criteria = builder.createQuery(Content.class);
        Root picture = criteria.from(Content.class);
        criteria.select(picture);
        criteria.where(builder.equal(picture.get(Content_.ID), id));
        List<Content> pictures = (List<Content>) session.createQuery(criteria).list();
        if (!pictures.isEmpty()) {
            available = true;
        } else {
            available = false;
        }
        session.close();
        return available;
    }//end fuction

    public static void saveOrUpdate(Content content) throws Exception {
        Session session = getSession();
        session.getTransaction().begin();
        session.saveOrUpdate(content);
        session.getTransaction().commit();
        session.close();
    }
}//end Class
