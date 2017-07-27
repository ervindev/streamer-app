package com.streamer.app.view.mediators
{
	import com.streamer.app.common.RTMPErrorCode;
	import com.streamer.app.signals.InitializeSettingsSignal;
	import com.streamer.app.signals.RunPlayerSignal;
	import com.streamer.app.signals.StartCameraSignal;
	import com.streamer.app.view.MainPageView;

	import flash.system.Security;
	import flash.system.SecurityPanel;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class MainPageMediator extends Mediator
	{
		[Inject]
		public var view:MainPageView;

		[Inject]
		public var initializeSettingsSignal:InitializeSettingsSignal;

		[Inject]
		public var runPlayerSignal:RunPlayerSignal;

		[Inject]
		public var startCameraSignal:StartCameraSignal;

		override public function initialize():void
		{
			view.cameraErrorSignal.add(onCameraError);
			startCameraSignal.add(onStartCamera);
			initializeSettingsSignal.dispatch();

			view.changeState(MainPageView.INTRO_STATE);
		}

		override public function destroy():void
		{
			view.cameraErrorSignal.remove(onCameraError);
			startCameraSignal.remove(onStartCamera);
		}

		private function onStartCamera(streamURL:String, streamName:String):void
		{
			view.camera.connect(streamURL, streamName);
		}

		private function onCameraError(errorCode:String):void
		{
			switch (errorCode)
			{
				case RTMPErrorCode.CAMERA_MUTED:
					view.changeState(MainPageView.ERROR_STATE);
					Security.showSettings(SecurityPanel.PRIVACY);
					break;
				default:
					view.changeState(MainPageView.ERROR_STATE);
			}
		}
	}
}