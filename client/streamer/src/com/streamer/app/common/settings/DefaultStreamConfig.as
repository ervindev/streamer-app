package com.streamer.app.common.settings
{
	public class DefaultStreamConfig implements IStreamConfig
	{

		public function get streamURL():String
		{
			return "rtmp://192.168.0.105/myapp/";
		}

		public function get streamName():String
		{
			return "mystream";
		}

		public function initialize():void
		{
		}
	}
}