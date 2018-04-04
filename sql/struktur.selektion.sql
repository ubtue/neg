CREATE TABLE `selektion_amtstandweihe` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_areal` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_autor` (
  `ID` int(3) NOT NULL default '0',
  `Nachname` varchar(50) NOT NULL default '',
  `Vorname` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_bearbeitungsstatus` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_bewertung` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_echtheit` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_editor` (
  `ID` int(3) NOT NULL default '0',
  `Nachname` varchar(50) NOT NULL default '',
  `Vorname` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_ethnie` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_funktion` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_geschlecht` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_grammatikgeschlecht` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_janein` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_kasus` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_lebendverstorben` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_literaturtyp` (
  `ID` int(11) NOT NULL auto_increment,
  `Bezeichnung` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM AUTO_INCREMENT=5 ;

CREATE TABLE `selektion_quellengattung` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;

CREATE TABLE `selektion_verwandtschaftsgrad` (
  `ID` int(3) NOT NULL default '0',
  `Bezeichnung` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM;        