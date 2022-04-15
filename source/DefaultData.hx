import openfl.Lib;
import flixel.FlxG;

class DefaultData
{
	public static function initSave()
	{
		if (FlxG.save.data.sistemDifficulty == null || FlxG.save.data.sistemDifficulty < 1 || FlxG.save.data.sistemDifficulty > 4)
			FlxG.save.data.sistemDifficulty = 2;
	    if (FlxG.save.data.sistemMaso == null)
			FlxG.save.data.sistemMaso = false;

	    if (FlxG.save.data.sistemFullPow == null)
            FlxG.save.data.sistemFullPow = false;
	    
		if (FlxG.save.data.sistemInvert == null)
            FlxG.save.data.sistemInvert = false;
		if (FlxG.save.data.sistemOption == null)
			FlxG.save.data.sistemOption = 1;

		if (FlxG.save.data.optionsZecimal == null)
			FlxG.save.data.optionsZecimal = false;
	    if (FlxG.save.data.optionsModifier == null)
			FlxG.save.data.optionsModifier = true;
		if (FlxG.save.data.optionsGreg == null)
			FlxG.save.data.optionsGreg = false;
		if (FlxG.save.data.optionsAnimation == null)
			FlxG.save.data.optionsAnimation = true;
		if (FlxG.save.data.optionsSkipTitle == null)
			FlxG.save.data.optionsSkipTitle = false;
		if (FlxG.save.data.optionsInfo == null)
			FlxG.save.data.optionsInfo = true;
		if (FlxG.save.data.optionsEaster == null)
			FlxG.save.data.optionsEaster == false;
	    if (FlxG.save.data.optionsUpdate == null)
			FlxG.save.data.optionsUpdate = true;
		if (FlxG.save.data.optionsShutUp == null)
		{
			if (FlxG.random.bool(0.1)) FlxG.save.data.optionsShutUp = true;
			else FlxG.save.data.optionsShutUp = false;
		}
	}
}
