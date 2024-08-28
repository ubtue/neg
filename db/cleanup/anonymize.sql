/*
The goal of this file is to remove user-related data from the database
in case a 3rd party / potential partner wants a full dump of our data.

The procedure would be
- duplicate the original database
    - there is no SQL command to do this directly, but you can e.g. use `mysqldump` for the export:
      https://stackoverflow.com/questions/675289/mysql-cloning-a-mysql-database-on-the-same-mysql-instance
- apply this sql file on the duplicated db
- export the duplicated/modified db
*/

ALTER TABLE bemerkung DROP CONSTRAINT bemerkung_BenutzerID;
ALTER TABLE bemerkung DROP COLUMN BenutzerID;
ALTER TABLE edition DROP CONSTRAINT edition_ErstelltVon;
ALTER TABLE edition DROP COLUMN ErstelltVon;
ALTER TABLE edition DROP CONSTRAINT edition_LetzteAenderungVon;
ALTER TABLE edition DROP COLUMN LetzteAenderungVon;
ALTER TABLE einzelbeleg DROP CONSTRAINT einzelbeleg_ErstelltVon;
ALTER TABLE einzelbeleg DROP COLUMN ErstelltVon;
ALTER TABLE einzelbeleg DROP CONSTRAINT einzelbeleg_LetzteAenderungVon;
ALTER TABLE einzelbeleg DROP COLUMN LetzteAenderungVon;
ALTER TABLE handschrift DROP CONSTRAINT handschrift_ErstelltVon;
ALTER TABLE handschrift DROP COLUMN ErstelltVon;
ALTER TABLE handschrift DROP CONSTRAINT handschrift_LetzteAenderungVon;
ALTER TABLE handschrift DROP COLUMN LetzteAenderungVon;
ALTER TABLE handschrift_ueberlieferung DROP CONSTRAINT handschrift_ueberlieferung_ErstelltVon;
ALTER TABLE handschrift_ueberlieferung DROP COLUMN ErstelltVon;
ALTER TABLE handschrift_ueberlieferung DROP CONSTRAINT handschrift_ueberlieferung_LetzteAenderungVon;
ALTER TABLE handschrift_ueberlieferung DROP COLUMN LetzteAenderungVon;
ALTER TABLE mgh_lemma DROP CONSTRAINT mgh_lemma_ErstelltVon;
ALTER TABLE mgh_lemma DROP COLUMN ErstelltVon;
ALTER TABLE mgh_lemma DROP CONSTRAINT mgh_lemma_LetzteAenderungVon;
ALTER TABLE mgh_lemma DROP COLUMN LetzteAenderungVon;
ALTER TABLE mgh_lemma_bearbeiter DROP CONSTRAINT mgh_lemma_bearbeiter_BenutzerID;
ALTER TABLE mgh_lemma_bearbeiter DROP COLUMN BenutzerID;
ALTER TABLE mgh_lemma_korrektor DROP CONSTRAINT mgh_lemma_korrektor_BenutzerID;
ALTER TABLE mgh_lemma_korrektor DROP COLUMN BenutzerID;
ALTER TABLE namenkommentar DROP CONSTRAINT namenkommentar_ErstelltVon;
ALTER TABLE namenkommentar DROP COLUMN ErstelltVon;
ALTER TABLE namenkommentar DROP CONSTRAINT namenkommentar_LetzteAenderungVon;
ALTER TABLE namenkommentar DROP COLUMN LetzteAenderungVon;
ALTER TABLE namenkommentar_bearbeiter DROP CONSTRAINT namenkommentar_bearbeiter_BenutzerID;
ALTER TABLE namenkommentar_bearbeiter DROP COLUMN BenutzerID;
ALTER TABLE namenkommentar_korrektor DROP CONSTRAINT namenkommentar_korrektor_BenutzerID;
ALTER TABLE namenkommentar_korrektor DROP COLUMN BenutzerID;
ALTER TABLE person DROP CONSTRAINT person_ErstelltVon;
ALTER TABLE person DROP COLUMN ErstelltVon;
ALTER TABLE person DROP CONSTRAINT person_LetzteAenderungVon;
ALTER TABLE person DROP COLUMN LetzteAenderungVon;
ALTER TABLE quelle DROP CONSTRAINT quelle_ErstelltVon;
ALTER TABLE quelle DROP COLUMN ErstelltVon;
ALTER TABLE quelle DROP CONSTRAINT quelle_LetzteAenderungVon;
ALTER TABLE quelle DROP COLUMN LetzteAenderungVon;

DROP TABLE benutzer;
