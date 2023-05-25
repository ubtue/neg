CREATE TABLE IF NOT EXISTS `neg`.`selektion_konvent` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE (`Bezeichnung`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

INSERT INTO datenbank_mapping (Formular, Datenfeld, de_Beschriftung, Feldtyp, Array, ZielTabelle, ZielAttribut, Auswahlherkunft, Seite, gb_beschriftung, fr_beschriftung, la_beschriftung)
VALUES ("einzelbeleg", "Konvent", "Konvent", "select", 0, "einzelbeleg", "KonventID", "selektion_konvent", "einzelbeleg", "Convent", "Monastère", "Monasterium");

ALTER TABLE einzelbeleg ADD KonventID INT DEFAULT NULL;
