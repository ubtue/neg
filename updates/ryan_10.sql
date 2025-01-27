UPDATE `neg`.`datenbank_texte` SET `gb` = 'Text Attestor' where Formular = "handschrift" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Open Link' where Formular = "openLink" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Advanced Search', `fr` = 'Recherche avancée', `la` = 'Quaesitio provecta' where Formular = "freie_suche" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Log Out' where Formular = "abmelden" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Inhalt Bearbeiten', `gb` = 'Edit Content' where Formular = "inhaltBearbeiten" and Textfeld = "Titel";


