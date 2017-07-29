package com.streamer.app.models
{
	[Bindable]
	public class ErrorPageModel
	{
		
		private var _errorCode:String;

		public function get errorCode():String
		{
			return _errorCode;
		}

		public function set errorCode(value:String):void
		{
			_errorCode = value;
		}

		public function ErrorPageModel()
		{

		}

	}
}