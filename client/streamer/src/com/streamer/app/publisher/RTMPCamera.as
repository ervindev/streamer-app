package com.streamer.app.publisher
{
	import com.streamer.app.common.NetStatusCode;
	import com.streamer.app.common.RTMPMedia;
	import com.streamer.app.common.RTMPErrorCode;
	import com.streamer.app.common.event.RTMPMediaEvent;

	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.H264Level;
	import flash.media.H264Profile;
	import flash.media.H264VideoStreamSettings;
	import flash.media.Microphone;
	import flash.net.NetStream;

	public class RTMPCamera extends RTMPMedia
	{
		private var _fps:int = 30;
		private var _videoWidth:int = 640;
		private var _videoHeight:int = 480;

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
				onCameraError(RTMPErrorCode.CAMERA_MUTED);
				return;
			}

			camera.addEventListener(StatusEvent.STATUS, cameraStatusHandler);
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

			var h264Settings:H264VideoStreamSettings = new H264VideoStreamSettings();
			h264Settings.setProfileLevel(H264Profile.BASELINE, H264Level.LEVEL_4_1);
			h264Settings.setMode(camera.width, camera.height, camera.fps);
			h264Settings.setKeyFrameInterval(1);

			_netStream.videoStreamSettings = h264Settings;
			_netStream.publish(_streamName);
		}

		private function cameraStatusHandler(event:StatusEvent):void
		{
			trace("camera status handler " + event.code);
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
			trace(this, "net status " + event.info.code);
			if (event.info.code == NetStatusCode.STREAM_PUBLISH_START)
			{
				dispatchEvent(new RTMPMediaEvent(RTMPMediaEvent.STARTED));
			}
		}

		override public function dispose():void
		{
			if (_netStream != null)
			{
				_netStream.dispose();
				_netStream = null;
			}
			super.dispose();
		}
	}
}