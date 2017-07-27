package com.streamer.app.signals
{
	import org.osflash.signals.Signal;

	public class StartCameraSignal extends Signal
	{

		public function StartCameraSignal()
		{
			super(String, String);//streamURL, streamName
		}

	}
}