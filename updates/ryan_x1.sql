CREATE TABLE `selektion_titelkritik` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Bezeichnung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Bezeichnung` (`Bezeichnung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Einträge einfügen
INSERT INTO selektion_titelkritik (ID, Bezeichnung) VALUES (-1, '-');
INSERT INTO selektion_titelkritik (ID, Bezeichnung) VALUES (1, '?');

ALTER TABLE `einzelbeleg`
ADD COLUMN `TitelKritikID` int DEFAULT -1 NULL AFTER `KritikID`;

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `FormularAttribut`, `Auswahlherkunft`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('einzelbeleg', 'TitelKritik', 'TitelKritik', 'select', '1', 'einzelbeleg_hattitelkritik', 'TitelKritikID', 'EinzelbelegID', 'selektion_titelkritik', 'einzelbeleg', 'Title critique', 'Critique de titre', 'Titulus Critica');


ALTER TABLE einzelbeleg
ADD COLUMN TitelText varchar(255) DEFAULT NULL AFTER TitelKritikID;

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('einzelbeleg', 'TitelText', 'Titel Text', 'textfield', '0', 'einzelbeleg', 'titelText', 'einzelbeleg', 'Title text', 'Texte du titre', 'Titulus textus');

CREATE TABLE einzelbeleg_hattitelkritik (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    EinzelbelegID INT UNSIGNED NOT NULL,
    TitelkritikID INT NOT NULL,
    CONSTRAINT einzelbeleg_hattitelkritik_EinzelbelegID FOREIGN KEY (EinzelbelegID) REFERENCES einzelbeleg(ID),
    CONSTRAINT einzelbeleg_hattitelkritik_TitelkritikID FOREIGN KEY (TitelkritikID) REFERENCES selektion_titelkritik(ID)
);

