package com.streamer.app.commands
{
	import com.streamer.app.common.settings.IStreamConfig;
	import com.streamer.app.common.settings.SettingsManager;
	import com.streamer.app.signals.StartPlayerSignal;

	import robotlegs.bender.bundles.mvcs.Command;

	public class RunPlayerCommand extends Command
	{

		[Inject]
		public var startPlayerSignal:StartPlayerSignal;

		[Inject]
		public var settingsManager:SettingsManager;

		override public function execute():void
		{
			var streamConfig:IStreamConfig = settingsManager.streamConfig;
			startPlayerSignal.dispatch(streamConfig.streamURL, streamConfig.streamName);
		}
	}
}