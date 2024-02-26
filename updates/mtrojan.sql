ALTER TABLE datenbank_mapping ADD COLUMN `schema_org_property` VARCHAR(255) DEFAULT NULL AFTER `default`;
UPDATE datenbank_mapping SET `schema_org_property` = 'sameAs' WHERE Datenfeld='GNDLink';
