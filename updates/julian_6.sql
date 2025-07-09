ALTER TABLE quelle ADD COLUMN QuelleGattungID INT NOT NULL DEFAULT '-1';
ALTER TABLE quelle ADD CONSTRAINT fk_quelle_quellengattungid FOREIGN KEY (QuelleGattungID) REFERENCES selektion_quellengattung(ID) ON UPDATE CASCADE;

#optional
#ALTER TABLE einzelbeleg DROP COLUMN QuelleGattungID;

INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Auswahlherkunft`, `Seite`, `gb_beschriftung`, `fr_beschriftung`, `la_beschriftung`) VALUES ('quelle', 'Quellengattung', 'Quellengattung', 'select', '0', 'quelle', 'QuelleGattungID', 'selektion_quellengattung', 'quelle', 'Source type', 'Type de source', 'Typus fontis');
