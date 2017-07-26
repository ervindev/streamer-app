package com.streamer.app.player.provider
{
	import com.streamer.app.player.*;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.net.NetStream;

	public class VideoProvider
	{
		private var _netStream:NetStream;
		private var _container:DisplayObjectContainer;
		private var _videoSource:VideoSource;

		public function VideoProvider()
		{

		}

		public function initialize(netStream:NetStream, container:DisplayObjectContainer):void
		{
			_netStream = netStream;
			_container = container;

			if (_container.stage)
			{
				init();
			}
			else
			{
				_container.addEventListener(Event.ADDED_TO_STAGE, containerAddedToStageHandler);
			}
		}

		private function containerAddedToStageHandler(event:Event):void
		{
			_container.removeEventListener(Event.ADDED_TO_STAGE, containerAddedToStageHandler);

			init();
		}

		private function init():void
		{
//			useCPUVideo();
//			return;

			_container.stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, stageVideoAvailabilityHandler);

			if (_container.stage.stageVideos.length > 0)
			{
				useGPUVideo();
			}
			else
			{
				useCPUVideo();
			}
		}

		private function stageVideoAvailabilityHandler(event:StageVideoAvailabilityEvent):void
		{
			if (event.availability == StageVideoAvailability.AVAILABLE)
			{
				useGPUVideo();
			}
			else
			{
				useCPUVideo();
			}
		}

		private function useGPUVideo():void
		{
			if (_videoSource is GPUVideoSource)
			{
				return;
			}
			disposePreviousVideoSource();

			var stageVideo:StageVideo = _container.stage.stageVideos[0];
			_videoSource = new GPUVideoSource(stageVideo);
			_videoSource.attachNetStream(_netStream);
			_container.addChild(_videoSource);

			trace("use GPU video")
		}

		private function useCPUVideo():void
		{
			if (_videoSource is CPUVideoSource)
			{
				return;
			}
			disposePreviousVideoSource();

			_videoSource = new CPUVideoSource();
			_videoSource.attachNetStream(_netStream);
			_container.addChild(_videoSource);
			trace("use CPU video")
		}

		private function disposePreviousVideoSource():void
		{
			if (_videoSource != null)
			{
//				_netStream.play(false);
				_videoSource.dispose();
				_container.removeChild(_videoSource);
				_videoSource = null;
			}
		}

		public function resize(width:Number, height:Number):void
		{
			if (_videoSource != null)
			{
				_videoSource.resize(_container.x, _container.y, width, height);
			}
		}

		public function dispose():void
		{
			disposePreviousVideoSource();
			if (_container != null && _container.stage != null)
			{
				_container.stage.removeEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, stageVideoAvailabilityHandler);
				_container = null;
			}
			_netStream = null;
		}

	}
}