INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('quelle', 'Bezeichnung', 'Quelle:', 'Source:', 'Source:', 'Fons:');

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'dating', `fr_beschriftung` = 'datation', `la_beschriftung` = 'definitio temporis' WHERE Formular = 'gast_quelle' and Datenfeld = 'Datierung';

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('titel_inc', 'Eintrag', 'Eintrag', 'Entry', 'Entrée', 'Ingressum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'WeiterZuSchritt2', 'Weiter zu Schritt 2', 'Continue to Step 2', 'Passer à l\'étape 2', 'Ad Passum II');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'ZurueckZuSchritt1', 'Zurück zu Schritt 1', 'Back to Step 1', 'Retour à l\'étape 1', 'Ad gradus I');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche ', 'WeiterZuSchritt3', 'Weiter zu Schritt 3', 'Continue to Step 3', 'Passer à l\'étape 3', 'Ad Passum III');

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Select all', `fr` = 'Tout sélectionner', `la` = 'Omnia eligere' WHERE Formular = "gast_freie_suche" and Textfeld = "AlleAuswahlen";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Deselect All', `fr` = 'Désélectionner tout', `la` = 'Delectio omnis tollere' WHERE Formular = "gast_freie_suche" and Textfeld = "AuswahlAufheben";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'Schritt1Von3', 'Schritt 1 von 3', 'Step 1 of 3', 'Étape 1 sur 3', 'Passus I de III');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'Schritt2Von3', 'Schritt 2 von 3', 'Step 2 of 3', 'Étape 2 sur 3', 'Passus II de III');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'Schritt3Von3', 'Schritt 3 von 3', 'Step 3 of 3', 'Étape 3 sur 3', 'Passus III de III');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'WeitereGruppierung', 'Weitere Gruppierung hinzufügen', 'Add another grouping', 'Ajouter un autre regroupement', 'Adde aliam copulam');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'ZurueckZuSchritt2', 'Zurück zu Schritt 2', 'Back to Step 2', 'Retour à l\'étape 2', 'Ad gradus II');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'Suchen', 'Suchen', 'Search', 'Rechercher', 'Quaerere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'Zuruecksetzen', 'Zurücksetzen', 'Reset', 'Réinitialiser', 'Reset');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'ZeitraumDatierung', 'Zeitraum (nur für Datierung):', 'Time period (for dating only):', 'Période (uniquement pour la datation):', 'Tempus (tantummodo ad dationem):');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'IhreSuchanfrage', 'Ihre Suchanfrage', 'Your search query', 'Votre requête de recherche', 'Quaestio vestra');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'EbeneAufklappen', 'Weitere Ebene aufklappen', 'Expand further level', 'Développer un autre niveau', 'Alterum expand level');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('gast_freie_suche', 'EbeneZuklappen', 'Weitere Ebene zuklappen', 'Collapse further level', 'Replier un autre niveau', 'Alterum contrahere level');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('startseite', 'Titel', 'Startseite', 'Home page', 'Page d\'accueil', 'Pagina domestica');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('ziele', 'Titel', 'Ziele', 'Goals', 'Objectifs', 'Scopos');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('datenbank', 'Titel', 'Datenbank', 'Database', 'Base de données', 'Tabula');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('quellenliste', 'Titel', 'Quellenliste', 'Source list', 'Liste des sources', 'Index fontium');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('tagungen', 'Titel', 'Tagungen', 'Meetings', 'Réunions', 'Conventūs');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('mitglieder', 'Titel', 'Mitglieder', 'Members', 'Membres', 'Membra');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('projekte', 'Titel', 'Projekte', 'Projects', 'Projets', 'Opera');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('publikationen', 'Titel', 'Publikationen', 'Publications', 'Publications', 'Publicationes');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'Sprachauswahl', 'Sprachauswahl', 'Language selection', 'Sélection de langue', 'Selectio linguae');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'Sprache_de', 'Deutsch', 'German', 'Allemand', 'Germanicus');
  
INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'Sprache_en', 'Englisch', 'English', 'Anglais', 'Anglicus');
  
INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'Sprache_fr', 'Französisch (nur Felder)', 'French (fields only)', 'Français (champs uniquement)', ' Gallica (agros tantum)');
  
INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'Sprache_la', 'Latein (nur Felder)', 'Latin (fields only)', 'Latin (champs uniquement)', 'Latina (agros tantum)');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('inhaltBearbeiten', 'Titel', 'Inhalt bearbeiten', 'Edit content', 'Modifier le contenu', 'Materia componere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('openLink', 'Titel', 'offene Verknüpfung', 'Open link', 'Lien ouvert', 'Nexus patens');

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Recherche Avancée', `la` = 'Excogitata Inquisitio' WHERE (`ID` = '158');


