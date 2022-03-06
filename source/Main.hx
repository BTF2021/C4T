package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextFormat;

class Main extends Sprite
{
	var gameWidth:Int = 1280;
	var gameHeight:Int = 720;
	var initialState:Class<FlxState> = TitleState;
	var zoom:Float = -1;
	var framerate:Int = 120;
	var skipSplash:Bool = true;
	#if !mobile
	var startFullscreen:Bool = false;
	#else
	var startFullscreen:Bool = true;
	#end

	public static function main():Void
	{
		// quick checks

		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !cpp
		framerate = 60;
		#end

		game = new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen);
		addChild(game);
	}

	var game:FlxGame;
}
