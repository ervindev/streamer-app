package com.streamer.app.models.settings
{
	public class SettingsManager
	{
		private var _streamConfig:IStreamConfig;

		public function get streamConfig():IStreamConfig
		{
			return _streamConfig;
		}

		public function SettingsManager()
		{
		}

		public function initialize(streamConfig:IStreamConfig):void
		{
			_streamConfig = streamConfig;
		}
	}
}