package game.objects;
/*
	Класс входа и регистрации
*/

// подключим зависимости
import flash.display.*;
import flash.events.*;
import flash.text.*;
import game.data.*;
import game.graphics.*;
import game.graphics3d.*;
import game.network.*;

class AuthMenu extends Sprite {

	// основная фукнция старта приложения в языке Haxe
	public static function main() {
		// flash.Lib.current является базовым спрайтом приложения
		// разместим на него сцену
		flash.Lib.current.addChild(new AuthMenu());
	}

	public function new(){
		// Haxe требует указывать вызов конструктора базового класса
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}

	private function onAdded (event) {
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);

		graphics.beginFill(0xFFAACC, 0.2);
		graphics.drawRect(0,0,Gameplay.SCREEN_WIDTH,Gameplay.SCREEN_HEIGHT);
		graphics.endFill();

		var req = new haxe.Http("http://localhost/ark-game/setup.php");
		req.request(false);

		username = label("Имя", false, false, 120, 50*2);
		password = label("Пароль", false, true, 120, 70*2);
		login = label("Войти", true, false, 120, 90*2);
		register = label("Зарегистрироваться", true, false, 120, 110*2);

		login.addEventListener(MouseEvent.CLICK, signin);
		register.addEventListener(MouseEvent.CLICK, signup);
	}

	function signin(event) {
		var req = new haxe.Http("http://localhost/ark-game/login.php");

		req.setParameter("USERNAME", username.text);
		req.setParameter("PASSWORD", password.text);

		req.onData = function (data:String) if(data == "true") done();
		req.onError = function (error:String) trace(error);
		req.request(false);
	}

	function signup(event) {
		var req = new haxe.Http("http://localhost/ark-game/reg.php");

		req.setParameter("USERNAME", username.text);
		req.setParameter("PASSWORD", password.text);

		req.onData = function (data:String) if(data == "true") done();
		req.onError = function (error:String) trace(error);
		req.request(false);
	}

	function done() {
		USERNAME = username.text;
		PASSWORD = password.text;

		parent.addChild(new game.objects.Scene());
		parent.removeChild(this);
	}

	private var username:TextField;
	private var password:TextField;
	private var login:TextField;
	private var register:TextField;

	public static var USERNAME = "";
	public static var PASSWORD = "";

	private function label(text, border, password, x, y) {
		var textField:TextField;
		textField = new TextField();
		textField.textColor = 0x00000000;
		textField.selectable = !border;
		textField.border = border;
		textField.embedFonts = textField.wordWrap = false;
		textField.width = 300;
		textField.height = 30;
		textField.text = text;
		textField.displayAsPassword = password;
		textField.x = x;
		textField.y = y;
		if(!border)
			textField.type = TextFieldType.INPUT;
		addChild(textField);
		return textField;
	}
}