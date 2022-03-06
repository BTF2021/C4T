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

class FreeplaySubState extends FlxSubState
{
    var bg:FlxSprite;
    var easy:FlxSprite;
    var easyText:FlxText;
    var normal:FlxSprite;
    var normalText:FlxText;
    var hard:FlxSprite;
    var hardText:FlxText;
    var extreme:FlxSprite;
    var extremeText:FlxText;

    var checkmark:FlxSprite;
    var checkmark2:FlxSprite;
    var checkmark3:FlxSprite;

    var title:FlxText;
    var subTitle:FlxText;
    var verText:FlxText;

    var layer1:Bool = false;

    var marker:FlxSprite;
    var canBeClicked:Bool = false;
    var info:FlxText;

    #if mobile
    var back:FlxSprite;
    var backText:FlxText;
    #end

    var confirm:FlxSound;

    override public function create():Void
    {
        super.create();
        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.YELLOW);
		bg.alpha = 1;
		add(bg);

        title = new FlxText(0, -80);
        title.size = 40;
        title.color = 0xFF000000;
        title.text = 'Freeplay Menu';
        title.screenCenter(X);
        add(title);
        subTitle = new FlxText(0, -80);
        subTitle.size = 40;
        subTitle.color = 0xFF000000;
        subTitle.text = "Choose Difficulty";
        subTitle.screenCenter(X);
        add(subTitle);

        marker = new FlxSprite(500, 800).loadGraphic(AssetPaths.buttonMarker__png, false, 290, 150);
        add(marker);

        easy = new FlxSprite(-300, 0).loadGraphic(AssetPaths.button__png, false, 270, 130);
        easy.color = 0x3F48CC;
        easy.screenCenter(Y);
        add(easy);
        easyText = new FlxText(-255, 0);
        easyText.screenCenter(Y);
        easyText.size = 40;
        easyText.color = 0x00A8F3;
        easyText.text = "Easy";
        add(easyText);

        normal = new FlxSprite(-300, 0).loadGraphic(AssetPaths.button__png, false, 270, 130);
        normal.color = 0xFF9819;
        normal.screenCenter(Y);
        add(normal);
        normalText = new FlxText(-255, 0);
        normalText.screenCenter(Y);
        normalText.size = 40;
        normalText.color = 0xFFF200;
        normalText.text = "Normal";
        add(normalText);

        hard = new FlxSprite(1580, 0).loadGraphic(AssetPaths.button__png, false, 270, 130);
        hard.color = 0xEC1C24;
        hard.screenCenter(Y);
        add(hard);
        hardText = new FlxText(1535, 0);
        hardText.screenCenter(Y);
        hardText.size = 40;
        hardText.color = 0x88001B;
        hardText.text = "Hard";
        add(hardText);

        extreme = new FlxSprite(1580, 0).loadGraphic(AssetPaths.button__png, false, 270, 130);
        extreme.color = 0xA20006;
        extreme.screenCenter(Y);
        add(extreme);
        extremeText = new FlxText(1535, 0);
        extremeText.screenCenter(Y);
        extremeText.size = 40;
        extremeText.color = 0x550011;
        extremeText.text = "Extreme";
        add(extremeText);

        checkmark = new FlxSprite(0, 0).loadGraphic(AssetPaths.checkymark__png, true, 50, 50);
        checkmark.animation.add("Check", [0, 1, 2, 3], 30, false);
        checkmark.animation.add("LOL", [0], 1, false);
        checkmark.x = 1400;
        checkmark.y = 140;
        add(checkmark);
        checkmark.kill();

        checkmark2 = new FlxSprite(0, 0).loadGraphic(AssetPaths.checkymark__png, true, 50, 50);
        checkmark2.animation.add("Check", [0, 1, 2, 3], 30, false);
        checkmark2.animation.add("LOL", [0], 1, false);
        checkmark2.x = 1400;
        checkmark2.y = 190;
        add(checkmark2);
        checkmark2.kill();

        checkmark3 = new FlxSprite(0, 0).loadGraphic(AssetPaths.checkymark__png, true, 50, 50);
        checkmark3.animation.add("Check", [0, 1, 2, 3], 30, false);
        checkmark3.animation.add("LOL", [0], 1, false);
        checkmark3.x = 1400;
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

        verText = new FlxText(10, 700);
        verText.size = 12;
        verText.color = 0xFF000000;
        verText.text = "Ver 0.1.0 (For closed beta testing only)";
        add(verText);

        info = new FlxText(480, 780);
        info.size = 20;
        info.color = 0xFF000000;
        info.text = "";
        add(info);

        FlxTween.tween(info, {alpha:1, y: 660}, 0.15, {ease: FlxEase.quartInOut});

        FlxTween.tween(title, {alpha: 1, y: 0}, 0.2, {ease: FlxEase.quartInOut});

        if (FlxG.save.data.sistemMaso == true) checkmark.animation.play("Check");
        else checkmark.animation.play("LOL");

        if (FlxG.save.data.sistemFullPow == true) checkmark2.animation.play("Check");
        else checkmark2.animation.play("LOL");
        
        if (FlxG.save.data.sistemInvert == true) checkmark3.animation.play("Check");
        else checkmark3.animation.play("LOL");

        confirm = FlxG.sound.load(AssetPaths.TempConfirm__ogg);

        transitioning();

    }

    function transitioning()
    {
        if (!layer1)
        {
            easy.color = 0x3F48CC;
            easy.x = -300;
            easy.screenCenter(Y);
            easyText.color = 0x00A8F3;
            easyText.x = -300;
            easyText.text = "Easy";
            easyText.screenCenter(Y);
            normal.revive();
            normal.color = 0xFF9819;
            normal.x = -300;
            normalText.color = 0xFFF200;
            normalText.text = "Normal";
            normalText.screenCenter(Y);
            hard.revive();
            hard.color = 0xEC1C24;
            hard.x = 1580;
            hardText.color = 0x88001B;
            hardText.text = "Hard";
            hardText.screenCenter(Y);
            extreme.revive();
            extreme.color = 0xA20006;
            extreme.x = 1580;
            extremeText.color = 0x550011;
            extremeText.text = "Extreme";
            extremeText.screenCenter(Y);
        }
        else if (layer1)
        {
            easy.color = 0xFF9819;
            easy.y = 800;
            easy.screenCenter(X);
            easyText.color = 0xFF000000;
            easyText.y = 835;
            easyText.screenCenter(X);
            easyText.text = "Begin";

            normalText.color = 0xFF000000;
            normalText.x = -500;
            normalText.y = 150;
            #if !mobile
            normalText.text = "M4s0ch1st Mode";
            #else
            normalText.text = "No teleportation Mode";
            #end

            hardText.color = 0xFF000000;
            hardText.y = 200;
            hardText.text = "Full Power Mode";
            extreme.color = 0xFF000000;
            extremeText.y = 250;
            extremeText.text = "Inverted Mode";
        }

        new FlxTimer().start(0.15, function(tmr:FlxTimer)
        {
            if (!layer1) subTitle.text = "Choose Difficulty";
            else subTitle.text = "Enable Modifiers";
            FlxTween.tween(subTitle, {alpha: 1, y: 40}, 0.2, {ease: FlxEase.quartInOut});

            if (!layer1) FlxTween.tween(easy, {x: 70}, 0.1, {ease: FlxEase.quartInOut});
            else FlxTween.tween(easy, {y: 530}, 0.1, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(easyText, {x: 135}, 0.1, {ease: FlxEase.quartInOut});
            else FlxTween.tween(easyText, {y: 565}, 0.1, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(normal, {x: 350}, 0.15, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(normalText, {x: 395}, 0.15, {ease: FlxEase.quartInOut});
            else FlxTween.tween(normalText, {x: 150}, 0.15, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(hard, {x: 630}, 0.15, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(hardText, {x: 705}, 0.15, {ease: FlxEase.quartInOut});
            else FlxTween.tween(hardText, {x: 150}, 0.15, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(extreme, {x: 910}, 0.1, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(extremeText, {x: 945}, 0.1, {ease: FlxEase.quartInOut});
            else FlxTween.tween(extremeText, {x: 150}, 0.1, {ease: FlxEase.quartInOut});

            #if mobile
            FlxTween.tween(back, {alpha:1, y: 40}, 0.15, {ease: FlxEase.quartInOut});
            FlxTween.tween(backText, {alpha:1, y: 39}, 0.15, {ease: FlxEase.quartInOut});
            #end

            if (layer1)
            {
                checkmark.revive();
                checkmark2.revive();
                checkmark3.revive();

                FlxTween.tween(checkmark, {x: 1000}, 0.1, {ease: FlxEase.quartInOut});
                FlxTween.tween(checkmark2, {x: 1000}, 0.1, {ease: FlxEase.quartInOut});
                FlxTween.tween(checkmark3, {x: 1000}, 0.1, {ease: FlxEase.quartInOut});
            }
    
            new FlxTimer().start(0.1, function(tmr:FlxTimer) 
            {
                canBeClicked = true;
                if(!layer1)marker.revive();
            }, 1);
        }, 1);
    }
    function getOuttaHere()
    {
        new FlxTimer().start(0.15, function(tmr:FlxTimer)
        {
            canBeClicked = false;
            marker.kill();

            FlxTween.tween(subTitle, {alpha: 1, y: -60}, 0.2, {ease: FlxEase.quartInOut});
            
            if (!layer1) FlxTween.tween(easy, {y: 800}, 0.1, {ease: FlxEase.quartInOut});
            else FlxTween.tween(easy, {x: -300}, 0.1, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(easyText, {y: 780}, 0.1, {ease: FlxEase.quartInOut});
            else FlxTween.tween(easyText, {x: -255}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(normal, {x: -300}, 0.15, {ease: FlxEase.quartInOut});
            FlxTween.tween(normalText, {x: -455}, 0.15, {ease: FlxEase.quartInOut});
            FlxTween.tween(hard, {x: 1580}, 0.15, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(hardText, {x: -455}, 0.15, {ease: FlxEase.quartInOut});
            else FlxTween.tween(hardText, {x: 1535}, 0.15, {ease: FlxEase.quartInOut});
            FlxTween.tween(extreme, {x: 1580}, 0.1, {ease: FlxEase.quartInOut});
            if (!layer1) FlxTween.tween(extremeText, {x: -455}, 0.15, {ease: FlxEase.quartInOut});
            else FlxTween.tween(extremeText, {x: 1535}, 0.1, {ease: FlxEase.quartInOut});

            if (!layer1)
            {
                FlxTween.tween(checkmark, {x: 2400}, 0.1, {ease: FlxEase.quartInOut});
                FlxTween.tween(checkmark2, {x: 2400}, 0.1, {ease: FlxEase.quartInOut});
                FlxTween.tween(checkmark3, {x: 2400}, 0.1, {ease: FlxEase.quartInOut});
                checkmark.kill();
                checkmark2.kill();
                checkmark3.kill();
            }

            info.text = '';
        
            new FlxTimer().start(0.15, function(tmr:FlxTimer) 
            {
                normal.kill();
                hard.kill();
                extreme.kill();
                transitioning();
            }, 1);
        }, 1);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (!FlxG.sound.music.playing)
        {
            FlxG.sound.playMusic(AssetPaths.TitleTest__ogg, 1, true);
            FlxG.sound.music.fadeIn(4, 0, 0.7);
        }
        #if !mobile
        if (FlxG.mouse.overlaps(easy))
        {
            if (canBeClicked)
            {
                marker.x = easy.x - 10;
                marker.y = easy.y - 10;
                if (!layer1) info.text = "7 lives, slower bolt speed, shorter dodge cooldown. Easy mode? More like, baby mode.";
                else info.text = "Begin the game";
                info.screenCenter(X);
            }
            if (FlxG.mouse.justPressed && !layer1)
            {
                FlxG.save.data.sistemDifficulty = 1;
                layer1 = true;
                getOuttaHere();
                //FlxG.sound.music.stop();
                //FlxG.switchState(new PlayState());
            }
            else if (FlxG.mouse.justPressed && layer1)
            {
                FlxG.camera.flash(FlxColor.WHITE, 1);
                confirm.play(true);
                new FlxTimer().start(0.5, function(tmr:FlxTimer) 
                {
                    DefaultData.initSave();
                    FlxG.switchState(new PlayState());
                }, 1);
            }
        }
        if (FlxG.mouse.overlaps(normal))
        {
            if (canBeClicked)
            {
                marker.x = normal.x - 10;
                marker.y = normal.y - 10;
                info.text = "5 lives, normal bolt speed, normal dodge cooldown. The standart difficulty.";
                info.screenCenter(X);
            }
            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.sistemDifficulty = 2;
                layer1 = true;
                getOuttaHere();
                //FlxG.sound.music.stop();
                //FlxG.switchState(new PlayState());
            }
        }
        if (FlxG.mouse.overlaps(hard))
        {
            if (canBeClicked)
            {
                marker.x = hard.x - 10;
                marker.y = hard.y - 10;
                info.text = "3 lives, faster bolt speed, longer dodge cooldown. Normal difficulty, but spicier.";
                info.screenCenter(X);
            }
            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.sistemDifficulty = 3;
                layer1 = true;
                getOuttaHere();
                //FlxG.sound.music.stop();
                //FlxG.switchState(new PlayState());
            }
        }
        if (FlxG.mouse.overlaps(extreme))
        {
            if (canBeClicked)
            {
                marker.x = extreme.x - 10;
                marker.y = extreme.y - 10;
                info.text = "Only 1 life, even faster bolt speed, NO DODGE. The hardest difficulty mode ever, no cap.";
                info.screenCenter(X);
            }
            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.sistemDifficulty = 4;
                layer1 = true;
                getOuttaHere();
                //FlxG.sound.music.stop();
                //FlxG.switchState(new PlayState());
            }
        }

        if (FlxG.mouse.overlaps(checkmark))
        {
            info.text = "This modifier REPLACES mouse-left click scheme with arrow keys-ctrl. This name fits perfectly.";
            info.screenCenter(X);
            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.sistemMaso = !FlxG.save.data.sistemMaso;
                if (FlxG.save.data.sistemMaso == true) checkmark.animation.play("Check");
                else checkmark.animation.play("LOL");
            }
        }
        if (FlxG.mouse.overlaps(checkmark2))
        {
            info.text = "This modifier makes all bolts to spawn at the beginning. The whole 10.";
            info.screenCenter(X);
            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.sistemFullPow = !FlxG.save.data.sistemFullPow;
                if (FlxG.save.data.sistemFullPow == true) checkmark2.animation.play("Check");
                else checkmark2.animation.play("LOL");
            }
        }
        if (FlxG.mouse.overlaps(checkmark3))
        {
            info.text = "This modifier 'changes' gravity... and by gravity I mean makes the bolts moves from down to up.";
            info.screenCenter(X);
            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.sistemInvert = !FlxG.save.data.sistemInvert;
                if (FlxG.save.data.sistemInvert == true) checkmark3.animation.play("Check");
                else checkmark3.animation.play("LOL");
            }
        }

        if(FlxG.keys.justPressed.ESCAPE)
        {
            if (layer1)
            {
                layer1 = false;
                getOuttaHere();
            }
            else close();
        }
        #else
        for (touch in FlxG.touches.list)
        {
            if (touch.overlaps(easy))
            {
                if (canBeClicked)
                {
                    marker.x = easy.x - 10;
                    marker.y = easy.y - 10;
                    if (!layer1) info.text = "7 lives, slower bolt speed, shorter dodge cooldown. Easy mode? More like, baby mode.";
                    else info.text = "Begin the game";
                    info.screenCenter(X);
                }
                if (touch.justReleased && !layer1)
                {
                    FlxG.save.data.sistemDifficulty = 1;
                    layer1 = true;
                    getOuttaHere();
                    //FlxG.sound.music.stop();
                    //FlxG.switchState(new PlayState());
                }
                else if (touch.justReleased && layer1)
                {
                    FlxG.camera.flash(FlxColor.WHITE, 1);
                    confirm.play(true);
                    new FlxTimer().start(0.5, function(tmr:FlxTimer) 
                    {
                        DefaultData.initSave();
                        #if !mobile
                        FlxG.switchState(new PlayState());
                        #else
                        FlxG.switchState(new PlayStateMobile());
                        #end
                    }, 1);
                }
            }
            if (touch.overlaps(normal))
            {
                if (canBeClicked)
                {
                    marker.x = normal.x - 10;
                    marker.y = normal.y - 10;
                    info.text = "5 lives, normal bolt speed, normal dodge cooldown. The standart difficulty.";
                    info.screenCenter(X);
                }
                if (touch.justReleased)
                {
                    FlxG.save.data.sistemDifficulty = 2;
                    layer1 = true;
                    getOuttaHere();
                    //FlxG.sound.music.stop();
                    //FlxG.switchState(new PlayState());
                }
            }
            if (touch.overlaps(hard))
            {
                if (canBeClicked)
                {
                    marker.x = hard.x - 10;
                    marker.y = hard.y - 10;
                    info.text = "3 lives, faster bolt speed, longer dodge cooldown. Normal difficulty, but spicier.";
                    info.screenCenter(X);
                }
                if (touch.justReleased)
                {
                    FlxG.save.data.sistemDifficulty = 3;
                    layer1 = true;
                    getOuttaHere();
                    //FlxG.sound.music.stop();
                    //FlxG.switchState(new PlayState());
                }
            }
            if (touch.overlaps(extreme))
            {
                if (canBeClicked)
                {
                    marker.x = extreme.x - 10;
                    marker.y = extreme.y - 10;
                    info.text = "Only 1 life, even faster bolt speed, NO DODGE. The hardest difficulty mode ever, no cap.";
                    info.screenCenter(X);
                }
                if (touch.justReleased)
                {
                    FlxG.save.data.sistemDifficulty = 4;
                    layer1 = true;
                    getOuttaHere();
                    //FlxG.sound.music.stop();
                    //FlxG.switchState(new PlayState());
                }
            }
    
            if (touch.overlaps(checkmark))
            {
                info.text = "This modifier disables the 'ability' to teleport. Now you can't exploit this, HaHa.";
                info.screenCenter(X);
                if (touch.justReleased)
                {
                    FlxG.save.data.sistemMaso = !FlxG.save.data.sistemMaso;
                    if (FlxG.save.data.sistemMaso == true) checkmark.animation.play("Check");
                    else checkmark.animation.play("LOL");
                }
            }
            if (touch.overlaps(checkmark2))
            {
                info.text = "This modifier makes all bolts to spawn at the beginning. The whole 13.";
                info.screenCenter(X);
                if (touch.justReleased)
                {
                    FlxG.save.data.sistemFullPow = !FlxG.save.data.sistemFullPow;
                    if (FlxG.save.data.sistemFullPow == true) checkmark2.animation.play("Check");
                    else checkmark2.animation.play("LOL");
                }
            }
            if (touch.overlaps(checkmark3))
            {
                info.text = "This modifier 'changes' gravity... and by gravity I mean makes the bolts moves from down to up.";
                info.screenCenter(X);
                if (touch.justReleased)
                {
                    FlxG.save.data.sistemInvert = !FlxG.save.data.sistemInvert;
                    if (FlxG.save.data.sistemInvert == true) checkmark3.animation.play("Check");
                    else checkmark3.animation.play("LOL");
                }
            }
    
            if(touch.overlaps(back) && touch.justReleased)
            {
                if (layer1)
                {
                    layer1 = false;
                    getOuttaHere();
                }
                else close();
            }
        }
        #end
    }
}