package com.grid.interfaces
{
	public interface ICellBorder
	{
		function set lineWeights(values:Array):void;
		function set lineColors(value:Array):void;
		function set lineAlphas(value:Array):void;
		
		function get lineWeights():Array;
		function get lineColors():Array;
		function get lineAlphas():Array;
	}
}