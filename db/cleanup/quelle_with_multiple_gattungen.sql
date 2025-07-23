#Temp Table für Import
DROP TABLE IF EXISTS bereinigung_csv;

CREATE TABLE bereinigung_csv (
    QuelleID INT,
    quelle_bezeichnung VARCHAR(255),
    anzahl_gattungen INT,
    gattungen_ids VARCHAR(255),
    gattungen_bezeichnungen VARCHAR(255),
    gattungen_NEU VARCHAR(255)
);

LOAD DATA INFILE '/var/lib/mysql-files/quelle_with_multiple_gattungen-2.csv'
INTO TABLE bereinigung_csv
FIELDS TERMINATED BY ';'
IGNORE 2 LINES
(QuelleID, quelle_bezeichnung, anzahl_gattungen, gattungen_ids, gattungen_bezeichnungen, gattungen_NEU);

UPDATE einzelbeleg
JOIN quelle ON einzelbeleg.QuelleID = quelle.ID
JOIN bereinigung_csv ON quelle.Bezeichnung = bereinigung_csv.quelle_bezeichnung
JOIN selektion_quellengattung ON selektion_quellengattung.Bezeichnung = bereinigung_csv.gattungen_NEU
SET einzelbeleg.QuelleGattungID = selektion_quellengattung.ID;

DROP TABLE bereinigung_csv;

ALTER TABLE quelle ADD COLUMN QuelleGattungID INT NOT NULL DEFAULT '-1';
ALTER TABLE quelle ADD CONSTRAINT fk_quelle_quellengattungid FOREIGN KEY (QuelleGattungID) REFERENCES selektion_quellengattung(ID) ON UPDATE CASCADE;

#optional
#ALTER TABLE einzelbeleg DROP COLUMN QuelleGattungID;

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Auswahlherkunft`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('quelle', 'Quellengattung', 'Quellengattung', 'select', '0', 'quelle', 'QuelleGattungID', 'selektion_quellengattung', 'quelle', 'Source type', 'Type de source', 'Typus fontis');

#migration
UPDATE quelle q
JOIN (
  SELECT QuelleID, MAX(QuelleGattungID) AS QuelleGattungID
  FROM einzelbeleg
  WHERE QuelleGattungID IS NOT NULL
  GROUP BY QuelleID
) e ON q.ID = e.QuelleID
SET q.QuelleGattungID = e.QuelleGattungID;
