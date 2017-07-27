package com.streamer.app.common.settings
{
	import mx.core.FlexGlobals;

	public class FlashVarsStreamConfig implements IStreamConfig
	{
		private static var STREAM_URL:String = "streamURL";
		private static var STREAM_NAME:String = "streamName";

		private var _streamURL:String;

		public function get streamURL():String
		{
			return _streamURL;
		}

		private var _streamName:String;

		public function get streamName():String
		{
			return _streamName;
		}

		public function FlashVarsStreamConfig()
		{

		}

		public function initialize():void
		{
			var parameters:Object = FlexGlobals.topLevelApplication.parameters;
			if (parameters.hasOwnProperty(STREAM_URL))
			{
				_streamURL = parameters[STREAM_URL];
			}
			if (parameters.hasOwnProperty(STREAM_NAME))
			{
				_streamName = parameters[STREAM_NAME];
			}
		}

	}
}