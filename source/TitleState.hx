package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class TitleState extends FlxState
{
    var bg:FlxSprite;
    var me:FlxText;
    var title:FlxText;
    var press:FlxText;
    var doit:FlxText;

    var confirm:FlxSound;

    var finishAnimation:Bool = false;
    var stop:Bool = false;

    override public function create()
    {
        super.create();

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.YELLOW);
        bg.screenCenter();
        add(bg);

        me = new FlxText(0, Main.gameHeight);
        me.size = 40;
        me.color = 0xFF000000;
        me.text = 'BTF Presents...';
        me.screenCenter(X);
        add(me);

        title = new FlxText(0, -50);
        title.size = 40;
        title.color = 0xFF000000;
        title.text = 'C4t';
        title.screenCenter(X);
        add(title);

        press = new FlxText(0, Main.gameHeight);
        press.size = 40;
        press.color = 0xFF000000;
        #if !mobile
        press.text = 'Click anywhere to continue';
        #else
        press.text = 'Touch anywhere to continue';
        #end
        press.screenCenter(X);
        add(press);

        doit = new FlxText();
        doit.size = 40;
        doit.color = 0xFF000000;
        #if !mobile
        doit.text = 'Click to skip the intro';
        #else
        doit.text = 'Touch to skip the intro';
        #end
        doit.alpha = 0.5;
        doit.screenCenter();
        add(doit);

        FlxTween.angle(me, me.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.angle(title, title.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.angle(press, press.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.tween(doit, {alpha:0.05}, 0.05, {ease: FlxEase.quartInOut});

        confirm = FlxG.sound.load(AssetPaths.TempConfirm__ogg);

        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (me.angle == -1)
                FlxTween.angle(me, me.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(me, me.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (title.angle == -1)
                FlxTween.angle(title, title.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(title, title.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (press.angle == -1)
                FlxTween.angle(press, press.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(press, press.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);

        if (FlxG.sound.music == null)
        {
            FlxG.sound.playMusic(AssetPaths.TitleTest__ogg, 1, true);
        }

        DefaultData.initSave();

        if(!FlxG.save.data.optionsSkipTitle)startIntro();
        else FlxG.switchState(new MainMenuState());

    }
    function startIntro()
    {
        if(!finishAnimation)
        {   
		    FlxG.sound.music.fadeIn(4, 0, 0.7);

            new FlxTimer().start(3, Me, 1);
            new FlxTimer().start(3.5, Title, 1);
            new FlxTimer().start(6, Press, 1);
        }    
    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        #if mobile
        for (touch in FlxG.touches.list)
        {
            if (touch.justPressed && !stop)
            { 
            finishAnimation = true;
            me.y = Main.gameHeight - 60;
            FlxTween.angle(me, me.angle, 0, 0.5, {ease: FlxEase.quartInOut});
            title.y = 40;
            FlxTween.angle(title, title.angle, 0, 0.5, {ease: FlxEase.quartInOut});
            press.y = Main.gameHeight / 2;
            FlxTween.angle(press, press.angle, 0, 0.5, {ease: FlxEase.quartInOut});
            if (!stop) skipIntro();
            }
        }
        #else
        if (FlxG.mouse.justPressed && !stop)
        { 
            finishAnimation = true;
            me.y = 640;
            FlxTween.angle(me, me.angle, 0, 0.5, {ease: FlxEase.quartInOut});
            title.y = 40;
            FlxTween.angle(title, title.angle, 0, 0.5, {ease: FlxEase.quartInOut});
            press.y = 360;
            FlxTween.angle(press, press.angle, 0, 0.5, {ease: FlxEase.quartInOut});
            if (!stop) skipIntro();
        }
        #end
    }
    function Me(timer:FlxTimer):Void
    {
        if (!finishAnimation)
        {
            FlxTween.tween(me, {alpha: 1, y: Main.gameHeight - 60}, 0.2, {ease: FlxEase.quartInOut});
        }
    }
    function Title(timer:FlxTimer):Void
    {       
        if (!finishAnimation)
        {    
            FlxTween.tween(title, {alpha: 1, y: 20}, 0.2, {ease: FlxEase.quartInOut});
        }
    }
    function Press(timer:FlxTimer):Void
    {    
        if(!finishAnimation)
        {       
            FlxTween.tween(press, {alpha: 1, y: Main.gameHeight / 2}, 0.2, {ease: FlxEase.quartInOut});
            FlxTween.tween(doit, {alpha: 0, y: -250}, 0.2, {ease: FlxEase.quartInOut});
        }
    }
    function skipIntro()
    {
        stop = true;
        FlxG.camera.flash(FlxColor.WHITE, 1);
        confirm.play(true);
        new FlxTimer().start(0.3, function(tmr:FlxTimer)
        {
            FlxTween.angle(title, title.angle, 0, 0.5, {ease: FlxEase.quartInOut});
            FlxTween.tween(me, {y: Main.gameHeight}, 0.5, {ease: FlxEase.quartInOut});
            FlxTween.tween(press, {alpha: 0}, 0.5, {ease: FlxEase.quartInOut});
            FlxTween.tween(doit, {alpha: 0, y: -100}, 0.1, {ease: FlxEase.quartInOut});
        }, 1);
        if (FlxG.save.data.optionsUpdate)
        {
            new FlxTimer().start(0.6, function(tmr:FlxTimer)
            {
                //Thank you KadeDev and its contributors for doing this
                title.angle = 0;

			    var http = new haxe.Http("https://raw.githubusercontent.com/BTF2021/C4t/master/version.downloadMe");
			    var returnedData:Array<String> = [];

			    http.onData = function(data:String)
			    {
				    returnedData[0] = data.substring(0, data.indexOf(';'));                       // Get current version
				    returnedData[1] = data.substring(data.indexOf('-'), data.length);
				    if (!MainMenuState.gameVer.contains(returnedData[0].trim()))
				    {
					    trace('outdated version, stupid');
					    UpdateSubState.needVer = returnedData[0];
					    UpdateSubState.currChanges = returnedData[1];
					    openSubState(new UpdateSubState()); //FlxG.switchState(new UpdateSubState());
				    }
				    else
				    {
					    FlxG.switchState(new MainMenuState());
				    }
			    }
			    http.onError = function(error)
			    {
				    FlxG.switchState(new MainMenuState()); // Just go to the main menu
			    }
			    http.request();
            }, 1);
        }
        else new FlxTimer().start(0.6, function(tmr:FlxTimer) {FlxG.switchState(new MainMenuState());}, 1);   
    }
}
