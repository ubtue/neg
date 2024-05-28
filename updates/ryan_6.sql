UPDATE `neg`.`content` SET `context` = 'CMS', `language` = 'de' WHERE (`Bezeichnung` = 'hilfe.html');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image001.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image002.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image003.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image004.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image005.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image006.png');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('tinyMce', 'ButtonSpeichern', 'Speichern', 'Save', 'sauvegarder', 'Servare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('tinyMce', 'LinkDateiBildVerwaltung', 'Datei & Bild Verwaltung', 'File & image management', 'Gestion des fichiers et des images', 'File & imaginem procuratio');
