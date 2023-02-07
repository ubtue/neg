#in mysql 8 it is recommend to use CURRENT_TIMESTAMP or NULL
#otherwise an error will be thrown
ALTER TABLE mgh_lemma_bearbeiter MODIFY Zeitstempel DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE mgh_lemma_korrektor MODIFY Zeitstempel DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE namenkommentar_bearbeiter MODIFY Zeitstempel DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE namenkommentar_korrektor MODIFY Zeitstempel DATETIME DEFAULT CURRENT_TIMESTAMP;


#Fix ERROR 1071 (42000): Specified key was too long; max key length is 1000 bytes
#This error happens because utf8mb4 uses 4 bytes instead of 3 bytes
#It is necessary to decrease the field length
ALTER TABLE datenbank_filter MODIFY Formular VARCHAR(191);
ALTER TABLE datenbank_filter MODIFY Bezeichnung VARCHAR(191);
ALTER TABLE einzelbeleg MODIFY Belegform VARCHAR(191);

#Finally change the CHARACTER SET to utf8mb4 and COLLATION to utf8mb4_unicode_ci
ALTER TABLE bemerkung CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE benutzer CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE benutzer_gruppe CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE datenbank_filter CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE datenbank_mapping CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE datenbank_selektion CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE datenbank_sprachen CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE datenbank_texte CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE edition CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE edition_band CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE edition_bestand CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE edition_hateditor CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatamtweihe CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatareal CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatethnie CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatfunktion CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatmghlemma CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatnamenkommentar CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatperson CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE einzelbeleg_hatstand CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE einzelbeleg_textkritik CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE handschrift CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE handschrift_ueberlieferung CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE mgh_lemma CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE mgh_lemma_bearbeiter CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE mgh_lemma_korrektor CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE namenkommentar CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE namenkommentar_bearbeiter CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE namenkommentar_korrektor CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE person CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE person_hatamtstandweihe CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE person_hatareal CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE person_hatethnie CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE person_hatstand CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE person_quiet CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE person_variante CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE person_verwandtmit CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE quelle CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE quelle_inedition CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_amtstandweihe CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_amtweihe CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_areal CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_autor CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_bearbeitungsstatus CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_bewertung CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_bkz CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_datgenauigkeit CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_dmghband CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_echtheit CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_editor CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_ethnie CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_ethnienerhalt CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE selektion_funktion CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_geschlecht CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_grammatikgeschlecht CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_janein CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_kasus CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_lebendverstorben CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE selektion_ort CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_quellengattung CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_reihe CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_sammelband CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_stand CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE selektion_urkundeausstellerempfaenger CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE selektion_verwandtschaftsgrad CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE suche_favoriten CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
ALTER TABLE ueberlieferung_edition CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE urkunde CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE urkunde_betreff CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE urkunde_dorsalnotiz CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE urkunde_hataussteller CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE urkunde_hatempfaenger CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

#Update the Column Seite to fit to the new URLs
UPDATE datenbank_mapping SET Seite = REPLACE(Seite, '.jsp', '');
