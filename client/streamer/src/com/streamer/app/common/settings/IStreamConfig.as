package com.streamer.app.common.settings
{
	public interface IStreamConfig
	{
		function get streamURL():String;
		function get streamName():String;
		
		function initialize():void;

	}
}