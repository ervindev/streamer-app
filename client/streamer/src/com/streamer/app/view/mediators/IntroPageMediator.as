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
			runCameraSignal.dispatch();
		}
	}
}