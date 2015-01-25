<?php
	header ('Content-type: text/html; charset=utf-8');

	// подключим базу данных
	$db = new SQLite3("database.db");
	if (!$db) {
		die;
	}

	// загрузим таблицу результатов

	$result = $db->query("
			SELECT s.BESTSCORE, u.USERNAME
			FROM SCORES s CROSS JOIN USERS u ON s.ID = u.ID
	");

	$out = array();

	while($res = $result->fetchArray(SQLITE3_ASSOC)) {
					$out []= $res;
	}

	echo json_encode($out);
?>