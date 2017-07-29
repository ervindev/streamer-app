package com.streamer.app.view.mediators
{
	import com.streamer.app.common.RTMPErrorCode;
	import com.streamer.app.signals.MediaErrorSignal;
	import com.streamer.app.signals.CameraStartedSignal;
	import com.streamer.app.signals.InitializeSettingsSignal;
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
		public var cameraStartedSignal:CameraStartedSignal;

		[Inject]
		public var mediaErrorSignal:MediaErrorSignal;

		override public function initialize():void
		{
			cameraStartedSignal.add(onCameraStarted);
			mediaErrorSignal.add(onMediaError);

			initializeSettingsSignal.dispatch();

			view.changeState(MainPageView.INTRO_STATE);
		}

		override public function destroy():void
		{
			cameraStartedSignal.remove(onCameraStarted);
			mediaErrorSignal.remove(onMediaError);
		}

		private function onCameraStarted():void
		{
			view.changeState(MainPageView.PLAYBACK_STATE);
		}

		private function onMediaError(errorCode:String):void
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