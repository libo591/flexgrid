package com.grid.styles
{
	public class GridStyleDeclare
	{
		private var _name:String;
		private var _values:Object;
		public function GridStyleDeclare()
		{
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get values():Object
		{
			return _values;
		}

		public function set values(value:Object):void
		{
			_values = value;
		}
		
		public function getStyle(name:String):GridStyle{
			return this.values[name] as GridStyle;
		}
	}
}