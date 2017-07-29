package com.streamer.app.view.mediators
{
	import com.streamer.app.models.ErrorPageModel;
	import com.streamer.app.view.ErrorPageView;

	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class ErrorPageMediator extends Mediator
	{
		[Inject]
		public var view:ErrorPageView;

		[Inject]
		public var model:ErrorPageModel;

		private var _changeWatcher:ChangeWatcher;
		
		override public function initialize():void
		{
			_changeWatcher = BindingUtils.bindProperty(view, "errorCode", model, "errorCode");
		}

		override public function destroy():void
		{
			if (_changeWatcher != null)
			{
				_changeWatcher.unwatch();
				_changeWatcher = null;
			}
		}

	}
}