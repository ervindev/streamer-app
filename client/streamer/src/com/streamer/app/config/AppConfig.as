package com.streamer.app.config
{
	import com.streamer.app.commands.MediaErrorCommand;
	import com.streamer.app.commands.InitializeSettingsCommand;
	import com.streamer.app.commands.RunCameraCommand;
	import com.streamer.app.commands.RunPlayerCommand;
	import com.streamer.app.common.event.RTMPMediaEvent;
	import com.streamer.app.common.settings.SettingsManager;
	import com.streamer.app.models.ErrorPageModel;
	import com.streamer.app.publisher.RTMPCamera;
	import com.streamer.app.signals.MediaErrorSignal;
	import com.streamer.app.signals.CameraStartedSignal;
	import com.streamer.app.signals.InitializeSettingsSignal;
	import com.streamer.app.signals.RunCameraSignal;
	import com.streamer.app.signals.RunPlayerSignal;
	import com.streamer.app.signals.StartCameraSignal;
	import com.streamer.app.signals.StartPlayerSignal;
	import com.streamer.app.view.ErrorPageView;
	import com.streamer.app.view.IntroPageView;
	import com.streamer.app.view.MainPageView;
	import com.streamer.app.view.PlaybackPageView;
	import com.streamer.app.view.mediators.ErrorPageMediator;
	import com.streamer.app.view.mediators.IntroPageMediator;
	import com.streamer.app.view.mediators.MainPageMediator;
	import com.streamer.app.view.mediators.PlaybackPageMediator;
	import com.streamer.app.view.mediators.RTMPCameraMediator;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;

	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var commandMap:IEventCommandMap;

		[Inject]
		public var signalCommandMap:ISignalCommandMap;

		public function configure():void
		{
			injector.map(ErrorPageModel).asSingleton();

			injector.map(SettingsManager).asSingleton();
			injector.map(StartPlayerSignal).asSingleton();
			injector.map(StartCameraSignal).asSingleton();

			injector.map(CameraStartedSignal).asSingleton();
			injector.map(MediaErrorSignal).asSingleton();

			signalCommandMap.map(InitializeSettingsSignal).toCommand(InitializeSettingsCommand);
			signalCommandMap.map(RunCameraSignal).toCommand(RunCameraCommand);
			signalCommandMap.map(RunPlayerSignal).toCommand(RunPlayerCommand);
			signalCommandMap.map(MediaErrorSignal).toCommand(MediaErrorCommand);

			mediatorMap.map(MainPageView).toMediator(MainPageMediator);
			mediatorMap.map(IntroPageView).toMediator(IntroPageMediator);
			mediatorMap.map(PlaybackPageView).toMediator(PlaybackPageMediator);
			mediatorMap.map(ErrorPageView).toMediator(ErrorPageMediator);

			mediatorMap.map(RTMPCamera).toMediator(RTMPCameraMediator);
		}
	}
}