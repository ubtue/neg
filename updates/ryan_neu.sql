UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Dating of the Reference', `fr_beschriftung` = 'Datation de la référence', `la_beschriftung` = 'Testimonii definitio temporis' where Formular = "gast_einzelbeleg" and Datenfeld = "Datierung";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = ' Kurztitel', `gb_beschriftung` = ' Short-title', `fr_beschriftung` = 'Abrévation du titre', `la_beschriftung` = 'Inscriptio abbreviata' where Formular = "einzelbeleg" and Datenfeld = "QuelleLink";

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_einzelbeleg', 'Edition', 'Edition', 'sqlselect', '0', 'einzelbeleg', 'EditionID', 'einzelbeleg', 'Edition', 'Édition', 'Editio');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_einzelbeleg', 'EditionKapitel', 'Kapitel', 'textfield', '0', 'einzelbeleg', 'EditionKapitel', 'einzelbeleg', 'Chapter', 'Chapitre', 'Capitulum');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('gast_einzelbeleg', 'EditionSeite', 'Seite', 'textfield', '0', 'einzelbeleg', 'EditionSeite', 'einzelbeleg', 'Page', 'Page', 'Pagina');
