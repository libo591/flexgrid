package com.grid.model
{
	public class GridMouseState
	{
		private var _onResize:Boolean;
		
		public function GridMouseState()
		{
		}

		public function get onResize():Boolean
		{
			return _onResize;
		}

		public function set onResize(value:Boolean):void
		{
			_onResize = value;
		}

	}
}