ALTER TABLE person ADD COLUMN Wikidata varchar(255) NULL AFTER GND, ADD INDEX idx_wikidata (Wikidata);

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('person', 'WikiData', 'WIKIDATA', 'textfield', '0', 'person', 'Wikidata', 'person', 'WIKIDATA', 'WIKIDATA', 'WIKIDATA');

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`) VALUES ('person', 'WikidataLink', 'wikidatalink', '0', 'person', 'Wikidata');

UPDATE `neg`.`datenbank_mapping` SET `Datenfeld` = 'IconLink' WHERE Formular = "person" and Datenfeld = "GNDLink";
