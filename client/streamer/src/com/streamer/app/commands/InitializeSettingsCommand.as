package com.streamer.app.commands
{
	import com.streamer.app.models.settings.IStreamConfig;
	import com.streamer.app.models.settings.SettingsManager;
	import com.streamer.app.models.settings.StreamConfigFactory;

	import robotlegs.bender.bundles.mvcs.Command;

	public class InitializeSettingsCommand extends Command
	{
		[Inject]
		public var settingsManager:SettingsManager;

		override public function execute():void
		{
			var streamConfig:IStreamConfig = StreamConfigFactory.getStreamConfig();
			streamConfig.initialize();
			settingsManager.initialize(streamConfig);
		}
	}
}