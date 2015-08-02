package com.grid.interfaces
{
	
	import morn.core.components.Box;
	
	
	
	public interface ICellType
	{
		function set gridname(value:String):void;
		function get gridname():String;
		
		function set rowindex(value:int):void;
		function get rowindex():int;
		function set colindex(value:int):void;
		function get colindex():int;
		
		function set p(value:Box):void;
		function get p():Box;
		
		function set cw(value:Number):void;
		function get cw():Number;
		function set ch(value:Number):void;
		function get ch():Number;
		
		function display():void;
	}
}