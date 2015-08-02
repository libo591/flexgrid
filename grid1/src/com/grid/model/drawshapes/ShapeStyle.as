package com.grid.model.drawshapes
{
	import flash.display.Bitmap;

	public class ShapeStyle
	{
		public static const SHADOW_DIRECTION_NONE:int=0;
		public static const SHADOW_DIRECTION_RIGHT:int=1;
		public static const SHADOW_DIRECTION_BOTTOMRIGHT:int=2;
		public static const SHADOW_DIRECTION_BOTTOM:int=3;
		public static const SHADOW_DIRECTION_BOTTOMLEFT:int=4;
		public static const SHADOW_DIRECTION_LEFT:int=5;
		public static const SHADOW_DIRECTION_TOPLEFT:int=6;
		public static const SHADOW_DIRECTION_TOP:int=7;
		public static const SHADOW_DIRECTION_TOPRIGHT:int=8;
		
		public static const SHADOW_OUTLINE_SOLID:int=0;
		public static const SHADOW_OUTLINE_DASH:int=1;//长点
		public static const SHADOW_OUTLINE_DOT:int=2;//小点
		public static const SHADOW_OUTLINE_DASHDOT:int=3;
		public static const SHADOW_OUTLINE_DASHDOTDOT:int=4;
		
		private var _backgroundColor:uint=0xFFFFFF;
		private var _backgroundColorAlpha:Number=1;
		private var _shadowAlpha:Number=0.5;
		private var _backImage:Bitmap;
		private var _fontName:String="宋体";
		private var _fontSize:int=12;
		private var _bold:Boolean=false;
		private var _italic:Boolean=false;
		private var _underline:Boolean=false;
		private var _forecolor:uint=0x000000;
		private var _foreImage:Bitmap;
		private var _shadowColor:uint=0xA9A9A9;
		private var _shadowDirection:uint=SHADOW_DIRECTION_NONE;
		private var _shadowOffsetX:uint=5;
		private var _shadowOffsetY:uint=5;
		private var _shadowOutlineColor:uint=0x000000;
		private var _shadowOutlineStyle:uint=SHADOW_OUTLINE_SOLID;
		private var _shadowOutlineThickness:uint=1;
		private var _rotation:Number;
		
		public function ShapeStyle()
		{
		}

		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
		}

		public function get backgroundColorAlpha():Number
		{
			return _backgroundColorAlpha;
		}

		public function set backgroundColorAlpha(value:Number):void
		{
			_backgroundColorAlpha = value;
		}

		public function get shadowAlpha():Number
		{
			return _shadowAlpha;
		}

		public function set shadowAlpha(value:Number):void
		{
			_shadowAlpha = value;
		}

		public function get backImage():Bitmap
		{
			return _backImage;
		}

		public function set backImage(value:Bitmap):void
		{
			_backImage = value;
		}

		public function get fontName():String
		{
			return _fontName;
		}

		public function set fontName(value:String):void
		{
			_fontName = value;
		}

		public function get fontSize():int
		{
			return _fontSize;
		}

		public function set fontSize(value:int):void
		{
			_fontSize = value;
		}

		public function get bold():Boolean
		{
			return _bold;
		}

		public function set bold(value:Boolean):void
		{
			_bold = value;
		}

		public function get italic():Boolean
		{
			return _italic;
		}

		public function set italic(value:Boolean):void
		{
			_italic = value;
		}

		public function get underline():Boolean
		{
			return _underline;
		}

		public function set underline(value:Boolean):void
		{
			_underline = value;
		}

		public function get forecolor():uint
		{
			return _forecolor;
		}

		public function set forecolor(value:uint):void
		{
			_forecolor = value;
		}

		public function get foreImage():Bitmap
		{
			return _foreImage;
		}

		public function set foreImage(value:Bitmap):void
		{
			_foreImage = value;
		}

		public function get shadowColor():uint
		{
			return _shadowColor;
		}

		public function set shadowColor(value:uint):void
		{
			_shadowColor = value;
		}

		public function get shadowDirection():uint
		{
			return _shadowDirection;
		}

		public function set shadowDirection(value:uint):void
		{
			_shadowDirection = value;
		}

		public function get shadowOffsetX():uint
		{
			return _shadowOffsetX;
		}

		public function set shadowOffsetX(value:uint):void
		{
			_shadowOffsetX = value;
		}

		public function get shadowOffsetY():uint
		{
			return _shadowOffsetY;
		}

		public function set shadowOffsetY(value:uint):void
		{
			_shadowOffsetY = value;
		}

		public function get shadowOutlineColor():uint
		{
			return _shadowOutlineColor;
		}

		public function set shadowOutlineColor(value:uint):void
		{
			_shadowOutlineColor = value;
		}

		public function get shadowOutlineStyle():uint
		{
			return _shadowOutlineStyle;
		}

		public function set shadowOutlineStyle(value:uint):void
		{
			_shadowOutlineStyle = value;
		}

		public function get shadowOutlineThickness():uint
		{
			return _shadowOutlineThickness;
		}

		public function set shadowOutlineThickness(value:uint):void
		{
			_shadowOutlineThickness = value;
		}

		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}


	}
}