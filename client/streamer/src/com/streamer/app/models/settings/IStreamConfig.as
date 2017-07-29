package com.streamer.app.models.settings
{
	public interface IStreamConfig
	{
		function get streamURL():String;
		function get streamName():String;
		
		function initialize():void;

	}
}