-- this is necessary because the id column contains 0 values. Otherwise an error appears
SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';
ALTER TABLE einzelbeleg DROP FOREIGN KEY einzelbeleg_QuelleGattungID;
ALTER TABLE einzelbeleg ADD CONSTRAINT einzelbeleg_QuelleGattungID FOREIGN KEY (QuelleGattungID) REFERENCES selektion_quellengattung(ID) ON UPDATE CASCADE;
ALTER TABLE selektion_quellengattung MODIFY COLUMN ID INT NOT NULL auto_increment;
-- restore sql mode
SET SESSION sql_mode=default;

INSERT INTO datenbank_texte (Formular, Textfeld, de, gb, fr, la) VALUES ('navigation', 'InhaltBearbeiten', 'Inhalt bearbeiten', 'edit content', 'modifier le contenu', 'recensere content');

