UPDATE `datenbank_texte` SET `de` = 'Lemma', `gb` = 'lemma', `fr` = 'lemme', `la` = 'lemma' WHERE textfeld = 'Titel' AND formular = 'mgh_lemma';

UPDATE `datenbank_texte` SET `de` = 'Lemma', `gb`='lemma', `fr`='lemme', `la`='lemma' WHERE Textfeld = 'OrderMGH' AND formular = 'freie_suche';

UPDATE `datenbank_mapping` SET `de_Beschriftung` = 'Lemma',`gb_Beschriftung` = 'Lemma',`fr_Beschriftung` = 'Lemme',`la_Beschriftung` = 'Lemma' WHERE Datenfeld = 'MGHLemma' AND formular = 'mgh_lemma';

UPDATE `datenbank_mapping` SET `de_Beschriftung` = 'Lemma',`gb_Beschriftung` = 'Lemma',`fr_Beschriftung` = 'Lemme',`la_Beschriftung` = 'Lemma' WHERE Datenfeld = 'MGHLemma' AND formular = 'freie_suche';

UPDATE `datenbank_mapping` SET `de_Beschriftung` = 'Lemma',`gb_Beschriftung` = 'Lemma',`fr_Beschriftung` = 'Lemme',`la_Beschriftung` = 'Lemma' WHERE Datenfeld = 'Ausgabe_MGHLemma' AND formular = 'freie_suche';

UPDATE `datenbank_mapping` SET `de_Beschriftung` = 'Lemma',`gb_Beschriftung` = 'Lemma',`fr_Beschriftung` = 'Lemme',`la_Beschriftung` = 'Lemma' WHERE Datenfeld = 'MGHLemmaRO' AND formular = 'einzelbeleg';

UPDATE datenbank_mapping SET de_combinedAnzeigenamen = 'Lemma;;Link',gb_combinedAnzeigenamen = 'Lemma;;Link',fr_combinedAnzeigenamen = 'Lemme;;Link',la_combinedAnzeigenamen = 'Lemma;;Link' WHERE formular = 'einzelbeleg' AND Datenfeld = 'MGHLemma';

UPDATE datenbank_mapping SET de_combinedAnzeigenamen = 'Philologisches-Lemma;;Link',gb_combinedAnzeigenamen = 'Philological-Lemma;;Link',fr_combinedAnzeigenamen = 'Lemme-Philologique;;Link',la_combinedAnzeigenamen = 'Lemma-Philologicum;;Link' WHERE formular = 'einzelbeleg' AND Datenfeld = 'Lemma';

UPDATE `datenbank_mapping` SET `de_Beschriftung` = 'Philologisches-Lemma',`gb_Beschriftung` = 'Philological lemma',`fr_Beschriftung` = 'Lemme philologique',`la_Beschriftung` = 'Lemma philologicum'  WHERE Datenfeld = 'PLemma' AND formular = 'namenkommentar';