package com.streamer.app.view.mediators
{
	import com.streamer.app.signals.RunPlayerSignal;
	import com.streamer.app.signals.StartPlayerSignal;
	import com.streamer.app.view.PlaybackPageView;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class PlaybackPageMediator extends Mediator
	{
		[Inject]
		public var view:PlaybackPageView;

		[Inject]
		public var runPlayerSignal:RunPlayerSignal;

		[Inject]
		public var startPlayerSignal:StartPlayerSignal;

		override public function initialize():void
		{
			startPlayerSignal.add(onStartPlayer);

			runPlayerSignal.dispatch();
		}

		override public function destroy():void
		{
			startPlayerSignal.remove(onStartPlayer);
		}

		private function onStartPlayer(streamURL:String, streamName:String):void
		{
			view.connect(streamURL, streamName);
		}
	}
}