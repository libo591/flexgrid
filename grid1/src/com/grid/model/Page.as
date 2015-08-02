package com.grid.model
{
	public class Page
	{
		private var _startRow:int;
		private var _endRow:int;
		private var _startCol:int;
		private var _endCol:int;
		private var _includeRows:Array;
		public function Page()
		{
		}

		public function get startRow():int
		{
			return _startRow;
		}

		public function set startRow(value:int):void
		{
			_startRow = value;
		}

		public function get endRow():int
		{
			return _endRow;
		}

		public function set endRow(value:int):void
		{
			_endRow = value;
		}

		public function get startCol():int
		{
			return _startCol;
		}

		public function set startCol(value:int):void
		{
			_startCol = value;
		}

		public function get endCol():int
		{
			return _endCol;
		}

		public function set endCol(value:int):void
		{
			_endCol = value;
		}

		public function toString():String{
			return "page:[startrow:"+this.startRow
				+",endrow:"+this.endRow
				+",startcol:"+this.startCol
				+",endcol:"+this.endCol+"]";
		}

		public function get includeRows():Array
		{
			return _includeRows;
		}

		public function set includeRows(value:Array):void
		{
			_includeRows = value;
		}

	}
}