package com.grid.model.header
{
	import com.grid.interfaces.IHeaderProp;
	
	public class NormalHeaderFuncProp implements IHeaderProp
	{
		public static const SORT_DESC:int=2;
		public static const SORT_ASC:int=1;
		public static const SORT_NOSORT:int=0;
		public function NormalHeaderFuncProp()
		{
		}
		
		private var _isSort:Boolean;
		public function isSort(value:Boolean):void
		{
			this._isSort = value;
		}
		
		public function canSort():Boolean
		{
			return this._isSort;
		}
		private var _currSort:int;
		public function set currSort(value:int):void
		{
			this._currSort = value;
		}
		
		public function get currSort():int
		{
			return this._currSort;
		}
		
		private var _isFilter:Boolean;
		public function isFilter(value:Boolean):void
		{
			_isFilter = value;
		}
		
		public function canFilter():Boolean
		{
			return _isFilter;
		}
		
		private var _filterType:int;
		public function set filterType(value:int):void
		{
			_filterType = value;
		}
		
		public function get filterType():int
		{
			return _filterType;
		}
		
		private var _filterUrl:String
		public function set filterUrl(value:String):void
		{
			_filterUrl = value;
		}
		
		public function get filterUrl():String
		{
			return _filterUrl;
		}
		
		private var _filterParams:Array;
		public function set filterParams(value:Array):void
		{
			_filterParams = value;
		}
		
		public function get filterParams():Array
		{
			return _filterParams;
		}
		
		private var _filterValues:Object;
		public function set filterValues(value:Object):void
		{
			_filterValues = value;
		}
		
		public function get filterValues():Object
		{
			if(_filterValues==null){
				_filterValues = {};
			}
			return _filterValues;
		}
		
	}
}