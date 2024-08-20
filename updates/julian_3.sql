UPDATE datenbank_mapping SET de_combinedAnzeigenamen = 'Zusatznamenkommentar;;Link',gb_combinedAnzeigenamen = 'Additional name comment;;Link',fr_combinedAnzeigenamen = 'Commentaire sur le nom supplémentaire;;Link',la_combinedAnzeigenamen = 'Commentarium nominis additicius;;Link' WHERE Formular = 'einzelbeleg' AND Datenfeld = 'Lemma';

UPDATE `datenbank_mapping` SET `de_Beschriftung` = 'Zusatznamenkommentar',`gb_Beschriftung` = 'Additional name comment',`fr_Beschriftung` = 'Commentaire sur le nom supplémentaire',`la_Beschriftung` = 'Commentarium nominis additicius'
WHERE (Datenfeld = 'PLemma' AND Formular = 'namenkommentar')
OR (Datenfeld = 'LemmaRO' AND Formular = 'einzelbeleg')
OR (Datenfeld = 'Namenlemma' AND Formular = 'freie_suche')
OR (Datenfeld = 'Ausgabe_Namenlemma' AND Formular = 'freie_suche');

UPDATE `neg`.`datenbank_mapping` SET `Feldtyp` = 'link(mgh_lemma tab,MGHLemmaID,MGHLemma,lemma)' WHERE (`Datenfeld` = 'MGHLemmaRO' AND Formular = 'einzelbeleg');