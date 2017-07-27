package com.streamer.app.common.settings
{
	public class SettingsManager
	{

		private static var _instance:SettingsManager;

		public static function getInstance():SettingsManager
		{
			return _instance == null ? _instance = new SettingsManager() : _instance;
		}

		private var _streamConfig:IStreamConfig;

		public function get streamConfig():IStreamConfig
		{
			return _streamConfig;
		}

		public function SettingsManager()
		{
			if (_instance != null)
			{
				throw new Error("Only one instance can be created!");
			}
		}

		public function initialize(streamConfig:IStreamConfig):void
		{
			_streamConfig = streamConfig;
		}
	}
}