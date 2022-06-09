package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
#if !mobile
import  flixel.input.keyboard.FlxKey;
#end
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;


class PlayState extends FlxState
{
    var cat:FlxSprite;
	var boltGen:FlxObject; //For random bolt x variation
	var bolt:FlxSprite;
	var boltflip:Bool;

	var bolt1:FlxSprite;
    var bolt1flip:Bool;

	var bolt2:FlxSprite;  //Me being dumb, cuz I can't clone
    var bolt2flip:Bool;

	var bolt3:FlxSprite;
    var bolt3flip:Bool;

	var bolt4:FlxSprite;
    var bolt4flip:Bool;

	var bolt5:FlxSprite;
    var bolt5flip:Bool;
	
	var bolt6:FlxSprite;
    var bolt6flip:Bool;

	var bolt7:FlxSprite;
    var bolt7flip:Bool;

	var bolt8:FlxSprite;
    var bolt8flip:Bool;

	var bolt9:FlxSprite;
    var bolt9flip:Bool;

	var timr:Float = 0;
	var time:FlxText;

	var dodge:Bool = true;
	var n:Float;
	var countdown:FlxText;

	var helth:Int;
	var v:Int;                                                   //Speed
	var Halth:FlxText;
	var refer:FlxSound;

	var ded:FlxText;
	var begen:Bool = false;

	var IFrame:Bool;
    var isAlive:Bool = true;

	#if mobile
	var back:FlxSprite;
    var backText:FlxText;
	#end

	var anSpeed:Float;

	override public function create()
	{
		super.create();

		if(FlxG.save.data.sistemThundMay) FlxG.save.data.sistemInvert = false;  //don't flip the cat
		if(FlxG.save.data.sistemInvert)
		{
			boltflip = true;
			bolt1flip = true;
			bolt2flip = true;
			bolt3flip = true;
			bolt4flip = true;
			bolt5flip = true;
			bolt6flip = true;
			bolt7flip = true;
			bolt8flip = true;
			bolt9flip = true;
		}
		else
		{
			boltflip = false;
			bolt1flip = false;
			bolt2flip = false;
			bolt3flip = false;
			bolt4flip = false;
			bolt5flip = false;
			bolt6flip = false;
			bolt7flip = false;
			bolt8flip = false;
			bolt9flip = false;
		}

		FlxG.sound.music.stop();

		cat = new FlxSprite().loadGraphic(AssetPaths.cat__png, true, 104, 112);
		cat.screenCenter();
		if (!FlxG.save.data.sistemInvert) cat.y = 620;
		else cat.y = 100;
		#if desktop
		if (FlxG.save.data.sistemThundMay && FlxG.save.data.sistemMaso) cat.screenCenter();
		#end
		if (FlxG.save.data.sistemInvert) cat.flipY = true;
		add(cat);

		boltGen = new FlxObject(0, 60, 0, 0);
		add(boltGen);

		bolt = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt.alpha = 0;
		bolt.y = 0;
		if (FlxG.save.data.sistemInvert) bolt.flipY = true;
		add(bolt);
		bolt1 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt1.alpha = 0;
		bolt1.y = 0;
		if (FlxG.save.data.sistemInvert) bolt1.flipY = true;
		add(bolt1);
		bolt2 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);  //Me being dumb, Part 2
		bolt2.alpha = 0;
		bolt2.y = 0;
		if (FlxG.save.data.sistemInvert) bolt2.flipY = true;
		add(bolt2);
		bolt3 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt3.alpha = 0;
		bolt3.y = 0;
		if (FlxG.save.data.sistemInvert) bolt3.flipY = true;
		add(bolt3);
		bolt4 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt4.alpha = 0;
		bolt4.y = 0;
		if (FlxG.save.data.sistemInvert) bolt4.flipY = true;
		add(bolt4);
		bolt5 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt5.alpha = 0;
		bolt5.y = 0;
		if (FlxG.save.data.sistemInvert) bolt5.flipY = true;
		add(bolt5);
		bolt6 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt6.alpha = 0;
		bolt6.y = 0;
		if (FlxG.save.data.sistemInvert) bolt6.flipY = true;
		add(bolt6);
		bolt7 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt7.alpha = 0;
		bolt7.y = 0;
		if (FlxG.save.data.sistemInvert) bolt7.flipY = true;
		add(bolt7);
		bolt8 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt8.alpha = 0;
		bolt8.y = 0;
		if (FlxG.save.data.sistemInvert) bolt8.flipY = true;
		add(bolt8);
		bolt9 = new FlxSprite().loadGraphic(AssetPaths.bolt__png, true, 51, 199);
		bolt9.alpha = 0;
		bolt9.y = 0;
		if (FlxG.save.data.sistemInvert) bolt9.flipY = true;
		add(bolt9);

		#if !mobile
        time = new FlxText(20, 20);
		time.size = 20;
		add(time);
		#else
		time = new FlxText(20, 80);
		time.size = 20;
		add(time);
		#end

		countdown = new FlxText(20, Main.gameHeight - 60);
		countdown.size = 20;
		add(countdown);

		Halth = new FlxText(20, Main.gameHeight - 40);
		Halth.size = 20;
		add(Halth);

		ded = new FlxText(380, 360);
		ded.size = 30;
		ded.text = '';
		add(ded);

		refer = FlxG.sound.load(AssetPaths.Pressure__ogg);
		refer.volume = 0.15;
        #if !mobile
		FlxG.mouse.visible = false;
		#end
		IFrame = false;
		if (FlxG.save.data.optionsZecimal) new FlxTimer().start(0.005, GameTimer, 0);
		else new FlxTimer().start(0.5, GameTimer, 0);

		switch(FlxG.save.data.sistemDifficulty)
		{
			case 1:
				helth = 7;
				n = 1.5;
				v = 7;
			case 2:
				helth = 5;
				n = 2;
				v = 9;
			case 3:
				helth = 3;
				n = 2.5;
				v = 10;
			case 4:
				helth = 1;
				v = 12;
			case 5:
				helth = FlxG.save.data.customLives;
				n = FlxG.save.data.customCooldown;
				v = FlxG.save.data.customSpeed;
		}

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

		if(FlxG.save.data.optionsAnimation) anSpeed=0.08;
        else anSpeed=0.00001;

		begin();
	}

	public function begin()
	{
		begen = false;
		ded.text = 'Click anywhere or press ctrl to begin';
		ded.x = 380;
	} 

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (begen)
		{
			time.text = 'Timer: ' + Std.string(timr);
			Halth.text = 'Health: ' + Std.string(helth);
			if(helth == 1 && FlxG.save.data.optionsEaster) Halth.text = "Health: You're the last one. Complete the mission";
			if(FlxG.save.data.sistemDifficulty != 4) countdown.text = 'Dodge: ' + (dodge ? "Ready (Press Left Click)" : "Not ready");
			else if (FlxG.save.data.sistemDifficulty == 4)
			{
				if(!FlxG.save.data.optionsEaster) countdown.text = 'Dodge is disabled';
				else countdown.text = "Dodge: unable to can :)";
			}
			if(FlxG.save.data.sistemThundMay && isAlive)
			{
				if (FlxG.random.bool(50)) FlxG.save.data.sistemInvert = true;
				else FlxG.save.data.sistemInvert = false;
			}
		}

		boltGen.x = FlxG.random.int(0, Main.gameWidth);
		

		if(FlxG.random.bool(5))                                                         //I'm gonna do 12 of them, if I would just enter all of them in only one, all of them would appear
		{
			if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
			{
                boltflip = FlxG.save.data.sistemInvert;
                if(!boltflip) bolt.y = Main.gameHeight + 200;
				else bolt.y = -399;
			}
			if(bolt.y >=Main.gameHeight + 199 && !boltflip)
			{
			    bolt.revive();
			    bolt.flipY = false;
			    FlxTween.tween(bolt, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
			    bolt.x = boltGen.x;
			    bolt.y = -199;
			}
			else if(bolt.y <= -398 && boltflip)
			{
                bolt.revive();
				bolt.flipY = true;
				FlxTween.tween(bolt, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
				bolt.x = boltGen.x;
				bolt.y = Main.gameHeight;
			}
		}
		if(FlxG.random.bool(5))
			{
				if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
					{
						bolt1flip = FlxG.save.data.sistemInvert;
						if(!bolt1flip) bolt1.y = Main.gameHeight + 200;
						else bolt1.y = -399;
					}
				if(bolt1.y >=Main.gameHeight + 199 && !bolt1flip)
				{
					bolt1.revive();
					bolt1.flipY = false;
					FlxTween.tween(bolt1, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt1.x = boltGen.x;
					bolt1.y = -199;
				}
				else if(bolt1.y <= -398 && bolt1flip)
				{
					bolt1.revive();
					bolt1.flipY = true;
					FlxTween.tween(bolt1, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt1.x = boltGen.x;
					bolt1.y = Main.gameHeight;
				}
			}
		if(FlxG.random.bool(5))
			{
				if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
					{
						bolt2flip = FlxG.save.data.sistemInvert;
						if(!bolt2flip) bolt2.y = Main.gameHeight + 200;
						else bolt2.y = -399;
					}
				if(bolt2.y >=Main.gameHeight + 199 && !bolt2flip)
				{
					bolt2.revive();
					bolt2.flipY = false;
					FlxTween.tween(bolt2, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt2.x = boltGen.x;
					bolt2.y = -199;
				}
				else if(bolt2.y <= -398 && bolt2flip)
				{
					bolt2.revive();
					bolt2.flipY = true;
					FlxTween.tween(bolt2, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt2.x = boltGen.x;
					bolt2.y = Main.gameHeight;
				}
			}
		if(FlxG.random.bool(5))
			{
				if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
					{
						bolt3flip = FlxG.save.data.sistemInvert;
						if(!bolt3flip) bolt3.y = Main.gameHeight + 200;
						else bolt3.y = -399;
					}
				if(bolt3.y >=Main.gameHeight + 199 && !bolt3flip)
				{
					bolt3.revive();
					bolt3.flipY = false;
					FlxTween.tween(bolt3, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt3.x = boltGen.x;
					bolt3.y = -199;
				}
				else if(bolt3.y <= -398 && bolt3flip)
				{
					bolt3.revive();
					bolt3.flipY = true;
					FlxTween.tween(bolt3, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt3.x = boltGen.x;
					bolt3.y = Main.gameHeight;
				}
			}
		if(FlxG.random.bool(5))
		{
			if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
				{
					bolt4flip = FlxG.save.data.sistemInvert;
					if(!bolt4flip) bolt4.y = Main.gameHeight + 200;
					else bolt4.y = -399;
				}
			if(bolt4.y >=Main.gameHeight + 199 && !bolt4flip)
			{
		        if (timr >= 10 && !FlxG.save.data.sistemFullPow)
		        {
			    bolt4.revive();
			    bolt4.flipY = false;
			    FlxTween.tween(bolt4, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
			    bolt4.x = boltGen.x;
			    bolt4.y = -199;
		        }
		        else if (FlxG.save.data.sistemFullPow)
		        {
			    bolt4.revive();
			    bolt4.flipY = false;
			    FlxTween.tween(bolt4, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
			    bolt4.x = boltGen.x;
			    bolt4.y =-199;
		        }
		    }
			else if(bolt4.y <= -398 && bolt4flip)
			{
				if (timr >= 10 && !FlxG.save.data.sistemFullPow)
					{
					bolt4.revive();
					bolt4.flipY = true;
					FlxTween.tween(bolt4, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt4.x = boltGen.x;
					bolt4.y = Main.gameHeight;
					}
					else if (FlxG.save.data.sistemFullPow)
					{
					bolt4.revive();
					bolt4.flipY = true;
					FlxTween.tween(bolt4, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt4.x = boltGen.x;
					bolt4.y = Main.gameHeight;
					}
			}
		}
		if(FlxG.random.bool(5))
		{
			if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
				{
					bolt5flip = FlxG.save.data.sistemInvert;
					if(!bolt5flip) bolt5.y = Main.gameHeight + 200;
					else bolt5.y = -399;
				}
			if(bolt5.y >=Main.gameHeight + 199 && !bolt5flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
					{
					bolt5.revive();
					bolt5.flipY = false;
					FlxTween.tween(bolt5, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt5.x = boltGen.x;
					bolt5.y = -199;
					}
					else if (FlxG.save.data.sistemFullPow)
					{
					bolt5.revive();
					bolt5.flipY = false;
					FlxTween.tween(bolt5, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt5.x = boltGen.x;
					bolt5.y = -199;
					}
				}
				else if(bolt5.y <= -398 && bolt5flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
						{
						bolt5.revive();
						bolt5.flipY = true;
						FlxTween.tween(bolt5, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt5.x = boltGen.x;
						bolt5.y = Main.gameHeight;
						}
						else if (FlxG.save.data.sistemFullPow)
						{
						bolt5.revive();
						bolt5.flipY = true;
						FlxTween.tween(bolt5, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt5.x = boltGen.x;
						bolt5.y = Main.gameHeight;
						}
				}
		}
		if(FlxG.random.bool(5))
		{
			if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
				{
					bolt6flip = FlxG.save.data.sistemInvert;
					if(!bolt6flip) bolt6.y = Main.gameHeight + 200;
					else bolt6.y = -399;
				}
			if(bolt6.y >=Main.gameHeight + 199 && !bolt6flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
					{
					bolt6.revive();
					bolt6.flipY = false;
					FlxTween.tween(bolt6, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt6.x = boltGen.x;
					bolt6.y = -199;
					}
					else if (FlxG.save.data.sistemFullPow)
					{
					bolt6.revive();
					bolt6.flipY = false;
					FlxTween.tween(bolt6, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt6.x = boltGen.x;
					bolt6.y = -199;
					}
				}
				else if(bolt6.y <= -398 && bolt6flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
						{
						bolt6.revive();
						bolt6.flipY = true;
						FlxTween.tween(bolt6, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt6.x = boltGen.x;
						bolt6.y = Main.gameHeight;
						}
						else if (FlxG.save.data.sistemFullPow)
						{
						bolt6.revive();
						bolt6.flipY = true;
						FlxTween.tween(bolt6, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt6.x = boltGen.x;
						bolt6.y = Main.gameHeight;
						}
				}
		}
		if(FlxG.random.bool(5))
		{
			if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
				{
					bolt7flip = FlxG.save.data.sistemInvert;
					if(!bolt7flip) bolt7.y = Main.gameHeight + 200;
					else bolt7.y = -399;
				}
			if(bolt7.y >=Main.gameHeight + 199 && !bolt7flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
					{
					bolt7.revive();
					bolt7.flipY = false;
					FlxTween.tween(bolt7, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt7.x = boltGen.x;
					bolt7.y = -199;
					}
					else if (FlxG.save.data.sistemFullPow)
					{
					bolt7.revive();
					bolt7.flipY = false;
					FlxTween.tween(bolt7, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt7.x = boltGen.x;
					bolt7.y = -199;
					}
				}
				else if(bolt7.y <= -398 && bolt7flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
						{
						bolt7.revive();
						bolt7.flipY = true;
						FlxTween.tween(bolt7, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt7.x = boltGen.x;
						bolt7.y = Main.gameHeight;
						}
						else if (FlxG.save.data.sistemFullPow)
						{
						bolt7.revive();
						bolt7.flipY = true;
						FlxTween.tween(bolt7, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt7.x = boltGen.x;
						bolt7.y = Main.gameHeight;
						}
				}
		}
		if(FlxG.random.bool(5))
		{
			if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
				{
					bolt8flip = FlxG.save.data.sistemInvert;
					if(!bolt8flip) bolt8.y = Main.gameHeight + 200;
					else bolt8.y = -399;
				}
			if(bolt8.y >=Main.gameHeight + 199 && !bolt8flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
					{
					bolt8.revive();
					bolt8.flipY = false;
					FlxTween.tween(bolt8, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt8.x = boltGen.x;
					bolt8.y = -199;
					}
					else if (FlxG.save.data.sistemFullPow)
					{
					bolt8.revive();
					bolt8.flipY = false;
					FlxTween.tween(bolt8, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt8.x = boltGen.x;
					bolt8.y = -199;
					}
				}
				else if(bolt8.y <= -398 && bolt8flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
						{
						bolt8.revive();
						bolt8.flipY = true;
						FlxTween.tween(bolt8, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt8.x = boltGen.x;
						bolt8.y = Main.gameHeight;
						}
						else if (FlxG.save.data.sistemFullPow)
						{
						bolt8.revive();
						bolt8.flipY = true;
						FlxTween.tween(bolt8, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt8.x = boltGen.x;
						bolt8.y = Main.gameHeight;
						}
				}
		}
		if(FlxG.random.bool(5))
		{
			if(FlxG.save.data.sistemThundMay && FlxG.random.bool(5))
				{
					bolt9flip = FlxG.save.data.sistemInvert;
					if(!bolt9flip) bolt9.y = Main.gameHeight + 200;
					else bolt9.y = -399;
				}
			if(bolt9.y >=Main.gameHeight + 199 && !bolt9flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
					{
					bolt9.revive();
					bolt9.flipY = false;
					FlxTween.tween(bolt9, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt9.x = boltGen.x;
					bolt9.y = -199;
					}
					else if (FlxG.save.data.sistemFullPow)
					{
					bolt9.revive();
					bolt9.flipY = false;
					FlxTween.tween(bolt9, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
					bolt9.x = boltGen.x;
					bolt9.y = -199;
					}
				}
				else if(bolt9.y <= -398 && bolt9flip)
				{
					if (timr >= 10 && !FlxG.save.data.sistemFullPow)
						{
						bolt9.revive();
						bolt9.flipY = true;
						FlxTween.tween(bolt9, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt9.x = boltGen.x;
						bolt9.y = Main.gameHeight;
						}
						else if (FlxG.save.data.sistemFullPow)
						{
						bolt9.revive();
						bolt9.flipY = true;
						FlxTween.tween(bolt9, {alpha: 1}, anSpeed, {ease: FlxEase.quartInOut});
						bolt9.x = boltGen.x;
						bolt9.y = Main.gameHeight;
						}
				}
		}

		if(begen && !FlxG.save.data.sistemMaso)
		{
			#if !mobile
		    cat.x = FlxG.mouse.x - 52;
			if (cat.x + 52 < FlxG.mouse.x) cat.flipX = true;
			else cat.flipX = false;
		    cat.y = FlxG.mouse.y - 56;
			#else
			for (touch in FlxG.touches.list)
			{
                if(!touch.overlaps(back))
				{
                    cat.x = touch.x - 52;
		            cat.y = touch.y - 56;
				}
			}
			#end	
		}
		else if (begen && FlxG.save.data.sistemMaso)
		{
			#if !mobile
			if(FlxG.keys.pressed.UP && cat.y > -56) cat.y = cat.y - 6;
			if(FlxG.keys.pressed.DOWN && cat.y < 670) cat.y = cat.y + 6;
			if(FlxG.keys.pressed.LEFT && cat.x > -56)
			{
				cat.x = cat.x - 6;
				cat.flipX = true;
			}
			if(FlxG.keys.pressed.RIGHT && cat.x < 1230)
			{
				cat.x = cat.x + 6;
				cat.flipX = false;
			}
			#else
			for (touch in FlxG.touches.list)
			{
			    if(!touch.overlaps(back))
			    {
				    if (!(cat.x < touch.x - 152 || cat.x > touch.x + 152)) cat.x = touch.x - 52;
				    if (!(cat.y < touch.y - 156 || cat.y > touch.y + 156)) cat.y = touch.y - 56;
			    }
			}
			#end
		}

		#if !mobile
		if (!FlxG.save.data.sistemMaso)
		{
			if (FlxG.mouse.justPressed)
			{
				#if debug
				if (FlxG.mouse.justPressed) FlxG.mouse.visible = !FlxG.mouse.visible;
				#end
				if (dodge && isAlive && !IFrame && begen && FlxG.save.data.sistemDifficulty != 4)
				{
					cat.alpha = 0.3;
					IFrame = true;
					dodge = false;
					new FlxTimer().start(0.5, ITimer, 1);
					new FlxTimer().start(n, DodgeCountdown, 1);
				}
				else if (!begen)
				{
					ded.text = '';
					begen = true;
				}
			}
		}
		else if (FlxG.save.data.sistemMaso)
		{
			if (FlxG.keys.justPressed.CONTROL)
			{
				if (dodge && isAlive && !IFrame && begen && FlxG.save.data.sistemDifficulty != 4)
				{
					cat.alpha = 0.3;
					IFrame = true;
					dodge = false;
					new FlxTimer().start(0.5, ITimer, 1);
					new FlxTimer().start(n, DodgeCountdown, 1);
				}
					else if (!begen)
				{
					ded.text = '';
					begen = true;
				}
			}
		}
		if (FlxG.keys.justPressed.ESCAPE && begen)
		{
			begen = false;
			FlxG.mouse.visible = true;
			openSubState(new PauseSubState());
			//FlxG.switchState(new PauseSubState());
		}
		#else
		for (touch in FlxG.touches.list)
		{
			if (touch.justReleased)
			{
				//#if debug
				//if (FlxG.mouse.justPressed) FlxG.mouse.visible = !FlxG.mouse.visible;
				//#end
				if (dodge && isAlive && !IFrame && begen && FlxG.save.data.sistemDifficulty != 4)
				{
					cat.alpha = 0.3;
					IFrame = true;
					dodge = false;
					new FlxTimer().start(0.5, ITimer, 1);
					new FlxTimer().start(n, DodgeCountdown, 1);
				}
				else if (!begen)
				{
					ded.text = '';
					begen = true;
				}
			}
			if (touch.overlaps(back) && touch.justReleased)
			{
			    begen = false;
			    //FlxG.mouse.visible = true;
				openSubState(new PauseSubState());
				//FlxG.switchState(new PauseSubState());
			}
	    }
		#end

		if(!IFrame && begen && isAlive)
		{
			#if desktop
		    if(cat.overlaps(bolt) || cat.overlaps(bolt1) || cat.overlaps(bolt2) || cat.overlaps(bolt3) || cat.overlaps(bolt4) || cat.overlaps(bolt5) || cat.overlaps(bolt6) || cat.overlaps(bolt7) || cat.overlaps(bolt8) || cat.overlaps(bolt9))
		    {
			    IFrame = true;
				cat.color = 0xfa1d1d;
                new FlxTimer().start(0.5, ITimer, 1);
			    helth --;
				if (helth == 1 && FlxG.save.data.optionsEaster) refer.play(true);
		    }
			#else
			if(cat.overlaps(bolt) || cat.overlaps(bolt1) || cat.overlaps(bolt2) || cat.overlaps(bolt3) || cat.overlaps(bolt4) || cat.overlaps(bolt5) || cat.overlaps(bolt6) || cat.overlaps(bolt7) || cat.overlaps(bolt8) || cat.overlaps(bolt9))
			{
				IFrame = true;
				cat.color = 0xfa1d1d;
				new FlxTimer().start(0.5, ITimer, 1);
				helth --;
				if (helth == 1 && FlxG.save.data.optionsEaster) refer.play(true);
			}
			#end 
		}

		if(helth <= 0)
		{
			cat.kill();
			isAlive = false;
		}

		if(!isAlive && begen)
		{
			#if !mobile
            ded.text = 'You died. Press left click or ctrl to play again';
			#else
			ded.text = 'You died. Touch the screen to play again';
			#end
			ded.screenCenter();
            
			#if !mobile
			if(FlxG.mouse.justPressed || FlxG.keys.justPressed.CONTROL)
				{
					cat.revive();
					cat.screenCenter();
					if (!FlxG.save.data.sistemInvert) cat.y = 620;
		            else cat.y = 100;
					timr = 0;
					switch(FlxG.save.data.sistemDifficulty)
		            {
			            case 1:
				            helth = 7;
			            case 2:
				            helth = 5;
			            case 3:
				            helth = 3;
			            case 4:
				            helth = 1;
		            }
					if(FlxG.save.data.sistemThundMay) FlxG.save.data.sistemInvert = false;
					if (!FlxG.save.data.sistemInvert)
					{
                        bolt.y = 0;
					    bolt1.y = Main.gameHeight + 199;
					    bolt2.y = Main.gameHeight + 199;
					    bolt3.y = Main.gameHeight + 199;
					    bolt4.y = Main.gameHeight + 199;
					    bolt5.y = Main.gameHeight + 199;
					    bolt6.y = Main.gameHeight + 199;
					    bolt7.y = Main.gameHeight + 199;
					    bolt8.y = Main.gameHeight + 199;
					    bolt9.y = Main.gameHeight + 199;
					}
					else if(FlxG.save.data.sistemInvert)
					{
						bolt.y = Main.gameHeight;
					    bolt1.y = -398;
					    bolt2.y = -398;
					    bolt3.y = -398;
					    bolt4.y = -398;
					    bolt5.y = -398;
					    bolt6.y = -398;
					    bolt7.y = -398;
					    bolt8.y = -398;
					    bolt9.y = -398;
					}

					bolt1.kill();
					bolt2.kill();
					bolt3.kill();
					bolt4.kill();
					bolt5.kill();
					bolt6.kill();
					bolt7.kill();
					bolt8.kill();
					bolt9.kill();

					bolt.x = -51;
					bolt1.x = -51;
                    bolt2.x = -51;
					bolt3.x = -51;
					bolt4.x = -51;
					bolt5.x = -51;
					bolt6.x = -51;
					bolt7.x = -51;
					bolt8.x = -51;
					bolt9.x = -51;

					bolt1.alpha = 0;
					bolt2.alpha = 0;
					bolt3.alpha = 0;
					bolt4.alpha = 0;
					bolt5.alpha = 0;
					bolt6.alpha = 0;
					bolt7.alpha = 0;
					bolt8.alpha = 0;
					bolt9.alpha = 0;
			
					isAlive = true;
					ded.text = '';
					dodge = true;
				}
			#else
			for (touch in FlxG.touches.list)
				{
					if(touch.justPressed) //|| FlxG.keys.justPressed.CONTROL)
					{
						cat.revive();
						cat.screenCenter();
						if (!FlxG.save.data.sistemInvert) cat.y = 620;
						else cat.y = 100;
						timr = 0;
						switch(FlxG.save.data.sistemDifficulty)
						{
							case 1:
								helth = 7;
							case 2:
								helth = 5;
							case 3:
								helth = 3;
							case 4:
								helth = 1;
						}
						if(FlxG.save.data.sistemThundMay) FlxG.save.data.sistemInvert = false;
						if (!FlxG.save.data.sistemInvert)
						{
							bolt.y = 0;
							bolt1.y = Main.gameHeight + 199;
							bolt2.y = Main.gameHeight + 199;
							bolt3.y = Main.gameHeight + 199;
							bolt4.y = Main.gameHeight + 199;
							bolt5.y = Main.gameHeight + 199;
							bolt6.y = Main.gameHeight + 199;
							bolt7.y = Main.gameHeight + 199;
							bolt8.y = Main.gameHeight + 199;
							bolt9.y = Main.gameHeight + 199;
						}
						else if(FlxG.save.data.sistemInvert)
						{
							bolt.y = Main.gameHeight;
							bolt1.y = -398;
							bolt2.y = -398;
							bolt3.y = -398;
							bolt4.y = -398;
							bolt5.y = -398;
							bolt6.y = -398;
							bolt7.y = -398;
							bolt8.y = -398;
							bolt9.y = -398;
						}
	
						bolt.kill();
						bolt1.kill();
						bolt2.kill();
						bolt3.kill();
						bolt4.kill();
						bolt5.kill();
						bolt6.kill();
						bolt7.kill();
						bolt8.kill();
						bolt9.kill();

						bolt.x = -51;
						bolt1.x = -51;
                        bolt2.x = -51;
						bolt3.x = -51;
						bolt4.x = -51;
						bolt5.x = -51;
						bolt6.x = -51;
						bolt7.x = -51;
						bolt8.x = -51;
						bolt9.x = -51;
	
						bolt1.alpha = 0;
						bolt2.alpha = 0;
						bolt3.alpha = 0;
						bolt4.alpha = 0;
						bolt5.alpha = 0;
						bolt6.alpha = 0;
						bolt7.alpha = 0;
						bolt8.alpha = 0;
						bolt9.alpha = 0;
						isAlive = true;
						ded.text = '';
						dodge = true;
					}
				}
			#end
		}

		if(isAlive && begen)
		{
				
			if(!boltflip)bolt.y = bolt.y + v;
			else bolt.y = bolt.y - v;
		    if(!bolt1flip)bolt1.y = bolt1.y + v;
			else bolt1.y = bolt1.y - v;
		    if(!bolt2flip)bolt2.y = bolt2.y + v;
			else bolt2.y = bolt2.y - v;
		    if(!bolt3flip)bolt3.y = bolt3.y + v;
			else bolt3.y = bolt3.y - v;
		    if(!bolt4flip)bolt4.y = bolt4.y + v;
			else bolt4.y = bolt4.y - v;
		    if(!bolt5flip)bolt5.y = bolt5.y + v;
			else bolt5.y = bolt5.y - v;
		    if(!bolt6flip)bolt6.y = bolt6.y + v;
			else bolt6.y = bolt6.y - v;
			if(!bolt7flip)bolt7.y = bolt7.y + v;
			else bolt7.y = bolt7.y - v;
		    if(!bolt8flip)bolt8.y = bolt8.y + v;
			else bolt8.y = bolt8.y - v;
		    if(!bolt9flip)bolt9.y = bolt9.y + v;
			else bolt9.y = bolt9.y - v;
		}

		

		    if(bolt.y >= Main.gameHeight + 199 && !boltflip) {bolt.kill(); bolt.alpha = 0;}
			else if(bolt.y <= -398 && boltflip) {bolt.kill(); bolt.alpha = 0;}

		    if(bolt1.y >= Main.gameHeight + 199 && !bolt1flip) {bolt1.kill(); bolt1.alpha = 0;}
			else if (bolt1.y <= -398 && bolt1flip) {bolt1.kill(); bolt1.alpha = 0;}

		    if(bolt2.y >= Main.gameHeight + 199 && !bolt2flip) {bolt2.kill(); bolt2.alpha = 0;}
			else if (bolt2.y <= -398 && bolt2flip) {bolt2.kill(); bolt2.alpha = 0;}

		    if(bolt3.y >= Main.gameHeight + 199 && !bolt3flip) {bolt3.kill(); bolt3.alpha = 0;}
			else if (bolt3.y <= -398 && bolt3flip) {bolt3.kill(); bolt3.alpha = 0;}

		    if(bolt4.y >= Main.gameHeight + 199 && !bolt4flip) {bolt4.kill(); bolt4.alpha = 0;}
			else if (bolt4.y <= -398 && bolt4flip) {bolt4.kill(); bolt4.alpha = 0;}

		    if(bolt5.y >= Main.gameHeight + 199 && !bolt5flip) {bolt5.kill(); bolt5.alpha = 0;}
			else if (bolt5.y <= -398 && bolt5flip) {bolt5.kill(); bolt5.alpha = 0;}

		    if(bolt6.y >= Main.gameHeight + 199 && !bolt6flip) {bolt6.kill(); bolt6.alpha = 0;}
			else if (bolt6.y <= -398 && bolt6flip) {bolt6.kill(); bolt6.alpha = 0;}

		    if(bolt7.y >= Main.gameHeight + 199 && !bolt7flip) {bolt7.kill(); bolt7.alpha = 0;}
			else if (bolt7.y <= -398 && bolt7flip) {bolt7.kill(); bolt7.alpha = 0;}

		    if(bolt8.y >= Main.gameHeight + 199 && !bolt8flip) {bolt8.kill(); bolt8.alpha = 0;}
			else if (bolt8.y <= -398 && bolt8flip) {bolt8.kill(); bolt8.alpha = 0;}

		    if(bolt9.y >= Main.gameHeight + 199 && !bolt9flip) {bolt9.kill(); bolt9.alpha = 0;}
			else if (bolt9.y <= -398 && bolt9flip) {bolt9.kill(); bolt9.alpha = 0;}
		/*
		if(FlxG.mouse.x <= 52) cat.x = 52;     
		else if(FlxG.mouse.x >= 1228) cat.x = 1228;
		if(FlxG.mouse.y <= 56) cat.y = 76;
		else if(FlxG.mouse.y >= 664) cat.y = 664;
		*/
	}
	function GameTimer(timer:FlxTimer):Void
	{
		if (isAlive && begen && FlxG.save.data.optionsZecimal)
		{
			timr = timr + 0.01;
			var a:Float = (timr / 0.01) % 100;
			Math.fround(a);
			if(a/60 >= 1) timr = timr + 0.40;   //Finally, an accurate stopwatch
			timr = FlxMath.roundDecimal(timr, 2);
		}
		else if (isAlive && begen && !FlxG.save.data.optionsZecimal) timr ++;
	}
	function ITimer(timer:FlxTimer):Void
	{
		IFrame = false;
		cat.alpha = 1;
		cat.color = 0xffffff;
	}
	function DodgeCountdown(timer:FlxTimer):Void
		{
			if(isAlive && begen) dodge = true;
		}
}
