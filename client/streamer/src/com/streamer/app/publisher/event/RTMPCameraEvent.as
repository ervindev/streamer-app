package com.streamer.app.publisher.event
{
	import flash.events.Event;

	public class RTMPCameraEvent extends Event
	{
		public static const ERROR:String = "cameraError";
		public static const STARTED:String = "cameraStarted";

		private var _code:String;

		public function RTMPCameraEvent(type:String, code:String = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_code = code;
			super(type, bubbles, cancelable);
		}

		public function get code():String
		{
			return _code;
		}

		override public function clone():Event
		{
			return new RTMPCameraEvent(type, code, bubbles, cancelable);
		}
	}
}