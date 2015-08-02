package com.grid.interfaces
{
	public interface IHeaderProp
	{
		function isSort(value:Boolean):void;
		function canSort():Boolean;
		function set currSort(value:int):void;//0: asc default, 1: desc 
		function get currSort():int;
		function isFilter(value:Boolean):void;
		function canFilter():Boolean;
		function set filterValues(value:Object):void;
		function get filterValues():Object;
		function set filterType(value:int):void;
		function get filterType():int;//0 local default,1 url
		function set filterUrl(value:String):void;
		function get filterUrl():String;
		function set filterParams(value:Array):void;
		function get filterParams():Array;
		
	}
}