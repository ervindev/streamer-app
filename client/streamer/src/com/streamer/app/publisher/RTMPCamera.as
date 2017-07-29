package com.streamer.app.publisher
{
	import mx.core.UIComponent;

	public class RTMPCamera extends UIComponent
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

		private var _quality:int = 90;

		public function get quality():int
		{
			return _quality;
		}

		public function set quality(value:int):void
		{
			_quality = value;
		}



		public function RTMPCamera()
		{

		}

	}
}