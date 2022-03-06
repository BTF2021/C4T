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
import  flixel.input.keyboard.FlxKey;
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
	var bolt1:FlxSprite;
	var bolt2:FlxSprite;   //Me being dumb, cuz I can't clone
	var bolt3:FlxSprite;
	var bolt4:FlxSprite;
	var bolt5:FlxSprite;
	var bolt6:FlxSprite;
	var bolt7:FlxSprite;
	var bolt8:FlxSprite;
	var bolt9:FlxSprite;

	var timr:Float = 0;
	var time:FlxText;

	var dodge:Bool = true;
	var n:Float;
	var countdown:FlxText;

	var helth:Int;
	var Halth:FlxText;
	var refer:FlxSound;

	var ded:FlxText;
	var begen:Bool = false;

	var IFrame:Bool;
    var isAlive:Bool = true;


	override public function create()
	{
		super.create();

		FlxG.sound.music.stop();

		cat = new FlxSprite().loadGraphic(AssetPaths.cat__png, true, 104, 112);
		cat.screenCenter();
		if (!FlxG.save.data.sistemInvert) cat.y = 620;
		else cat.y = 100;
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

        time = new FlxText(20, 40);
		time.size = 20;
		add(time);

		countdown = new FlxText(20, 660);
		countdown.size = 20;
		add(countdown);

		Halth = new FlxText(20, 680);
		Halth.size = 20;
		add(Halth);

		ded = new FlxText(380, 360);
		ded.size = 30;
		ded.text = '';
		add(ded);

		refer = FlxG.sound.load(AssetPaths.Pressure__ogg);
		refer.volume = 0.15;

		FlxG.mouse.visible = false;
		IFrame = false;
		new FlxTimer().start(0.05, GameTimer, 0);

		switch(FlxG.save.data.sistemDifficulty)
		{
			case 1:
				helth = 7;
				n = 1.5;
			case 2:
				helth = 5;
				n = 2;
			case 3:
				helth = 3;
				n = 2.5;
			case 4:
				helth = 1;
		}

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
		if (begen) time.text = 'Timer: ' + Std.string(timr);
		if (begen && helth >=2) Halth.text = 'Health: ' + Std.string(helth);
		else if (begen && helth == 1) Halth.text = "Health: You're the last one. Complete the mission";
		if (begen && FlxG.save.data.sistemDifficulty != 4) countdown.text = 'Dodge: ' + (dodge ? "Ready (Press Left Click)" : "Not ready");
		else if (begen && FlxG.save.data.sistemDifficulty == 4) countdown.text = "Dodge: unable to can :)";

		boltGen.x = FlxG.random.int(0, 1260);
		if (!FlxG.save.data.sistemInvert)                                                             //For not thinking more smarter, you get two
		{
		if(FlxG.random.bool(5) && bolt.y >=800)
		{
			bolt.revive();
			FlxTween.tween(bolt, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			bolt.x = boltGen.x;
			bolt.y = 0;
		}
		if(FlxG.random.bool(5) && bolt1.y >=800)
		{
			bolt1.revive();
			FlxTween.tween(bolt1, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			bolt1.x = boltGen.x;
			bolt1.y = 0;
		}
		if(FlxG.random.bool(5) && bolt2.y >=800)
		{
			bolt2.revive();
			FlxTween.tween(bolt2, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			bolt2.x = boltGen.x;
			bolt2.y = 0;
		}
		if(FlxG.random.bool(5) && bolt3.y >=800)
		{
			bolt3.revive();
			FlxTween.tween(bolt3, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			bolt3.x = boltGen.x;
			bolt3.y = 0;
		}
		if(FlxG.random.bool(5) && bolt4.y >=800)
		{
		    if (timr >= 10 && !FlxG.save.data.sistemFullPow)
		    {
			bolt4.revive();
			FlxTween.tween(bolt4, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			bolt4.x = boltGen.x;
			bolt4.y = 0;
		    }
		    else if (FlxG.save.data.sistemFullPow)
		    {
			bolt4.revive();
			FlxTween.tween(bolt4, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			bolt4.x = boltGen.x;
			bolt4.y = 0;
		    }
		}
		if(FlxG.random.bool(5) && bolt5.y >=800)
		{
			if (timr >= 10 && !FlxG.save.data.sistemFullPow)
			{
			    bolt5.revive();
			    FlxTween.tween(bolt5, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			    bolt5.x = boltGen.x;
			    bolt5.y = 0;
			}
			else if (FlxG.save.data.sistemFullPow)
			{
				bolt5.revive();
			    FlxTween.tween(bolt5, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
			    bolt5.x = boltGen.x;
			    bolt5.y = 0;
			}
		}
		if(FlxG.random.bool(5) && bolt6.y >=800)
		{
			if (timr >= 10 && !FlxG.save.data.sistemFullPow)
			{
				bolt6.revive();
				FlxTween.tween(bolt6, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt6.x = boltGen.x;
				bolt6.y = 0;
			}
			else if (FlxG.save.data.sistemFullPow)
			{
				bolt6.revive();
				FlxTween.tween(bolt6, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt6.x = boltGen.x;
				bolt6.y = 0;
			}
		}
		if(FlxG.random.bool(5) && bolt7.y >=800)
		{
			if (timr >= 20 && !FlxG.save.data.sistemFullPow)
			{
				bolt7.revive();
				FlxTween.tween(bolt7, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt7.x = boltGen.x;
				bolt7.y = 0;
			}
			else if (FlxG.save.data.sistemFullPow)
			{
				bolt7.revive();
				FlxTween.tween(bolt7, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt7.x = boltGen.x;
				bolt7.y = 0;
			}
		}
		if(FlxG.random.bool(5) && bolt8.y >=800)
		{
			if (timr >= 20 && !FlxG.save.data.sistemFullPow)
			{
				bolt8.revive();
				FlxTween.tween(bolt8, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt8.x = boltGen.x;
				bolt8.y = 0;
			}
			else if (FlxG.save.data.sistemFullPow)
			{
				bolt8.revive();
				FlxTween.tween(bolt8, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt8.x = boltGen.x;
				bolt8.y = 0;
			}
		}
		if(FlxG.random.bool(5) && bolt9.y >=800)
		{
			if (timr >= 20 && !FlxG.save.data.sistemFullPow)
			{
				bolt9.revive();
				FlxTween.tween(bolt9, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt9.x = boltGen.x;
				bolt9.y = 0;
			}
			else if (FlxG.save.data.sistemFullPow)
			{
				bolt9.revive();
				FlxTween.tween(bolt9, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt9.x = boltGen.x;
				bolt9.y = 0;
			}
		}
	    }


		else if (FlxG.save.data.sistemInvert)                                                                      //The second one
		{
		if(FlxG.random.bool(5) && bolt.y <=-200)
			{
				bolt.revive();
				FlxTween.tween(bolt, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt.x = boltGen.x;
				bolt.y = 720;
			}
			if(FlxG.random.bool(5) && bolt1.y <=-200)
			{
				bolt1.revive();
				FlxTween.tween(bolt1, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt1.x = boltGen.x;
				bolt1.y = 720;
			}
			if(FlxG.random.bool(5) && bolt2.y <=-200)
			{
				bolt2.revive();
				FlxTween.tween(bolt2, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt2.x = boltGen.x;
				bolt2.y = 720;
			}
			if(FlxG.random.bool(5) && bolt3.y <=-200)
			{
				bolt3.revive();
				FlxTween.tween(bolt3, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt3.x = boltGen.x;
				bolt3.y = 720;
			}
			if(FlxG.random.bool(5) && bolt4.y <=-200)
			{
				if (timr >= 10 && !FlxG.save.data.sistemFullPow)
				{
				bolt4.revive();
				FlxTween.tween(bolt4, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt4.x = boltGen.x;
				bolt4.y = 720;
				}
				else if (FlxG.save.data.sistemFullPow)
				{
				bolt4.revive();
				FlxTween.tween(bolt4, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
				bolt4.x = boltGen.x;
				bolt4.y = 720;
				}
			}
			if(FlxG.random.bool(5) && bolt5.y <=-200)
			{
				if (timr >= 10 && !FlxG.save.data.sistemFullPow)
				{
					bolt5.revive();
					FlxTween.tween(bolt5, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt5.x = boltGen.x;
					bolt5.y = 720;
				}
				else if (FlxG.save.data.sistemFullPow)
				{
					bolt5.revive();
					FlxTween.tween(bolt5, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt5.x = boltGen.x;
					bolt5.y = 720;
				}
			}
			if(FlxG.random.bool(5) && bolt6.y <=-200)
			{
				if (timr >= 10 && !FlxG.save.data.sistemFullPow)
				{
					bolt6.revive();
					FlxTween.tween(bolt6, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt6.x = boltGen.x;
					bolt6.y = 720;
				}
				else if (FlxG.save.data.sistemFullPow)
				{
					bolt6.revive();
					FlxTween.tween(bolt6, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt6.x = boltGen.x;
					bolt6.y = 720;
				}
				}
			if(FlxG.random.bool(5) && bolt7.y <=-200)
			{
				if (timr >= 20 && !FlxG.save.data.sistemFullPow)
				{
					bolt7.revive();
					FlxTween.tween(bolt7, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt7.x = boltGen.x;
					bolt7.y = 720;
				}
				else if (FlxG.save.data.sistemFullPow)
				{
					bolt7.revive();
					FlxTween.tween(bolt7, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt7.x = boltGen.x;
					bolt7.y = 720;
				}
			}
			if(FlxG.random.bool(5) && bolt8.y <=-200)
			{
				if (timr >= 20 && !FlxG.save.data.sistemFullPow)
				{
					bolt8.revive();
					FlxTween.tween(bolt8, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt8.x = boltGen.x;
					bolt8.y = 720;
				}
				else if (FlxG.save.data.sistemFullPow)
				{
					bolt8.revive();
					FlxTween.tween(bolt8, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt8.x = boltGen.x;
					bolt8.y = 720;
				}
			}
			if(FlxG.random.bool(5) && bolt9.y <=-200)
			{
				if (timr >= 20 && !FlxG.save.data.sistemFullPow)
				{
					bolt9.revive();
					FlxTween.tween(bolt9, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt9.x = boltGen.x;
					bolt9.y = 720;
				}
				else if (FlxG.save.data.sistemFullPow)
				{
					bolt9.revive();
					FlxTween.tween(bolt9, {alpha: 1}, 0.08, {ease: FlxEase.quartInOut});
					bolt9.x = boltGen.x;
					bolt9.y = 720;
				}
			}
		}


		if(begen && !FlxG.save.data.sistemMaso)
		{
		    cat.x = FlxG.mouse.x - 52;
		    cat.y = FlxG.mouse.y - 56;
		}
		else if (begen && FlxG.save.data.sistemMaso)
		{
			if(FlxG.keys.pressed.UP && cat.y > -56) cat.y = cat.y - 6;
			if(FlxG.keys.pressed.DOWN && cat.y < 670) cat.y = cat.y + 6;
			if(FlxG.keys.pressed.LEFT && cat.x > -56) cat.x = cat.x - 6;
			if(FlxG.keys.pressed.RIGHT && cat.x < 1230) cat.x = cat.x + 6;
		}

		if(!IFrame && begen && isAlive)
		{
		    if(cat.overlaps(bolt) || cat.overlaps(bolt1) || cat.overlaps(bolt2) || cat.overlaps(bolt3) || cat.overlaps(bolt4) || cat.overlaps(bolt5) || cat.overlaps(bolt6) || cat.overlaps(bolt7) || cat.overlaps(bolt8) || cat.overlaps(bolt9))
		    {
			    IFrame = true;
				cat.color = 0xfa1d1d;
                new FlxTimer().start(0.5, ITimer, 1);
			    helth --;
				//if (helth == 1) refer.play(true);
		    }
		}

		if(helth <= 0)
		{
			cat.kill();
			isAlive = false;
		}

		if(!isAlive && begen)
		{
            ded.text = 'You died. Press left click or ctrl to play again';
			ded.screenCenter(X);
            
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
					if (!FlxG.save.data.sistemInvert)
					{
                        bolt.y = 0;
					    bolt1.y = 800;
					    bolt2.y = 800;
					    bolt3.y = 800;
					    bolt4.y = 800;
					    bolt5.y = 800;
					    bolt6.y = 800;
					    bolt7.y = 800;
					    bolt8.y = 800;
					    bolt9.y = 800;
					}
					else if(FlxG.save.data.sistemInvert)
					{
						bolt.y = 720;
					    bolt1.y = -200;
					    bolt2.y = -200;
					    bolt3.y = -200;
					    bolt4.y = -200;
					    bolt5.y = -200;
					    bolt6.y = -200;
					    bolt7.y = -200;
					    bolt8.y = -200;
					    bolt9.y = -200;
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

		if(isAlive && begen)
		{
			if (!FlxG.save.data.sistemInvert)
			{
			    switch(FlxG.save.data.sistemDifficulty)
			    {
				case 1:
					bolt.y = bolt.y + 7;
		            bolt1.y = bolt1.y + 7;
		            bolt2.y = bolt2.y + 7;
		            bolt3.y = bolt3.y + 7;
		            bolt4.y = bolt4.y + 7;
		            bolt5.y = bolt5.y + 7;
		            bolt6.y = bolt6.y + 7;
		            bolt7.y = bolt7.y + 7;
		            bolt8.y = bolt8.y + 7;
		            bolt9.y = bolt9.y + 7;
				case 2:
				    bolt.y = bolt.y + 9;
		            bolt1.y = bolt1.y + 9;
		            bolt2.y = bolt2.y + 9;
		            bolt3.y = bolt3.y + 9;
		            bolt4.y = bolt4.y + 9;
		            bolt5.y = bolt5.y + 9;
		            bolt6.y = bolt6.y + 9;
		            bolt7.y = bolt7.y + 9;
		            bolt8.y = bolt8.y + 9;
		            bolt9.y = bolt9.y + 9;
				case 3:
					bolt.y = bolt.y + 10;
		            bolt1.y = bolt1.y + 10;
		            bolt2.y = bolt2.y + 10;
		            bolt3.y = bolt3.y + 10;
		            bolt4.y = bolt4.y + 10;
		            bolt5.y = bolt5.y + 10;
		            bolt6.y = bolt6.y + 10;
		            bolt7.y = bolt7.y + 10;
		            bolt8.y = bolt8.y + 10;
		            bolt9.y = bolt9.y + 10;
				case 4:
					bolt.y = bolt.y + 12;
		            bolt1.y = bolt1.y + 12;
		            bolt2.y = bolt2.y + 12;
		            bolt3.y = bolt3.y + 12;
		            bolt4.y = bolt4.y + 12;
		            bolt5.y = bolt5.y + 12;
		            bolt6.y = bolt6.y + 12;
		            bolt7.y = bolt7.y + 12;
		            bolt8.y = bolt8.y + 12;
		            bolt9.y = bolt9.y + 12;
			    }
		    }
			else if (FlxG.save.data.sistemInvert)
		    {
                switch(FlxG.save.data.sistemDifficulty)
			    {
				case 1:
					bolt.y = bolt.y - 7;
		            bolt1.y = bolt1.y - 7;
		            bolt2.y = bolt2.y - 7;
		            bolt3.y = bolt3.y - 7;
		            bolt4.y = bolt4.y - 7;
		            bolt5.y = bolt5.y - 7;
		            bolt6.y = bolt6.y - 7;
		            bolt7.y = bolt7.y - 7;
		            bolt8.y = bolt8.y - 7;
		            bolt9.y = bolt9.y - 7;
				case 2:
				    bolt.y = bolt.y - 9;
		            bolt1.y = bolt1.y - 9;
		            bolt2.y = bolt2.y - 9;
		            bolt3.y = bolt3.y - 9;
		            bolt4.y = bolt4.y - 9;
		            bolt5.y = bolt5.y - 9;
		            bolt6.y = bolt6.y - 9;
		            bolt7.y = bolt7.y - 9;
		            bolt8.y = bolt8.y - 9;
		            bolt9.y = bolt9.y - 9;
				case 3:
					bolt.y = bolt.y - 10;
		            bolt1.y = bolt1.y - 10;
		            bolt2.y = bolt2.y - 10;
		            bolt3.y = bolt3.y - 10;
		            bolt4.y = bolt4.y - 10;
		            bolt5.y = bolt5.y - 10;
		            bolt6.y = bolt6.y - 10;
		            bolt7.y = bolt7.y - 10;
		            bolt8.y = bolt8.y - 10;
		            bolt9.y = bolt9.y - 10;
				case 4:
					bolt.y = bolt.y - 12;
		            bolt1.y = bolt1.y - 12;
		            bolt2.y = bolt2.y - 12;
		            bolt3.y = bolt3.y - 12;
		            bolt4.y = bolt4.y - 12;
		            bolt5.y = bolt5.y - 12;
		            bolt6.y = bolt6.y - 12;
		            bolt7.y = bolt7.y - 12;
		            bolt8.y = bolt8.y - 12;
		            bolt9.y = bolt9.y - 12;
			    }
			}
		}

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
			        new FlxTimer().start(0.15, ITimer, 1);
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
					new FlxTimer().start(0.15, ITimer, 1);
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

		if (!FlxG.save.data.sistemInvert)
		{
		    if(bolt.y >= 800) {bolt.kill(); bolt.alpha = 0;}
		    if(bolt1.y >= 800) {bolt1.kill(); bolt1.alpha = 0;}
		    if(bolt2.y >= 800) {bolt2.kill(); bolt2.alpha = 0;}
		    if(bolt3.y >= 800) {bolt3.kill(); bolt3.alpha = 0;}
		    if(bolt4.y >= 800) {bolt4.kill(); bolt4.alpha = 0;}
		    if(bolt5.y >= 800) {bolt5.kill(); bolt5.alpha = 0;}
		    if(bolt6.y >= 800) {bolt6.kill(); bolt6.alpha = 0;}
		    if(bolt7.y >= 800) {bolt7.kill(); bolt7.alpha = 0;}
		    if(bolt8.y >= 800) {bolt8.kill(); bolt8.alpha = 0;}
		    if(bolt9.y >= 800) {bolt9.kill(); bolt9.alpha = 0;}
		}
		else if (FlxG.save.data.sistemInvert)
		{
            if(bolt.y <=-200) {bolt.kill(); bolt.alpha = 0;}
		    if(bolt1.y <=-200) {bolt1.kill(); bolt1.alpha = 0;}
		    if(bolt2.y <=-200) {bolt2.kill(); bolt2.alpha = 0;}
		    if(bolt3.y <=-200) {bolt3.kill(); bolt3.alpha = 0;}
		    if(bolt4.y <=-200) {bolt4.kill(); bolt4.alpha = 0;}
		    if(bolt5.y <=-200) {bolt5.kill(); bolt5.alpha = 0;}
		    if(bolt6.y <=-200) {bolt6.kill(); bolt6.alpha = 0;}
		    if(bolt7.y <=-200) {bolt7.kill(); bolt7.alpha = 0;}
		    if(bolt8.y <=-200) {bolt8.kill(); bolt8.alpha = 0;}
		    if(bolt9.y <=-200) {bolt9.kill(); bolt9.alpha = 0;}
		}

		/*
		if(FlxG.mouse.x <= 52) cat.x = 52;     
		else if(FlxG.mouse.x >= 1228) cat.x = 1228;
		if(FlxG.mouse.y <= 56) cat.y = 76;
		else if(FlxG.mouse.y >= 664) cat.y = 664;
		*/
	}
	function GameTimer(timer:FlxTimer):Void
	{
		if(isAlive && begen) timr = timr + 0.1;
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
