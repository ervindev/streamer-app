package com.streamer.app.player.provider
{
	import flash.display.Sprite;
	import flash.net.NetStream;

	public class VideoSource extends Sprite
	{
		protected var _netStream:NetStream;

		public function VideoSource()
		{
			init();
		}

		protected function init():void
		{

		}

		public function attachNetStream(netStream:NetStream):void
		{
			_netStream = netStream;
		}

		public function resize(x:Number, y:Number, width:Number, height:Number):void
		{

		}

		public function dispose():void
		{
			_netStream = null;
		}

	}
}