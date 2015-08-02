package com.grid.model.header
{
	import com.grid.interfaces.IHeaderProp;

	public class ColProp
	{
		public static const COLTYPE_NORMAL			:int=0;
		public static const COLTYPE_LEFTHEADER		:int=1;
		
		public static const COLDATATYPE_STRING		:int = 0;//
		public static const COLDATATYPE_NUMBER		:int = 1;//
		public static const COLDATATYPE_DATETIME	:int = 2;//
		private var _width:Number;
		private var _visiable:Boolean;
		private var _x:Number;
		private var _colindex:int;
		private var _type:int;
		
		private var _headerFunc:IHeaderProp;
		
		private var _isTreeNode:Boolean;
		
		public function ColProp()
		{
		}
		
		public function toString():String{
			return "colindex:"+this.colindex+"_x:"+this.x+"_width:"+this.width;
		}
		public function cloneSelf():ColProp{
			var colp:ColProp = new ColProp();
			colp.colindex = this._colindex;
			colp.visiable = this.visiable;
			colp.x = this.x;
			colp.colindex = this.colindex;
			return colp;
		}
		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function get visiable():Boolean
		{
			return _visiable;
		}

		public function set visiable(value:Boolean):void
		{
			_visiable = value;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		public function get colindex():int
		{
			return _colindex;
		}

		public function set colindex(value:int):void
		{
			_colindex = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get headerFunc():IHeaderProp
		{
			if(_headerFunc==null){
				_headerFunc=new NormalHeaderFuncProp();
			}
			return _headerFunc;
		}

		public function set headerFunc(value:IHeaderProp):void
		{
			_headerFunc = value;
		}

		private var _colDataType:int;
		public function set colDataType(value:int):void
		{
			_colDataType = value;
		}
		
		public function get colDataType():int
		{
			return _colDataType;
		}

		public function get isTreeNode():Boolean
		{
			return _isTreeNode;
		}

		public function set isTreeNode(value:Boolean):void
		{
			_isTreeNode = value;
		}

	}
}