DELETE FROM selektion_ort WHERE ID BETWEEN 39 AND 60;

CREATE TABLE person_hatgruppeherkunftareal (
	    ID int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
	    PersonID int unsigned NOT NULL,
	    ArealID int NOT NULL,
	    FOREIGN KEY (PersonID) REFERENCES person(ID),
	    FOREIGN KEY (ArealID) REFERENCES selektion_areal(ID)
	);

INSERT INTO datenbank_mapping (Formular, Datenfeld, de_Beschriftung, Feldtyp, Array, ZielTabelle, ZielAttribut, FormularAttribut, Auswahlherkunft, Seite, gb_beschriftung, fr_beschriftung, la_beschriftung) VALUES ("person", "GruppeHerkunft", "Gruppe Herkunft", "addselect", 1, "person_hatgruppeherkunftareal", "ArealID", "PersonID", "selektion_areal", "person", "Group origin", "Groupe Origine", "Gruppus Originis");
	