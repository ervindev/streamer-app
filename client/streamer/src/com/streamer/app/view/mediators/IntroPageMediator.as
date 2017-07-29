package com.streamer.app.view.mediators
{
	import com.streamer.app.signals.RunCameraSignal;
	import com.streamer.app.view.IntroPageView;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class IntroPageMediator extends Mediator
	{
		[Inject]
		public var runCameraSignal:RunCameraSignal;

		[Inject]
		public var view:IntroPageView;

		override public function initialize():void
		{
			view.startButtonSignal.addOnce(onStartButtonClicked);
		}

		override public function destroy():void
		{
			view.startButtonSignal.remove(onStartButtonClicked);
		}

		private function onStartButtonClicked():void
		{
			runCameraSignal.dispatch();
		}
	}
}