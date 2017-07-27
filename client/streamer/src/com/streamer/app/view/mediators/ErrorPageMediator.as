package com.streamer.app.view.mediators
{
	import com.streamer.app.view.ErrorPageView;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class ErrorPageMediator extends Mediator
	{
		[Inject]
		public var view:ErrorPageView;

		override public function initialize():void
		{

		}
	}
}