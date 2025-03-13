INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('error', 'PhilologischerKommentarID', 'Philologischer Kommentar ID ist nicht vorhanden.', 'Philological commentary ID is not available.', 'L\'ID du commentaire philologique n\'est pas disponible.', 'Commentatio philologica ID non adest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('error', 'LemmaID', 'Lemma ID ist nicht vorhanden.', 'Lemma ID is not available.', 'L\'ID du Lemme n\'est pas disponible.', 'Lemma ID non adest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('error', 'EinzelbelegID', 'Einzelbeleg ID ist nicht vorhanden.', 'Single Reference ID is not available.', 'L\'ID de la référence individuelle n\'est pas disponible.', 'Testimonium ID non adest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('error', 'PersonID', 'Person ID ist nicht vorhanden.', 'Person ID is not available.', 'L\'ID de la personne n\'est pas disponible.', 'Persona ID non adest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('error', 'QuellenID', 'Quellen ID ist nicht vorhanden.', 'Source ID is not available.', 'L\'ID de la source n\'est pas disponible.', 'Fons ID non adest.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('error', 'EditionID', 'Edition ID ist nicht vorhanden.', 'Edition ID is not available.', 'L\'ID de l\'édition n\'est pas disponible.', 'Editio ID non adest.');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Auswahlherkunft`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('handschrift', 'Bearbeitungsstatus', 'Bearbeitungsstatus', 'select', '0', 'handschrift_ueberlieferung', 'BearbeitungsstatusID', 'selektion_bearbeitungsstatus', 'handschrift', 'Processing status', 'Statut de traitement', 'Status tractandi');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Auswahlherkunft`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('edition', 'Bearbeitungsstatus', 'Bearbeitungsstatus', 'select', '0', 'edition', 'BearbeitungsstatusID', 'selektion_bearbeitungsstatus', 'edition', 'Processing status', 'Statut de traitement', 'Status tractandi');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Testweise', 'Testweise gibt es hier eine für die Philologen Interessante Liste\n                        zu {Link} dieser Person.{end}', 'For philologists, there is an interesting list available here, related to {Link} this person.{end}', 'À titre d\'essai, voici une liste intéressante pour les philologues, concernant {Link} cette personne.{end}', 'Probationis causa hic est index philologis interesting, qui ad {Link} hanc personam pertinet.{end}');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Abbrechen', 'abbrechen', 'cancel', 'annuler', 'rescinde');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Suchen', 'suchen', 'search', 'rechercher', 'quaerere');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Folgt', 'folgt!', 'follows!', 'suit !', 'sequitur!');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche ', 'Belegform', 'Belegform', 'Form of Reference', 'Forme de la référence', 'Forma Testimonii');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Amt', 'Amt', 'Office', 'Fonction', 'Officium');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche ', 'Ausgabefelder', 'Ausgabefelder', 'Output fields', 'Champs de sortie', 'Agri exitus');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Zusatz', 'Zusatz', 'Addition', 'Ajout', 'Additamentum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche ', 'DatumErsteNennung', 'Datum erste Nennung', 'Date of first mention', 'Date de la première mention', 'Dies primae mentionis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'DatumLetzteNennung', 'Datum letzte Nennung', 'Date of last mention', 'Date de la dernière mention', 'Dies ultimae mentionis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Handschrift', 'Handschrift', 'Handwriting', 'Écriture manuscrite', 'Scriptura manu');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Kurztitel', 'Kurztitel', 'Short title', 'Titre abrégé', 'Titulus brevis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Zwischenlemma', 'Zwischenlemma', 'Intermediate lemma', 'Lemme intermédiaire', 'Lemma intermedium');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Namenelement', 'Namenelement', 'Name element', 'Élément du nom', 'Elementum nominis');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Link', 'Link', 'Link', 'Lien', 'Vinculum');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'Person', 'Person', 'Person', 'Personne', 'Persona');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'SigleVariante', 'Sigle: Variante', 'Siglum: Variant', 'Sigle : Variante', 'Sigla: Varietas');
