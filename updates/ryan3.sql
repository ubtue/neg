
Create Table selektion_beziehung(ID int Not NULL AUTO_INCREMENT, Bezeichnung varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`ID`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


/* Insert default values */
INSERT INTO `neg`.`selektion_beziehung` (ID,Bezeichnung) VALUES (-1,'-');
INSERT INTO `neg`.`selektion_beziehung` (ID,Bezeichnung) VALUES (1,'?');

ALTER TABLE einzelbeleg ADD COLUMN BeziehungGemeinschaftID INT NOT NULL DEFAULT -1 AFTER KonventID,
ADD INDEX `BeziehungGemeinschaftID` (`BeziehungGemeinschaftID`),
ADD CONSTRAINT `einzelbeleg_BeziehungGemeinschaftID` FOREIGN KEY (`BeziehungGemeinschaftID`) REFERENCES `selektion_beziehung` (`ID`);


INSERT INTO `neg`.`datenbank_mapping` (`Formular`, `Datenfeld`, `de_Beschriftung`, `Feldtyp`, `Array`, `ZielTabelle`, `ZielAttribut`, `Auswahlherkunft`, `Seite`, `gb_beschriftung`, `fr_beschriftung`) VALUES ('einzelbeleg', 'BeziehungGemeinschaft', 'Beziehung zur Gemeinschaft', 'select', '0', 'einzelbeleg', 'BeziehungGemeinschaftID', 'selektion_beziehung', 'einzelbeleg', 'Relationship with the community', 'Relation avec la communauté');

ALTER TABLE selektion_amtstandweihe MODIFY Bezeichnung varchar(255);   

ALTER TABLE selektion_angabe MODIFY Bezeichnung varchar(255); 

ALTER TABLE selektion_bearbeitungsstatus MODIFY Bezeichnung varchar(255); 

ALTER TABLE selektion_bewertung MODIFY Bezeichnung varchar(255); 

ALTER TABLE selektion_echtheit MODIFY Bezeichnung varchar(255);

ALTER TABLE selektion_ethnie MODIFY Bezeichnung varchar(255);

ALTER TABLE selektion_geschlecht MODIFY Bezeichnung varchar(255);

ALTER TABLE selektion_grammatikgeschlecht MODIFY Bezeichnung varchar(255);

ALTER TABLE selektion_janein MODIFY Bezeichnung varchar(255);

ALTER TABLE  selektion_kasus MODIFY Bezeichnung varchar(255);

ALTER TABLE  selektion_kontext MODIFY Bezeichnung varchar(255);

ALTER TABLE  selektion_konvent MODIFY Bezeichnung varchar(255);

ALTER TABLE  selektion_kritik MODIFY Bezeichnung varchar(255);

ALTER TABLE  selektion_lebendverstorben MODIFY Bezeichnung varchar(255);

ALTER TABLE  selektion_quellengattung MODIFY Bezeichnung varchar(255);

ALTER TABLE  selektion_verwandtschaftsgrad MODIFY Bezeichnung varchar(255);
