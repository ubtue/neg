UPDATE `neg`.`content` SET `context` = 'CMS', `language` = 'de' WHERE (`Bezeichnung` = 'hilfe.html');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image001.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image002.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image003.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image004.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image005.png');
UPDATE `neg`.`content` SET `context` = 'CMS' WHERE (`Bezeichnung` = 'image006.png');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('tinyMce', 'ButtonSpeichern', 'Speichern', 'Save', 'sauvegarder', 'Servare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('tinyMce', 'LinkDateiBildVerwaltung', 'Datei & Bild Verwaltung', 'File & image management', 'Gestion des fichiers et des images', 'File & imaginem procuratio');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'h2', 'Html Dateien & Bilder verwalten', 'Manage HTML Files & Images', 'Gérer les fichiers HTML et les images', 'Administrare HTML tabellas et imagines');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'p1', 'Wenn sie eine Datei löschen, dann ist auch jede Verknüpfung im Programm gelöscht,', 'If you delete a file, every link in the program is also deleted,', 'Si vous supprimez un fichier, tous les liens vers celui-ci dans le programme', 'Si fasciculum deles, omne vinculum in programmatis etiam deletum est,');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'p2', 'auch wenn Sie die Datei mit gleichem Namen hochladen.', 'even if you upload the file with the same name.', 'seront également supprimés, même si vous téléchargez un fichier avec le même nom.', 'etiam si tabellam eodem nomine imposuisti.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'p3', 'Wenn sie aber Ersetzen wählen, dann bleiben die Verknüpfungen im Programm bestehen.', 'But if you choose to replace, the links in the program will remain.', 'Cependant, si vous choisissez Remplacer, les liens restent dans le programme.', 'Sed si eliges substituere, nexus in programmate manebunt.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'ErrorLoeschen', 'Datei kann nicht gelöscht werden', 'File cannot be deleted', 'Le fichier ne peut pas être supprimé', 'File non potest deleri');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet ', 'ErrorErsetzen', 'Datei kann nicht ersetzt werden', 'File cannot be replaced', 'Le fichier ne peut pas être remplacé', 'Tabella non potest substitui');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'ErrorDateiWahl', 'Sie haben keine Datei ausgewählt', 'You have not selected a file', 'Vous n\'avez pas sélectionné de fichier', 'Tabellam non selegeris');



