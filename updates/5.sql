#remove entry selektion_literaturtyp
DELETE FROM datenbank_selektion WHERE selektion = "selektion_literaturtyp";

#drop table selektion_literaturtyp
DROP TABLE IF EXISTS selektion_literaturtyp;
