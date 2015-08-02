package com.grid.interfaces
{
	import com.grid.model.header.ColProp;
	import com.grid.model.header.RowProp;

	public interface IGrid
	{
		function set cells(cells:Array):void;
		function addCellInPosition(rowindex:int,colindex:int,icell:ICell):void;
		function set name(value:String):void;
		function set rowProps(value:Array):void;
		function set colProps(value:Array):void;
		function setColProp(colindex:int,colprop:ColProp):void;
		function setRowProp(rowindex:int,rowprop:RowProp):void;
		function set mergeAreas(mas:Array):void;
		
		function get cells():Array;
		function getCellInPosition(rowindex:int,colindex:int):ICell;
		function get name():String;
		function get rowcount():int;
		function get colcount():int;
		function get rowProps():Array;
		function get colProps():Array;
		function getColProp(colindex:int):ColProp;
		function getRowProp(rowindex:int):RowProp;
		function get mergeAreas():Array;
		
		function set type(value:int):void;
		function get type():int;
		function set dispType(value:int):void;
		function get dispType():int;
		function set style(value:Object):void;
		function get style():Object;
	}
}