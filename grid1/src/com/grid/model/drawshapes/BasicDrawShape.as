package com.grid.model.drawshapes
{
	import flash.display.Sprite;
	
	
	public class BasicDrawShape extends Sprite
	{
		private var _shapeData:ShapeData;
		private var _shapeStyle:ShapeStyle;
		private var _shapeAction:ShapeAction;
		private var _shapeExtend:ShapeExtend;
		public function BasicDrawShape()
		{
			super();
		}

		public function draw():void{
			
		}
		public function get shapeData():ShapeData
		{
			return _shapeData;
		}

		public function set shapeData(value:ShapeData):void
		{
			_shapeData = value;
		}

		public function get shapeStyle():ShapeStyle
		{
			return _shapeStyle;
		}

		public function set shapeStyle(value:ShapeStyle):void
		{
			_shapeStyle = value;
		}

		public function get shapeAction():ShapeAction
		{
			return _shapeAction;
		}

		public function set shapeAction(value:ShapeAction):void
		{
			_shapeAction = value;
		}

		public function get shapeExtend():ShapeExtend
		{
			return _shapeExtend;
		}

		public function set shapeExtend(value:ShapeExtend):void
		{
			_shapeExtend = value;
		}

	}
}