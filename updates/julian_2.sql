UPDATE `datenbank_texte` SET `de` = 'Lemma', `gb` = 'lemma', `fr` = 'lemme', `la` = 'lemma' WHERE textfeld = 'Titel' AND formular = 'mgh_lemma';

UPDATE `datenbank_mapping` SET `de_Beschriftung` = 'Lemma' WHERE Datenfeld = 'MGHLemma' AND formular = 'mgh_lemma';
