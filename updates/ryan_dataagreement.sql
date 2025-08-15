ALTER TABLE content ADD COLUMN version INT NOT NULL DEFAULT 1 After language;

ALTER TABLE content ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP After version;

ALTER TABLE benutzer ADD COLUMN data_agreement_version_de INT NOT NULL DEFAULT 0 After IstReadOnly;

ALTER TABLE benutzer ADD COLUMN data_agreement_accepted_at_de TIMESTAMP NULL AFTER data_agreement_version_de;

ALTER TABLE benutzer ADD COLUMN data_agreement_version_gb INT NOT NULL DEFAULT 0 After data_agreement_accepted_at_de;

ALTER TABLE benutzer ADD COLUMN data_agreement_accepted_at_gb TIMESTAMP NULL AFTER data_agreement_version_gb;

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'Zustimmen', 'Zustimmen', 'Agree', 'Accepter', 'Assentior');

INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('login', 'Datenvereinbarung', 'Datenvereinbarung', 'Data Agreement', 'Accord de données', 'Pactio datorum');

/*
    In order for the program to run, you need a German and an English version right from the start.
    Here are two simple example files for the DE and GB data agreements.
    You can upload different ones later or use these and edit them in TinyMCE.

*/

INSERT INTO content (Bezeichnung, contentType, content, context, language) VALUES ('dataagreement.html', 'text/html', 0x0a3c68313e446174612041677265656d656e74204578616d706c653c2f68313e0a3c703e54686973206973207468652074657874206f662074686520646174612070726f63657373696e672061677265656d656e742e20506c656173652072656164206974206361726566756c6c79206265666f72652070726f63656564696e672e3c2f703e, 'CMS', 'gb');

INSERT INTO content (Bezeichnung, contentType, content, context, language) VALUES ('dataagreement.html', 'text/html', 0x0a3c68313e446174612041677265656d656e7420426569737069656c3c2f68313e0a3c703e486965722073746568742064657220546578742064657320446174656e766572617262656974756e677361626b6f6d6d656e732e204269747465206c6573656e205369652064696573656e20736f726766c3a46c7469672064757263682c206265766f722053696520666f727466616872656e2e3c2f703e, 'CMS', 'de');
