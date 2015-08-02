package com.grid.model.header
{
	public class RowProp
	{
		public static const ROWTYPE_NORMAL			:int=0;
		public static const ROWTYPE_TABLEHEADER		:int=1;
		private var _height:Number;
		private var _visiable:Boolean=true;
		private var _y:Number;
		private var _rowindex:int;
		private var _type:int;
		
		private var _treeLevel:int;
		private var _treeExpand:Boolean;
		
		public function RowProp()
		{
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get visiable():Boolean
		{
			return _visiable;
		}

		public function set visiable(value:Boolean):void
		{
			_visiable = value;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		public function get rowindex():int
		{
			return _rowindex;
		}

		public function set rowindex(value:int):void
		{
			_rowindex = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get treeLevel():int
		{
			return _treeLevel;
		}

		public function set treeLevel(value:int):void
		{
			_treeLevel = value;
		}

		public function get treeExpand():Boolean
		{
			return _treeExpand;
		}

		public function set treeExpand(value:Boolean):void
		{
			_treeExpand = value;
		}


	}
}