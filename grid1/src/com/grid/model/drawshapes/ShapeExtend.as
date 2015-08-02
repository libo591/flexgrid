package com.grid.model.drawshapes
{
	public class ShapeExtend
	{
		
		public static const LINECAP_ROUND:int=0;
		public static const LINECAP_TRIANGLE:int=1;
		public static const LINECAP_SQUARE:int=2;
		public static const LINECAP_ROUNDANCHOR:int=3;
		public static const LINECAP_TRIANGLEANCHOR:int=4;
		public static const LINECAP_SQUAREANCHOR:int=5;
		public static const LINECAP_NONE:int=6;
		
		private var _flipHorizontal:Boolean;
		private var _flipVertical:Boolean;
		
		private var _lineStartCap:int=LINECAP_NONE;
		private var _lineEndCap:int=LINECAP_NONE;
		private var _thickness:int=1;
		public function ShapeExtend()
		{
		}

		public function get flipHorizontal():Boolean
		{
			return _flipHorizontal;
		}

		public function set flipHorizontal(value:Boolean):void
		{
			_flipHorizontal = value;
		}

		public function get flipVertical():Boolean
		{
			return _flipVertical;
		}

		public function set flipVertical(value:Boolean):void
		{
			_flipVertical = value;
		}

		public function get lineStartCap():int
		{
			return _lineStartCap;
		}

		public function set lineStartCap(value:int):void
		{
			_lineStartCap = value;
		}

		public function get lineEndCap():int
		{
			return _lineEndCap;
		}

		public function set lineEndCap(value:int):void
		{
			_lineEndCap = value;
		}

		public function get thickness():int
		{
			return _thickness;
		}

		public function set thickness(value:int):void
		{
			_thickness = value;
		}


	}
}