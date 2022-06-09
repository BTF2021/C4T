package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.animation.FlxAnimation;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
#if !mobile
import flixel.input.keyboard.FlxKey;
#end
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class OptionsSubState extends FlxSubState
{
    var bg:FlxSprite;
    var easyText:FlxText;
    var normalText:FlxText;
    var hardText:FlxText;
    var extremeText:FlxText;

    var checkmark:FlxSprite;
    var checkmark2:FlxSprite;
    var checkmark3:FlxSprite;

    var title:FlxText;
    var subTitle:FlxText;
    var verText:FlxText;

    var canBeClicked:Bool = false;
    var info:FlxText;

    #if mobile
    var back:FlxSprite;
    var backText:FlxText;
    #end

    private var center:Float = Main.gameWidth / 2;
    var n:Float;

    var changed:Bool = false;
    var beep:FlxSound;

    override public function create():Void
    {
        super.create();
        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.YELLOW);
		bg.alpha = 1;
		add(bg);

        title = new FlxText(0, -80);
        title.size = 40;
        title.color = 0xFF000000;
        title.text = 'Options Menu';
        title.screenCenter(X);
        add(title);
        subTitle = new FlxText(0, -80);
        subTitle.size = 40;
        subTitle.color = 0xFF000000;
        subTitle.text = "Menu";
        subTitle.screenCenter(X);
        add(subTitle);

        normalText = new FlxText(-1000, 0);
        normalText.screenCenter(Y);
        normalText.size = 40;
        normalText.color = 0xFFF200;
        normalText.text = "Normal";
        add(normalText);

        hardText = new FlxText(-1000, 0);
        hardText.screenCenter(Y);
        hardText.size = 40;
        hardText.color = 0x88001B;
        hardText.text = "Hard";
        add(hardText);

        extremeText = new FlxText(-1000, 0);
        extremeText.screenCenter(Y);
        extremeText.size = 40;
        extremeText.color = 0x550011;
        extremeText.text = "Extreme";
        add(extremeText);

        checkmark = new FlxSprite(0, 0).loadGraphic(AssetPaths.checkymark__png, true, 50, 50);
        checkmark.animation.add("Check", [0, 1, 2, 3], 30, false);
        checkmark.animation.add("LOL", [0], 1, false);
        checkmark.x = Main.gameWidth + 100;
        checkmark.y = 140;
        add(checkmark);
        checkmark.kill();

        checkmark2 = new FlxSprite(0, 0).loadGraphic(AssetPaths.checkymark__png, true, 50, 50);
        checkmark2.animation.add("Check", [0, 1, 2, 3], 30, false);
        checkmark2.animation.add("LOL", [0], 1, false);
        checkmark2.x = Main.gameWidth + 100;
        checkmark2.y = 190;
        add(checkmark2);
        checkmark2.kill();

        checkmark3 = new FlxSprite(0, 0).loadGraphic(AssetPaths.checkymark__png, true, 50, 50);
        checkmark3.animation.add("Check", [0, 1, 2, 3], 30, false);
        checkmark3.animation.add("LOL", [0], 1, false);
        checkmark3.x = Main.gameWidth + 100;
        checkmark3.y = 240;
        add(checkmark3);
        checkmark3.kill();

        #if mobile
        back = new FlxSprite(20, -200).loadGraphic(AssetPaths.Backbutton__png, false, 60, 40);
        back.color = 0xFF9819;
        add(back);
        backText = new FlxText(40, -200);
        backText.size = 40;
        backText.color = 0xFF000000;
        backText.text = "<";
        add(backText);
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

        beep = FlxG.sound.load(AssetPaths.Tone__ogg);

        UpdateText();

        DefaultData.initSave();

        transitioning();

    }

    function transitioning()
    {
        normalText.color = 0xFF000000;
        normalText.x = -1000;
        normalText.y = 150;
        hardText.color = 0xFF000000;
        hardText.x = -1000;
        hardText.y = 200;
        extremeText.color = 0xFF000000;
        extremeText.x = -1000;
        extremeText.y = 250;

        checkmark.x = Main.gameWidth + 100;
        checkmark2.x = Main.gameWidth + 100;
        checkmark3.x = Main.gameWidth + 100;

        #if mobile
        back.y = -200;
        backText.y = -200;
        #end

        subTitle.y = -80;
        title.y = -80;

        new FlxTimer().start(n, function(tmr:FlxTimer)
        {
            subTitle.text = "Gameplay options";
            subTitle.screenCenter(X);
            FlxTween.tween(subTitle, {alpha: 1, y: 40}, n, {ease: FlxEase.quartInOut});

            FlxTween.tween(normalText, {x: 150}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(hardText, {x: 150}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(extremeText, {x: 150}, n, {ease: FlxEase.quartInOut});

            #if mobile
            FlxTween.tween(back, {alpha:1, y: 40}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(backText, {alpha:1, y: 39}, n, {ease: FlxEase.quartInOut});
            #end

            checkmark.revive();
            checkmark2.revive();
            checkmark3.revive();

            FlxTween.tween(checkmark, {x: Main.gameWidth - 250}, n-0.05, {ease: FlxEase.quartInOut});
            FlxTween.tween(checkmark2, {x: Main.gameWidth - 250}, n-0.05, {ease: FlxEase.quartInOut});
            FlxTween.tween(checkmark3, {x: Main.gameWidth - 250}, n-0.05, {ease: FlxEase.quartInOut});
    
            new FlxTimer().start(n-0.05, function(tmr:FlxTimer) 
            {
                canBeClicked = true;
            }, 1);
        }, 1);
    }
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        DefaultData.initSave();
        if (!FlxG.sound.music.playing)
        {
            FlxG.sound.playMusic(AssetPaths.TitleTest__ogg, 1, true);
            FlxG.sound.music.fadeIn(4, 0, 0.7);
        }
        #if !mobile
        if (FlxG.mouse.overlaps(checkmark))
        {
            switch (FlxG.save.data.sistemOption)
            {
                case 1:
                    if(FlxG.save.data.optionsInfo)info.text = "Display the zecimals of the timer";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsZecimal = !FlxG.save.data.optionsZecimal;
                        if (FlxG.save.data.optionsZecimal == true) checkmark.animation.play("Check");
                        else checkmark.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 2:
                    if(FlxG.save.data.optionsInfo)info.text = "Display animations, which makes the garbage more lively";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsAnimation = !FlxG.save.data.optionsAnimation;
                        if (FlxG.save.data.optionsAnimation == true) checkmark.animation.play("Check");
                        else checkmark.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 3:
                    if(FlxG.save.data.optionsInfo)info.text = "You gotta find'em all.";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsEaster = !FlxG.save.data.optionsEaster;
                        if (FlxG.save.data.optionsEaster == true) checkmark.animation.play("Check");
                        else checkmark.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
            }
        }
        if (FlxG.mouse.overlaps(checkmark2))
        {
            switch (FlxG.save.data.sistemOption)
            {
                case 1:
                    if(FlxG.save.data.optionsInfo)info.text = "Enables modifiers, spicing up the gameplay.";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsModifier = !FlxG.save.data.optionsModifier;
                        if (FlxG.save.data.optionsModifier == true) checkmark2.animation.play("Check");
                        else checkmark2.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 2:
                    if(FlxG.save.data.optionsInfo)info.text = "Skippes the title, so you can get to gameplay faster";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsSkipTitle = !FlxG.save.data.optionsSkipTitle;
                        if (FlxG.save.data.optionsSkipTitle == true) checkmark2.animation.play("Check");
                        else checkmark2.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 3:
                    if(FlxG.save.data.optionsInfo)info.text = "Connects to the internet, so you can update to the latest version";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsUpdate = !FlxG.save.data.optionsUpdate;
                        if (FlxG.save.data.optionsUpdate) checkmark2.animation.play("Check");
                        else checkmark2.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
            }
        }
        if (FlxG.mouse.overlaps(checkmark3))
        {
            switch (FlxG.save.data.sistemOption)
            {
                case 1:
                    if(FlxG.save.data.optionsInfo)
                    {
                        if(FlxG.save.data.optionsEaster)info.text = "Gregory, what happened to you. SQUID GAME!!!";
                        else info.text = "Greg";
                    }
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsGreg = !FlxG.save.data.optionsGreg;
                        if (FlxG.save.data.optionsGreg == true) checkmark3.animation.play("Check");
                        else checkmark3.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 2:
                    if(FlxG.save.data.optionsInfo)info.text = "Enables the text you read right now.";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsInfo = !FlxG.save.data.optionsInfo;
                        if (FlxG.save.data.optionsInfo == true) checkmark3.animation.play("Check");
                        else checkmark3.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 3:
                    if(FlxG.save.data.optionsShutUp && FlxG.save.data.optionsInfo) info.text = "Shut up";
                    else if(FlxG.save.data.optionsInfo)info.text = "Shut up BTF";
                    info.screenCenter(X);
                    if (FlxG.mouse.justPressed)
                    {
                        FlxG.save.data.optionsShutUp = !FlxG.save.data.optionsShutUp;
                        if (FlxG.save.data.optionsShutUp == true) checkmark3.animation.play("Check");
                        else checkmark3.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
            }
        }

        if(FlxG.keys.justPressed.ESCAPE && canBeClicked)
        {
            canBeClicked = false;
            if(!changed)close();
            else
            {
                FlxG.save.flush();
                FlxG.switchState(new MainMenuState());
            }
        }
        #else
        for (touch in FlxG.touches.list)
        {
            if (touch.overlaps(checkmark))
            {
                switch (FlxG.save.data.sistemOption)
                {
                case 1:
                    if(FlxG.save.data.optionsInfo)info.text = "Display the zecimals of the timer";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsZecimal = !FlxG.save.data.optionsZecimal;
                        if (FlxG.save.data.optionsZecimal == true) checkmark.animation.play("Check");
                        else checkmark.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 2:
                    if(FlxG.save.data.optionsInfo)info.text = "Display animations, which makes the garbage more lively";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsAnimation = !FlxG.save.data.optionsAnimation;
                        if (FlxG.save.data.optionsAnimation == true) checkmark.animation.play("Check");
                        else checkmark.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 3:
                    if(FlxG.save.data.optionsInfo)info.text = "You gotta find'em all.";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsEaster = !FlxG.save.data.optionsEaster;
                        if (FlxG.save.data.optionsEaster == true) checkmark.animation.play("Check");
                        else checkmark.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                }
            }
            if (touch.overlaps(checkmark2))
            {
                switch (FlxG.save.data.sistemOption)
                {
                case 1:
                    if(FlxG.save.data.optionsInfo)info.text = "Enables modifiers, spicing up the gameplay.";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsModifier = !FlxG.save.data.optionsModifier;
                        if (FlxG.save.data.optionsModifier == true) checkmark2.animation.play("Check");
                        else checkmark2.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 2:
                    if(FlxG.save.data.optionsInfo)info.text = "Skippes the title, so you can get to gameplay faster";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsSkipTitle = !FlxG.save.data.optionsSkipTitle;
                        if (FlxG.save.data.optionsSkipTitle == true) checkmark2.animation.play("Check");
                        else checkmark2.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 3:
                    if(FlxG.save.data.optionsInfo)info.text = "Connects to the internet, so you can update to the latest version";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsUpdate = !FlxG.save.data.optionsUpdate;
                        if (FlxG.save.data.optionsUpdate) checkmark2.animation.play("Check");
                        else checkmark2.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                }
            }
            if (touch.overlaps(checkmark3))
            {
                switch (FlxG.save.data.sistemOption)
                {
                case 1:
                    if(FlxG.save.data.optionsInfo)
                    {
                        if(FlxG.save.data.optionsEaster)info.text = "Gregory, what happened to you. SQUID GAME!!!";
                        else info.text = "Greg";
                    }
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsGreg = !FlxG.save.data.optionsGreg;
                        if (FlxG.save.data.optionsGreg == true) checkmark3.animation.play("Check");
                        else checkmark3.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 2:
                    if(FlxG.save.data.optionsInfo)info.text = "Enables the text you read right now.";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsInfo = !FlxG.save.data.optionsInfo;
                        if (FlxG.save.data.optionsInfo == true) checkmark3.animation.play("Check");
                        else checkmark3.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                case 3:
                    if(FlxG.save.data.optionsShutUp && FlxG.save.data.optionsInfo) info.text = "Shut up";
                    else if(FlxG.save.data.optionsInfo)info.text = "Shut up BTF";
                    info.screenCenter(X);
                    if (touch.justPressed)
                    {
                        FlxG.save.data.optionsShutUp = !FlxG.save.data.optionsShutUp;
                        if (FlxG.save.data.optionsShutUp == true) checkmark3.animation.play("Check");
                        else checkmark3.animation.play("LOL");
                        changed = true;
                        UpdateText();
                    }
                }
            }
    
            if(touch.overlaps(back) && touch.justReleased && canBeClicked)
            {
                canBeClicked = false;
                if(!changed)close();
                else
                {
                    FlxG.save.flush();
                    FlxG.switchState(new MainMenuState());
                }
            }
        }
        #end
    }
    function UpdateText()
    {
        switch(FlxG.save.data.sistemOption)
        {
            case 1:
                if (FlxG.save.data.optionsZecimal == true) checkmark.animation.play("Check");
                else checkmark.animation.play("LOL");
                normalText.text = "Zecimal timer";

                if (FlxG.save.data.optionsModifier == true) checkmark2.animation.play("Check");
                else checkmark2.animation.play("LOL");
                hardText.text = "Modifiers";
        
                if (FlxG.save.data.optionsGreg == true) checkmark3.animation.play("Check");
                else checkmark3.animation.play("LOL");
                extremeText.text = "Greg";
            case 2:
                if (FlxG.save.data.optionsAnimation == true) checkmark.animation.play("Check");
                else checkmark.animation.play("LOL");
                normalText.text = "Animation";

                if (FlxG.save.data.optionsSkipTitle == true) checkmark2.animation.play("Check");
                else checkmark2.animation.play("LOL");
                hardText.text = "Skip Title";
        
                if (FlxG.save.data.optionsInfo == true) checkmark3.animation.play("Check");
                else checkmark3.animation.play("LOL");
                extremeText.text = "Info";
            case 3:
                if (FlxG.save.data.optionsEaster == true) checkmark.animation.play("Check");
                else checkmark.animation.play("LOL");
                normalText.text = "Eggz";

                if (FlxG.save.data.optionsUpdate == true) checkmark2.animation.play("Check");
                else checkmark2.animation.play("LOL");
                hardText.text = "Updates Reminders";
        
                if (FlxG.save.data.optionsShutUp == true)
                {
                    checkmark3.animation.play("Check");
                    extremeText.text = "Shut up";
                    if(FlxG.save.data.optionsEaster == true)
                    {
                        if(!FlxG.random.bool(0.01)) extremeText.text = "Uncheck this for annoyance";
                        else extremeText.text = "mmhmmhmhhmhmhmhmmhmhm";
                    }
                } 
                else
                {
                    checkmark3.animation.play("LOL");
                    extremeText.text = "Shut up BTF";
                    if(FlxG.save.data.optionsEaster == true)
                    {
                        if(!FlxG.random.bool(0.01)) extremeText.text = "Silence the zoomer";
                    }
                }
        }
        DefaultData.initSave();
    }
}
