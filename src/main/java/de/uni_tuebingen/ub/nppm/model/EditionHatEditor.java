package de.uni_tuebingen.ub.nppm.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "edition_hateditor")
public class EditionHatEditor {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @OneToOne(targetEntity = Edition.class)
    @JoinColumn(name = "EditionID", referencedColumnName="ID")
    private Edition edition;

    @OneToOne(targetEntity = SelektionEditor.class)
    @JoinColumn(name = "EditorID", referencedColumnName="ID")
    private SelektionEditor editor;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Edition getEdition() {
        return edition;
    }

    public void setEdition(Edition edition) {
        this.edition = edition;
    }

    public SelektionEditor getEditor() {
        return editor;
    }

    public void setEditor(SelektionEditor editor) {
        this.editor = editor;
    }
    
}
