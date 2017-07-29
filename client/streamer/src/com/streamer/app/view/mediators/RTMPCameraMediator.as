package com.streamer.app.view.mediators
{
	import com.streamer.app.common.NetStatusCode;
	import com.streamer.app.common.RTMPErrorCode;
	import com.streamer.app.publisher.RTMPCamera;
	import com.streamer.app.signals.MediaErrorSignal;
	import com.streamer.app.signals.CameraStartedSignal;
	import com.streamer.app.signals.StartCameraSignal;

	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.net.NetStream;

	public class RTMPCameraMediator extends RTMPMediaMediator
	{
		[Inject]
		public var view:RTMPCamera;

		[Inject]
		public var cameraStartedSignal:CameraStartedSignal;

		[Inject]
		public var startCameraSignal:StartCameraSignal;

		private var _netStream:NetStream;
		private var _camera:Camera;
		
		public function RTMPCameraMediator()
		{

		}

		override public function initialize():void
		{
			startCameraSignal.add(onStartCamera);
		}

		override public function destroy():void
		{
			startCameraSignal.remove(onStartCamera);
			removeNetStream();
			removeCamera();
			super.destroy();
		}

		private function onStartCamera(streamURL:String, streamName:String):void
		{
			connect(streamURL, streamName);
		}

		override protected function onMediaStart():void
		{
			removeCamera();
			if (!setupCamera())
			{
				return;
			}

			var mic:Microphone = setupMicrophone();

			var clientObj:Object = {};
			clientObj.onMetaData = onMetaData;
			clientObj.onCuePoint = onCuePoint;

			_netStream = new NetStream(_nc);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, netStreamAsyncErrorHandler);
			_netStream.client = clientObj;
			_netStream.attachCamera(_camera);

			if (mic != null)
			{
				_netStream.attachAudio(mic);
			}

			_netStream.publish(_streamName);
		}

		private function setupCamera():Boolean
		{
			_camera = Camera.getCamera();
			if (_camera == null)
			{
				onCameraError(RTMPErrorCode.CAMERA_NOT_FOUND);
				return false;
			}

			_camera.addEventListener(StatusEvent.STATUS, cameraStatusHandler);
			if (_camera.muted)
			{
				onCameraError(RTMPErrorCode.CAMERA_MUTED);
				return false;
			}

			_camera.setMode(view.videoWidth, view.videoHeight, view.fps, true);
			_camera.setQuality(0, view.quality);
			return true;
		}

		private function setupMicrophone():Microphone
		{
			var mic:Microphone = Microphone.getMicrophone();
			if (mic == null)
			{
				onCameraError(RTMPErrorCode.MIC_NOT_FOUND);
			}
			if (mic != null && mic.muted)
			{
				onCameraError(RTMPErrorCode.MIC_MUTED);
			}
			return mic;
		}

		private function cameraStatusHandler(event:StatusEvent):void
		{
			if (event.code == "Camera.Muted")
			{
				if (_netStream != null)
				{
					removeNetStream();
					onCameraError(RTMPErrorCode.CAMERA_MUTED);
				}
			}
			else
			{
				if (_netStream == null)
				{
					onMediaStart();
				}
			}
		}

		private function onCameraError(errorCode:String):void
		{
			mediaErrorSignal.dispatch(errorCode);
		}

		private function netStreamAsyncErrorHandler(event:AsyncErrorEvent):void
		{
			trace("RTMPCamera asyncError " + event.error.getStackTrace());
		}

		private function netStatusHandler(event:NetStatusEvent):void
		{
			switch (event.info.code)
			{
				case NetStatusCode.STREAM_PUBLISH_START:
					cameraStartedSignal.dispatch();
					break;
				case NetStatusCode.STREAM_PUBLISH_BAD_NAME:
					onCameraError(RTMPErrorCode.BAD_STREAM_NAME);
					break;
			}
		}

		private function removeNetStream():void
		{
			if (_netStream != null)
			{
				_netStream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				_netStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, netStreamAsyncErrorHandler);
				_netStream.attachCamera(null);
				_netStream.attachAudio(null);
				_netStream.dispose();
				_netStream = null;
			}
		}

		private function removeCamera():void
		{
			if (_camera != null)
			{
				_camera.removeEventListener(StatusEvent.STATUS, cameraStatusHandler);
				_camera = null;
			}
		}

	}
}