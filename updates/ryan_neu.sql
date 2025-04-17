UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Dating of the Reference', `fr_beschriftung` = 'Datation de la référence', `la_beschriftung` = 'Testimonii definitio temporis' where Formular = "gast_einzelbeleg" and Datenfeld = "Datierung";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = ' Kurztitel', `gb_beschriftung` = ' Short-title', `fr_beschriftung` = 'Abrévation du titre', `la_beschriftung` = 'Inscriptio abbreviata' where Formular = "einzelbeleg" and Datenfeld = "QuelleLink";

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_einzelbeleg', 'Edition', 'Edition', 'sqlselect', '0', 'einzelbeleg', 'EditionID', 'einzelbeleg', 'Edition', 'Édition', 'Editio');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_einzelbeleg', 'EditionKapitel', 'Kapitel', 'textfield', '0', 'einzelbeleg', 'EditionKapitel', 'einzelbeleg', 'Chapter', 'Chapitre', 'Capitulum');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_einzelbeleg', 'EditionSeite', 'Seite', 'textfield', '0', 'einzelbeleg', 'EditionSeite', 'einzelbeleg', 'Page', 'Page', 'Pagina');

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Person', `gb_beschriftung` = 'Person', `fr_beschriftung` = 'Personne', `la_beschriftung` = 'Persona' WHERE Formular = "person" and Datenfeld = "Standardname";

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_person', 'Identifizierungsproblem', 'Kommentar', 'textarea', '0', 'person', 'Identifizierungsproblem', 'Comment', 'Commentaire', 'Commentarius');

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Ämter', `gb_beschriftung` = 'Offices', `fr_beschriftung` = 'Fonctions', `la_beschriftung` = 'Officia' WHERE Formular = "person" and Datenfeld = "AmtWeihe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Dating', `fr_beschriftung` = 'Datation', `la_beschriftung` = 'Definitio temporis' WHERE Formular = "gast_quelle" and Datenfeld = "Datierung";

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_quelle', 'WeitereEditionen', 'Weitere Editionen', 'Further Editions', 'Éditions supplémentaires', 'Editiones alterae');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('freie_suche', 'ErstZweitGlied', 'Erst-/ ZweitGlied', 'select', '0', 'First/ Second part', 'Première/ Deuxième partie', 'Prima/ Secunda pars');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('freie_suche', 'Sortierung1', 'Gruppieren nach', 'textfield', '0', 'sort according to', 'trier par', 'primo in genera digerere');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('freie_suche', 'Sortierung2', 'Anschließend nach', 'textfield', '0', 'afterwards according to', 'ensuite par', 'deinde');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('freie_suche', 'Sortierung3', 'Dann nach', 'textfield', '0', 'finally according to', 'finalement par', 'postremo');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('startseite', 'Datenschutzerklaerung', 'Datenschutzerklärung', 'Privacy Policy', 'Politique de confidentialité', 'Declaratio secreti');
