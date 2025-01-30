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

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'PasswortVergessen', 'Passwort vergessen?', 'Forgot password?', 'Mot de passe oublié ?', 'Tessera oblita?');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'PasswortUngueltig', 'Ungültiges Passwort', 'Invalid password', 'Mot de passe invalide', 'Tessera invalida');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login ', 'BenutzerExistiertNicht', 'Benutzer existiert nicht', 'User does not exist', 'L\'utilisateur n\'existe pas', 'Usor non existit');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'AktivSchalten', 'Zugriff nicht erlaubt, Ihr Administrator muss Sie auf aktiv schalten!', 'Access not allowed, your administrator must activate you!', 'Accès non autorisé, votre administrateur doit vous activer !', 'Accessus non permittitur, administrator vester vos activare debet!');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'NichtErlaubt', 'Zugriff nicht erlaubt', 'Access not allowed', 'Accès non autorisé', 'Accessus non permittitur');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'PasswortNeuSetzen', 'Die Sicherheit der Datenbank wurde verbessert. Das Passwort muss neu gesetzt werden.', 'The security of the database has been improved. The password must be reset.', 'La sécurité de la base de données a été améliorée. Le mot de passe doit être réinitialisé.', 'Securitas datorum repositorii melior facta est. Tessera nova constituenda est.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'LinkGenerieren', 'Neuen Link generieren', 'Generate new link', 'Générer un nouveau lien', 'Novum vinculum generare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'EingabeEmail', '1. Geben Sie unten Ihre E-Mail Adresse ein.', '1. Enter your email address below.', '1. Entrez votre adresse e-mail ci-dessous.', '1. Inscribe infra inscriptionem electronicam tuam.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'SendetEmail', '2. Unser System sendet Ihnen einen Link an Ihre E-Mail Adresse.', '2. Our system will send you a link to your email address.', '2. Notre système vous enverra un lien à votre adresse e-mail.', '2. Systema nostrum tibi vinculum ad inscriptionem electronicam tuam mittet.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'KlickLink', '3. Klicken Sie den Link in Ihrer E-mail an, sie werden weiter geleitet um Ihr Passwort neu zu setzen.', '3. Click the link in your email, and you will be redirected to reset your password.', '3. Cliquez sur le lien dans votre e-mail, vous serez redirigé pour réinitialiser votre mot de passe.', '3. Preme vinculum in epistula tua electronica, et ad tesserae restitutionem redirectus eris.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'ZurueckLogin', 'Zurück zum Login', 'Back to Login', 'Retour à la connexion', 'Revertere ad nexum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'PasswortNeu', 'Neues Passwort', 'New Password', 'Mot de passe nouveau', 'Tessara nova');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'RegistrierteEmail', 'Ihre Registrierte E-Mail', 'Your registered email', 'Votre e-mail enregistré', 'Inscriptionem electronicam tuam');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'ErrorEmailAdresse', 'Fehler, E-mail Adresse ist nicht registriert versuchen sie einen Link mit einer anderen EMail Adresse zugenerieren.', 'Error, email address is not registered. Try generating a link with a different email address.', 'Erreur, l\'adresse e-mail n\'est pas enregistrée. Essayez de générer un lien avec une autre adresse e-mail.', 'Error, inscriptio electronica non est. Conare vinculum generare cum alia inscriptione electronica.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login ', 'LinkUngueltig', 'Link ist nicht mehr gültig, bitte einen neuen Link generieren.', 'The link is no longer valid, please generate a new link.', 'Le lien n\'est plus valide, veuillez générer un nouveau lien.', 'inculum iam non valet, quaeso novum vinculum genera.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'NeuerLink', 'Neuen Link generieren', 'Generate new link', 'Générer un nouveau lien', 'Novum vinculum generare');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'ResetPasswort', 'Reset Passwort', 'Reset Password', 'Réinitialiser le mot de passe', 'Tessera restituere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'WiederholePasswort', 'Wiederhole neues Passwort', 'Repeat new password', 'Répétez le nouveau mot de passe', 'Novam tesseram repete');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'Reset', 'Reset', 'Reset', 'Réinitialiser', 'Restituere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'PasswortGesetzt', 'Passwort wurde neu gesetzt', 'Password has been reset', 'Le mot de passe a été réinitialisé', 'Tessera nova constituta est');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'ZumLogin', 'Zum Login', 'To login', 'Aller à la connexion', 'Ad login');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'ZuKurz', 'Passwort ist zu kurz, mindestlänge sind 6 Buchstaben.', 'Password is too short, the minimum length is 6 characters.', 'Le mot de passe est trop court, la longueur minimale est de 6 caractères.', 'Tessera nimis brevis est, longitudo minima sex litterae sunt.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'ErrorPasswortWiederholung', 'Passwort wiederholung stimmt nicht überein.', ' Password repeat does not match.', 'La répétition du mot de passe ne correspond pas.', 'Repetitio tesserae non congruit.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'KeineEmailEingegeben', 'Sie haben keine E-mail eingegeben.', 'You have not entered an email.', 'Vous n\'avez pas saisi d\'e-mail.', 'Nullam epistulam electronicam ingressus es.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'PasswortZuruecksetzen', 'Passwort zurücksetzen?', 'Reset password?', 'Réinitialiser le mot de passe ?', 'Tessera restituere?');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'MessageOne', 'Um Ihr Passwort zurückzusetzen, klicken Sie auf den Link.', 'To reset your password, click on the link.', ' Pour réinitialiser votre mot de passe, cliquez sur le lien.', 'Ut tesserae tuae restituantur, in vinculum clicca.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'MessageTwo', 'Der Link ist 24 Stunden gültig.', 'The link is valid for 24 hours.', 'Le lien est valide pendant 24 heures.', 'Vinculum viget per 24 horas.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'Zuruecksetzen', 'Zurücksetzen', 'Reset', 'Réinitialiser', 'Restituere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'ErfolgGeheZuEmail', 'Erfolgreich, bitte gehen Sie zu Ihrer E-mail und benutzen Sie den link.', 'Successful, please go to your email and use the link.', 'Succès, veuillez aller dans votre e-mail et utiliser le lien.', 'Feliciter, quaeso vade ad epistulam tuam electronicam et vinculum utere.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'EmailBetreff', 'Neues Passwort für NEG Zugang', 'New password for NEG access', 'Nouveau mot de passe pour l\'accès NEG', 'Nova tessera pro accessu NEG');

UPDATE `neg`.`datenbank_texte` SET `la` = 'Tessera'  where Formular = "login" and Textfeld = "Passwort";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'DatenSenden', 'Daten absenden', 'Submit data', 'Soumettre les données', 'Submittere data');





