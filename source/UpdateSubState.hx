package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

using StringTools;

class UpdateSubState extends FlxSubState
{
	public static var needVer:String = "";
	public static var currChanges:String = "";

	#if mobile
    var back:FlxSprite;
    var backText:FlxText;
    #end

	override function create()
	{
		super.create();
        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.YELLOW);
        bg.scale.x *= 1.55;
		bg.scale.y *= 1.55;
		bg.screenCenter();
        add(bg);

        var title:FlxText = new FlxText();
        title.size = 40;
        title.color = 0xFF000000;
        title.text = 'C4t';
        title.screenCenter(X);
        title.y = 5;
        add(title);

		#if !mobile
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"Hooray, a new version is out!"
			+ "\nThe version " + needVer + " is available for download."
			+ "\n\nWhat's new:\n\n"
			+ currChanges
            + "And more"
			+ "\n\nPress Enter to go download it or Escape to ignore this",
			30);
		#else
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"Hooray, a new version is out!"
			+ "\nThe version " + needVer + " is available for download."
			+ "\n\nWhat's new:\n\n"
			+ currChanges
            + "And more"
			+ "\n\nTouch to go download it or Back to ignore this",
			30);
		#end
        txt.setFormat(30, FlxColor.BLACK, CENTER);
        txt.screenCenter();
        add(txt);

		#if mobile
        back = new FlxSprite(20, 40).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        back.color = 0xFF9819;
        add(back);
        backText = new FlxText(40, 39);
        backText.size = 40;
        backText.color = 0xFF000000;
        backText.text = "<";
        add(backText);
        #end
	}

	override function update(elapsed:Float)
	{
        super.update(elapsed);
		#if !mobile
		if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
		{
			fancyOpenURL("https://github.com/BTF2021/C4T");
		}
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MainMenuState());
		}
		#else
		for (touch in FlxG.touches.list)
		{
		    if (touch.justPressed && !touch.overlaps(back))
		    {
				fancyOpenURL("https://github.com/BTF2021/C4T");
		    }
		    if (touch.justPressed && touch.overlaps(back))
		    {
				FlxG.switchState(new MainMenuState());
		    }
		}
		#end
		super.update(elapsed);
	}
    public function fancyOpenURL(schmancy:String)
    {
        #if linux
        Sys.command('/usr/bin/xdg-open', [schmancy, "&"]);
        #else
        FlxG.openURL(schmancy);
        #end
    }
}
