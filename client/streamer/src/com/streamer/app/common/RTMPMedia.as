package com.streamer.app.common
{
	import com.streamer.app.*;
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;

	public class RTMPMedia extends Sprite
	{
		protected var _streamURL:String;
		protected var _streamName:String;
		protected var _nc:NetConnection;

		public function RTMPMedia()
		{

		}

		public function connect(streamURL:String, streamName:String):void
		{
			_streamURL = streamURL;
			_streamName = streamName;

			var clientObj:Object = {};
			clientObj.onBWDone = onBWDone;
			clientObj.onBWCheck = onBWCheck;

			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS, netConnectionStatusHandler);
			_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, netConnectionSecurityErrorHandler);
			_nc.client = clientObj;

			try
			{
				_nc.connect(streamURL);
			}
			catch (error:Error)
			{

			}
		}

		public function start(channelName:String = null):void
		{
			if (channelName != null)
			{
				_streamName = channelName;
			}

			if (!isConnected())
			{
				connect(_streamURL, _streamName);
				return;
			}

			onMediaStart();
		}

		protected function onMediaStart():void
		{

		}

		public function isConnected():Boolean
		{
			return _nc != null && _nc.connected;
		}

		protected function netConnectionStatusHandler(event:NetStatusEvent):void
		{
			trace(this, "connection status " + event.info.code);

			switch (event.info.code)
			{
				case NetStatusCode.CONNECT_SUCCESS:
					start();
					break;
				case NetStatusCode.CONNECT_FAILED:
					onConnectionFailed();
					break;
			}
		}

		private function onConnectionFailed():void
		{
			trace("connection failed");
		}

		private function netConnectionSecurityErrorHandler(event:SecurityErrorEvent):void
		{

		}

		public function dispose():void
		{
			if (_nc != null)
			{
				_nc.removeEventListener(NetStatusEvent.NET_STATUS, netConnectionStatusHandler);
				_nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, netConnectionSecurityErrorHandler);

				if (_nc.connected)
				{
					_nc.close();
				}
				_nc = null;
			}
		}

		protected function onBWDone(...rest):Boolean
		{
			return true;
		}

		protected function onBWCheck(...rest):Number
		{
			return 0;
		}

		protected function onMetaData(info:Object):void
		{

		}

		protected function onCuePoint(info:Object):void
		{

		}

	}
}