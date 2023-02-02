
##TABLE bemerkung##

#delete corrupt bemerkung records(bemerkung that isnt associate with anything)
DELETE FROM bemerkung WHERE NOT EXISTS
 (SELECT * FROM einzelbeleg WHERE EinzelbelegID = einzelbeleg.ID)
 or
 NOT EXISTS
 (SELECT * FROM quelle WHERE QuelleID = quelle.ID)
  or
 NOT EXISTS
 (SELECT * FROM edition WHERE EditionID = edition.ID)
   or
 NOT EXISTS
 (SELECT * FROM handschrift WHERE HandschriftID = handschrift.ID)
   or
 NOT EXISTS
 (SELECT * FROM namenkommentar WHERE NamenkommentarID = namenkommentar.ID)
   or
 NOT EXISTS
 (SELECT * FROM mgh_lemma WHERE MGHLemmaID = mgh_lemma.ID)
   or
 NOT EXISTS
 (SELECT * FROM benutzer_gruppe WHERE GruppeID = benutzer_gruppe.ID)
  or
 NOT EXISTS
 (SELECT * FROM benutzer WHERE BenutzerID = benutzer.ID) 
 ;

##TABLE edition##

# setting corrupt foreign keys BearbeitungsstatusID to default 2
UPDATE edition SET BearbeitungsstatusID = 2 WHERE NOT EXISTS
  (SELECT * FROM selektion_bearbeitungsstatus WHERE BearbeitungsstatusID = selektion_bearbeitungsstatus.ID);

#setting corrupt foreing keys ReiheID to default ID -1
UPDATE edition SET ReiheID = -1 WHERE NOT EXISTS
  (SELECT * FROM selektion_reihe WHERE ReiheID = selektion_reihe.ID);

##TABLE einzelbeleg_hatfunktionn##

#delete corrupt m:m records
DELETE FROM einzelbeleg_hatfunktion WHERE NOT EXISTS
 (SELECT * FROM einzelbeleg WHERE EinzelbelegID = einzelbeleg.ID)
 or
 NOT EXISTS
 (SELECT * FROM selektion_funktion WHERE FunktionID = selektion_funktion.ID)
 ;

##TABLE einzelbeleg_textkritik##

#delete corrupt m:m records
DELETE FROM einzelbeleg_textkritik WHERE NOT EXISTS
 (SELECT * FROM einzelbeleg WHERE EinzelbelegID = einzelbeleg.ID)
 or
 NOT EXISTS
 (SELECT * FROM handschrift WHERE HandschriftID = handschrift.ID)
  or
 NOT EXISTS
 (SELECT * FROM edition WHERE EditionID = edition.ID)
 ;


##TABLE einzelbeleg##

# setting corrupt foreign keys GrammatikGeschlechtID to 3
UPDATE einzelbeleg SET GrammatikGeschlechtID = 3 WHERE NOT EXISTS
 (SELECT * FROM selektion_grammatikgeschlecht WHERE GrammatikGeschlechtID = selektion_grammatikgeschlecht.ID);
  
# setting corrupt foreign keys LebendVerstorbenID to 2
 UPDATE einzelbeleg SET LebendVerstorbenID = 2 WHERE NOT EXISTS
 (SELECT * FROM selektion_lebendverstorben WHERE LebendVerstorbenID = selektion_lebendverstorben.ID);
 
 # setting corrupt foreign keys EditionID to NULL
 UPDATE einzelbeleg SET EditionID = NULL WHERE NOT EXISTS
 (SELECT * FROM edition WHERE EditionID = edition.ID);
 
 
 #replace missing user with a valid (example for mderntl)
 #TODO create dummy user in live system
UPDATE einzelbeleg SET LetzteAenderungVon = 145,ErstelltVon=145,GehoertGruppe=4 WHERE NOT EXISTS
 (SELECT * FROM benutzer WHERE LetzteAenderungVon = benutzer.ID ) OR NOT EXISTS
 (SELECT * FROM benutzer WHERE ErstelltVon = benutzer.ID ) OR NOT EXISTS
 (SELECT * FROM benutzer WHERE GehoertGruppe = benutzer.ID );

##TABLE mgh_lemma##

# setting corrupt foreign keys BearbeitungsstatusID to 2
UPDATE mgh_lemma SET BearbeitungsstatusID = 2 WHERE NOT EXISTS
 (SELECT * FROM selektion_bearbeitungsstatus WHERE BearbeitungsstatusID = selektion_bearbeitungsstatus.ID );

##TABLE namenkommentar_bearbeiter##

#fix corrupt FKs NamenkommentarID in namenkommentar_bearbeiter table (Delete records because a namenkommentar_bearbeiter without a namenkommentar makes no sense)

DELETE FROM namenkommentar_bearbeiter WHERE NOT EXISTS
 (SELECT * FROM namenkommentar WHERE NamenkommentarID = namenkommentar.ID);

##TABLE namenkommentar##

#set corrupt FKs to the default ID 2
UPDATE namenkommentar SET BearbeitungsstatusID = 2 WHERE NOT EXISTS
 (SELECT * FROM selektion_bearbeitungsstatus WHERE BearbeitungsstatusID = selektion_bearbeitungsstatus.ID);

##TABLE person_hatamtstandweihe##

#delete corrupt m:m records
DELETE FROM person_hatamtstandweihe WHERE NOT EXISTS
 (SELECT * FROM person WHERE PersonID = person.ID)
 or
 NOT EXISTS
 (SELECT * FROM selektion_amtweihe WHERE AmtWeiheID = selektion_amtweihe.ID)
 ;

##TABLE urkunde##

#fix corrupt FKs QuelleID in urkunde table (Delete records because a urkunde without a quelle makes no sense)

DELETE FROM urkunde WHERE NOT EXISTS
 (SELECT * FROM quelle WHERE QuelleID = quelle.ID);
