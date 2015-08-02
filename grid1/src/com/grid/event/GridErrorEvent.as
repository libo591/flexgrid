package com.grid.event
{
	import com.grid.model.GridEvent;
	
	
	public class GridErrorEvent extends GridEvent
	{
		public static const ERROR_RUNTIME:String="runtime_error";
		public static const ERROR_OPER:String="oper_error";
		
		public function GridErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}