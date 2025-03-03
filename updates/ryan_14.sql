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

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Login', 'Login', 'Login', 'Connexion', 'Accessus');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'E-mail', 'E-Mail', 'Email', 'E-mail', 'Epistula electronica');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Projektgruppe', 'Projektgruppe', 'Project Group', 'Groupe de projet', 'Grex operum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Admin', 'Admin.', 'Admin.', 'Admin.', 'Admin.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Language', 'Sprache', 'Language', 'Langue', 'Lingua');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Bearbeiten', 'Bearbeiten', 'Edit', 'Modifier', 'Editare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Aendern', 'ändern', 'change', 'changer', 'mutare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'AktiveBenutzer', 'Aktive Benutzer', 'Active Users', 'Utilisateurs actifs', 'Usus activos');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'InaktiveBenutzer', 'Inaktive Benutzer', 'Active Users', 'Utilisateurs inactifs', 'Usus inactivos');

UPDATE `neg`.`datenbank_texte` SET `la` = 'Epistula electronica' where Formular = "einstellungen" and Textfeld = "Email";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Epistulae electronicae inscriptio iam adhibetur.' where Formular = "einstellungen" and Textfeld = "EmailBesetzt";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Inscribe infra epistulam electronicam tuam.' where Formular = "login" and Textfeld = "EingabeEmail";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Systema nostrum tibi vinculum ad epistulam electronicam tuam mittet.' where Formular = "login" and Textfeld = "SendetEmail";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Preme vinculum in epistula electronica tua, et ad restitutionem tesserae redirectus eris.' where Formular = "login" and Textfeld = "KlickLink";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Epistula electronica tua registranda' where Formular = "login" and Textfeld = "RegistrierteEmail";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Feliciter, quaeso vade ad epistulam electronicam tuam et vinculum preme.' where Formular = "login" and Textfeld = "ErfolgGeheZuEmail";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Ja', 'Ja', 'Yes', 'Oui', 'Ita');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Administrator', 'Administrator', 'Administrator', 'Administrateur', 'Administrator');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Abbrechen', 'Abbrechen', 'Cancel', 'Annuler', 'Rescinde');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Anlegen', 'Anlegen', 'Create', 'Créer', 'Creare');

UPDATE `neg`.`datenbank_texte` SET  `de` = 'Benutzer Verw.', `gb` = 'Users Mgmt.', `fr` = 'Util. gest.', `la` = 'Socius adm.' where Formular = "administration" and Textfeld = "TabBenutzerVerwalten";

UPDATE `neg`.`datenbank_texte` SET `de` = 'Neuer Benutzer', `gb` = 'New User', `fr` = 'Utilisateur nouveaux', `la` = 'Socius novus' where Formular = "administration" and Textfeld = "TabBenutzerNeu";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Select Fields', `fr` = 'Champs de sélection', `la` = 'Selectio datorum' where Formular = "administration" and Textfeld = "TabAuswahlfelder";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'BearbeitenKlein', 'bearbeiten', 'edit', 'modifier', 'editare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'zusammenfuehren', 'zusammenführen', 'merge', 'fusionner', 'coniungere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Aufteilen', 'aufteilen', 'split', 'diviser', 'dividere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Baumstruktur', 'Baumstruktur', 'Tree structure', 'Structure arborescente', 'Structura arboris');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'BenutzerNameLeer', 'Benutzername ist leer.', 'Username is empty', 'Le nom d\'utilisateur est vide', 'Nomen usoris vacuum est');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'NachnameLeer', 'Nachname ist leer.', 'Last name is empty.', 'Le nom de famille est vide.', 'Nomen familiae vacuum est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'VornameLeer', 'Vorname ist leer.', 'First name is empty.', 'Le prénom est vide.', 'Praenomen vacuum est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'EmailLeer', 'E-Mail ist leer.', 'Email is empty.', 'L\'e-mail est vide.', 'Epistula electronica vacua est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'KennwortLeer', 'Kennwort ist leer.', 'Password is empty.', 'Le mot de passe est vide.', 'Tessera vacua est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Bezeichnung', 'Bezeichnung', 'Designation', 'Désignation', 'Designatio');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ProvenanceSource', 'Provenienzquelle', 'Provenance Source', 'Source de provenance', 'Fons Provenientiae');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ProvenanceID', 'Provenienz ID', 'Provenance ID', 'Provenance ID', 'Provenientiae ID');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ProvenanceDB', 'Provenienz (DB)', 'Provenance (DB)', 'Provenance (DB)', 'Provenientiae (DB)');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ProvenanceInfo', 'Provenienz info', 'Provenance info', 'Infos sur la provenance', 'Notitia Provenientiae');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'BaumstrukturBearbeiten', 'Baumstruktur bearbeiten', 'Edit tree structure', 'Modifier la structure arborescente', 'Structuram arboris modificare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Tabelle', 'Tabelle', 'Table', 'Tableau', 'Tabula');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'DragAndDrop', 'Bitte verwenden Sie Drag-and-Drop zum Verschieben der Einträge auf andere Ebenen.', 'Please use drag-and-drop to move entries to other levels.', 'Veuillez utiliser le glisser-déposer pour déplacer les entrées vers d\'autres niveaux.', 'Quaeso ut drag-and-drop utaris ad elementa ad alia gradus transferenda.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'AllesZuklappen', 'Alles zuklappen', 'Collapse all', 'Tout replier', 'Omnia claudere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'AllesAufklappen', 'Alles aufklappen', 'Expand all', 'Tout déplier', 'Omnia pandere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Beschriftung', 'Beschriftung', 'Label', 'Étiquette', 'Titulus');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Umbenennen', 'umbenennen', 'rename', 'renommer', 'renominare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'BeschriftungLeer', 'Beschriftung darf nicht leer sein.', 'Label cannot be empty.', 'L\'étiquette ne peut pas être vide.', 'Titulus non esse vacuus potest.');

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Error', `fr` = 'Erreur', `la` = 'Error' where Formular = "einstellungen" and Textfeld = "Fehler";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Auswahl', 'Auswahl', 'Selection', 'La sélection', 'Electio');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'existiertBereits', 'existiert bereits und wurde daher nicht angelegt.', 'already exists and was therefore not created.', 'existe déjà et n\'a donc pas été créée.', 'iam exstat et ideo non creata est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'AuswahlAngelegt', 'erfolgreich angelegt.', 'successfully created.', 'créée avec succès.', 'prospere creata est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'AbbrechenKlein', 'abbrechen', 'cancel', 'annuler', 'rescinde');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'WeitereElementeBearbeiten', 'Weitere Elemente bearbeiten', 'Edit more elements', 'Modifier d\'autres éléments', 'Plura elementa corrigere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ZurueckAdministration', 'Zurück zur Administration', 'Back to administration', 'Retour à l\'administration', 'Revertere ad administrationem');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Auswahlenzusammenzuführen', 'existiert bereits, benutzen Sie bitte die Funktion zum Zusammenführen, um beide Auswahlen zusammenzuführen.', 'already exists, please use the merge function to combine both selections.', 'existe déjà, veuillez utiliser la fonction de fusion pour combiner les deux sélections.', 'iam existit, quaeso functionem coniungendi utere ut ambas electiones coniungas.');

UPDATE `neg`.`datenbank_texte` SET `de` = 'zurück', `gb` = 'back', `fr` = 'retour', `la` = 'revertere' where Formular = "einstellungen" and Textfeld = "Zurueck";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ErfolgreichNach', 'erfolgreich nach', 'successfully renamed to', 'renommé avec succès en', 'feliciter in');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Umbenannt', 'umbenannt.', '.', '.', 'renominatus.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('stat', 'ListeDerQuellenAnzahl', 'Liste der Quellen mit Anzahl der Belege', 'List of sources with number of references', 'Liste des sources avec le nombre de références', 'Index fontium cum numero testimoniorum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'AlteAuswahl', 'Alte Auswahl', 'Old Selection', 'Ancienne sélection', 'Vetus selectio');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'NeueAuswahl', 'Neue Auswahl', 'New Selection', 'Nouvelle sélection', 'Nova selectio');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'Verschieben', 'verschieben', 'move', 'déplacer', 'movere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ErrorVerschieben', 'Auswahl kann nicht mit sich selbst zusammengeführt werden.', 'Selection cannot be merged with itself.', 'La sélection ne peut pas être fusionnée avec elle-même.', 'Selectio secum ipsa coniungi non potest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'AufteilenGross', 'Aufteilen', 'Split', 'Diviser', 'Dividere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ErrorAufteilen', 'Keine Werte für Aufteilen.', 'No values for splitting.', 'Aucune valeur pour diviser.', 'Nulla valores ad dividendum.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'WeitereElementeAufteilen', 'Weitere Elemente Aufteilen', 'Divide more elements', 'Divisez plus d\'éléments', 'Plura elementa divide');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'WeitereElementeZusammenfuehren', 'Weitere Elemente zusammenführen', 'Merge more elements', 'Fusionner plus d\'éléments', 'Plura elementa coniunge');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ErrorAufteilenMitSichSelbst', 'Auswahl kann nicht mit sich selbst aufgeteilt werden.', 'Selection cannot be split with itself.', 'La sélection ne peut pas être divisée avec elle-même.', 'Selectio in se ipsa dividi non potest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ErfolgVerschiebenNach', 'erfolgreich zusammengeführt.', 'successfully merged.', '.', 'prospere coniunctum est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ErfolgVerschiebenVon', 'nach', 'to', 'a été fusionné avec succès avec', 'cum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'DarfNichtUmbenanntWerden', '- darf nicht umbenannt werden.', '- may not be renamed.', '- ne peut pas être renommé.', '- renominari non potest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'DarfNichtZusammengefuehrtWerden', '- darf nicht zusammengeführt werden', '- must not be merged', '- ne doit pas être fusionné', '- non coniungendum est');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'DarfNichtAufgeteiltWerden', '- darf nicht aufgeteilt werden.', '- cannot be divided.', '- ne peut pas être divisé.', '- non dividitur.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('admin', 'ErfolgreichAufgeteiltIn', 'Erfolgreich aufgeteilt in', 'Successfully divided into', 'Divisé avec succès dans', 'Successu divisa in');


