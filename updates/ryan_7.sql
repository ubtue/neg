INSERT INTO `neg`.`datenbank_texte` (`Formular`, `Textfeld`, `de`, `gb`, `fr`, `la`) VALUES ('namenkommentar', 'PLemma', 'Philologisches Lemma', 'Philological lemma', 'Lemme philologique', 'Lemma philologicum');

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Lemma', `fr` = 'Lemme', `la` = 'Lemma' WHERE (`ID` = '175');

