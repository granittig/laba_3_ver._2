package game.network;
/*
	Класс для работы с сервером рекордов
*/
import flash.system.Security;
import game.objects.AuthMenu;
import haxe.Http;

typedef Score = { USERNAME : String, BESTSCORE : Int }

class ScoreServer
{
	public static function getHighScores(callback:Array<Score> -> Void):Void
	{
		// разрешим доступ к серверу
		Security.allowDomain("*");
		Security.loadPolicyFile("crossdomain.xml");

		// выполним запрос стандартными средствами Haxe
		var req = new haxe.Http("http://localhost/ark-game/score.php");
		// успешное получение данных
		req.onData = function (data:String)
		{
			callback(haxe.Json.parse(data));
		}
		req.onError = function (error:String)
		{
			// произошла ошибка, вернем пустой массив
			callback([]);
			trace(error);
		}
		req.request(false);
	}

	public static function setHighScores(highscores:Int):Void
	{
		// разрешим доступ к серверу
		Security.allowDomain("*");
		Security.loadPolicyFile("crossdomain.xml");

		// выполним POST запрос стандартными средствами Haxe
		var req = new haxe.Http("http://localhost/ark-game/keep.php");
		req.setParameter("USERNAME", AuthMenu.USERNAME);
		req.setParameter("PASSWORD", AuthMenu.PASSWORD);
		req.setParameter("BESTSCORE", "" + highscores);
		req.onError = function (error:String)
		{
			// произошла ошибка
			trace(error);
		}
		req.request(false);
	}
}