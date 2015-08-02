package com.grid.model
{
	import flash.utils.Timer;

	public class TimerController
	{
		private static var _inst:TimerController = new TimerController();
		private var _obj:Object = {};
		public function TimerController()
		{
		}
		
		public static function getInst():TimerController{
			return _inst;
		}
		
		public function getTimer(name:String):Timer{
			if(!_obj[name]){
				_obj[name] = new Timer(33);
			}
			return _obj[name] as Timer;
		}
	}
}