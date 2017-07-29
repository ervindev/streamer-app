package com.streamer.app.models.settings
{
	import com.streamer.app.common.utils.FlashVarsUtils;

	public class StreamConfigFactory
	{
		public static function getStreamConfig():IStreamConfig
		{
			if (FlashVarsUtils.isEmpty())
			{
				return new DefaultStreamConfig();
			}
			return new FlashVarsStreamConfig();
		}
	}
}