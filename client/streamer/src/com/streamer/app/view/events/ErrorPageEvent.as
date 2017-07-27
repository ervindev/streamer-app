package com.streamer.app.view.events
{
	import flash.events.Event;

	public class ErrorPageEvent extends Event
	{
		public static const RETRY:String = "retry";

		public function ErrorPageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new ErrorPageEvent(type, bubbles, cancelable);
		}
	}
}