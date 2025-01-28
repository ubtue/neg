UPDATE `neg`.`datenbank_texte` SET `gb` = 'Text Attestor' where Formular = "handschrift" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Open Link' where Formular = "openLink" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Advanced Search', `fr` = 'Recherche avancée', `la` = 'Quaesitio provecta' where Formular = "freie_suche" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Log Out' where Formular = "abmelden" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Inhalt Bearbeiten', `gb` = 'Edit Content' where Formular = "inhaltBearbeiten" and Textfeld = "Titel";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('titelNavigation', 'Neu', 'Neu', 'New', 'Nouveau', 'Novus');

UPDATE `neg`.`datenbank_texte` SET `de` = 'Speichern', `gb` = 'Save', `fr` = 'Sauvegarder', `la` = 'Servare' where Formular = "navigation" and Textfeld = "Speichern";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Zurücksetzen', `gb` = 'Reset', `fr` = 'Annuler', `la` = 'Reponere' where Formular = "navigation" and Textfeld = "Abbrechen";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('navigation', 'Duplizieren', 'Duplizieren', 'Duplicate', 'Dupliquer', 'Duplicare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('navigation', 'Filter', 'Filter', 'Filter', 'Filtrer', 'Filtrare');

ALTER TABLE datenbank_filter CHANGE Bezeichnung de varchar(255) NULL;



