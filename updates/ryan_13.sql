UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Paläographische Abgrenzung', `gb_beschriftung` = 'Palaeographic Demarcation', `fr_beschriftung` = 'Délimitation paléographique', `la_beschriftung` = 'Delimitatio palaeographica' where Formular = "einzelbeleg" and Datenfeld = "PalAbgrenzung";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Inhaltliche Abgrenzung', `gb_beschriftung` = 'Content-related Demarcation', `fr_beschriftung` = 'Démarcation du contenu"', `la_beschriftung` = 'Delimitatio contentualis' where Formular = "einzelbeleg" and Datenfeld = "InhAbgrenzung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Details about the Person' where Formular = "einzelbeleg" and Datenfeld = "AngabenPerson";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Context before', `fr_beschriftung` = 'Contexte avant', `la_beschriftung` = 'Ante contextum' where Formular = "einzelbeleg" and Datenfeld = "Kontext_vor";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Context after', `fr_beschriftung` = 'Contexte après', `la_beschriftung` = 'Post contextum' where Formular = "einzelbeleg" and Datenfeld = "Kontext_nach";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating', `fr` = 'Datation', `la` = 'Definitio temporis' where Formular = "einzelbeleg" and Textfeld = "Datierung";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Definitio temporis' where Formular = "quelle" and Textfeld = "Datierung";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Jour;Mois;Année;Siècle', `la_combinedAnzeigenamen` = 'Dies;Mensis;Annus;Saeculum' where Formular = "einzelbeleg" and Datenfeld = "DatumVon";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Jour;Mois;Année;Siècle', `la_combinedAnzeigenamen` = 'Dies;Mensis;Annus;Saeculum' where Formular = "einzelbeleg" and Datenfeld = "DatumBis";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Source Reference', `fr` = 'Référence de source'  where Formular = "einzelbeleg" and Textfeld = "TabBelegstelle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Source ID', `fr_beschriftung` = 'Source ID', `la_beschriftung` = 'Numerus fontis' where Formular = "einzelbeleg" and Datenfeld = "Quellennummer";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Used Edition' where Formular = "einzelbeleg" and Datenfeld = "Edition";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Chapter in the Edition', `fr_beschriftung` = 'Chapitre dans l\'édition', `la_beschriftung` = 'Capitulum editionis' where Formular = "einzelbeleg" and Datenfeld = "EditionKapitel";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Pages in the Edition', `fr_beschriftung` = 'Pages dans l\'édition', `la_beschriftung` = 'Paginae editionis' where Formular = "einzelbeleg" and Datenfeld = "EditionSeite";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Jour;Mois;Année;Siècle', `la_combinedAnzeigenamen` = 'Dies;Mensis;Annus;Saeculum' where Formular = "einzelbeleg" and Datenfeld = "QuelleDatumVon";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Jour;Mois;Année;Siècle', `la_combinedAnzeigenamen` = 'Dies;Mensis;Annus;Saeculum' where Formular = "einzelbeleg" and Datenfeld = "QuelleDatumBis";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Source Type', `fr_beschriftung` = 'Genre de source', `la_beschriftung` = 'Genus fontis' where Formular = "einzelbeleg" and Datenfeld = "Quellengattung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Authenticity', `fr_beschriftung` = 'Authenticité', `la_beschriftung` = 'Authenticitas' where Formular = "einzelbeleg" and Datenfeld = "Echtheit";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'VersionsX', `fr_beschriftung` = 'VariantesX', `la_beschriftung` = 'Lectiones variaeX' where Formular = "einzelbeleg" and Datenfeld = "Textkritik";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Versions', `fr_beschriftung` = 'Variantes', `gb_combinedAnzeigenamen` = 'Edition;;Symbol;Variant;Remark', `fr_combinedAnzeigenamen` = 'Édition;;Sigle;Variante;Remarque', `la_beschriftung` = 'Lectiones variae', `la_combinedAnzeigenamen` = 'Editio;;Sigla;Lectio varia;Commentarii;' where Formular = "einzelbeleg" and Datenfeld = "Textkritik";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Diacritic', `fr_beschriftung` = 'Diacritique', `la_beschriftung` = 'Diacriticus' where Formular = "einzelbeleg" and Datenfeld = "Diakritisch";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Grammatical Gender', `fr_beschriftung` = 'Genre grammatical', `la_beschriftung` = 'Genus grammaticum' where Formular = "einzelbeleg" and Datenfeld = "GrammatikGeschlecht";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Case', `fr_beschriftung` = 'Cas', `la_beschriftung` = 'Casus' where Formular = "einzelbeleg" and Datenfeld = "Kasus";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Concerning the Name', `fr` = 'Concernant le nom', `la` = 'Commentaria nominis' where Formular = "einzelbeleg" and Textfeld = "TabNamen";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Concerning the Person', `fr` = 'Concernant la personne', `la` = 'Commentaria personae' where Formular = "einzelbeleg" and Textfeld = "TabPerson";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Remarques', `la` = 'Commentaria' where Formular = "einzelbeleg" and Textfeld = "TabBemerkungen";

UPDATE `neg`.`datenbank_mapping` SET `de_combinedAnzeigenamen` = 'Person ID;;Link;Identität gesichert', `gb_combinedAnzeigenamen` = 'Person ID;;Link;Certain Identity', `fr_combinedAnzeigenamen` = 'Personne ID;;Lien;Certaine identité', `la_combinedAnzeigenamen` = 'Persona ID;;Conexus;Identitas certa' where Formular = "einzelbeleg" and Datenfeld = "PersonID";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Office/ Consecration', `fr_beschriftung` = 'Fonction/ Ordination', `la_beschriftung` = 'Officium/ Consecratio' where Formular = "einzelbeleg" and Datenfeld = "AmtWeihe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Relationship with the Community', `la_beschriftung` = 'Relatio cum communitate' where Formular = "einzelbeleg" and Datenfeld = "BeziehungGemeinschaft";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Ethnic Group', `fr_beschriftung` = 'Ethnie', `la_beschriftung` = 'Gens' where Formular = "einzelbeleg" and Datenfeld = "Ethnie";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Status', `fr_beschriftung` = 'Statut', `la_beschriftung` = 'Status' where Formular = "einzelbeleg" and Datenfeld = "Stand";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Title Text' where Formular = "einzelbeleg" and Datenfeld = "TitelText";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Title Critique', `la_beschriftung` = 'Titulus critica' where Formular = "einzelbeleg" and Datenfeld = "TitelKritik";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Commentary', `fr_beschriftung` = 'Commentaire', `la_beschriftung` = 'Commentarius' where Formular = "einzelbeleg" and Datenfeld = "Kommentar";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Fonction;Numéro', `la_combinedAnzeigenamen` = 'Functio;Numerus' where Formular = "einzelbeleg" and Datenfeld = "Funktion";

UPDATE `neg`.`datenbank_mapping` SET `de_combinedAnzeigenamen` = 'Areal;Areal-Typ', `gb_combinedAnzeigenamen` = 'Area;Area Type', `fr_combinedAnzeigenamen` = 'Zone;Type de zone', `la_combinedAnzeigenamen` = 'Area;Typus areae' where Formular = "einzelbeleg" and Datenfeld = "NewAreal";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (for all)', `fr_beschriftung` = 'Remarque (pour tous)', `la_beschriftung` = 'Commentarius (pro omnibus)' where Formular = "einzelbeleg" and Datenfeld = "BemerkungAlle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (group)', `fr_beschriftung` = 'Remarque (en groupe)', `la_beschriftung` = 'Commentarius (coniunctis apertus)' where Formular = "einzelbeleg" and Datenfeld = "BemerkungGruppe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (private)', `fr_beschriftung` = 'Remarque (privée)', `la_beschriftung` = 'Commentarius (privatus)' where Formular = "einzelbeleg" and Datenfeld = "BemerkungPrivat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Processing status', `fr_beschriftung` = 'Statut de traitement', `la_beschriftung` = 'Status tractandi' where Formular = "einzelbeleg" and Datenfeld = "Bearbeitungsstatus";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Last modification', `fr_beschriftung` = 'Dernière modification', `la_beschriftung` = 'Novissima retractatio' where Formular = "einzelbeleg" and Datenfeld = "LetzteAenderung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Latest modification by', `fr_beschriftung` = 'Dernière modification par', `la_beschriftung` = 'Novissime retractatum ab' where Formular = "einzelbeleg" and Datenfeld = "LetzteAenderungVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created', `fr_beschriftung` = 'Établi', `la_beschriftung` = 'Generatum' where Formular = "einzelbeleg" and Datenfeld = "Erstellt";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created by', `fr_beschriftung` = 'Établi par', `la_beschriftung` = 'Generatum ab' where Formular = "einzelbeleg" and Datenfeld = "ErstelltVon";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'To the Compact View', `fr` = 'À la vue compacte', `la` = 'In aspectum brevem vertere' where Formular = "einzelbeleg" and Textfeld = "KompakteSicht";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'To the Detailed View', `fr` = 'À la vue détaillée', `la` = 'In adspectum copiosum vertere' where Formular = "einzelbeleg" and Textfeld = "AusfuehrlicheSicht";

