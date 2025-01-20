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

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Search', `fr` = 'Rechercher', `la` = 'Quaerere' WHERE Formular = "suche" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Référence individuelle', `la` = 'Testimonium personae' WHERE Formular = "einzelbeleg" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Persons', `fr` = 'Personnes', `la` = 'Personae' WHERE Formular = "person" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Names', `fr` = 'Noms', `la` = 'Nomina' WHERE Formular = "namenkommentar" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Sources', `fr` = 'Sources', `la` = 'Fontes' WHERE Formular = "quelle" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Editions', `fr` = 'Éditions', `la` = 'Editiones' WHERE Formular = "edition" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Text attestor', `fr` = 'Témoins du texte', `la` = 'Testimonia textus' WHERE Formular = "handschrift" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Offene Verknüpfung' WHERE Formular = "openLink" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Free search', `fr` = 'Recherche libre', `la` = 'Libere quaerere' WHERE Formular = "freie_suche" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Settings', `fr` = 'Paramètres', `la` = 'Optiones' WHERE Formular = "einstellungen" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Administration', `fr` = 'Administration', `la` = 'Administratio' WHERE Formular = "administration" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Inscrit(e) comme', `la` = 'Initus/a est' WHERE Formular = "navigation" and Textfeld = "AngemeldetAls";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'EinzelbelegOhneLemma', 'Einzelbelege ohne Lemma', 'Single reference without a lemma', 'Référence individuelle sans lemme', 'Testimonia sine lemmate');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'EinzelbelegOhneTextkritik', 'Einzelbelege ohne Textkritik', 'Single references without text attestor', 'Références individuelles sans témoins du texte', 'Testimonia sine testimoniis textus');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'EinzelbelegOhnePerson', 'Einzelbelege ohne Person', 'Single references without a person', 'Références individuelles sans personne', 'Testimonia sine persona');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'NamenOhneBelege', 'Namen ohne Belege', 'Names without references', 'Noms sans références', 'Nomina sine testimoniis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'PersonOhneBelege', 'Person ohne Belege', 'Person without references', 'Personne sans références', 'Persona sine testimoniis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'QuelleOhneEdition', 'Quelle ohne Edition', 'Source without edition', 'Source sans édition', 'Fonte sine editione');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'QuelleOhneUeberlieferung', 'Quelle ohne Ueberlieferung', 'Source without tradition', 'Source sans tradition', 'Fonte sine traditione');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ohneVerknuepfung', 'TextzeugenOhneUeberlieferung', 'Textzeugen ohne Ueberlieferung', 'Text attestors without tradition', 'Témoins du texte sans tradition', 'Testimonia textus sine traditione');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('dodeletefile', 'FalscherAufruf', 'Falscher Aufruf!', 'Wrong call!', 'mauvais appel !', 'Falsum vocatum!');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('dodeletefile', 'ZugriffNichtErlaubt', 'Zugriff nicht erlaubt!!!', 'Access not allowed!!!', 'Accès non autorisé !!!', 'Accessus non permissus!!!');

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Retourner à la  page d\'accueil ', `la` = 'Redire ad paginam primam' WHERE Formular = "all" and Textfeld = "Startseite";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Inscriptum' WHERE Formular = "titel_inc" and Textfeld = "Eintrag";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('dodeletefile', 'ErfolgreichGeloescht', 'erfolgreich gelöscht!', 'successfully deleted!', 'supprimée avec succès !', 'feliciter deleta est!');

UPDATE `neg`.`datenbank_texte` SET `de` = 'Zurück', `gb` = 'Back', `fr` = 'En arrière', `la` = 'Revertere' WHERE Formular = "einstellungen" and Textfeld = "Zurueck";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('dodelete', 'EintragErflogreichGelöscht', 'Eintrag erfolgreich gelöscht!', 'Entry successfully deleted!', 'Entrée supprimée avec succès !', 'Inscriptum feliciter deleta est!');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('dodelete', 'FehlerBeimLoeschen!', 'Fehler beim löschen!', 'Error while deleting!', 'Erreur lors de la suppression !', 'Error in delendo!');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('stat', 'QuellenTitel', 'Titel der Quelle', 'Source Title', 'Titre de la source', 'Titulus fontis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('stat', 'AnzahlBelege', 'Anzahl Belege', 'Number of References', 'Nombre de références', 'Numerus Testimoniorum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('stat', 'TitelFilter', 'Titel Filter', 'Title Filter', 'Filtre par titre', 'Titulus Filtrum');

UPDATE `neg`.`datenbank_texte` SET `la` = 'Statistica' WHERE Formular = "stat" and Textfeld = "Titel";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('person', 'Prosopographical', 'Prosopographisches', 'Prosopographical', 'Prosopographique', 'Prosopographicum');

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Functions', `fr` = 'Fonctions', `la` = 'Officia' WHERE Formular = "person" and Textfeld = "Aemter";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Andere Namen', `gb_beschriftung` = 'Other Names', `fr_beschriftung` = 'Autres noms', `la_beschriftung` = 'Alia nomina' WHERE Formular = "person" and Datenfeld = "Varianten";

