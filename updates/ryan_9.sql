UPDATE `neg`.`datenbank_texte` SET `fr` = 'Référence', `la` = 'Locus testimonii' where Formular = "einzelbeleg" and Textfeld = "TabBelegstelle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Person(s)', `fr_beschriftung` = 'Personne(s)', `la_beschriftung` = 'Persona(e) ' where Formular = "einzelbeleg" and Datenfeld = "PersonRO";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Form of Reference', `fr_beschriftung` = 'Forme de référence', `la_beschriftung` = 'Forma testimonii' where Formular = "einzelbeleg" and Datenfeld = "Belegform";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Greek', `fr_beschriftung` = 'Grec', `la_beschriftung` = 'Graecus' where Formular = "einzelbeleg" and Datenfeld = "Griechisch";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Philological Lemma' where Formular = "einzelbeleg" and Datenfeld = "LemmaRO";

UPDATE `neg`.`datenbank_mapping` SET `fr_beschriftung` = 'Description du contexte', `la_beschriftung` = 'Contextus description' where Formular = "einzelbeleg" and Datenfeld = "Kontext";

UPDATE `neg`.`datenbank_mapping` SET `fr_beschriftung` = 'Classification du contexte', `la_beschriftung` = 'Context genus' where Formular = "einzelbeleg" and Datenfeld = "KontextSelektion";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Lebend/Verstorben', `gb_beschriftung` = 'Alive/Dead', `fr_beschriftung` = 'Vivant/Mort', `la_beschriftung` = 'Vivus/Mortuus' where Formular = "einzelbeleg" and Datenfeld = "LebendVerstorben";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating of the Reference', `fr` = 'Datation de la référence', `la` = 'Testimonii definitio temporis' where Formular = "einzelbeleg" and Textfeld = "DatierungNennung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Uncertain Dating', `fr_beschriftung` = 'Datation incertaine', `la_beschriftung` = 'Datatio incerta' where Formular = "einzelbeleg" and Datenfeld = "DatierungUngewiss";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Commentary (Dating)', `fr_beschriftung` = 'Commentaire (datation)', `la_beschriftung` = 'Commentarius ad datationem spectans'  where Formular = "einzelbeleg" and Datenfeld = "KommentarDatierung";

UPDATE `neg`.`datenbank_mapping` SET `fr_beschriftung` = 'Pal démarcation', `la_beschriftung` = 'Pal signatio' where Formular = "einzelbeleg" and Datenfeld = "PalAbgrenzung";

UPDATE `neg`.`datenbank_mapping` SET `fr_beschriftung` = 'Inh démarcation', `la_beschriftung` = 'Inh signatio' where Formular = "einzelbeleg" and Datenfeld = "InhAbgrenzung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Number in Structure' where Formular = "einzelbeleg" and Datenfeld = "NrInStrukt";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Source', `fr` = 'Source', `la` = 'Fons' where Formular = "einzelbeleg" and Textfeld = "BoxQuelle";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Short-title', `fr` = 'Abrévation du titre', `la` = 'Inscriptio abbreviata' where Formular = "einzelbeleg" and Textfeld = "Kurztitel";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Edition Used', `fr_beschriftung` = 'Édition utilisée ', `la_beschriftung` = 'Editio adhibita' where Formular = "einzelbeleg" and Datenfeld = "Edition";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Chapter', `fr` = 'Chapitre', `la` = 'Capitulum' where Formular = "einzelbeleg" and Textfeld = "Kapitel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Edition', `fr` = 'Édition', `la` = 'Editio' where Formular = "einzelbeleg" and Textfeld = "Edition";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Page', `fr` = 'Page', `la` = 'Pagina' where Formular = "einzelbeleg" and Textfeld = "Seite";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Date of Source', `fr_beschriftung` = 'Datation de la source', `la_beschriftung` = 'Datatio fontis' where Formular = "einzelbeleg" and Datenfeld = "QuelleDatierung";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Textual Criticism', `fr` = 'Critique du texte', `la` = 'Iudicium textus' where Formular = "einzelbeleg" and Textfeld = "TabTextkritik";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Symbol', `fr` = 'Sigle', `la` = 'Sigla' where Formular = "einzelbeleg" and Textfeld = "Sigle";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Versions', `fr` = 'Variantes', `la` = 'Lectiones variae' where Formular = "einzelbeleg" and Textfeld = "Varianten";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating of the Text Attestor', `fr` = 'Datation des témoins du texte', `la` = 'Definitio temporis testimoniorum' where Formular = "einzelbeleg" and Textfeld = "DatierungTextzeuge";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Remark', `fr` = 'Remarque', `la` = 'Commentaria' where Formular = "einzelbeleg" and Textfeld = "Bemerkung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Text-critical Note' where Formular = "einzelbeleg" and Datenfeld = "KritikSelektion";
