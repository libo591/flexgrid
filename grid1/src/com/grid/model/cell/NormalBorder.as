package com.grid.model.cell
{
	import com.grid.interfaces.ICellBorder;
	
	public class NormalBorder implements ICellBorder
	{
		private var _lineWeights:Array;
		private var _lineColors:Array;
		private var _lineAlphas:Array;
		private var _lineAnchor:Array;//0:self 1:other
		
		public function NormalBorder()
		{
		}
		
		public function set lineWeights(values:Array):void
		{
			this._lineWeights = values;
		}
		
		public function set lineColors(value:Array):void
		{
			this._lineColors = value;
		}
		
		public function set lineAlphas(value:Array):void
		{
			this._lineAlphas = value;
		}
		
		public function get lineWeights():Array
		{
			if(this._lineWeights==null){
				this._lineWeights=[1,1,1,1];
			}
			return this._lineWeights;
		}
		
		public function get lineColors():Array
		{
			if(this._lineColors==null){
				this._lineColors=[0xD3D3D3,0xD3D3D3,0xD3D3D3,0xD3D3D3];
			}
			return this._lineColors;
		}
		
		public function get lineAlphas():Array
		{
			if(this._lineAlphas==null){
				this._lineAlphas=[1,1,1,1];
			}
			return this._lineAlphas;
		}

		public function get lineAnchor():Array
		{
			return _lineAnchor;
		}

		public function set lineAnchor(value:Array):void
		{
			_lineAnchor = value;
		}

	}
}