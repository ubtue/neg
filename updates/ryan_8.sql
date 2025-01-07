INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'SprachauswahlSchliessen', 'Sprachauswahl schließen', 'Close language selection', 'Fermer la sélection de langue', 'Linguarum electionem claudere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('logo', 'AriaLabelUniversitaetTuebingen', 'Logo der Universität Tübingen – Zur Website', 'Logo of the University of Tübingen – To the Website', 'Logo de l\\\'Université de Tübingen – Vers le site Web', 'Logo Universitatis Tübingen – Ad Website');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('logo', 'AriaLabelExcellence', 'Logo der Excellenzstrategie der Universität Tübingen – Zur Website', 'Logo of the Excellence Strategy of the University of Tübingen – To the Website', 'Logo de la stratégie d\\\'excellence de l\\\'Université de Tübingen – Vers le site Web', 'Logo Strategiae Excellentiae Universitatis Tübingen – Ad Website');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('library', 'Library', 'Universitätsbibliothek', 'University Library', 'Bibliothèque universitaire', 'Bibliotheca Universitatis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('logo', 'NomenEtGens', 'Zur Startseite von Nomen et Gens', 'To the homepage of Nomen et Gens', 'Vers la page d\'accueil de Nomen et Gens', 'Ad paginam prima Nomen et Gens');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('logo', 'AriaLabelLibrary', 'Link zur Website der Universitätsbibliothek\"', 'Link to the University Library Website', 'Lien vers le site web de la bibliothèque universitaire', 'Nodus ad paginam bibliothecae universitatis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('dfg', 'GefoerdertVon', 'Gefördert von', 'Funded by', 'Financé par', 'Subsidium a');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('kontakt', 'Kontakt', 'Kontakt', 'Contact', 'Contact', 'Contactus');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('informationen', 'WeitereInformationen', 'Weitere Informationen', 'Further Information', 'Informations supplémentaires', 'Ulteriores Informationes');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('mgh_lemma', 'GoToLemma', 'Gehe zu Lemma', 'go to Lemma', 'aller à Lemma', 'ad Lemma');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('namenkommentar', 'GoToPhilologicalLemma', 'gehe zu Philologisches Lemma', 'go to Philological Lemma', 'aller à Lemme philologique', 'ad Lemma philologicum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('jump', 'JumpTo', 'Springe zu NeG-ID:', 'Jump to NeG-ID:', 'Aller à NeG-ID:', 'Salta ad NeG-ID:');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('jump', 'Los', 'los', 'go', 'aller', 'ire');

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Jump ahead for', `fr` = 'Avancer de ', `la` = 'Transire per' WHERE Textfeld = 'vor';

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Jump to no.', `fr` = 'Sauter au no', `la` = 'Transire ad numerum' WHERE Textfeld = 'zu';

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Jump back for', `fr` = 'Retourner de ', `la` = 'Redire per' WHERE Textfeld = 'zurück';

