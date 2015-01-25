<?php
	$db = new SQLite3("database.db");
	if (!$db) die;

	$db->query("
		CREATE TABLE IF NOT EXISTS `USERS` (
			`ID` integer PRIMARY KEY AUTOINCREMENT,
			`USERNAME` varchar(255) NOT NULL default '',
			`PASSWORD` varchar(255) NOT NULL default ''
		)
	");
	$db->query("
		CREATE TABLE IF NOT EXISTS `SCORES` (
			`ID` integer PRIMARY KEY,
			`BESTSCORE` integer default 0
		)
	");
?>