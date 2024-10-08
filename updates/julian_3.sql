ALTER TABLE selektion_kritik ADD provenance_id VARCHAR (255) DEFAULT NULL, ADD CONSTRAINT unique_provenance_id UNIQUE (provenance_id);
ALTER TABLE selektion_kritik ADD provenance_source VARCHAR (255) NOT NULL DEFAULT('NeG');

ALTER TABLE gastselektion_amtweihe_einzelbeleg ADD provenance_id VARCHAR (255) DEFAULT NULL, ADD CONSTRAINT unique_provenance_id UNIQUE (provenance_id);
ALTER TABLE gastselektion_amtweihe_einzelbeleg ADD provenance_source VARCHAR (255) NOT NULL DEFAULT('NeG');
