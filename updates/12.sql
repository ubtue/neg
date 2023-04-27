#Clean up CM References
DELETE FROM datenbank_mapping WHERE Formular = "quelle" AND Datenfeld = "CMRef";
DELETE FROM datenbank_mapping WHERE Formular = "quelle" AND Datenfeld = "CMLink";
DELETE FROM datenbank_mapping WHERE Formular = "person" AND Datenfeld = "CMRef";
DELETE FROM datenbank_mapping WHERE Formular = "person" AND Datenfeld = "CMLink";
