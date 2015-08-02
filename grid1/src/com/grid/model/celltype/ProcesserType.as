package com.grid.model.celltype
{
	import flash.events.Event;
	
	import morn.core.components.ProgressBar;
	
	public class ProcesserType extends NONEType
	{
		private var _progressBar:ProgressBar;
		public function ProcesserType()
		{
		}
		/**
		 * {value://0-1,label:}
		 */
		override public function display():void
		{
			if(_progressBar==null){
				_progressBar = new ProgressBar("png.comp.progress");
				p.addChild(_progressBar);
			}
			_progressBar.sizeGrid = "4,4,4,4";
			_progressBar.width = cw;
			_progressBar.height = ch;
			App.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			_progressBar.value += 0.005;
			if (_progressBar.value >= 1) {
				_progressBar.value = 0;
			}
			//pro.label = int(pro.value * 100) + "%";
			_progressBar.label = "Loading...";
		}
		
	}
}