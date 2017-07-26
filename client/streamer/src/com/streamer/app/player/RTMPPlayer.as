package com.streamer.app.player
{
	import com.streamer.app.common.RTMPMedia;
	import com.streamer.app.player.provider.VideoProvider;

	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetStream;

	public class RTMPPlayer extends RTMPMedia
	{
		private var _netStream:NetStream;
		private var _videoProvider:VideoProvider;

		public function RTMPPlayer()
		{

		}

		override protected function onMediaStart():void
		{
			var clientObj:Object = {};
			clientObj.onMetaData = onMetaData;
			clientObj.onCuePoint = onCuePoint;
			
			_netStream = new NetStream(_nc);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStreamStatusHandler);
			_netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, netStreamAsyncErrorHandler);
			_netStream.client = clientObj;

			_videoProvider = new VideoProvider();
			_videoProvider.initialize(_netStream, this);
			_netStream.play(_streamName);
		}

		override protected function onMetaData(info:Object):void
		{
			if (info.hasOwnProperty("width") && info.hasOwnProperty("height"))
			{
				_videoProvider.resize(info.width, info.height);
			}
			super.onMetaData(info);
		}

		private function netStreamStatusHandler(event:NetStatusEvent):void
		{

		}

		private function netStreamAsyncErrorHandler(event:AsyncErrorEvent):void
		{

		}

		override public function dispose():void
		{
			if (_videoProvider != null)
			{
				_videoProvider.dispose();
				_videoProvider = null;
			}
			if (_netStream != null)
			{
				_netStream.dispose();
				_netStream = null;
			}
			super.dispose();
		}

	}
}