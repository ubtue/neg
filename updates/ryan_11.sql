UPDATE `neg`.`datenbank_texte` SET `gb` = 'Editor', `fr` = 'Rédacteur', `la` = 'Editor' where  Formular = "mgh_lemma" and Textfeld = "TabBearbeiter";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'References', `fr` = 'Références', `la` = 'Testimonia' where  Formular = "mgh_lemma" and Textfeld = "TabBelege";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Remarks', `fr` = 'Remarques', `la` = 'Commentaria' where Formular = "mgh_lemma" and Textfeld = "TabBemerkungen";

UPDATE `neg`.`datenbank_texte` SET `la` = 'Testimonia' where Formular = "einzelbeleg" and Textfeld = "Titel";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Als Bearbeiter hinzufügen', `gb_beschriftung` = 'Add as editor', `fr_beschriftung` = 'Ajouter comme rédacteur', `la_beschriftung` = 'Addere ut editor' where Formular = "mgh_lemma" and Datenfeld = "BearbeiterNeu";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Als Korrektor hinzufügen', `gb_beschriftung` = 'Add as revisor', `fr_beschriftung` = 'Ajouter comme correcteur', `la_beschriftung` = 'Addere ut corrector' where Formular = "mgh_lemma" and Datenfeld = "KorrektorNeu";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Editor', `fr` = 'Rédacteur', `la` = 'Editor' where Formular = "mgh_lemma" and Textfeld = "Bearbeiter";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Revisor', `fr` = 'Correcteur', `la` = 'Corrector' where Formular = "mgh_lemma" and Textfeld = "Korrektor";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Date', `fr` = 'Date', `la` = 'Dies' where Formular = "mgh_lemma" and Textfeld = "Datum";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Time', `fr` = 'Temps', `la` = 'Hora' where Formular = "mgh_lemma" and Textfeld = "Uhrzeit";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Form of Reference', `fr` = 'Forme de la référence', `la` = 'Forma testimonii' where Formular = "mgh_lemma" and Textfeld = "Belegform";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Person', `fr` = 'Personne', `la` = 'Persona' where Formular = "mgh_lemma" and Textfeld = "Person";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Standard Name', `fr` = 'Nom standard', `la` = 'Nomen standard' where Formular = "mgh_lemma" and Textfeld = "Standardname";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating', `fr` = 'Datation', `la` = 'Datatio' where Formular = "mgh_lemma" and Textfeld = "Datierung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (for all)', `fr_beschriftung` = 'Remarque (pour tous)', `la_beschriftung` = 'Commentarius (pro omnibus)' where Formular = "mgh_lemma" and Datenfeld = "BemerkungAlle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (group)', `fr_beschriftung` = 'Remarque (en groupe)', `la_beschriftung` = 'Commentarius (coniunctis apertus)' where Formular = "mgh_lemma" and Datenfeld = "BemerkungGruppe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (private)', `fr_beschriftung` = 'Remarque (privée)', `la_beschriftung` = 'Commentarius (privatus)' where Formular = "mgh_lemma" and Datenfeld = "BemerkungPrivat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Processing status', `fr_beschriftung` = 'Statut de traitement', `la_beschriftung` = 'Status tractandi' where Formular = "mgh_lemma" and Datenfeld = "Bearbeitungsstatus";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Last modification', `fr_beschriftung` = 'Dernière modification', `la_beschriftung` = 'Novissima retractatio' where Formular = "mgh_lemma" and Datenfeld = "LetzteAenderung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Latest modification by', `fr_beschriftung` = 'Dernière modification par', `la_beschriftung` = 'Novissime retractatum ab' where Formular = "mgh_lemma" and Datenfeld = "LetzteAenderungVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created', `fr_beschriftung` = 'Établi', `la_beschriftung` = 'Generatum' where Formular = "mgh_lemma" and Datenfeld = "Erstellt";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created by', `fr_beschriftung` = 'Établi par', `la_beschriftung` = 'Generatum ab' where Formular = "mgh_lemma" and Datenfeld = "ErstelltVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Signature/Designation', `fr_beschriftung` = 'Signature/Désignation', `la_beschriftung` = 'Signatura/Descriptio brevis' where Formular = "handschrift" and Datenfeld = "Bibliothekssignatur";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Tradition', `fr` = 'Tradition', `la` = 'Traditio' where Formular = "handschrift" and Textfeld = "TabUeberlieferung";

UPDATE `neg`.`datenbank_mapping` SET `fr_combinedAnzeigenamen` = 'Source;;Lien;Édition/Sigle;Origine de l\'écriture;Lieu de création de l\'écriture;Origine bibliothèque;Datation', `la_combinedAnzeigenamen` = 'Fons;;Conexus;Editio/Sigla;Origo scripturae;Origo libri;Origo bibliothecaria;Datatio' where Formular = "handschrift" and Datenfeld = "Ueberlieferung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (for all)', `fr_beschriftung` = 'Remarque (pour tous)', `la_beschriftung` = 'Commentarius (pro omnibus)' where Formular = "handschrift" and Datenfeld = "BemerkungAlle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (group)', `fr_beschriftung` = 'Remarque (en groupe)', `la_beschriftung` = 'Commentarius (coniunctis apertus)' where Formular = "handschrift" and Datenfeld = "BemerkungGruppe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (private)', `fr_beschriftung` = 'Remarque (privée)', `la_beschriftung` = 'Commentarius (privatus)' where Formular = "handschrift" and Datenfeld = "BemerkungPrivat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Processing status', `fr_beschriftung` = 'Statut de traitement', `la_beschriftung` = 'Status tractandi' where Formular = "handschrift" and Datenfeld = "Bearbeitungsstatus";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Last modification', `fr_beschriftung` = 'Dernière modification', `la_beschriftung` = 'Novissima retractatio' where Formular = "handschrift" and Datenfeld = "LetzteAenderung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Latest modification by', `fr_beschriftung` = 'Dernière modification par', `la_beschriftung` = 'Novissime retractatum ab' where Formular = "handschrift" and Datenfeld = "LetzteAenderungVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created', `fr_beschriftung` = 'Établi', `la_beschriftung` = 'Generatum' where Formular = "handschrift" and Datenfeld = "Erstellt";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created by', `fr_beschriftung` = 'Établi par', `la_beschriftung` = 'Generatum ab' where Formular = "handschrift" and Datenfeld = "ErstelltVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Philological Lemma' where Formular = "namenkommentar" and Datenfeld = "PLemma";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Index Lemma', `fr_beschriftung` = 'Lemme index', `la_beschriftung` = 'Praelemma' where Formular = "namenkommentar" and Datenfeld = "ELemma";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Element of the name / Suffix', `fr_beschriftung` = 'Élément du nom / Suffixe', `la_beschriftung` = 'Elementum nominis / Suffixum' where Formular = "namenkommentar" and Datenfeld = "Suffix";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Protocol', `fr_beschriftung` = 'Protocole', `la_beschriftung` = 'Protocollum' where Formular = "namenkommentar" and Datenfeld = "Protokoll";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Comments of philological correctors and historians', `fr_beschriftung` = 'Remarques des correcteurs philologiques et des historiens', `la_beschriftung` = 'Indicia correctorum philologicorum et historicorum' where Formular = "namenkommentar" and Datenfeld = "Hinweise";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Editor', `fr` = 'Rédacteur', `la` = 'Editor' where  Formular = "namenkommentar" and Textfeld = "TabBearbeiter";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'References', `fr` = 'Références', `la` = 'Testimonia' where  Formular = "namenkommentar" and Textfeld = "TabBelege";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Remarks', `fr` = 'Remarques', `la` = 'Commentaria' where Formular = "namenkommentar" and Textfeld = "TabBemerkungen";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Als Bearbeiter hinzufügen', `gb_beschriftung` = 'Add as editor', `fr_beschriftung` = 'Ajouter comme rédacteur', `la_beschriftung` = 'Addere ut editor' where Formular = "namenkommentar" and Datenfeld = "BearbeiterNeu";

UPDATE `neg`.`datenbank_mapping` SET `de_Beschriftung` = 'Als Korrektor hinzufügen', `gb_beschriftung` = 'Add as revisor', `fr_beschriftung` = 'Ajouter comme correcteur', `la_beschriftung` = 'Addere ut corrector' where Formular = "namenkommentar" and Datenfeld = "KorrektorNeu";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Editor', `fr` = 'Rédacteur', `la` = 'Editor' where Formular = "namenkommentar" and Textfeld = "Bearbeiter";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Revisor', `fr` = 'Correcteur', `la` = 'Corrector' where Formular = "namenkommentar" and Textfeld = "Korrektor";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Date', `fr` = 'Date', `la` = 'Dies' where Formular = "namenkommentar" and Textfeld = "Datum";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Time', `fr` = 'Temps', `la` = 'Hora' where Formular = "namenkommentar" and Textfeld = "Uhrzeit";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Form of Reference', `fr` = 'Forme de la référence', `la` = 'Forma testimonii' where Formular = "namenkommentar" and Textfeld = "Belegform";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Person', `fr` = 'Personne', `la` = 'Persona' where Formular = "namenkommentar" and Textfeld = "Person";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Standard Name', `fr` = 'Nom standard', `la` = 'Nomen standard' where Formular = "namenkommentar" and Textfeld = "Standardname";

UPDATE `neg`.`datenbank_texte` SET `gb` = 'Dating', `fr` = 'Datation', `la` = 'Datatio' where Formular = "namenkommentar" and Textfeld = "Datierung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (for all)', `fr_beschriftung` = 'Remarque (pour tous)', `la_beschriftung` = 'Commentarius (pro omnibus)' where Formular = "namenkommentar" and Datenfeld = "BemerkungAlle";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (group)', `fr_beschriftung` = 'Remarque (en groupe)', `la_beschriftung` = 'Commentarius (coniunctis apertus)' where Formular = "namenkommentar" and Datenfeld = "BemerkungGruppe";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Remark (private)', `fr_beschriftung` = 'Remarque (privée)', `la_beschriftung` = 'Commentarius (privatus)' where Formular = "namenkommentar" and Datenfeld = "BemerkungPrivat";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Processing status', `fr_beschriftung` = 'Statut de traitement', `la_beschriftung` = 'Status tractandi' where Formular = "namenkommentar" and Datenfeld = "Bearbeitungsstatus";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Last modification', `fr_beschriftung` = 'Dernière modification', `la_beschriftung` = 'Novissima retractatio' where Formular = "namenkommentar" and Datenfeld = "LetzteAenderung";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Latest modification by', `fr_beschriftung` = 'Dernière modification par', `la_beschriftung` = 'Novissime retractatum ab' where Formular = "namenkommentar" and Datenfeld = "LetzteAenderungVon";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created', `fr_beschriftung` = 'Établi', `la_beschriftung` = 'Generatum' where Formular = "namenkommentar" and Datenfeld = "Erstellt";

UPDATE `neg`.`datenbank_mapping` SET `gb_beschriftung` = 'Created by', `fr_beschriftung` = 'Établi par', `la_beschriftung` = 'Generatum ab' where Formular = "namenkommentar" and Datenfeld = "ErstelltVon";
