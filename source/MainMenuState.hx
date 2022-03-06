package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
#if mobile
import flixel.group.FlxGroup;
#else
import flixel.input.keyboard.FlxKey;
#end
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MainMenuState extends FlxState
{
    var bg:FlxSprite;

    var play:FlxSprite;

    var playText:FlxText;
    var freeplayText:FlxText;
    var gameplayText:FlxText;
    var creatorText:FlxText;

    var credits:FlxSprite;

    var creditsText:FlxText;
    var challengesText:FlxText;
    var aspectText:FlxText;
    var ogText:FlxText;

    var options:FlxSprite;

    var optionsText:FlxText;
    var customizeText:FlxText;
    var otherText:FlxText;

    var title:FlxText;
    var subTitle:FlxText;
    var verText:FlxText;
    var info:FlxText;
    var marker:FlxSprite;

    var playSubLayer:Bool = false;
    var creditsSubLayer:Bool = false;
    var optionsSubLayer:Bool = false;

    var canBeClicked:Bool = false;

    #if mobile
    var back:FlxSprite;
    var backText:FlxText;
    #end

    override public function create()
    {
        super.create();

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.YELLOW);
        bg.screenCenter();
        add(bg);

        marker = new FlxSprite(500, 800).loadGraphic(AssetPaths.buttonMarker__png, false, 290, 150);
        add(marker);
        
        play = new FlxSprite(500, 800).loadGraphic(AssetPaths.button__png, false, 270, 130);
        play.screenCenter(X);
        add(play);
        playText = new FlxText(575, 800);
        playText.size = 40;
        playText.color = 0xFF000000;
        playText.text = "Play";
        playText.screenCenter(X);
        add(playText);
        freeplayText = new FlxText(525, 800);
        freeplayText.size = 40;
        freeplayText.color = 0xFF000000;
        freeplayText.text = "Freeplay";
        freeplayText.screenCenter(X);
        add(freeplayText);
        gameplayText = new FlxText(515, 800);
        gameplayText.size = 40;
        gameplayText.color = 0xFF000000;
        gameplayText.text = "Gameplay";
        gameplayText.screenCenter(X);
        add(gameplayText);
        creatorText = new FlxText(525, 800);
        creatorText.size = 40;
        creatorText.color = 0xFF000000;
        creatorText.text = "Creators";
        creatorText.screenCenter(X);
        add(creatorText);

        credits = new FlxSprite(500, 800).loadGraphic(AssetPaths.button__png, false, 270, 130);
        credits.screenCenter(X);
        add(credits);

        creditsText = new FlxText(545, 800);
        creditsText.size = 40;
        creditsText.color = 0xFF000000;
        creditsText.text = "Credits";
        creditsText.screenCenter(X);
        add(creditsText);
        challengesText = new FlxText(485, 800);
        challengesText.size = 40;
        challengesText.color = 0xFF000000;
        challengesText.text = "Challenges";
        challengesText.screenCenter(X);
        add(challengesText);
        aspectText = new FlxText(555, 800);
        aspectText.size = 40;
        aspectText.color = 0xFF000000;
        aspectText.text = "Aspect";
        aspectText.screenCenter(X);
        add(aspectText);
        ogText = new FlxText(525, 800);
        ogText.size = 40;
        ogText.color = 0xFF000000;
        ogText.text = "Og game";
        ogText.screenCenter(X);
        add(ogText);

        options = new FlxSprite(500, 800).loadGraphic(AssetPaths.button__png, false, 270, 130);
        options.screenCenter(X);
        add(options);

        optionsText = new FlxText(545, 800);
        optionsText.size = 40;
        optionsText.color = 0xFF000000;
        optionsText.text = "Options";
        optionsText.screenCenter(X);
        add(optionsText);
        customizeText = new FlxText(510, 800);
        customizeText.size = 40;
        customizeText.color = 0xFF000000;
        customizeText.text = "Customize";
        customizeText.screenCenter(X);
        add(customizeText);
        otherText = new FlxText(555, 800);
        otherText.size = 40;
        otherText.color = 0xFF000000;
        otherText.text = "Others";
        otherText.screenCenter(X);
        add(otherText);

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

        title = new FlxText(0, 40);
        title.size = 40;
        title.color = 0xFF000000;
        title.text = '(Temp)Pokemon Birds Fight';
        title.screenCenter(X);
        add(title);
        subTitle = new FlxText(490, -80);
        subTitle.size = 40;
        subTitle.color = 0xFF000000;
        add(subTitle);

        #if !mobile
        verText = new FlxText(10, 780);
        #else
        verText = new FlxText(25, 780);
        #end
        verText.size = 12;
        verText.color = 0xFF000000;
        verText.text = "Ver 0.1.0 (For closed beta testing only)";
        add(verText);

        info = new FlxText(480, 780);
        info.size = 20;
        info.color = 0xFF000000;
        //info.font = "Japanese.ttf"; For Japanese texts
        info.text = "";
        add(info);

        FlxTween.tween(verText, {alpha:1, y: 700}, 0.15, {ease: FlxEase.quartInOut});
        FlxTween.tween(info, {alpha:1, y: 611}, 0.15, {ease: FlxEase.quartInOut});

        FlxTween.tween(title, {alpha: 1, y: 20}, 0.2, {ease: FlxEase.quartInOut});
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (title.angle == -1)
                FlxTween.angle(title, title.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(title, title.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);

        FlxTween.tween(subTitle, {alpha: 1, y: 20}, 0.2, {ease: FlxEase.quartInOut});
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (subTitle.angle == -1)
                FlxTween.angle(subTitle, subTitle.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(subTitle, subTitle.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);

        transitioning();
    }

    function transitioning()
    {
        new FlxTimer().start(0.15, function(tmr:FlxTimer)
        {
            play.revive();
            play.screenCenter(X);
            play.color = 0xFF9819;   //Had to put here, because it doesn't work anywhere else

            playText.revive();
            freeplayText.revive();
            gameplayText.revive();
            creatorText.revive();

            credits.revive();
            credits.screenCenter(X);
            credits.color = 0xFF9819;

            creditsText.revive();
            challengesText.revive();
            aspectText.revive();
            ogText.revive();

            options.revive();
            options.screenCenter(X);
            options.color = 0xFF9819;

            optionsText.revive();
            customizeText.revive();
            otherText.revive();

            if (playSubLayer || creditsSubLayer || optionsSubLayer)subTitle.revive();
            FlxTween.tween(play, {alpha:1, y: 160}, 0.05, {ease: FlxEase.quartInOut});
            if (!playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(playText, {alpha:1, y: 205}, 0.05, {ease: FlxEase.quartInOut});
            else if (playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(freeplayText, {alpha:1, y: 205}, 0.05, {ease: FlxEase.quartInOut});
            else if (!playSubLayer && optionsSubLayer && !creditsSubLayer)FlxTween.tween(gameplayText, {alpha:1, y: 205}, 0.05, {ease: FlxEase.quartInOut});
            else if (!playSubLayer && !optionsSubLayer && creditsSubLayer){FlxTween.tween(creatorText, {alpha:1, y: 205}, 0.05, {ease: FlxEase.quartInOut}); play.color = 0x494949;}
            FlxTween.tween(credits, {alpha:1, y: 300}, 0.1, {ease: FlxEase.quartInOut});
            if (!playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(creditsText, {alpha:1, y: 345}, 0.1, {ease: FlxEase.quartInOut});
            else if (playSubLayer && !optionsSubLayer && !creditsSubLayer){FlxTween.tween(challengesText, {alpha:1, y: 345}, 0.1, {ease: FlxEase.quartInOut}); credits.color = 0x494949;}
            else if (!playSubLayer && optionsSubLayer && !creditsSubLayer)FlxTween.tween(aspectText, {alpha:1, y: 345}, 0.1, {ease: FlxEase.quartInOut}); //credits.color = 0x7F7F7F;}
            else if (!playSubLayer && !optionsSubLayer && creditsSubLayer)FlxTween.tween(ogText, {alpha:1, y: 345}, 0.1, {ease: FlxEase.quartInOut});
            if (!creditsSubLayer) {FlxTween.tween(options, {alpha:1, y: 440}, 0.15, {ease: FlxEase.quartInOut}); options.color = 0x494949;}
            if (!playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(optionsText, {alpha:1, y: 485}, 0.15, {ease: FlxEase.quartInOut});
            else if (playSubLayer && !optionsSubLayer && !creditsSubLayer){FlxTween.tween(customizeText, {alpha:1, y: 485}, 0.15, {ease: FlxEase.quartInOut}); options.color = 0x494949;}
            else if (!playSubLayer && optionsSubLayer && !creditsSubLayer)FlxTween.tween(otherText, {alpha:1, y: 485}, 0.15, {ease: FlxEase.quartInOut});

            #if mobile
            if (playSubLayer || optionsSubLayer || creditsSubLayer)
            {
                FlxTween.tween(back, {alpha:1, y: 40}, 0.15, {ease: FlxEase.quartInOut});
                FlxTween.tween(backText, {alpha:1, y: 39}, 0.15, {ease: FlxEase.quartInOut});
            }
            #end

            if(playSubLayer || creditsSubLayer || optionsSubLayer)
            {
                if(playSubLayer) {subTitle.text = "Play Menu"; subTitle.screenCenter(X);}
                else if(creditsSubLayer) {subTitle.text = "Credits Menu"; subTitle.screenCenter(X);}
                else if(optionsSubLayer) {subTitle.text = "Options Menu"; subTitle.screenCenter(X);}
                FlxTween.tween(subTitle, {alpha:1, y: 80}, 0.15, {ease: FlxEase.quartInOut});
            }
            
            new FlxTimer().start(0.3, function(tmr:FlxTimer) {canBeClicked = true; marker.revive();}, 1);
        }, 1);
    }
    function getOuttaHere()
    {
        canBeClicked = false;

        marker.kill();
        info.text = "";
       
        FlxTween.tween(play, {alpha:1, x: -300}, 0.15, {ease: FlxEase.quartInOut});
        if (!playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(playText, {alpha:1, x: -300}, 0.15, {ease: FlxEase.quartInOut});
        else if (playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(freeplayText, {alpha:1, x: -300}, 0.15, {ease: FlxEase.quartInOut});
        else if (!playSubLayer && optionsSubLayer && !creditsSubLayer)FlxTween.tween(gameplayText, {alpha:1, x: -300}, 0.15, {ease: FlxEase.quartInOut});
        else if (!playSubLayer && !optionsSubLayer && creditsSubLayer)FlxTween.tween(creatorText, {alpha:1, x: -300}, 0.15, {ease: FlxEase.quartInOut});
        FlxTween.tween(credits, {alpha:1, x: -300}, 0.1, {ease: FlxEase.quartInOut});
        if (!playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(creditsText, {alpha:1, x: -300}, 0.1, {ease: FlxEase.quartInOut});
        else if (playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(challengesText, {alpha:1, x: -300}, 0.1, {ease: FlxEase.quartInOut});
        else if (!playSubLayer && optionsSubLayer && !creditsSubLayer)FlxTween.tween(aspectText, {alpha:1, x: -300}, 0.1, {ease: FlxEase.quartInOut});
        else if (!playSubLayer && !optionsSubLayer && creditsSubLayer)FlxTween.tween(ogText, {alpha:1, x: -300}, 0.1, {ease: FlxEase.quartInOut});
        if (!creditsSubLayer)FlxTween.tween(options, {alpha:1, x: -300}, 0.05, {ease: FlxEase.quartInOut});
        if (!playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(optionsText, {alpha:1, x: -300}, 0.05, {ease: FlxEase.quartInOut});
        else if (playSubLayer && !optionsSubLayer && !creditsSubLayer)FlxTween.tween(customizeText, {alpha:1, x: -300}, 0.05, {ease: FlxEase.quartInOut});
        else if (!playSubLayer && optionsSubLayer && !creditsSubLayer)FlxTween.tween(otherText, {alpha:1, x: -300}, 0.05, {ease: FlxEase.quartInOut});

        #if mobile
        if (!playSubLayer || !optionsSubLayer || !creditsSubLayer)
        {
            FlxTween.tween(back, {alpha:1, y: -200}, 0.15, {ease: FlxEase.quartInOut});
            FlxTween.tween(backText, {alpha:1, y: -200}, 0.15, {ease: FlxEase.quartInOut});
        }
        #end

        FlxTween.tween(subTitle, {alpha:1, y: -80}, 0.15, {ease: FlxEase.quartInOut});

        new FlxTimer().start(0.15, function(tmr:FlxTimer) 
        {
            canBeClicked = true;
            play.kill();
            play.y = 800;

            playText.kill();
            playText.screenCenter(X);
            playText.y = 800;
            freeplayText.kill();
            freeplayText.screenCenter(X);
            freeplayText.y = 800;
            gameplayText.kill();
            gameplayText.screenCenter(X);
            gameplayText.y = 800;
            creatorText.kill();
            creatorText.screenCenter(X);
            creatorText.y = 800;

            credits.kill();
            credits.y = 800;

            creditsText.kill();
            creditsText.screenCenter(X);
            creditsText.y = 800;
            challengesText.kill();
            challengesText.screenCenter(X);
            challengesText.y = 800;
            aspectText.kill();
            aspectText.screenCenter(X);
            aspectText.y = 800;
            ogText.kill();
            ogText.screenCenter(X);
            ogText.y = 800;

            options.kill();
            options.y = 800;

            optionsText.kill();
            optionsText.screenCenter(X);
            optionsText.y = 800;
            customizeText.kill();
            customizeText.screenCenter(X);
            customizeText.y = 800;
            otherText.kill();
            otherText.screenCenter(X);
            otherText.y = 800;

            subTitle.kill();

            marker.screenCenter(X);

            DefaultData.initSave();

            transitioning();
        }, 1);
    }

    override public function update(elapsed:Float)
    {  
        if (!FlxG.sound.music.playing)
        {
            FlxG.sound.playMusic(AssetPaths.TitleTest__ogg, 1, true);
            FlxG.sound.music.fadeIn(4, 0, 0.7);
        }
        super.update(elapsed);

        #if !mobile
        if(FlxG.mouse.overlaps(play)) 
        {
            if (canBeClicked)
            {
                marker.x = play.x - 10;
                marker.y = play.y - 10;
            }
            if(!playSubLayer && !creditsSubLayer && !optionsSubLayer && canBeClicked) 
            {
                info.text = "Play. What can I say more?";
                info.screenCenter(X);
                if(FlxG.mouse.justPressed){playButton();  info.text = "";}
            }
            else if(!creditsSubLayer && !optionsSubLayer && playSubLayer && canBeClicked)
            {
                info.text = "Play how you want. No one will comment anything. Except...";
                info.screenCenter(X);
                if(FlxG.mouse.justPressed)
                {
                    info.text = "";
                    //FlxG.switchState(new PlayState());
                    DefaultData.initSave();
                    openSubState(new FreeplaySubState());
                }
            }
            if(!playSubLayer && creditsSubLayer && !optionsSubLayer && canBeClicked)
            {
                info.text = "OH, you want to see who made the game? Hold on... Okay, so basically you can't do that right now.";
                info.screenCenter(X);
                /*if(FlxG.mouse.justPressed)
                {

                }*/
            }
            if(!playSubLayer && optionsSubLayer  && !creditsSubLayer && canBeClicked)
            {
                info.text = "Change some gameplay elements. Is that clear?";
                info.screenCenter(X);
                /*if(FlxG.mouse.justPressed)
                {
    
                }*/
            }
        }
        if(FlxG.mouse.overlaps(credits))
        {
            if (canBeClicked)
            {
                marker.x = credits.x - 10;
                marker.y = credits.y - 10;
            }
            if(!creditsSubLayer && !playSubLayer && !optionsSubLayer && canBeClicked)
            {
                info.text = "Just to remind you who made the game. And maybe to annoy you...";
                info.screenCenter(X);
                if(FlxG.mouse.justPressed){creditsButton(); info.text = "";}
            }
            else if(creditsSubLayer && !playSubLayer && !optionsSubLayer && canBeClicked)
            {
                info.text = "Go to gulaaaaa... I mean go to where everything started.";
                info.screenCenter(X);
                if(FlxG.mouse.justPressed)
                {
                    info.text = "";
                    if(!FlxG.random.bool(1)) fancyOpenURL("https://scratch.mit.edu/projects/647644347/");
                    else fancyOpenURL("https://youtu.be/dQw4w9WgXcQ"); //HAHA, get rickrolled b!!1!
                }
            }
            if(!creditsSubLayer && playSubLayer && !optionsSubLayer && canBeClicked)
            {
                info.text = "Complete some challenges that are... not avalaible right now LOL."; //Complete some challenges to earn some extra coins
                info.screenCenter(X);
                /*if(FlxG.mouse.justPressed)
                {
                    
                }*/
            }
            if(!creditsSubLayer && optionsSubLayer && !playSubLayer && canBeClicked)
            {
                info.text = "Don't like this game's look. Then change it here!";
                info.screenCenter(X);
                /*if(FlxG.mouse.justPressed)
                {
                        
                }*/
            }
        }
        if(FlxG.mouse.overlaps(options))
        {
            if (canBeClicked)
            {
                marker.x = options.x - 10;
                marker.y = options.y - 10;
            }
            if(!optionsSubLayer && !creditsSubLayer && !playSubLayer && canBeClicked)
            {
                info.text = "When the game become deep, I will announce you when you can access this.";//"I give you options, you give me time.";
                info.screenCenter(X);
                if(FlxG.mouse.justPressed && canBeClicked){optionsButton(); info.text = "";}
            }
            else if(optionsSubLayer && !creditsSubLayer && !playSubLayer && canBeClicked)
            {
                info.text = "Can't find a setting? Maybe there's either here or doesn't exist..";
                info.screenCenter(X);
                /*if(FlxG.mouse.justPressed)
                {
                        
                }*/
            }
            if(!optionsSubLayer && playSubLayer && !creditsSubLayer && canBeClicked)
            {
                info.text = "How about breaking game's logic when this feature will be released?";
                info.screenCenter(X);
                /*if(FlxG.mouse.justPressed)
                {
                            
                }*/
            }
        }
        if(FlxG.keys.justPressed.ESCAPE)
        {
            if (playSubLayer)
            {
                getOuttaHere();
                playSubLayer = false;
            }
            else if(optionsSubLayer)
            {
                getOuttaHere();
                optionsSubLayer = false;
            }
            else if(creditsSubLayer)
            {
                getOuttaHere();
                creditsSubLayer = false;
            }
        }
        #else
        for (touch in FlxG.touches.list)
        {
            if(touch.overlaps(play)) 
            {
                if (canBeClicked)
                {
                    marker.x = play.x - 10;
                    marker.y = play.y - 10;
                }
                if(!playSubLayer && !creditsSubLayer && !optionsSubLayer && canBeClicked) 
                {
                    info.text = "Play. What can I say more?";
                    info.screenCenter(X);
                    if(touch.justReleased){playButton();  info.text = "";}
                }
                else if(!creditsSubLayer && !optionsSubLayer && playSubLayer && canBeClicked)
                {
                    info.text = "Play how you want. No one will comment anything. Except...";
                    info.screenCenter(X);
                    if(touch.justReleased)
                    {
                        info.text = "";
                        //FlxG.switchState(new PlayState());
                        DefaultData.initSave();
                        openSubState(new FreeplaySubState());
                    }
                }
                if(!playSubLayer && creditsSubLayer && !optionsSubLayer && canBeClicked)
                {
                    info.text = "Ow, you want to see who made the game? Hold on... Okay, so basically you can't";
                    info.screenCenter(X);
                    /*if(FlxG.mouse.justPressed)
                    {
    
                    }*/
                }
                if(!playSubLayer && optionsSubLayer  && !creditsSubLayer && canBeClicked)
                {
                    info.text = "Change some gameplay elements. Is that clear?";
                    info.screenCenter(X);
                    /*if(FlxG.mouse.justPressed)
                    {
        
                    }*/
                }
            }
            if(touch.overlaps(credits))
            {
                if (canBeClicked)
                {
                    marker.x = credits.x - 10;
                    marker.y = credits.y - 10;
                }
                if(!creditsSubLayer && !playSubLayer && !optionsSubLayer && canBeClicked)
                {
                    info.text = "Just to remind you who made the game. And maybe to annoy you...";
                    info.screenCenter(X);
                    if(touch.justReleased){creditsButton(); info.text = "";}
                }
                else if(creditsSubLayer && !playSubLayer && !optionsSubLayer && canBeClicked)
                {
                    info.text = "Go to gulaaaaa... I mean go to where everything started.";
                    info.screenCenter(X);
                    if(touch.justReleased)
                    {
                        info.text = "";
                        if(!FlxG.random.bool(1)) fancyOpenURL("https://scratch.mit.edu/projects/647644347/");
                        else fancyOpenURL("https://youtu.be/dQw4w9WgXcQ"); //HAHA, get rickrolled b!!1!
                    }
                }
                if(!creditsSubLayer && playSubLayer && !optionsSubLayer && canBeClicked)
                {
                    info.text = "Complete some challenges that are... not avalaible right now LOL."; //Complete some challenges to earn some extra coins
                    info.screenCenter(X);
                    /*if(FlxG.mouse.justPressed)
                    {
                        
                    }*/
                }
                if(!creditsSubLayer && optionsSubLayer && !playSubLayer && canBeClicked)
                {
                    info.text = "Don't like this game's look. Then change it here!";
                    info.screenCenter(X);
                    /*if(FlxG.mouse.justPressed)
                    {
                            
                    }*/
                }
            }
            if(touch.overlaps(options))
            {
                if (canBeClicked)
                {
                    marker.x = options.x - 10;
                    marker.y = options.y - 10;
                }
                if(!optionsSubLayer && !creditsSubLayer && !playSubLayer && canBeClicked)
                {
                    info.text = "When the game become deep, I will announce you when you can access this.";//"I give you options, you give me time.";
                    info.screenCenter(X);
                    if(touch.justReleased && canBeClicked){optionsButton(); info.text = "";}
                }
                else if(optionsSubLayer && !creditsSubLayer && !playSubLayer && canBeClicked)
                {
                    info.text = "Can't find a setting? Maybe there's either here or doesn't exist..";
                    info.screenCenter(X);
                    /*if(FlxG.mouse.justPressed)
                    {
                            
                    }*/
                }
                if(!optionsSubLayer && playSubLayer && !creditsSubLayer && canBeClicked)
                {
                    info.text = "How about breaking game's logic when this feature will be released?";
                    info.screenCenter(X);
                    /*if(FlxG.mouse.justPressed)
                    {
                                
                    }*/
                }
            }
            if(touch.overlaps(back))
            {
                if (playSubLayer && touch.justReleased)
                {
                    getOuttaHere();
                    playSubLayer = false;
                }
                else if(optionsSubLayer && touch.justReleased)
                {
                    getOuttaHere();
                    optionsSubLayer = false;
                }
                else if(creditsSubLayer && touch.justReleased)
                {
                    getOuttaHere();
                    creditsSubLayer = false;
                }
            }
        }
        #end
    }

    function playButton()
    {
        getOuttaHere();
        playSubLayer =true;//FlxG.sound.music.stop();
        //FlxG.switchState(new PlayState());
    }
    function creditsButton()
    {
        getOuttaHere();
        creditsSubLayer = true;
        //fancyOpenURL("https://scratch.mit.edu/projects/254398429/");
    }
    function optionsButton()
    {
        //getOuttaHere();
        //optionsSubLayer = true;
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