package com.streamer.app.player.provider
{
	import com.streamer.app.player.provider.VideoSource;

	import flash.media.Video;
	import flash.net.NetStream;

	public class CPUVideoSource extends VideoSource
	{

		private var _video:Video;

		public function CPUVideoSource()
		{

		}

		override protected function init():void
		{
			_video = new Video();
			addChild(_video);

			super.init();
		}

		override public function attachNetStream(netStream:NetStream):void
		{
			super.attachNetStream(netStream);
			_video.attachNetStream(netStream);
		}

		override public function resize(x:Number, y:Number, width:Number, height:Number):void
		{
			_video.width = width;
			_video.height = height;
		}

		override public function dispose():void
		{
			_video.attachNetStream(null);
			removeChild(_video);
			_video = null;

			super.dispose();
		}
	}
}