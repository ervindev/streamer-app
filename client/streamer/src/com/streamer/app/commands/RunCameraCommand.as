package com.streamer.app.commands
{
	import com.streamer.app.models.settings.IStreamConfig;
	import com.streamer.app.models.settings.SettingsManager;
	import com.streamer.app.signals.StartCameraSignal;

	import robotlegs.bender.bundles.mvcs.Command;

	public class RunCameraCommand extends Command
	{

		[Inject]
		public var startCameraSignal:StartCameraSignal;

		[Inject]
		public var settingsManager:SettingsManager;

		override public function execute():void
		{
			var streamConfig:IStreamConfig = settingsManager.streamConfig;
			startCameraSignal.dispatch(streamConfig.streamURL, streamConfig.streamName);
		}
	}
}