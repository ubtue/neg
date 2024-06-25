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

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'ContextWahl', 'Context auswählen', 'Select context', 'Sélectionnez le contexte', 'Contextum selige');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'Datei', 'Datei', 'File', 'Le Ficher', 'Tabella');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'BeenDeleted', 'wurde gelöscht', 'has been deleted', 'a été supprimé', 'deleta est');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FileNotDeleted', 'Datei kann nicht gelöscht werden', 'File cannot be deleted', 'Le fichier ne peut pas être supprimé', 'Tabella deleri non potest');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FileNotReplaced', 'kann nicht ersetzt werden', 'cannot be replaced', 'ne peut pas être remplacé', 'non potest substitui');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FileCreated', 'wurde erstellt', 'has been created', 'a été créé', 'creata est');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet ', 'NoFile', 'Sie haben keine Datei ausgewählt !', 'You have not selected a file !', 'Vous n\'avez pas sélectionné de fichier !', 'Non tabellam elegisti !');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FileUpdate', 'wurde aktualisiert', 'has been updated', 'a été mis à jour', 'renovata est');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FilesDontMatch', 'Dateinamen stimmen nicht überein', 'File names do not match', 'Les noms de fichier ne correspondent pas', 'Nomina tabellarum non congruunt');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'Und', 'und', 'and', 'et', 'et');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FileNotAllowed', 'Dateityp nicht erlaubt. Bitte wenden Sie sich an den Administrator.', 'file type not allowed. Please contact the administrator.', 'Type de fichier non autorisé. Veuillez contacter l\'administrateur.', 'Genus tabellae non licet. Quaeso contactu administrator.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FileExist', 'existiert bereits im Context:', 'already exists in the context:', 'existe déjà dans le contexte:', 'iam exstat in contextu:');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('contentServlet', 'FileSuccess', 'erfolgreich hochgeladen !', 'uploaded successfully !', 'téléchargé avec succès !', 'feliciter sublata est !');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'NoFileChosen', 'keine Datei ausgewählt', 'No file chosen', 'Aucun fichier sélectionné', 'Nullus fasciculus electus');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'ChooseFiles', 'Dateien auswählen', 'Choose files', 'Choisir des fichiers', 'Fasciculos eligere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Upload', 'Hochladen', 'Upload', 'Télécharger', 'Uploadare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'Sprache_fr_2', 'Französisch', 'French', 'Français', 'Gallica');

UPDATE `neg`.`datenbank_texte` SET `la` = 'Gallica (agros tantum)' WHERE (`ID` = '234');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('sprachauswahl', 'Sprache_la_2', 'Latein', 'Latin', 'Latin', 'Latina');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Pfad', 'Pfad', 'Path', 'Chemin', 'Semita');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Vorschau', 'Vorschau', 'Preview', 'Aperçu', 'Praevideo');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Aktionen', 'Aktionen', 'Actions', 'Actions', 'Actiones');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'DateiErstellen', 'Datei erstellen', 'Create file', 'Créer un fichier', 'tabellam creare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'HtmlBearbeiten', 'HTML Bearbeiten (TinyMCE)', 'Edit HTML (TinyMCE)', 'Modifier HTML (TinyMCE)', 'HTML Edere (TinyMCE)');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Delete', 'Löschen', 'Delete', 'Supprimer', 'Delere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Ersetzen', 'Ersetzen', 'Replace', 'Remplacer', 'Reponere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'ChooseFile', 'Datei auswählen', 'Choose file', 'Choisir un fichier', 'Elige fasciculum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'reallyDelete', 'wirklich löschen?', 'really delete?', 'vraiment supprimer?', 'vere delere?');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'reallyReplace', 'wirklich ersetzen?', 'really replace?', 'vraiment remplacer?', 'vere reponere?');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Namenkommentar', 'NAMENKOMMENTAR', 'NAME COMMENT', 'COMMENTAIRE DE NOM', 'COMMENTARIUS NOMINIS');
		
INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Quellenkommentar', 'QUELLENKOMMENTAR', 'SOURCE COMMENT', 'COMMENTAIRE SOURCE', 'COMMENTARIUS FONTIUM');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('fileManagement', 'Überlieferungskommentar', 'ÜBERLIEFERUNGSKOMMENTAR', 'TRANSMISSION COMMENTARY', 'COMMENTAIRE DE TRANSMISSION', 'COMMENTARIUS TRADITIONIS'); 

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('impressum', 'Titel', 'Impressum', 'Imprint', 'Mentions légales', 'Imprimatur');

-- Kommentar: Datenbank.html (de)
INSERT INTO content (Bezeichnung, contentType, content, context, language) VALUES ('datenbank.html', 'text/html', 0x3c683220636c6173733d2275742d68656164696e672075742d68656164696e672d2d6832223e446174656e62616e6b3c2f68323e0a0a3c703e205570646174653a2032302e204a756c692032303230202d2031323a3334202d205075626c69736865643a2031362e204a756c692032303038202d2031303a33363c2f703e0a3c703e266e6273703b3c2f703e0a3c703e44696520446174656e62616e6b20656e7468c3a46c74207a75727a65697420696e73676573616d74206d65687220616c732037302e3030302070726f736f706f677261706869736368650a202020756e64206f6e6f6d61737469736368652045696e7a656c62656c6567652c206469652072756e642033302e30303020506572736f6e656e207a7567656f72646e65742073696e642e20566f6c6c656e205a7567616e67207a752064696573656d0a2020204d6174657269616c20686162656e20766f7265727374206e7572204d6974676c6965646572206465722047727570706520e2809e4e6f6d656e2065742047656e73e2809c2e204869657266c3bc72206973742065696e6520416e6d656c64756e67206d69740a20202070657273c3b66e6c696368656d2042656e75747a65726e616d656e20756e642050617373776f7274206e6f7477656e6469672e3c2f703e0a3c703ec39c6265722064656e20427574746f6e206f62656e20617566206469657365722053656974652067656c616e67656e2053696520696e2064656e206265726569747320c3b66666656e746c696368207a7567c3a46e676c696368656e205465696c0a20202064657220446174656e62616e6b2e2044696573657220756d666173737420696d204d6f6d656e742072756e642032312e3530302045696e7a656c62656c6567652e2057656e6e2053696520496e7465726573736520616e0a202020776569746572676568656e64656e205a756772696666737265636874656e20686162656e2c2077656e64656e20536965207369636820626974746520616e203c6120636c6173733d2275742d6c696e6b2075742d6c696e6b2d2d656d61696c2075742d6c696e6b2d2d626c6f636b2075742d6c696e6b2d2d636f6e746578742d69636f6e22207461726765743d225f746f70220a202020687265663d226d61696c746f3a6e656740756e692d74756562696e67656e2e646522203e6e656740756e692d74756562696e67656e2e64653c2f613e2e3c2f703e0a3c70207374796c653d2277686974652d73706163653a206e6f777261703b223e486965722066696e64656e205369652077656974657265203c6120636c6173733d2275742d6c696e6b2075742d6c696e6b2d2d696e7465726e616c2075742d6c696e6b2d2d626c6f636b220a202020687265663d222f6e65672f676173742f696e666f733f73686172656448746d6c3d68696c6665223e48696e7765697365207a75722053756368653c2f613e2e0a3c2f703e0a0a0a, 'CMS', 'de');



