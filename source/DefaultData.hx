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
	}
}