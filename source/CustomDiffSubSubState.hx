package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.animation.FlxAnimation;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if !mobile
import flixel.input.keyboard.FlxKey;
#end
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.addons.ui.FlxInputText;

class CustomDiffSubSubState extends FlxSubState
{
    var bg:FlxSprite;
    var next:FlxSprite;
    var nextText:FlxText;
    var LivesText:FlxText;
    var SpeedText:FlxText;
    var CooldwnText:FlxText;

    var Lives:FlxInputText;
    var Speed:FlxInputText;
    var Cooldwn:FlxInputText;

    var title:FlxText;
    var verText:FlxText;

    var canBeClicked:Bool = false;
    var info:FlxText;

    #if mobile
    var back:FlxSprite;
    var backText:FlxText;

    //I already hate myself because of this implementation.
    //There're gouped for convenience, but seriously someone should implement needsSoftKeyboard from openfl for FlxInputText
    var lm:FlxSprite;     var lp:FlxSprite;
    var lmText:FlxText;   var lpText:FlxText;
    var sm:FlxSprite;     var sp:FlxSprite;
    var smText:FlxText;   var spText:FlxText;
    var dm:FlxSprite;     var dp:FlxSprite;
    var dmText:FlxText;   var dpText:FlxText;
    #end

    var n:Float;
    var confirm:FlxSound;
    var errornumb:Int;      //Dumb troubleshooting for invalid values

    override public function create():Void
    {
        super.create();
        super.create();
        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.YELLOW);
		bg.alpha = 1;
		add(bg);

        title = new FlxText(0, -80);
        title.size = 40;
        title.color = 0xFF000000;
        title.text = 'Custom Difficulty Menu';
        title.screenCenter(X);
        add(title);

        next = new FlxSprite(0, Main.gameHeight).loadGraphic(AssetPaths.button__png, false, 270, 130);
        next.color = 0xFF9819;
        next.screenCenter(X);
        add(next);
        nextText = new FlxText(0, Main.gameHeight + 35);
        nextText.size = 40;
        nextText.color = 0xFF000000;
        nextText.text = "Next";
        nextText.screenCenter(X);
        add(nextText);

        Lives = new FlxInputText(Main.gameWidth, 150, 95, Std.string(FlxG.save.data.customLives), 40);
        Lives.maxLength = 4;
        Lives.filterMode = 2;
        add(Lives);
        LivesText = new FlxText(-1000, 150);
        LivesText.size = 40;
        LivesText.color = 0xFF000000;
        LivesText.text = "Lives";
        add(LivesText);

        Speed = new FlxInputText(Main.gameWidth, 200, 95, Std.string(FlxG.save.data.customSpeed), 40);
        Speed.maxLength = 4;
        Speed.filterMode = 2;
        add(Speed);
        SpeedText = new FlxText(-1000, 200);
        SpeedText.size = 40;
        SpeedText.color = 0xFF000000;
        SpeedText.text = "Bolt Speed";
        add(SpeedText);

        Cooldwn = new FlxInputText(Main.gameWidth, 250, 95, Std.string(FlxG.save.data.customCooldown), 40);
        Cooldwn.maxLength = 4;
        Cooldwn.filterMode = 2;
        add(Cooldwn);
        CooldwnText = new FlxText(-1000, 250);
        CooldwnText.size = 40;
        CooldwnText.color = 0xFF000000;
        CooldwnText.text = "Dodge Cooldown";
        add(CooldwnText);

        #if mobile
        back = new FlxSprite(20, -200).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        back.color = 0xFF9819;
        add(back);
        backText = new FlxText(40, -200);
        backText.size = 40;
        backText.color = 0xFF000000;
        backText.text = "<";
        add(backText);

        lm = new FlxSprite(Main.gameWidth, 150).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        lm.color = 0xFF9819;
        add(lm);
        lmText = new FlxText(Main.gameWidth, 151);
        lmText.size = 40;
        lmText.color = 0xFF000000;
        lmText.text = "-";
        add(lmText);
        lp = new FlxSprite(Main.gameWidth, 150).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        lp.color = 0xFF9819;
        add(lp);
        lpText = new FlxText(Main.gameWidth, 151);
        lpText.size = 40;
        lpText.color = 0xFF000000;
        lpText.text = "+";
        add(lpText);

        sm = new FlxSprite(Main.gameWidth, 200).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        sm.color = 0xFF9819;
        add(sm);
        smText = new FlxText(Main.gameWidth, 201);
        smText.size = 40;
        smText.color = 0xFF000000;
        smText.text = "-";
        add(smText);
        sp = new FlxSprite(Main.gameWidth, 200).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        sp.color = 0xFF9819;
        add(sp);
        spText = new FlxText(Main.gameWidth, 201);
        spText.size = 40;
        spText.color = 0xFF000000;
        spText.text = "+";
        add(spText);

        dm = new FlxSprite(Main.gameWidth, 250).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        dm.color = 0xFF9819;
        add(dm);
        dmText = new FlxText(Main.gameWidth, 251);
        dmText.size = 40;
        dmText.color = 0xFF000000;
        dmText.text = "-";
        add(dmText);
        dp = new FlxSprite(Main.gameWidth, 250).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        dp.color = 0xFF9819;
        add(dp);
        dpText = new FlxText(Main.gameWidth, 251);
        dpText.size = 40;
        dpText.color = 0xFF000000;
        dpText.text = "+";
        add(dpText);
        #end

        verText = new FlxText(10, Main.gameHeight - 20);
        verText.size = 12;
        verText.color = 0xFF000000;
        verText.text = "Ver" + MainMenuState.gameVer;
        add(verText);

        info = new FlxText(480, Main.gameHeight);
        info.size = 20;
        info.color = 0xFF000000;
        info.text = "";
        add(info);

        FlxTween.tween(info, {alpha:1, y: Main.gameHeight - 109}, 0.15, {ease: FlxEase.quartInOut});

        FlxTween.tween(title, {alpha: 1, y: 0}, 0.2, {ease: FlxEase.quartInOut});

        if(FlxG.save.data.optionsAnimation) n=0.15;
        else n=0.00001;

        confirm = FlxG.sound.load(AssetPaths.TempConfirm__ogg);

        DefaultData.initSave();

        transitioning();
    }
    function transitioning()
    {
        new FlxTimer().start(n, function(tmr:FlxTimer)
        {
            FlxTween.tween(next, {y: Main.gameHeight - 260}, n-0.05, {ease: FlxEase.quartInOut});
            FlxTween.tween(nextText, {y: Main.gameHeight - 225}, n-0.05, {ease: FlxEase.quartInOut});

            FlxTween.tween(LivesText, {x: 150}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(SpeedText, {x: 150}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(CooldwnText, {x: 150}, n, {ease: FlxEase.quartInOut});

            FlxTween.tween(Lives, {x: Main.gameWidth - 250}, n-0.05, {ease: FlxEase.quartInOut});
            FlxTween.tween(Speed, {x: Main.gameWidth - 250}, n-0.05, {ease: FlxEase.quartInOut});
            FlxTween.tween(Cooldwn, {x: Main.gameWidth - 250}, n-0.05, {ease: FlxEase.quartInOut});
    
            #if mobile
            FlxTween.tween(back, {alpha:1, y: 40}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(backText, {alpha:1, y: 39}, n, {ease: FlxEase.quartInOut});


            FlxTween.tween(lm, {x: Main.gameWidth - 315}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(lmText, {x: Main.gameWidth - 295}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(lp, {x: Main.gameWidth - 145}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(lpText, {x: Main.gameWidth - 130}, n, {ease: FlxEase.quartInOut});

            FlxTween.tween(sm, {x: Main.gameWidth - 315}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(smText, {x: Main.gameWidth - 295}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(sp, {x: Main.gameWidth - 145}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(spText, {x: Main.gameWidth - 130}, n, {ease: FlxEase.quartInOut});

            FlxTween.tween(dm, {x: Main.gameWidth - 315}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(dmText, {x: Main.gameWidth - 295}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(dp, {x: Main.gameWidth - 145}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(dpText, {x: Main.gameWidth - 130}, n, {ease: FlxEase.quartInOut});
            #end
        
            new FlxTimer().start(n-0.05, function(tmr:FlxTimer) 
            {
                canBeClicked = true;
            }, 1);
        }, 1);
    }
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        #if !mobile
        if(FlxG.keys.justPressed.ESCAPE && canBeClicked)
        {
                canBeClicked = false;
                close();
        }
        if (FlxG.mouse.overlaps(next))
        {
            if (canBeClicked)
            {
                if(FlxG.save.data.optionsInfo)info.text = "Continue in the play menu";
                info.screenCenter(X);
            }
            if (FlxG.mouse.justReleased)
            {
                DefaultData.initSave();
                FlxG.save.flush();
                if(FlxG.save.data.optionsModifier)close();
                else
                {
                    confirm.play(true);
                    new FlxTimer().start(0.5, function(tmr:FlxTimer) 
                    {
                        DefaultData.initSave();
                        //#if !mobile
                        FlxG.switchState(new PlayState());
                        //#else
                        //FlxG.switchState(new PlayStateMobile());
                        //#end
                    }, 1);
                }
            }
        }
        if (FlxG.mouse.overlaps(Lives))
        {
            if (canBeClicked)
            {
                if(FlxG.save.data.optionsInfo)info.text = "Change the number of lives (max. 999)";
                info.screenCenter(X);
            }
        }
        if (FlxG.mouse.overlaps(Speed))
        {
            if (canBeClicked)
            {
                if(FlxG.save.data.optionsInfo)info.text = "Change the speed of bolts (max. " + Std.string(Main.gameHeight / 2) + ")";
                info.screenCenter(X);
            }
        }
        if (FlxG.mouse.overlaps(Cooldwn))
        {
            if (canBeClicked)
            {
                if(FlxG.save.data.optionsInfo)info.text = "Change the cooldown of the cat (max. 999)";
                info.screenCenter(X);
            }
        }
        #else
        for (touch in FlxG.touches.list)
        {
            if(touch.overlaps(back) && touch.justReleased && canBeClicked)
            {
                canBeClicked = false;
                close();
            }
            if (touch.overlaps(next))
            {
                if (canBeClicked)
                {
                    if(FlxG.save.data.optionsInfo)info.text = "Continue in the play menu";
                    info.screenCenter(X);
                }
                if (touch.justReleased)
                {
                    DefaultData.initSave();
                    FlxG.save.flush();
                    if(FlxG.save.data.optionsModifier)close();
                    else
                    {
                        confirm.play(true);
                        new FlxTimer().start(0.5, function(tmr:FlxTimer) 
                        {
                            DefaultData.initSave();
                            //#if !mobile
                            FlxG.switchState(new PlayState());
                            //#else
                            //FlxG.switchState(new PlayStateMobile());
                            //#end
                        }, 1);
                    }
                }
            }
            if (touch.overlaps(Lives))
            {
                if (canBeClicked)
                {
                    if(FlxG.save.data.optionsInfo)info.text = "Change the number of lives (max. 999)";
                    info.screenCenter(X);
                }
            }
            if (touch.overlaps(Speed))
            {
                if (canBeClicked)
                {
                    if(FlxG.save.data.optionsInfo)info.text = "Change the speed of bolts in pixels per frame (max. " + Std.string(Main.gameHeight / 2) + ")";
                    info.screenCenter(X);
                }
            }
            if (touch.overlaps(Cooldwn))
            {
                if (canBeClicked)
                {
                    if(FlxG.save.data.optionsInfo)info.text = "Change the dodge cooldown time of the cat (max. 999)";
                    info.screenCenter(X);
                }
            }


            if (touch.overlaps(lm))
            {
                if (canBeClicked && touch.justPressed && FlxG.save.data.customLives > 0)
                {
                    FlxG.save.data.customLives --;
                    Lives.text = FlxG.save.data.customLives;
                }
            }
            if (touch.overlaps(lp))
            {
                if (canBeClicked && touch.justPressed && FlxG.save.data.customLives < 999)
                {
                    FlxG.save.data.customLives ++;
                    Lives.text = FlxG.save.data.customLives;
                }
            }
            if (touch.overlaps(sm))
            {
                if (canBeClicked && touch.justPressed && FlxG.save.data.customSpeed > 0)
                {
                    FlxG.save.data.customSpeed --;
                    Speed.text = FlxG.save.data.customSpeed;
                }
            }
            if (touch.overlaps(sp))
            {
                if (canBeClicked && touch.justPressed && FlxG.save.data.customSpeed < Main.gameHeight / 2)
                {
                    FlxG.save.data.customSpeed ++;
                    Speed.text = FlxG.save.data.customSpeed;
                }
            }
            if (touch.overlaps(dm))
            {
                if (canBeClicked && touch.justPressed && FlxG.save.data.customCooldown > 0)
                {
                    FlxG.save.data.customCooldown --;
                    Cooldwn.text = FlxG.save.data.customCooldown;
                }
            }
            if (touch.overlaps(dp))
            {
                if (canBeClicked && touch.justPressed && FlxG.save.data.customCooldown < 999)
                {
                    FlxG.save.data.customCooldown ++;
                    Cooldwn.text = FlxG.save.data.customCooldown;
                }
            }
        }
        #end

        Lives.callback = function(string:String, string2:String)
        {
            if (!(Std.parseFloat(Lives.text) <= 0)) FlxG.save.data.customLives = Lives.text;
            else 
            {
                Lives.text = '5';
                errornumb = 1;
                Error();
            }
        }
        Speed.callback = function(string:String, string2:String)
        {
            if (!(Std.parseFloat(Speed.text) <= 0) && !(Std.parseFloat(Speed.text) > Main.gameHeight / 2)) FlxG.save.data.customSpeed = Speed.text;
            else 
            {
                Speed.text = '9';
                errornumb = 2;
                Error();
            }
        }
        Cooldwn.callback = function(string:String, string2:String)
        {
            if (!(Std.parseFloat(Cooldwn.text) < 0)) FlxG.save.data.customCooldown = Cooldwn.text;
            else 
            {
                Cooldwn.text = '2';
                errornumb = 3;
                Error();
            }
        }
    }
    //Why it doesn't work as intended?
    function Error()
    {
        switch (errornumb)
        {
            case 1:
                info.text = "Invalid Lives Value";
                info.screenCenter(X);
            case 2:
                info.text = "Invalid Speed Value";
                info.screenCenter(X);
            case 3:
                info.text = "Invalid Cooldown Number";
                info.screenCenter(X);
        }
        FlxTween.tween(info, {alpha: 0}, n + 0.35, {ease: FlxEase.quartInOut});
        new FlxTimer().start(n, function(tmr:FlxTimer) 
        {
            info.text = '';
            info.alpha = 1;
        }, 1);
    }
}