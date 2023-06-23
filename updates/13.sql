SET @count = 0;
UPDATE `selektion_quellengattung` SET `selektion_quellengattung`.`ID` = @count:= @count + 1;
ALTER TABLE `selektion_quellengattung` AUTO_INCREMENT = 1;

