--avoid foreign key check for this session, otherwise the alter table statement will not work
SET FOREIGN_KEY_CHECKS = 0;
--this is necessary because the id column contains 0 values. Otherwise an error appears
SET SQL_MODE=NO_AUTO_VALUE_ON_ZERO;
ALTER TABLE selektion_quellengattung MODIFY COLUMN ID INT NOT NULL auto_increment;
--restore foreign key check
SET FOREIGN_KEY_CHECKS = 1;
