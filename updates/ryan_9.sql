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

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Place of Execution', `fr_beschriftung` = 'Lieu d\'exécution', `la_beschriftung` = 'Actum' where Formular = "urkunde" and Datenfeld = "Actumort";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Subject', `fr_beschriftung` = 'Objet', `la_beschriftung` = 'Titulus' where Formular = "urkunde" and Datenfeld = "Betreff";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Issuer of the Charter', `fr_beschriftung` = 'Auteur de la charte', `la_beschriftung` = 'Qui chartam subscripsit' where Formular = "urkunde" and Datenfeld = "Aussteller";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Recipient', `fr_beschriftung` = 'Destinataire', `la_beschriftung` = 'Destinatarius' where Formular = "urkunde" and Datenfeld = "Empfaenger";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Dorsal Note', `fr_beschriftung` = 'Note dorsale', `la_beschriftung` = 'Adnotata dorsualia' where Formular = "urkunde" and Datenfeld = "Dorsalnotiz";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Recherche simple', `la` = 'Quaestio simplex' where Formular = "gast_freie_suche" and Textfeld = "EinfacheSuche";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'First Step', `fr` = 'Première étape', `la` = 'Gradus I' where Formular = "freie_suche" and Textfeld = "Tab1";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Second Step', `fr` = 'Deuxième étape', `la` = 'Gradus II' where Formular = "freie_suche" and Textfeld = "Tab2";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Third Step', `fr` = 'Troisième étape', `la` = 'Gradus III' where Formular = "freie_suche" and Textfeld = "Tab3";

UPDATE `neg`.`datenbank_mapping` SET `la_beschriftung` = 'NeG-ID' where Formular = "freie_suche" and Datenfeld = "NeGID";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Form of Reference', `fr_beschriftung` = 'Forme de référence', `la_beschriftung` = 'Forma testimonii' where Formular = "freie_suche" and Datenfeld = "Belegform";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Context', `fr_beschriftung` = 'Contexte', `la_beschriftung` = 'Contextus ' where Formular = "freie_suche" and Datenfeld = "Kontext";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Philological Lemma' where Formular = "freie_suche" and Datenfeld = "Namenlemma";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Name of Person', `fr_beschriftung` = 'Nom de personne', `la_beschriftung` = 'Nomen personae' where Formular = "freie_suche" and Datenfeld = "Personenname";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Sex', `fr_beschriftung` = 'Sexe', `la_beschriftung` = 'Sexus' where Formular = "freie_suche" and Datenfeld = "Geschlecht";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Time Frame of Reference (Person)', `fr_beschriftung` = 'Période d\'attestation (personne)', `la_beschriftung` = 'Spatium temporis testimonii (persona)' where Formular = "freie_suche" and Datenfeld = "PersonZeitraum";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Office/Consecration (Person)', `fr_beschriftung` = 'Fonction/Ordination (personne)', `la_beschriftung` = 'Officium/Consecratio (persona)' where Formular = "freie_suche" and Datenfeld = "AmtWeihePerson";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Status (Person)', `fr_beschriftung` = 'Statut (personne)', `la_beschriftung` = 'Status (persona)' where Formular = "freie_suche" and Datenfeld = "StandPerson";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Ethnicity (Person)', `fr_beschriftung` = 'Ethnie (personne)', `la_beschriftung` = 'Gens (persona)' where Formular = "freie_suche" and Datenfeld = "EthniePerson";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Office/Consecration (Single Reference)', `fr_beschriftung` = 'Fonction/Ordination (Référence indivuelle)', `la_beschriftung` = 'Officium/Consecratio (testimonium)' where Formular = "freie_suche" and Datenfeld = "AmtWeiheEinzelbeleg";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Ethnicity (Single Reference)', `fr_beschriftung` = 'Ethnie (référence indivuelle)', `la_beschriftung` = 'Gens (testimonium)' where Formular = "freie_suche" and Datenfeld = "EthnieEinzelbeleg";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Testimonium' where Formular = "einzelbeleg" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Source', `fr_beschriftung` = 'Source', `la_beschriftung` = 'Fons' where Formular = "freie_suche" and Datenfeld = "Quelle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Source Type', `fr_beschriftung` = 'Genre de source', `la_beschriftung` = 'Genus fontis' where Formular = "freie_suche" and Datenfeld = "QuelleGattung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Date of Source', `fr_beschriftung` = 'Datation de la source', `la_beschriftung` = 'Datatio fontis' where Formular = "freie_suche" and Datenfeld = "QuelleZeitraum";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Page', `fr_beschriftung` = 'Page', `la_beschriftung` = 'Pagina' where Formular = "freie_suche" and Datenfeld = "Seite";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'To the Name', `fr` = 'Sur le nom', `la` = 'Ad nomen' where Formular = "gast_freie_suche" and Textfeld = "ZumNamen";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Philological Lemma' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Namenlemma";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'About the Person', `fr` = 'À propos de la personne', `la` = 'De persona' where Formular = "gast_freie_suche" and Textfeld = "ZurPerson";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Standard Name', `fr_beschriftung` = 'Nom standard', `la_beschriftung` = 'Nomen standard' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Person_Standardname";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Offices and Degrees of Consecration of the Person', `fr_beschriftung` = 'Fonctions et degrés de consécration de la personne', `la_beschriftung` = 'Officia et gradus consecrationis personae' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Person_AmtWeihe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Including Time Period', `fr_beschriftung` = 'Période incluse', `la_beschriftung` = 'Tempus inclusum' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Person_AmtWeiheZeitraum";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Status', `fr_beschriftung` = 'Statut', `la_beschriftung` = 'Status' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Stand";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Ethnicity(ies)', `fr_beschriftung` = 'Ethnie(s)', `la_beschriftung` = 'Gens/Gentes' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Person_Ethnie";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Sex', `fr_beschriftung` = 'Sexe', `la_beschriftung` = 'Sexus' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Geschlecht";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'To the Single Reference', `fr` = 'À la Référence individuelle', `la` = 'Ad Testimonium' where Formular = "gast_freie_suche" and Textfeld = "ZumEinzelbeleg";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Form of Reference', `fr_beschriftung` = 'Forme de référence', `la_beschriftung` = 'Forma testimonii' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_Belegform";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Reference Location (Source, Edition, Chapter, Page)', `fr_beschriftung` = 'Lieu de Référence (Source, Édition, Chapitre, Page)', `la_beschriftung` = 'Locus Testimonii (Fons, Editio, Caput, Pagina)' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_Belegstelle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Context', `fr_beschriftung` = 'Contexte', `la_beschriftung` = 'Contextus ' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_Kontext";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Dating', `fr_beschriftung` = 'Datation', `la_beschriftung` = 'Datatio' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_Datierung";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Lebend / Verstorben', `gb_beschriftung` = 'Alive/Dead', `fr_beschriftung` = 'Vivant/Mort', `la_beschriftung` = 'Vivus/Mortuus' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_lebend";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Variants', `fr_beschriftung` = 'Variantes', `la_beschriftung` = 'Variationes' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_Varianten";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Source Type', `fr_beschriftung` = 'Genre de sources', `la_beschriftung` = 'Genus fontis' where Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_Quellengattung";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'ascendant' where Formular = "freie_suche" and Textfeld = "SortierungASC";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'descendant' where Formular = "freie_suche" and Textfeld = "SortierungDESC";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Période de Temps (uniquement pour la datation):', `la` = 'Tempus (tantum pro datatione):' where Formular = "gast_freie_suche" and Textfeld = "ZeitraumDatierung";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating', `fr` = 'Datation', `la` = 'Datatio' where Formular = "quelle" and Textfeld = "Datierung";






