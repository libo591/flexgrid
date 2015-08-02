package com.grid.interfaces
{
	public interface ICell
	{
		function set style(value:ICellStyle):void;
		function set border(value:ICellBorder):void;
		function set extendProp(value:ICellProp):void;
		function set type(value:int):void;
		function set changeFlag(value:int):void;
		
		function get style():ICellStyle;
		function get border():ICellBorder;
		function get extendProp():ICellProp;
		function get type():int;
		function get changeFlag():int;
		
	}
}