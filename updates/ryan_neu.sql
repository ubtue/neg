INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'NummerSeite', 'Nr./Seite', 'Nr./S.', 'N°/P.', 'Nr./Pag.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche ', 'Raster', 'Rast.', 'Grid', 'Grille', 'Ret.');

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Edition', `fr_beschriftung` = 'Édition', `la_beschriftung` = 'Editio' WHERE Formular = "quelle" and Datenfeld = "Edition";

UPDATE `neg`.`datenbank_mapping` SET `fr_beschriftung` = 'vivant/mort' WHERE Formular = "freie_suche" and Datenfeld = "Ausgabe_Einzelbeleg_Lebend";

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'VonTag', 'von T.', 'from D.', 'du J.', 'a D.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'VonMonat', 'von M.', 'from M.', 'du M.', 'a M.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'VonJahr', 'von J.', 'from Y.', 'de l’A', 'a A.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'VonJahrhundert', 'von Jh.', 'from C.', 'du S.', 'a S.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche ', 'BisTag', 'bis T.', 'until D.', 'jusq. J.', 'usq. D.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'BisMonat', 'bis M.', 'until M.', 'jusq. M.', 'usq. M.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'BisJahr', 'bis J.', 'until Y.', 'jusq. A.', 'usq. A.');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('suche', 'BisJahrhundert', 'bis Jh.', 'until C.', 'jusq. S.', 'usq. S.');


