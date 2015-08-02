package com.grid.model.celltype
{
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.ICellType;
	import com.grid.model.GridController;
	
	import morn.core.components.Box;
	
	
	
	
	public class NONEType implements ICellType
	{
		public function NONEType()
		{
		}
		
		private var _ch:Number;
		public function set ch(value:Number):void
		{
			_ch = value;
		}
		
		public function get ch():Number
		{
			return _ch;
		}
		
		private var _colindex:int;
		public function set colindex(value:int):void
		{
			_colindex = value;
		}
		
		public function get colindex():int
		{
			return _colindex;
		}
		
		private var _cw:Number;
		public function set cw(value:Number):void
		{
			_cw = value;
		}
		
		public function get cw():Number
		{
			return _cw;
		}
		
		public function display():void
		{
		}
		
		private var _gridname:String;
		public function set gridname(value:String):void
		{
			_gridname = value;
		}
		
		public function get gridname():String
		{
			return _gridname;
		}
		
		private var _p:Box;
		public function set p(value:Box):void
		{
			_p = value;
		}
		
		public function get p():Box
		{
			return _p;
		}
		
		private var _rowindex:int;
		public function set rowindex(value:int):void
		{
			_rowindex = value;
		}
		
		public function get rowindex():int
		{
			return _rowindex;
		}
		
		private var _cell:ICell;
		
		public function get cell():ICell
		{
			return GridController.getInstance().getGrid(this.gridname).getCellInPosition(this.rowindex,this.colindex);
		}
	}
}