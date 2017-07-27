package com.streamer.app.common.utils
{
	import mx.core.FlexGlobals;

	public class FlashVarsUtils
	{
		public static function isEmpty():Boolean
		{
			var parameters:Object = FlexGlobals.topLevelApplication.parameters;
			for (var key:String in parameters)
			{
				return false;
			}
			return true;
		}
	}
}