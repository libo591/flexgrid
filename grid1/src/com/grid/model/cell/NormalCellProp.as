package com.grid.model.cell
{
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICellProp;
	import com.grid.interfaces.ICellType;
	
	import flash.display.BitmapData;
	
	public class NormalCellProp implements ICellProp
	{
		private var _text:String;
		
		public function NormalCellProp()
		{
		}
		public function set text(values:String):void{
			this._text = values;
		}
		
		public function get text():String{
			if(this._text==null){
				this._text="";
			}
			return this._text;
		}
		
		private var _dataVisiable:Boolean = true;
		public function set dataVisiable(value:Boolean):void
		{
			this._dataVisiable = value;
		}
		
		public function get dataVisiable():Boolean
		{
			return this._dataVisiable;
		}
		
		private var _href:String;
		public function set href(value:String):void
		{
			this._href = value;
		}
		
		public function get href():String
		{
			return this._href;
		}
		
		private var _hrefTarget:String;
		public function set hrefTarget(value:String):void
		{
			this._hrefTarget = value;
		}
		
		public function get hrefTarget():String
		{
			return this._hrefTarget;
		}
		
		private var _value:Object;
		public function set value(value:Object):void
		{
			this._value = value;
		}
		
		public function get value():Object
		{
			return this._value;
		}
		
		
		private var _imageData:Object;
		public function set imageData(value:Object):void
		{
			this._imageData = value;
		}
		
		public function get imageData():Object
		{
			return this._imageData;
		}
		
		private var _typeData:Object;
		public function set typeData(value:Object):void
		{
			this._typeData = value;
		}
		
		public function get typeData():Object
		{
			return this._typeData;
		}
		
	}
}