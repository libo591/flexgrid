package com.grid.model.drawshapes
{
	public class ShapeAction
	{
		public static const MOVE_HORIZONTAL:int=0;
		public static const MOVE_VERTICAL:int=1;
		public static const MOVE_NONE:int=2;
		public static const MOVE_HORIZONTALANDVERTICAL:int=3;
		
		public static const SIZE_WIDTH:int=0;
		public static const SIZE_HEIGHT:int=1;
		public static const SIZE_NONE:int=2;
		public static const SIZE_WIDTHANDHEIGHT:int=3;
		
		private var _allowBackImageRotation:Boolean=false;
		private var _canMove:int=MOVE_HORIZONTALANDVERTICAL;
		private var _canPrint:Boolean=true;
		private var _canRenderText:Boolean;
		private var _canRotate:Boolean=true;
		private var _canSize:int=SIZE_WIDTHANDHEIGHT;
		private var _locked:Boolean;
		private var _sizeProportional:Boolean;
		
		public function ShapeAction()
		{
		}

		public function get allowBackImageRotation():Boolean
		{
			return _allowBackImageRotation;
		}

		public function set allowBackImageRotation(value:Boolean):void
		{
			_allowBackImageRotation = value;
		}

		public function get canMove():int
		{
			return _canMove;
		}

		public function set canMove(value:int):void
		{
			_canMove = value;
		}

		public function get canPrint():Boolean
		{
			return _canPrint;
		}

		public function set canPrint(value:Boolean):void
		{
			_canPrint = value;
		}

		public function get canRenderText():Boolean
		{
			return _canRenderText;
		}

		public function set canRenderText(value:Boolean):void
		{
			_canRenderText = value;
		}

		public function get canRotate():Boolean
		{
			return _canRotate;
		}

		public function set canRotate(value:Boolean):void
		{
			_canRotate = value;
		}

		public function get canSize():int
		{
			return _canSize;
		}

		public function set canSize(value:int):void
		{
			_canSize = value;
		}

		public function get locked():Boolean
		{
			return _locked;
		}

		public function set locked(value:Boolean):void
		{
			_locked = value;
		}

		public function get sizeProportional():Boolean
		{
			return _sizeProportional;
		}

		public function set sizeProportional(value:Boolean):void
		{
			_sizeProportional = value;
		}


	}
}