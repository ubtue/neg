ALTER TABLE selektion_amtweihe ADD COLUMN parentId INT DEFAULT NULL;
ALTER TABLE selektion_amtweihe ADD CONSTRAINT `selektion_amtweihe_parentId` FOREIGN KEY (`parentId`) REFERENCES selektion_amtweihe(`ID`);

ALTER VIEW `gastselektion_amtweihe_einzelbeleg` AS select distinct `s`.`ID` AS `ID`,`s`.`Bezeichnung` AS `Bezeichnung`,`s`.`parentId` AS `parentId` from (`selektion_amtweihe` `s` join `einzelbeleg_hatamtweihe` `phs`) where ((`phs`.`AmtWeiheID` = `s`.`ID`) and `phs`.`EinzelbelegID` in (select `einzelbeleg`.`ID` AS `ID` from (`einzelbeleg` join `quelle`) where ((`einzelbeleg`.`QuelleID` = `quelle`.`ID`) and (`quelle`.`ZuVeroeffentlichen` = 1))));
ALTER VIEW `gastselektion_amtweihe_person` AS select distinct `s`.`ID` AS `ID`,`s`.`Bezeichnung` AS `Bezeichnung`,`s`.`parentId` AS `parentId` from (`selektion_amtweihe` `s` join `person_hatamtstandweihe` `phs`) where ((`phs`.`AmtWeiheID` = `s`.`ID`) and `phs`.`PersonID` in (select `einzelbeleg_hatperson`.`PersonID` AS `PersonID` from `einzelbeleg_hatperson` where `einzelbeleg_hatperson`.`EinzelbelegID` in (select `einzelbeleg`.`ID` AS `ID` from (`einzelbeleg` join `quelle`) where ((`einzelbeleg`.`QuelleID` = `quelle`.`ID`) and (`quelle`.`ZuVeroeffentlichen` = 1)))));