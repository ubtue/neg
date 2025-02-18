UPDATE `neg`.`datenbank_texte` SET `gb` = 'Settings', `fr` = 'Paramètres', `la` = 'Configuratio ' where Formular = "einstellungen" and Textfeld = "TabEinstellungen";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Change Password', `fr` = 'Changer le mot de passe', `la` = 'Tesseram mutare' where Formular = "einstellungen" and Textfeld = "TabPasswort";

UPDATE `neg`.`datenbank_texte` SET `fr` = 'Nom d\'utilisateur' where Formular = "login" and Textfeld = "Benutzername";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('einstellungen', 'Nachname', 'Nachname', 'Last Name', 'Nom de famille', 'Nomen');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('einstellungen', 'Vorname', 'Vorname', 'First Name', 'Prénom', 'Praenomen');

UPDATE `neg`.`datenbank_texte` SET `de` = 'E-Mail:', `gb` = 'Email:', `fr` = 'E-mail:', `la` = 'Electronicam tuam:' where Formular = "einstellungen" and Textfeld = "EMail";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Sprache:', `gb` = 'Language:', `fr` = 'Langue:', `la` = 'Lingua:' where Formular = "einstellungen" and Textfeld = "Sprache";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('einstellungen', 'Aktiv', 'Aktiv', 'Active', 'Actif', 'Activus');

UPDATE `neg`.`datenbank_texte` SET `de` = 'Altes Passwort', `gb` = 'Old Password', `fr` = 'Mot de passe vieux', `la` = 'Tessera vetus' where Formular = "einstellungen" and Textfeld = "PasswortAlt";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Neues Passwort', `gb` = 'New Password', `fr` = 'Nouveau mot de passe', `la` = 'Tessara nova' where Formular = "einstellungen" and Textfeld = "PasswortNeu";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Neues Passwort bestätigen', `gb` = 'Confirm New Password', `fr` = 'Mot de passe nouveau confirmation', `la` = 'Confirmare tessera nova' where Formular = "einstellungen" and Textfeld = "PasswortNeuWdh";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Old password is empty.', `fr` = 'Le mot de passe vieux manque.', `la` = 'Tessera vetus deest.' where Formular = "einstellungen" and Textfeld = "FehlerPasswortAltLeer";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'New password is empty.', `fr` = 'Le nouveau mot de passe est vide.', `la` = 'Tessera nova deest.' where Formular = "einstellungen" and Textfeld = "FehlerPasswortNeuLeer";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Repeated new password is empty.', `fr` = 'La répétition du mot de passe manque.', `la` = 'Repetitio tesserae novae deest.' where Formular = "einstellungen" and Textfeld = "FehlerPasswortNeuWdhLeer";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'New password differs from repeated password.', `fr` = 'Le nouveau mot de passe ne correspond pas à la répétition.', `la` = 'Tessera nova non convenit repetitioni.' where Formular = "einstellungen" and Textfeld = "FehlerPasswortNeuUngleich";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Altes Passwort ist falsch.', `gb` = 'Old password is wrong.', `fr` = 'L\'ancien mot de passe est faux.', `la` = 'Tessera vetus falsa est.' where Formular = "einstellungen" and Textfeld = "FehlerPasswortAltFalsch";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Email address is empty. ', `fr` = 'L\'adresse e-mail manque.', `la` = 'Litterae electronicae desunt.' where Formular = "einstellungen" and Textfeld = "FehlerEmailLeer";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Data changed successfully.', `fr` = 'Données modifiées avec succès.', `la` = 'Data efficaciter mutata.' where Formular = "einstellungen" and Textfeld = "ErfolgDaten";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('einstellungen', 'EmailBesetzt', 'Die angegebene E-Mail-Adresse wird bereits verwendet.', 'The specified email address is already in use.', 'L\'adresse e-mail indiquée est déjà utilisée.', 'Litterae electronicae datae iam in usu sunt.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('einstellungen', 'LoginNameBesetzt', 'Benutzername ist bereits vorhanden.', 'Username already exists.', 'Le nom d\'utilisateur existe déjà.', 'Nomen usoris iam exstat.');

UPDATE `neg`.`datenbank_texte` SET `la` = 'Nomen usoris' where Formular = "login" and Textfeld = "Benutzername";
