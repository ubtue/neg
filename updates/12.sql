#Clean up CM References
DELETE from datenbank_mapping where Formular = "quelle" and Datenfeld = "CMRef";
DELETE from datenbank_mapping where Formular = "quelle" and Datenfeld = "CMLink";
