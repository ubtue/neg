UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Title', `fr_beschriftung` = 'Titre', `la_beschriftung` = 'Inscriptio' where Formular = "edition" and Datenfeld = "Titel";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Sources', `fr_beschriftung` = 'Sources', `la_beschriftung` = 'Fontes' where Formular = "edition" and Datenfeld = "Quelle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Sources', `fr_beschriftung` = 'Sources', `gb_combinedAnzeigenamen` = 'Source number ;; Title ; Pages ; Number', `fr_combinedAnzeigenamen` = 'Numéro de source ;; Titre ; Pages ; Numéro', `la_beschriftung` = 'Fontes', `la_combinedAnzeigenamen` = 'Numerus fontis ;; Inscriptio ; Paginae ; Numerus' where Formular = "edition" and Datenfeld = "Quelle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Year', `fr_beschriftung` = 'Année', `la_beschriftung` = 'Annus' where Formular = "edition" and Datenfeld = "Jahr";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Place', `fr_beschriftung` = 'Lieu', `la_beschriftung` = 'Locus' where Formular = "edition" and Datenfeld = "Ort";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Series', `fr_beschriftung` = 'Série', `la_beschriftung` = 'Series' where Formular = "edition" and Datenfeld = "Reihe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Volume number', `fr_beschriftung` = 'Numéro du volume', `la_beschriftung` = 'Numerus voluminis' where Formular = "edition"  and Datenfeld = "Band";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'dMGH-Volume', `fr_beschriftung` = 'dMGH-Volume', `la_beschriftung` = 'dMGH-Volumen' where Formular = "edition"  and Datenfeld = "dMGHBand";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Short citation', `fr_beschriftung` = 'Citation brève', `la_beschriftung` = 'Citatio brevis' where Formular = "edition" and Datenfeld = "Zitierweise";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Remarks', `fr` = 'Remarques', `la` = 'Commentaria' where Formular = "edition" and Textfeld = "TabBemerkungen";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Surname, First name', `fr_beschriftung` = 'Nom de famille, Prénom', `la_beschriftung` = 'Cognomen, Praenomen' where Formular = "edition" and Datenfeld = "Editor";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Tradition', `fr` = 'Tradition', `la` = 'Traditio' where Formular = "quelle" and Textfeld = "Ueberlieferung";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Sigel' where Formular = "quelle" and Textfeld = "Sigle";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Lieu de création de l\'écriture' where Formular = "quelle" and Textfeld = "Schriftheimat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (for all)', `fr_beschriftung` = 'Remarque (pour tous)', `la_beschriftung` = 'Commentarius (pro omnibus)' where Formular = "edition" and Datenfeld = "BemerkungAlle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (group)', `fr_beschriftung` = 'Remarque (en groupe)', `la_beschriftung` = 'Commentarius (coniunctis apertus)' where Formular = "edition" and Datenfeld = "BemerkungGruppe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (private)', `fr_beschriftung` = 'Remarque (privée)', `la_beschriftung` = 'Commentarius (privatus)' where Formular = "edition" and Datenfeld = "BemerkungPrivat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Processing status', `fr_beschriftung` = 'Statut de traitement', `la_beschriftung` = 'Status tractandi' where Formular = "edition" and Datenfeld = "Bearbeitungsstatus";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Last modification', `fr_beschriftung` = 'Dernière modification', `la_beschriftung` = 'Novissima retractatio' where Formular = "edition" and Datenfeld = "LetzteAenderung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Latest modification by', `fr_beschriftung` = 'Dernière modification par', `la_beschriftung` = 'Novissime retractatum ab' where Formular = "edition" and Datenfeld = "LetzteAenderungVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created', `fr_beschriftung` = 'Établi', `la_beschriftung` = 'Generatum' where Formular = "edition" and Datenfeld = "Erstellt";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created by', `fr_beschriftung` = 'Établi par', `la_beschriftung` = 'Generatum ab' where Formular = "edition" and Datenfeld = "ErstelltVon";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Editors', `fr` = 'Éditeurs', `la` = 'Editores' where Formular = "edition" and Textfeld = "TabEditoren";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Remarks', `fr` = 'Remarques', `la` = 'Commentaria' where Formular = "handschrift" and Textfeld = "TabBemerkungen";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Short title', `fr_beschriftung` = 'Titre abrégé', `la_beschriftung` = 'Citatio brevis' where Formular = "quelle" and Datenfeld = "Bezeichnung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Source commentary', `fr_beschriftung` = 'Commentaire sur les sources', `la_beschriftung` = 'Commentarius fontium' where Formular = "quelle" and Datenfeld = "Quellenkommentar";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Tradition commentary', `fr_beschriftung` = 'Commentaire traditionnel' where Formular = "quelle" and Datenfeld = "Ueberlieferungskommentar";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'For publication', `fr_beschriftung` = 'À publier', `la_beschriftung` = 'Edendum' where Formular = "quelle" and Datenfeld = "ZuVeroeffentlichen";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('quelle', 'Delete', 'löschen', 'delete', 'supprimer', 'delere');

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Jour;Mois;Année;Siècle', `la_combinedAnzeigenamen` = 'Dies;Mensis;Annus;Saeculum' where Formular = "quelle" and Datenfeld = "DatumVon";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Jour;Mois;Année;Siècle', `la_combinedAnzeigenamen` = 'Dies;Mensis;Annus;Saeculum' where Formular = "quelle" and Datenfeld = "DatumBis";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Uncertain date', `fr_beschriftung` = 'Datation incertaine', `la_beschriftung` = 'Datatio incerta' where Formular = "quelle" and Datenfeld = "DatierungUngewiss";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Edition', `fr` = 'Édition', `la` = 'Editio' where Formular = "quelle" and Textfeld = "TabEdition";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Remarks', `fr` = 'Remarques', `la` = 'Commentaria' where Formular = "quelle" and Textfeld = "TabBemerkungen";

UPDATE `neg`.`datenbank_mapping` SET `gb_combinedAnzeigenamen` = 'Edition number;;Indication;Standard;Pages;Number', `fr_combinedAnzeigenamen` = 'Numéro de l\'édition;;Désignation;Standard;Pages;Numéro', `la_combinedAnzeigenamen` = 'Numerus editionis;;Descriptio brevis;In usu;Paginae;Numerus' where Formular = "quelle" and Datenfeld = "Edition";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'For Charters', `fr` = 'Pour les chartes', `la` = 'Pro chartis' where Formular = "quelle" and Textfeld = "TabUrkunde";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (for all)', `fr_beschriftung` = 'Remarque (pour tous)', `la_beschriftung` = 'Commentarius (pro omnibus)' where Formular = "quelle" and Datenfeld = "BemerkungAlle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (group)', `fr_beschriftung` = 'Remarque (en groupe)', `la_beschriftung` = 'Commentarius (coniunctis apertus)' where Formular = "quelle" and Datenfeld = "BemerkungGruppe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (private)', `fr_beschriftung` = 'Remarque (privée)', `la_beschriftung` = 'Commentarius (privatus)' where Formular = "quelle" and Datenfeld = "BemerkungPrivat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Processing status', `fr_beschriftung` = 'Statut de traitement', `la_beschriftung` = 'Status tractandi' where Formular = "quelle" and Datenfeld = "Bearbeitungsstatus";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Last modification', `fr_beschriftung` = 'Dernière modification', `la_beschriftung` = 'Novissima retractatio' where Formular = "quelle" and Datenfeld = "LetzteAenderung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Latest modification by', `fr_beschriftung` = 'Dernière modification par', `la_beschriftung` = 'Novissime retractatum ab' where Formular = "quelle" and Datenfeld = "LetzteAenderungVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created', `fr_beschriftung` = 'Établi', `la_beschriftung` = 'Generatum' where Formular = "quelle" and Datenfeld = "Erstellt";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created by', `fr_beschriftung` = 'Établi par', `la_beschriftung` = 'Generatum ab' where Formular = "quelle" and Datenfeld = "ErstelltVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Standard Name', `fr_beschriftung` = 'Nom standard', `la_beschriftung` = 'Nomen standard' where Formular = "person" and Datenfeld = "Standardname";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Fictitious Person', `fr_beschriftung` = 'Personne fictive', `la_beschriftung` = 'Persona ficta' where Formular = "person" and Datenfeld = "Fiktiv";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Identifikationskommentare', `gb_beschriftung` = 'Identification Problems', `fr_beschriftung` = 'Problèmes d\'identification', `la_beschriftung` = 'Commentarii quoad identificationem' where Formular = "person" and Datenfeld = "Identifizierungsproblem";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('modul', 'Name', 'Name', 'Name', 'Nom', 'Nomen');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('modul', 'Namen', 'Namen', 'Names', 'Noms', 'Nomina');

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Name Additions', `fr` = 'Complémentaires du Nom', `la` = 'Addita Nominis' where Formular = "person" and Textfeld = "TabZusatz";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Qui et;Complémentaire', `la_combinedAnzeigenamen` = 'Qui et;Quod additur' where Formular = "person" and Datenfeld = "QuiEt";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Office/Status/Consecration', `fr` = 'Fonction/ Statut/ Ordination', `la` = 'Officium/Status/Consecratio' where Formular = "person" and Textfeld = "TabASW";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Ethnie/Area', `fr` = 'Ethnie/Terrain', `la` = 'Gens/Regio' where Formular = "person" and Textfeld = "TabEthnieAreal";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Area', `fr_beschriftung` = 'Terrain', `la_beschriftung` = 'Regio' where Formular = "person" and Datenfeld = "Areal";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Group Origin', `fr_beschriftung` = 'Groupe origine', `la_beschriftung` = 'Gruppus originis' where Formular = "person" and Datenfeld = "GruppeHerkunft";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Commentary (ethnicity)', `fr_beschriftung` = 'Commentaire (ethnie)', `la_beschriftung` = 'Commentarius ad gentem spectans' where Formular = "person" and Datenfeld = "KommentarEthnie";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Commentary (area)', `fr_beschriftung` = 'Commentaire (terrain)', `la_beschriftung` = 'Commentaria ad regionem spectans' where Formular = "person" and Datenfeld = "KommentarAreal";

UPDATE `neg`.`datenbank_mapping` SET `gb_combinedAnzeigenamen` = 'Person ID;Name of Person;Degree of Relationship', `fr_combinedAnzeigenamen` = 'Personne ID;;Nom de la personne;Degré de parenté', `la_combinedAnzeigenamen` = 'Numerus personae ID;;Nomen personae; Gradus propinquitatis' where Formular = "person" and Datenfeld = "Verwandtschaft";

UPDATE `neg`.`datenbank_mapping` SET `de_combinedAnzeigenamen` = 'Beleg ID;;Belegform;Datierung;Amt/Weihe;Stand;Kontext', `gb_combinedAnzeigenamen` = 'Reference ID;;Form of Reference;Dating;Office/Consecration;Status;Context', `fr_combinedAnzeigenamen` = 'Testimonium ID;;Forma Testimonii;Datatio;Officium/Consecratio;Status;Contextus', `la_combinedAnzeigenamen` = 'Testimonium ID;;Forma Testimonii;Datatio;Officium/Consecratio;Status;Contextus' where Formular = "person" and Datenfeld = "Einzelbeleg";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (for all)', `fr_beschriftung` = 'Remarque (pour tous)', `la_beschriftung` = 'Commentarius (pro omnibus)' where Formular = "person" and Datenfeld = "BemerkungAlle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (group)', `fr_beschriftung` = 'Remarque (en groupe)', `la_beschriftung` = 'Commentarius (coniunctis apertus)' where Formular = "person" and Datenfeld = "BemerkungGruppe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (private)', `fr_beschriftung` = 'Remarque (privée)', `la_beschriftung` = 'Commentarius (privatus)' where Formular = "person" and Datenfeld = "BemerkungPrivat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Processing status', `fr_beschriftung` = 'Statut de traitement', `la_beschriftung` = 'Status tractandi' where Formular = "person" and Datenfeld = "Bearbeitungsstatus";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Last modification', `fr_beschriftung` = 'Dernière modification', `la_beschriftung` = 'Novissima retractatio' where Formular = "person" and Datenfeld = "LetzteAenderung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Latest modification by', `fr_beschriftung` = 'Dernière modification par', `la_beschriftung` = 'Novissime retractatum ab' where Formular = "person" and Datenfeld = "LetzteAenderungVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created', `fr_beschriftung` = 'Établi', `la_beschriftung` = 'Generatum' where Formular = "person" and Datenfeld = "Erstellt";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created by', `fr_beschriftung` = 'Établi par', `la_beschriftung` = 'Generatum ab' where Formular = "person" and Datenfeld = "ErstelltVon";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Remarks', `fr` = 'Remarques', `la` = 'Commentaria' where Formular = "person" and Textfeld = "TabBemerkungen";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Place of Issue', `fr_beschriftung` = 'Lieu de délivrance' where Formular = "urkunde" and Datenfeld = "Actumort";
