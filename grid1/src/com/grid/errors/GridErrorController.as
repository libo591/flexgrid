package com.grid.errors
{
	import com.grid.event.GridErrorEvent;

	public class GridErrorController
	{
		private static var _inst:GridErrorController = new GridErrorController();
		public function GridErrorController()
		{
			
		}
		public static function getInst():GridErrorController{
			return _inst;
		}
		
		public function throwRuntimeError(msg:String):void{
			var errorEvent:GridErrorEvent = new GridErrorEvent(GridErrorEvent.ERROR_RUNTIME,true);
			errorEvent.dispatch();
		}
	}
}