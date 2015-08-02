package com.grid.model
{
	import morn.core.components.Box;
	
	public class CommonCellView extends Box
	{
		private var _rowindex:int=-1;
		private var _colindex:int=-1;
		private var _gridname:String;
		private var _text:String;
		public function CommonCellView()
		{
			super();
		}
		public function get rowindex():int
		{
			return _rowindex;
		}
		
		public function set rowindex(value:int):void
		{
			_rowindex = value;
		}
		
		public function get colindex():int
		{
			return _colindex;
		}
		
		public function set colindex(value:int):void
		{
			_colindex = value;
		}
		
		public function get gridname():String
		{
			return _gridname;
		}
		
		public function set gridname(value:String):void
		{
			_gridname = value;
		}
		
		public function clearAll():void{
		
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
		}
		
		public function drawNormal():void{
			
		}
	}
}