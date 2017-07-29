package com.streamer.app.commands
{
	import com.streamer.app.models.ErrorPageModel;

	import robotlegs.bender.bundles.mvcs.Command;

	public class MediaErrorCommand extends Command
	{
		[Inject]
		public var errorCode:String;
		
		[Inject]
		public var errorPageModel:ErrorPageModel;

		override public function execute():void
		{
			errorPageModel.errorCode = errorCode;
		}
	}
}