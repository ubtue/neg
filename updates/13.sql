SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';
ALTER TABLE einzelbeleg DROP FOREIGN KEY einzelbeleg_QuelleGattungID;
ALTER TABLE selektion_quellengattung MODIFY COLUMN ID INT NOT NULL auto_increment;
ALTER TABLE einzelbeleg ADD CONSTRAINT einzelbeleg_QuelleGattungID FOREIGN KEY (QuelleGattungID) REFERENCES selektion_quellengattung(ID) ON UPDATE CASCADE;
