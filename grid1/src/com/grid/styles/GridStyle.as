package com.grid.styles
{
	public class GridStyle
	{
		private var _name:String;
		private var _value:Object;
		
		public function GridStyle()
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

		public function get value():Object
		{
			return _value;
		}

		public function set value(value:Object):void
		{
			_value = value;
		}


	}
}