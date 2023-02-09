package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "tinyMce_content")
public class TinyMCE_Content {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name= "ID")
    int ID;

    @Column(name = "name", length = 255)
    String name;

    @Column(name = "contentType", length = 55)
    String content_Type;


    @Lob
    @Type(type="org.hibernate.type.ImageType")
    @Column(name="content", nullable=false, columnDefinition="blob")
    private byte[] content;

    //Constructors

    public TinyMCE_Content() {
    }

    public TinyMCE_Content(String name, String content_Type, byte[] content) {
        this.name = name;
        this.content_Type = content_Type;
        this.content = content;
    }

    //Getters & Setters

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent_Type() {
        return content_Type;
    }

    public void setContent_Type(String content_Type) {
        this.content_Type = content_Type;
    }

    public byte[] getContent() {
        return content;
    }

    public void setContent(byte[] content) {
        this.content = content;
    }

    //To-String

    @Override
    public String toString() {
        return "ImageContent{" + "ID=" + ID + ", name=" + name + ", content_Type=" + content_Type + ", content=" + content + '}';
    }

}//end Class
