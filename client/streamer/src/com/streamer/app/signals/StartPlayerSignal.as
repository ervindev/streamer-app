package com.streamer.app.signals
{
	import org.osflash.signals.Signal;

	public class StartPlayerSignal extends Signal
	{

		public function StartPlayerSignal()
		{
			super(String, String);//streamURL, streamName
		}

	}
}