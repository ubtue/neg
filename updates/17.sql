ALTER TABLE einzelbeleg DROP FOREIGN KEY einzelbeleg_QuelleGattungID;
-- this is necessary because the id column contains 0 values. Otherwise an error appears
ALTER TABLE einzelbeleg ADD CONSTRAINT einzelbeleg_QuelleGattungID FOREIGN KEY (QuelleGattungID) REFERENCES selektion_quellengattung(ID) ON UPDATE CASCADE;
SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';
ALTER TABLE selektion_quellengattung MODIFY COLUMN ID INT NOT NULL AUTO_INCREMENT;
-- restore sql mode
SET SESSION sql_mode=default;
