package com.grid.model
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.IGrid;
	import com.grid.model.header.ColProp;
	import com.grid.model.header.RowProp;
	
	
	public class NormalGrid implements IGrid
	{
		private var _cells:Array;
		private var _name:String;
		
		public function NormalGrid()
		{
		}
		
		public function set cells(cells:Array):void
		{
			this._cells = cells;
		}
		
		public function addCellInPosition(rowindex:int, colindex:int, icell:ICell):void
		{
			var rowcount:int = this.rowcount;
			var colcount:int = this.colcount;
			if(rowindex>=rowcount){
				return;
			}
			if(colindex>=colcount){
				return;
			}
			this._cells[rowindex][colindex] = icell;
		}
		
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		public function get cells():Array
		{
			return this._cells;
		}
		
		public function getCellInPosition(rowindex:int, colindex:int):ICell
		{
			return this._cells[rowindex][colindex];
		}
		
		public function get name():String
		{
			return this._name;
		}
		public function get rowcount():int
		{
			return this._rowPorps.length;
		}
		public function get colcount():int
		{
			return this._colPorps.length;
		}
		
		private var _colPorps:Array;
		public function set colProps(value:Array):void
		{
			this._colPorps = value;
		}
		
		public function get colProps():Array
		{
			return this._colPorps;
		}
		
		private var _rowPorps:Array;
		public function set rowProps(value:Array):void
		{
			this._rowPorps = value;
		}
		
		public function get rowProps():Array
		{
			return this._rowPorps;
		}
		
		public function getColProp(colindex:int):ColProp
		{
			return this.colProps[colindex] as ColProp;
		}
		
		public function setColProp(colindex:int, colprop:ColProp):void
		{
			this.colProps[colindex] = colprop;
		}
		
		public function getRowProp(rowindex:int):RowProp
		{
			return this.rowProps[rowindex] as RowProp;
		}
		
		public function setRowProp(rowindex:int, rowprop:RowProp):void
		{
			this.rowProps[rowindex] = rowprop;
		}
		
		
		private var _mergeAreas:Array;
		
		public function set mergeAreas(mas:Array):void
		{
			this._mergeAreas = mas;
		}
		
		public function get mergeAreas():Array
		{
			if(this._mergeAreas==null){
				this._mergeAreas=[];
			}
			return this._mergeAreas;
		}
		
		private var _type:int = GridConst.GRIDTYPE_NORMAL;
		public function set type(value:int):void
		{
			this._type = value;
		}
		
		public function get type():int
		{
			return this._type;
		}
		
		private var _dispType:int = GridConst.GRIDTYPE_DISPLAY;
		public function set dispType(value:int):void
		{
			this._dispType = value;
		}
		
		public function get dispType():int
		{
			return this._dispType;
		}
		
		private var _style:Object;
		public function set style(value:Object):void
		{
			this._style = value;
		}
		
		public function get style():Object
		{
			return this._style;
		}
	}
}