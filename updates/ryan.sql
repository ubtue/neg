UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'moderne Namen', `gb_beschriftung` = 'modern Names', `fr_beschriftung` = 'Noms modernes', `la_beschriftung` = 'moderna nomina' WHERE Formular = "person" and Datenfeld = "Varianten";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Person', `gb_beschriftung` = 'Person', `fr_beschriftung` = 'Personne', `la_beschriftung` = 'Persona' WHERE Formular = "freie_suche" and Datenfeld = "Ausgabe_Person_Standardname";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('stat', 'SortAZ', 'a-z', 'a-z', 'a-z', 'a-z');

UPDATE `neg`.`datenbank_texte` SET `gb` = 'ascending', `fr` = 'ascendant' WHERE Formular = "stat" and Textfeld = "SortUp";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'descending', `fr` = 'descendant' WHERE Formular = "stat" and Textfeld = "SortDown";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('stat', 'SortZA', 'z-a', 'z-a', 'z-a', 'z-a');
