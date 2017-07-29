package com.streamer.app.signals
{
	import org.osflash.signals.Signal;

	public class MediaErrorSignal extends Signal
	{

		public function MediaErrorSignal()
		{
			super(String);//errorCode
		}

	}
}