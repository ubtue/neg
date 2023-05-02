CREATE TABLE IF NOT EXISTS `neg`.`selektion_konvent` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('-');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: Kreuzzeichen');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: Zugehörigkeit zu "C" und "LE"');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: Zugehörigkeit zu "CL" (Cluny)');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "C"');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('unbekannter Bezeichner: C');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: Zugehörigkeit zu "C" (?)');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "C" und "P"');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "M" rot durchstrichen');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('unbekannter Bezeichner: F');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('übergeschriebenes "P" und "S"');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('unbekannter Bezeichner: G');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "C" und "S"');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('unbekannter Bezeichner: H');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: Zugehörigkeit zu "LE" (Limoges)');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: Zugehörigkeit zu "L" (?)');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "M"');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('unbekannter Bezeichner: M');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "M" getilgt');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('unbekannter Bezeichner: N');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: Zugehörigkeit zu "?" (?)');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "P"');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('unbekannter Bezeichner: P');
INSERT INTO `neg`.`selektion_konvent` (Bezeichnung) VALUES ('Zusatz: übergeschriebenes "S"');

INSERT INTO datenbank_mapping (Formular, Datenfeld, de_Beschriftung, Feldtyp, Array, ZielTabelle, ZielAttribut, Auswahlherkunft, Seite, gb_beschriftung, fr_beschriftung, la_beschriftung)
VALUES ("einzelbeleg", "Konvent", "Konvent", "select", 0, "einzelbeleg", "KonventID", "selektion_konvent", "einzelbeleg", "Convent", "Monastère", "Monasterium");

ALTER TABLE einzelbeleg ADD KonventID INT DEFAULT NULL;
