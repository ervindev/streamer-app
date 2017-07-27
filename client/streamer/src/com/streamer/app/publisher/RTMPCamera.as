package com.streamer.app.publisher
{
	import com.streamer.app.common.NetStatusCode;
	import com.streamer.app.common.RTMPErrorCode;
	import com.streamer.app.common.RTMPMedia;
	import com.streamer.app.common.event.RTMPMediaEvent;

	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.net.NetStream;

	[Event(name="cameraStarted", type="com.streamer.app.common.event.RTMPMediaEvent")]
	[Event(name="cameraError", type="com.streamer.app.common.event.RTMPMediaEvent")]
	public class RTMPCamera extends RTMPMedia
	{
		private var _fps:int = 30;

		public function get fps():int
		{
			return _fps;
		}

		public function set fps(value:int):void
		{
			_fps = value;
		}

		private var _videoWidth:int = 640;

		public function get videoWidth():int
		{
			return _videoWidth;
		}

		public function set videoWidth(value:int):void
		{
			_videoWidth = value;
		}

		private var _videoHeight:int = 480;

		public function get videoHeight():int
		{
			return _videoHeight;
		}

		public function set videoHeight(value:int):void
		{
			_videoHeight = value;
		}

		private var _netStream:NetStream;

		public function RTMPCamera()
		{

		}

		override protected function onMediaStart():void
		{
			var camera:Camera = Camera.getCamera();
			if (camera == null)
			{
				onCameraError(RTMPErrorCode.CAMERA_NOT_FOUND);
				return;
			}

			if (camera.muted)
			{
				camera.addEventListener(StatusEvent.STATUS, cameraStatusHandler);
				onCameraError(RTMPErrorCode.CAMERA_MUTED);
				return;
			}

			camera.setMode(_videoWidth, _videoHeight, _fps, true);

			var mic:Microphone = Microphone.getMicrophone();
			if (mic == null)
			{
				onCameraError(RTMPErrorCode.MIC_NOT_FOUND);
			}
			if (mic != null && mic.muted)
			{
				onCameraError(RTMPErrorCode.MIC_MUTED);
			}

			var clientObj:Object = {};
			clientObj.onMetaData = onMetaData;
			clientObj.onCuePoint = onCuePoint;

			_netStream = new NetStream(_nc);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, netStreamAsyncErrorHandler);
			_netStream.client = clientObj;
			_netStream.attachCamera(camera);

			if (mic != null)
			{
				_netStream.attachAudio(mic);
			}

			_netStream.publish(_streamName);
		}

		private function cameraStatusHandler(event:StatusEvent):void
		{
			trace("cameraStatusHandler " + event.code);
		}

		private function onCameraError(errorCode:String):void
		{
			dispatchEvent(new RTMPMediaEvent(RTMPMediaEvent.ERROR, errorCode));
		}

		private function netStreamAsyncErrorHandler(event:AsyncErrorEvent):void
		{

		}

		private function netStatusHandler(event:NetStatusEvent):void
		{
			switch (event.info.code)
			{
				case NetStatusCode.STREAM_PUBLISH_START:
					dispatchEvent(new RTMPMediaEvent(RTMPMediaEvent.STARTED));
					break;
				case NetStatusCode.STREAM_PUBLISH_BAD_NAME:
					dispatchEvent(new RTMPMediaEvent(RTMPMediaEvent.ERROR, RTMPErrorCode.BAD_STREAM_NAME));
					break;
			}
		}

		override public function dispose():void
		{
			if (_netStream != null)
			{
				_netStream.attachCamera(null);
				_netStream.attachAudio(null);
				_netStream.dispose();
				_netStream = null;
			}
			super.dispose();
		}
	}
}