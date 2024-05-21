INSERT INTO datenbank_mapping (Formular, Datenfeld, Feldtyp, Array, ZielTabelle, ZielAttribut, gb_beschriftung, fr_beschriftung, de_Beschriftung, la_beschriftung) VALUES ("einzelbeleg", "PreKontext", "textarea", 0, "einzelbeleg", "PreKontext","Pre Kontext", "Pré-contexte", "Pre Kontext", "Pre Kontext");

INSERT INTO datenbank_mapping (Formular, Datenfeld, Feldtyp, Array, ZielTabelle, ZielAttribut, gb_beschriftung, fr_beschriftung, de_Beschriftung, la_beschriftung) VALUES ("einzelbeleg", "PostKontext", "textarea", 0, "einzelbeleg", "PostKontext","Post Kontext", "Post-contexte", "Post Kontext", "Post Kontext");


ALTER TABLE einzelbeleg ADD PreKontext mediumtext;

ALTER TABLE einzelbeleg ADD PostKontext mediumtext;