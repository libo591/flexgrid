package com.grid.model.cell
{
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.ICellBorder;
	import com.grid.interfaces.ICellProp;
	import com.grid.interfaces.ICellStyle;
	import com.grid.utils.CellUtil;
	

	public class NormalCell implements ICell
	{
		private var _style:ICellStyle;
		private var _border:ICellBorder;
		private var _extendProp:ICellProp;
		
		public function NormalCell()
		{
		}
		
		
		public function set style(value:ICellStyle):void
		{
			this._style = value;
		}
		
		public function set border(value:ICellBorder):void
		{
			this._border = value;
		}
		
		public function set extendProp(value:ICellProp):void
		{
			this._extendProp = value;
		}
		
		public function get style():ICellStyle
		{
			if(this._style==null){
				this._style = new NormalStyle();
			}
			return this._style;
		}
		
		public function get border():ICellBorder
		{
			if(this._border==null){
				this._border = new NormalBorder();
			}
			return this._border;
		}
		
		public function get extendProp():ICellProp
		{
			if(this._extendProp==null){
				this._extendProp = new NormalCellProp();
			}
			return this._extendProp;
		}
		
		private var _type:int = CellConst.CELLTYPE_NONE;
		public function set type(value:int):void
		{
			this._type = value;
		}
		
		public function get type():int
		{
			return this._type;
		}
		
		private var _changeFlag:int=CellUtil.allChangeFlag();
		public function set changeFlag(value:int):void
		{
			this._changeFlag = value;
		}
		
		public function get changeFlag():int
		{
			return this._changeFlag;
		}
		
	}
}