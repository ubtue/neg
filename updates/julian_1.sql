INSERT INTO datenbank_mapping(Formular, Datenfeld, de_Beschriftung, Feldtyp, Auswahlherkunft, Array, Seite, gb_beschriftung, fr_beschriftung, la_beschriftung)  VALUES ("freie_suche", "ProvenanceEinzelbeleg", "Provenienz (Einzelbeleg)", "select","selektion_provenienz", 0, "freie_suche", "Provenance (Einzelbeleg)", "Provenance (Einzelbeleg)", "Provenance (Einzelbeleg)");
INSERT INTO datenbank_mapping(Formular, Datenfeld, de_Beschriftung, Feldtyp, Array, Seite, gb_beschriftung, fr_beschriftung, la_beschriftung)  VALUES ("freie_suche", "Ausgabe_Provenance_Einzelbeleg", "Provenienz (Einzelbeleg)", "checkbox", 0, "freie_suche", "Provenance (Einzelbeleg)", "Provenance (Einzelbeleg)", "Provenance (Einzelbeleg)");

INSERT INTO datenbank_mapping(Formular, Datenfeld, de_Beschriftung, Feldtyp, Auswahlherkunft, Array, Seite, gb_beschriftung, fr_beschriftung, la_beschriftung)  VALUES ("freie_suche", "ProvenanceLemma", "Provenienz (Lemma)", "select", "selektion_provenienz", 0, "freie_suche", "Provenance (Lemma)", "Provenance (Lemma)", "Provenance (Lemma)");
INSERT INTO datenbank_mapping(Formular, Datenfeld, de_Beschriftung, Feldtyp, Array, Seite, gb_beschriftung, fr_beschriftung, la_beschriftung)  VALUES ("freie_suche", "Ausgabe_Provenance_Lemma", "Provenienz (Lemma)", "checkbox", 0, "freie_suche", "Provenance (Lemma)", "Provenance (Lemma)", "Provenance (Lemma)");

CREATE TABLE IF NOT EXISTS `neg`.`selektion_provenienz` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE (`Bezeichnung`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

/*Insert values*/
INSERT INTO `neg`.`selektion_provenienz` (`ID`,`Bezeichnung`) VALUES (-1,'-');
INSERT INTO `neg`.`selektion_provenienz` (`ID`,`Bezeichnung`) VALUES (0,'NeG');
INSERT INTO `neg`.`selektion_provenienz` (`ID`,`Bezeichnung`) VALUES (1,'DMP');
