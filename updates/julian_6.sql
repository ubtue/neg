ALTER TABLE quelle ADD COLUMN QuelleGattungID INT NULL;
ALTER TABLE quelle ADD CONSTRAINT fk_quelle_quellengattungid FOREIGN KEY (QuelleGattungID) REFERENCES selektion_quellengattung(ID);

#optional
#ALTER TABLE einzelbeleg DROP COLUMN QuelleGattungID;
