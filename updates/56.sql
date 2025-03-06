ALTER TABLE selektion_titelkritik ADD provenance_source VARCHAR (255) NOT NULL DEFAULT('NeG');
ALTER TABLE selektion_titelkritik ADD provenance_id VARCHAR (255) DEFAULT NULL, ADD CONSTRAINT unique_provenance_id UNIQUE (provenance_id);
