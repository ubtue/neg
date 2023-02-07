# TinyMCE + Content
CREATE TABLE `tinyMce_content` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `contentType` varchar(55) NOT NULL,
  `content` longblob NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

