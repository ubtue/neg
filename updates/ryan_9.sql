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

UPDATE `neg`.`datenbank_texte` SET `la` = 'Numerus testimoniorum' where Formular = "stat" and Textfeld = "AnzahlBelege";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Person', `fr` = 'Personne', `la` = 'Persona' where Formular = "person" and Textfeld = "person";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Sex', `fr_beschriftung` = 'Sexe', `la_beschriftung` = 'Sexus' where Formular = "person" and Datenfeld = "Geschlecht";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Status', `fr_beschriftung` = 'Statut', `la_beschriftung` = 'Status' where Formular = "person" and Datenfeld = "Stand";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Offices' where Formular = "person" and Textfeld = "Aemter";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Ethnicity', `fr_beschriftung` = 'Ethnie', `la_beschriftung` = 'Gens' where Formular = "person" and Datenfeld = "Ethnie";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Relatives', `fr` = 'Parents', `la` = 'Cognati' where Formular = "person" and Textfeld = "TabVerwandte";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Reference', `fr` = 'Référence', `la` = 'Testimonia' where Formular = "person" and Textfeld = "TabEinzelbelege";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Name of the Person', `fr` = 'Nom de la personne', `la` = 'Nomen personae' where Formular = "gast_person" and Textfeld = "PersonName";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Degrees of Relationship', `fr` = 'Degré de parenté', `la` = 'Gradus propinquitatis' where Formular = "gast_person" and Textfeld = "Verwandtschaftsgrade";

UPDATE `neg`.`datenbank_mapping` SET `gb_combinedAnzeigenamen` = 'Ethnie;Type of Attribution', `fr_combinedAnzeigenamen` = 'Ethnie;Type de l\'attribution', `la_combinedAnzeigenamen` = 'Gens;Modus attribuendi' where Formular = "person" and Datenfeld = "Ethnie";

UPDATE `neg`.`datenbank_mapping` SET `gb_combinedAnzeigenamen` = 'Office;Period of Time;Identification', `fr_combinedAnzeigenamen` = 'Fonction/Ordination;Période;identification', `la_combinedAnzeigenamen` = 'Officium/Sacri ordines;Spatium temporis;identificatio' where Formular = "person" and Datenfeld = "AmtWeihe";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Reference', `fr` = 'Référence', `la` = 'Testimonium' where Formular = "person" and Textfeld = "Beleg";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Form of Reference', `fr` = 'Forme de la référence', `la` = 'Forma Testimonii' where Formular = "person" and Textfeld = "Belegform";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating', `fr` = 'Datation', `la` = 'Definitio temporis' where Formular = "person" and Textfeld = "Datierung";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Office/Consecration', `fr` = 'Fonction/Ordination', `la` = 'Officium/Consecratio' where Formular = "person" and Textfeld = "AmtWeihe";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Status', `fr` = 'Statut', `la` = 'Status' where Formular = "person" and Textfeld = "Stand";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Context', `fr` = 'Contexte', `la` = 'Contextus ' where Formular = "person" and Textfeld = "Kontext";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Reference', `fr` = 'Référence', `la` = 'Testimonium' where Formular = "mgh_lemma" and Textfeld = "Beleg";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Reference', `fr` = 'Référence', `la` = 'Testimonium' where Formular = "namenkommentar" and Textfeld = "Beleg";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'References', `fr_beschriftung` = 'Références', `la_beschriftung` = 'Testimonia' where Formular = "mgh_lemma" and Datenfeld = "EinzelbelegRO";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'References', `fr_beschriftung` = 'Références', `la_beschriftung` = 'Testimonia' where Formular = "namenkommentar" and Datenfeld = "EinzelbelegRO";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating', `fr` = 'Datation', `la` = 'Definitio temporis' where Formular = "quelle" and Textfeld = "Datierung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Commentary (Dating)', `fr_beschriftung` = 'Commentaire (datation)', `la_beschriftung` = 'Commentarius datationis' where Formular = "quelle" and Datenfeld = "KommentarDatierung";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Series', `fr` = 'Série', `la` = 'Series' where Formular = "quelle" and Textfeld = "Reihe";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Location', `fr` = 'Lieu ', `la` = 'Locus' where Formular = "quelle" and Textfeld = "Ort";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Year', `fr` = 'Année', `la` = 'Annus' where Formular = "quelle" and Textfeld = "Jahr";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Pages', `fr` = 'Pages', `la` = 'Paginae' where Formular = "quelle" and Textfeld = "Seiten";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Standard Edition', `fr` = '  Édition standard', `la` = 'Editio Standard' where Formular = "quelle" and Textfeld = "StandardEdition";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Further Editions', `fr` = 'Éditions supplémentaires', `la` = 'Editiones alterae' where Formular = "quelle" and Textfeld = "WeitereEditionen";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Editor', `fr` = 'Éditeur', `la` = 'Editor' where Formular = "quelle" and Textfeld = "Herausgeber";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Single Reference' where Formular = "einzelbeleg" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Tradition', `fr` = 'Tradition', `la` = 'Traditio' where Formular = "quelle" and Textfeld = "TabUeberlieferung";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Signature/Indication', `fr` = 'Signature/Désignation', `la` = 'Signum libri/Inscriptio' where Formular = "quelle" and Textfeld = "Signatur";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Symbol', `fr` = 'Sigle', `la` = 'Sigla' where Formular = "quelle" and Textfeld = "Sigle";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Origin of the Writing', `fr` = 'Origine de l’écriture', `la` = 'Origo libri' where Formular = "quelle" and Textfeld = "Schriftheimat";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Edition', `fr` = 'Édition', `la` = 'Editio' where Formular = "quelle" and Textfeld = "Edition";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Charter', `fr` = 'Chartes', `la` = 'Chartae' where Formular = "quelle" and Textfeld = "TabUrkunde";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Place of execution', `fr_beschriftung` = 'Lieu d\'exécution', `la_beschriftung` = 'Actum' where Formular = "urkunde" and Datenfeld = "Actumort";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Subject', `fr_beschriftung` = 'Objet', `la_beschriftung` = 'Titulus' where Formular = "urkunde" and Datenfeld = "Betreff";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Issuer of the Charter', `fr_beschriftung` = 'Auteur de la charte', `la_beschriftung` = 'Qui chartam subscripsit' where Formular = "urkunde" and Datenfeld = "Aussteller";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Recipient', `fr_beschriftung` = 'Destinataire', `la_beschriftung` = 'Destinatarius' where Formular = "urkunde" and Datenfeld = "Empfaenger";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Dorsal Note', `fr_beschriftung` = 'Note dorsale', `la_beschriftung` = 'Adnotata dorsualia' where Formular = "urkunde" and Datenfeld = "Dorsalnotiz";


