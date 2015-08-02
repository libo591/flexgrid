package com.grid.model.cell
{
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICellStyle;
	
	import flash.display.Bitmap;
	
	public class NormalStyle implements ICellStyle
	{
		private var _backgroundColor:uint=0xFFFFFF;
		private var _bold:Boolean=false;
		private var _fontsize:uint = 12;
		private var _forecolor:uint = 0x000000;
		private var _horizontalAligh:int = CellConst.HORIZONTALALIGH_CENTER;
		private var _indentation:uint = 0;
		private var _italic:Boolean = false;
		
		
		public function set bold(value:Boolean):void
		{
			this._bold = value;
		}
		
		public function get bold():Boolean
		{
			return this._bold;
		}
		
		public function set fontsize(value:uint):void
		{
			this._fontsize = value;
		}
		
		public function get fontsize():uint
		{
			return this._fontsize;
		}
		
		public function set forecolor(value:uint):void
		{
			this._forecolor = value;
		}
		
		public function get forecolor():uint
		{
			return this._forecolor;
		}
		
		public function set horizontalAligh(value:int):void
		{
			this._horizontalAligh = value;
		}
		
		public function get horizontalAligh():int
		{
			return this._horizontalAligh;
		}
		
		public function set indentation(value:uint):void
		{
			this._indentation = value;
		}
		
		public function get indentation():uint
		{
			return this._indentation;
		}
		
		public function set italic(value:Boolean):void
		{
			this._italic = value;
		}
		
		public function get italic():Boolean
		{
			return this._italic;
		}
		private var _textFormat:String="";
		public function set textFormat(value:String):void
		{
			this._textFormat = value;
		}
		
		public function get textFormat():String
		{
			return this._textFormat;
		}
		private var _textResize:int=CellConst.TEXTRESIZE_FIXCELL;
		public function set textResize(value:int):void
		{
			this._textResize = value;
		}
		
		public function get textResize():int
		{
			return this._textResize;
		}
		private var _textWrap:Boolean=false;
		public function set textWrap(value:Boolean):void
		{
			this._textWrap = value;
		}
		
		public function get textWrap():Boolean
		{
			return this._textWrap;
		}
		private var _typeface:String="Dialog";
		public function set typeface(value:String):void
		{
			this._typeface = value;
		}
		
		public function get typeface():String
		{
			return this._typeface;
		}
		
		private var _underline:Boolean = false;
		public function set underline(value:Boolean):void
		{
			this._underline = value;
		}
		
		public function get underline():Boolean
		{
			return this._underline;
		}
		
		private var _verticalAlign:int = CellConst.VERTICALALIGN_MIDDLE;
		public function set verticalAlign(value:int):void
		{
			this._verticalAlign = value;
		}
		
		public function get verticalAlign():int
		{
			return this._verticalAlign;
		}
		
		public function toString():String
		{
			return super.toString();
		}
		
		public function NormalStyle()
		{
		}
		
		public function set backgroundColor(color:uint):void
		{
			this._backgroundColor = color;
		}
		
		public function get backgroundColor():uint
		{
			return this._backgroundColor;
		}
		
	}
}