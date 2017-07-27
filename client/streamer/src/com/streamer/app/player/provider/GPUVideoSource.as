package com.streamer.app.player.provider
{
	import flash.events.StageVideoEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.net.NetStream;

	public class GPUVideoSource extends VideoSource
	{
		private var _stageVideo:StageVideo;
		private var _rect:Rectangle;

		public function GPUVideoSource(stageVideo:StageVideo)
		{
			_stageVideo = stageVideo;
			super();
		}

		override protected function init():void
		{
			_stageVideo.addEventListener(StageVideoEvent.RENDER_STATE, stageVideoRenderStateHandler);

			super.init();
		}

		private function stageVideoRenderStateHandler(event:StageVideoEvent):void
		{
			var newX:Number = x;
			var newY:Number = y;
			if (parent)
			{
				newX = parent.x;
				newY = parent.y;
			}
			resize(newX, newY, _stageVideo.videoWidth, _stageVideo.videoHeight);
		}

		override public function attachNetStream(netStream:NetStream):void
		{
			super.attachNetStream(netStream);

			_stageVideo.attachNetStream(_netStream);
		}

		override public function resize(x:Number, y:Number, width:Number, height:Number):void
		{
			super.resize(x, y, width, height);

			if (_rect == null)
			{
				_rect = new Rectangle();
			}
			_rect.setTo(x, y, width, height);

			_stageVideo.viewPort = _rect;
		}

		override public function dispose():void
		{
			_stageVideo.removeEventListener(StageVideoEvent.RENDER_STATE, stageVideoRenderStateHandler);
			_stageVideo.attachNetStream(null);
			_stageVideo = null;
			_rect = null;
			super.dispose();
		}
	}
}